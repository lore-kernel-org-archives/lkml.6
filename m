Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA78C20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GmHkWxAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfBUL4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:56:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52420 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBUL4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:56:45 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LBsc0B035676;
        Thu, 21 Feb 2019 11:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Pbq0pvPOHEEJ+KrRRgeyvszIi/z/+hzos7hFkkP1w74=;
 b=GmHkWxAk1iIPPv86Vvh3PdDb2Tl90iilKrF8nfs07s0exHy6e3hKUGI+Gomw1huQqbox
 CGrXa5AYkbjUoEJe/AomYIIYR4a4OAzvbbEidd19PGy5qoQbjC+87uXDPVp2/pjnD4PB
 MmnB3HJtVYv6F8yw9aLbViwTPP6guX32/UnljBCbqtBTOBpPTUNcGKrdfmeCcGYZBV6Q
 jZwuIXRdgfrXYyN2QdgBkC5niMPmhjKekk9KpNyqA5fK8pkP/g7KDNlXXEvznt2OhQGr
 dDi9UofGStiA+zXeMVnC/LPaoTesvnwzQSK2Cnmpc43qnFh7LuHSs2G6PEhCXPKYkaMn Lg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rqcv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 11:55:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LBtP3a022610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 11:55:25 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LBtNG2012028;
        Thu, 21 Feb 2019 11:55:24 GMT
Received: from [192.168.1.67] (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 03:55:23 -0800
Subject: Re: [Xen-devel] [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        x86@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220233941.GA5279@mail-itl>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <6c12ea67-0845-d2c2-6f78-f4819b46b7b5@oracle.com>
Date:   Thu, 21 Feb 2019 11:55:10 +0000
MIME-Version: 1.0
In-Reply-To: <20190220233941.GA5279@mail-itl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 11:39 PM, Marek Marczykowski-Górecki wrote:
> On Wed, Feb 20, 2019 at 08:15:30PM +0000, Joao Martins wrote:
>>  2. PV Driver support (patches 17 - 39)
>>
>>  We start by redirecting hypercalls from the backend to routines
>>  which emulate the behaviour that PV backends expect i.e. grant
>>  table and interdomain events. Next, we add support for late
>>  initialization of xenbus, followed by implementing
>>  frontend/backend communication mechanisms (i.e. grant tables and
>>  interdomain event channels). Finally, introduce xen-shim.ko,
>>  which will setup a limited Xen environment. This uses the added
>>  functionality of Xen specific shared memory (grant tables) and
>>  notifications (event channels).
> 
> Does it mean backends could be run in another guest, similarly as on
> real Xen? AFAIK virtio doesn't allow that as virtio backends need
> arbitrary write access to guest memory. But grant tables provide enough
> abstraction to do that safely.
> 
In this series not yet. Here we are trying to resemble how KVM drives its kernel
PV backends (i.e. vhost virtio).

The domU grant {un,}mapping could be added complementary. The main difference
between domU gntmap vs shim gntmap is that the former maps/unmaps the  guest
page on the backend. Most of it is common code I think.

	Joao
