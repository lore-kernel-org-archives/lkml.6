Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A395DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E642146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFNcxLbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfBUAcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:32:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33264 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfBUAcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:32:03 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1L0SklX102932;
        Thu, 21 Feb 2019 00:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9Yi0nUtp/p2qYVg/S+SSRoCpnvGRxFRBCQS7128GnrE=;
 b=AFNcxLbDUjrSbfUM7/R4Q09G2NEHjff9EswhTPsfZYSTcjpqXVZTUM5otfnYrQrDb5f/
 ThGJJScE/tcWBPOGnEEWTkLUHUeGwzHbS0t0WucUARPsps1cyRlLWBkCENPyDwCdAi8G
 1OS5cLmxO6RSEHH4MFwKmZHxvpjw34HjXgV5iLsfJ6qnGX2EPj/maMHXYdl2lXJtwrfq
 k4ocnhP0PO6Tv2YLICQ2ZmladQ6n2zWIjwafN0yV98kISBzbez4GuTNjV4drojoIREoA
 CSNXf9yZbGFMDMViWi1HK27dLACa6Oa9NIHW+m57Liz54PGL0N5VaPrMUv8rJB4F96iq hA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qpb5rmx5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 00:31:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1L0VcVs015628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 00:31:38 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1L0Vb8i030592;
        Thu, 21 Feb 2019 00:31:37 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 16:31:36 -0800
Subject: Re: [Xen-devel] [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220233941.GA5279@mail-itl>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <292773f7-5a4d-ba00-8398-0c8b81766b93@oracle.com>
Date:   Wed, 20 Feb 2019 16:31:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190220233941.GA5279@mail-itl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/19 3:39 PM, Marek Marczykowski-Górecki wrote:
> On Wed, Feb 20, 2019 at 08:15:30PM +0000, Joao Martins wrote:
>>   2. PV Driver support (patches 17 - 39)
>>
>>   We start by redirecting hypercalls from the backend to routines
>>   which emulate the behaviour that PV backends expect i.e. grant
>>   table and interdomain events. Next, we add support for late
>>   initialization of xenbus, followed by implementing
>>   frontend/backend communication mechanisms (i.e. grant tables and
>>   interdomain event channels). Finally, introduce xen-shim.ko,
>>   which will setup a limited Xen environment. This uses the added
>>   functionality of Xen specific shared memory (grant tables) and
>>   notifications (event channels).
> 
> Does it mean backends could be run in another guest, similarly as on
> real Xen? AFAIK virtio doesn't allow that as virtio backends need
I'm afraid not. For now grant operations (map/unmap) can only be done
by backends to the local KVM instance.

Ankur

> arbitrary write access to guest memory. But grant tables provide enough
> abstraction to do that safely.

> 
