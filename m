Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB462C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986B620855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5d0bFzU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBULqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:46:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfBULqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:46:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LBhikK026679;
        Thu, 21 Feb 2019 11:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ba56OhV4U5fdnKqj0DAsFEfOsTPbQnQh9bKnjWL81Js=;
 b=5d0bFzU68fTDrZKFM90n/ePecS4MtjsvOpToE1uC6m0f/H72LLmuECxRb4bjXNPaaINu
 DhZqsU4DEqclsjtPy0c6wuMMwrrPXAhGElErASm0IkX+1365sYyw910FccfAc/KIxC3j
 Rzb32cBS88com0KpAdy9TeAXZfZGq+soGDtADfWi7Dst+AUkc1SSKb314a+lHTi/Llp0
 WnZBf0Pxt/lnnbvChyg47K3evnIJwWIEeqAMODqUuCYcuvnRYLAt3t45t77HLOwORKlk
 wuxrfj1r7eN8vjqEmHFrPDwlbz7pkYNIWp41ofcePfu5Io9qBK3C2ZpRtxXctpvQXWhH sQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rqbkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 11:45:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LBjdlX031560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 11:45:40 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LBjdFW024966;
        Thu, 21 Feb 2019 11:45:39 GMT
Received: from [192.168.1.67] (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 03:45:39 -0800
Subject: Re: [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <8b1f4912-4f92-69ae-ae01-d899d5640572@oracle.com>
Date:   Thu, 21 Feb 2019 11:45:32 +0000
MIME-Version: 1.0
In-Reply-To: <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 9:09 PM, Paolo Bonzini wrote:
> On 20/02/19 21:15, Joao Martins wrote:
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
> I am a bit worried by the last patches, they seem really brittle and
> prone to breakage.  I don't know Xen well enough to understand if the
> lack of support for GNTMAP_host_map is fixable, but if not, you have to
> define a completely different hypercall.
> 
I guess Ankur already answered this; so just to stack this on top of his comment.

The xen_shim_domain() is only meant to handle the case where the backend
has/can-have full access to guest memory [i.e. netback and blkback would work
with similar assumptions as vhost?]. For the normal case, where a backend *in a
guest* maps and unmaps other guest memory, this is not applicable and these
changes don't affect that case.

IOW, the PV backend here sits on the hypervisor, and the hypercalls aren't
actual hypercalls but rather invoking shim_hypercall(). The call chain would go
more or less like:

<netback|blkback|scsiback>
 gnttab_map_refs(map_ops, pages)
   HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,...)
     shim_hypercall()
       shim_hcall_gntmap()

Our reasoning was that given we are already in KVM, why mapping a page if the
user (i.e. the kernel PV backend) is himself? The lack of GNTMAP_host_map is how
the shim determines its user doesn't want to map the page. Also, there's another
issue where PV backends always need a struct page to reference the device
inflight data as Ankur pointed out.

> Of course, tests are missing.

FWIW: this was deliberate as we wanted to get folks impressions before
proceeding further with the work.

> You should use the
> tools/testing/selftests/kvm/ framework, and ideally each patch should
> come with coverage for the newly-added code.
> Got it.

Cheers,
	Joao
