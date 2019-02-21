Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6F2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TFhxlqWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfBUMCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:02:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59730 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBUMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:02:09 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LBsVT5033428;
        Thu, 21 Feb 2019 12:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5Frl408uQa5TvOGxjZ7jBSx4QfxXDcTDI9sfTVpZaQI=;
 b=TFhxlqWblW7FmFCC3Cdqh21Rz8h54PgMRIBoKmHMv6PjCYRbjFg5K1BY6L/mkmhwCmP9
 Uu7JngVwPrwpAn3cs6hmepAn+qDX55RgGzZiafZlWpIqk3grTNAcujqbqKGyDIdCvg1J
 t2WavHPFCVDoM739bQ2WNc77vIbURHvUCAMCxIyzaYqLyeMthAR+YyQD5Z3IRDeCqrp4
 OFarTfiUwW/CWm0YZxmxq8G1NqNAqgWmcM29ONnRkkfMk+Q6mGd5aoiwlTmJlCT0gy7m
 sWsMuZ6eU5r1rN1poyYJ+0RFAjeuxZ5fov/EFDR4BVbarGvu+tSt/++N2GjgY8r1AYJx 4w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qp81efn5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 12:00:44 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LC0giO005099
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 12:00:43 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1LC0g04004016;
        Thu, 21 Feb 2019 12:00:42 GMT
Received: from [192.168.1.67] (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 04:00:41 -0800
Subject: Re: [Xen-devel] [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220233941.GA5279@mail-itl>
 <58ff93e1-6c91-c1a6-4273-531c28101569@suse.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <705f125d-ea4a-4dca-01ae-06690bc56eed@oracle.com>
Date:   Thu, 21 Feb 2019 12:00:35 +0000
MIME-Version: 1.0
In-Reply-To: <58ff93e1-6c91-c1a6-4273-531c28101569@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 7:57 AM, Juergen Gross wrote:
> On 21/02/2019 00:39, Marek Marczykowski-Górecki wrote:
>> On Wed, Feb 20, 2019 at 08:15:30PM +0000, Joao Martins wrote:
>>>  2. PV Driver support (patches 17 - 39)
>>>
>>>  We start by redirecting hypercalls from the backend to routines
>>>  which emulate the behaviour that PV backends expect i.e. grant
>>>  table and interdomain events. Next, we add support for late
>>>  initialization of xenbus, followed by implementing
>>>  frontend/backend communication mechanisms (i.e. grant tables and
>>>  interdomain event channels). Finally, introduce xen-shim.ko,
>>>  which will setup a limited Xen environment. This uses the added
>>>  functionality of Xen specific shared memory (grant tables) and
>>>  notifications (event channels).
>>
>> Does it mean backends could be run in another guest, similarly as on
>> real Xen? AFAIK virtio doesn't allow that as virtio backends need
>> arbitrary write access to guest memory. But grant tables provide enough
>> abstraction to do that safely.
> 
> As long as the grant table emulation in xen-shim isn't just a wrapper to
> "normal" KVM guest memory access.
> 
> I guess the xen-shim implementation doesn't support the same kind of
> guest memory isolation as Xen does?
> 
It doesn't, but it's also two different usecases.

The xen-shim is meant to when PV backend lives in the hypervisor (similar model
as KVM vhost), whereas domU grant mapping that Marek is asking about require
additional hypercalls handled by guest (i.e. in kvm_xen_hypercall). This would
equate to how Xen currently performs grant mapping/unmapping.

	Joao
