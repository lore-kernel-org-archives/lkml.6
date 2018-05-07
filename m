Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1403089-1525719278-2-13196718499601056735
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525719277; b=KoyBw/sz8AhBe+bRuMLaFNvvIn2YC09q5iT4PTvVrR7peMRKds
    IbsrSdBV0hTrCOdTyMHAXEAK9tMVNohaDm3Wg5gpyw/2oTizVethioqhM3gWUmv7
    EJeQGZCkZl1sB9MRc+hWxdrFVVLkPi/7N9gDFiphgFh6C8mI3rZ7li74rx5ZyrJw
    YjyWinBxzXzxOsgwDBE0n40RO5dZh4E8saRCG7jwnmSuAPrhqHHDaAqHajX9Aij2
    BQ7dDw+rIXGRNgzP+dfFiv56Mw80wD2ju6EQhviT3Dkvwoq0cl89jCHsftawVWyU
    veG1S7qz+GWAoRNTzp81uRljYiL55c0mWbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525719277;
    bh=D4Nezy+MJU16E/QPZVHcdM8QNX3KVx1nNB9wunWLveg=; b=T+ndi9PwysnK
    pN8h9ITanzFTdCvctmYA0km2CD6YJB0LuNKS3NXtMRfckj55Gkmp3SPzE0W9/F9W
    B/dEC61Sq6x5dtr+lScW+VctRWrTombR4mEvQrsGbSZHlPXNiksCu+3dvdSyWJ7N
    WnH/xXqKvfO3YPQdJjFCE0SJJSSrVPSAhiQBGolAAqhHiIwjvEHiv/eyOXFEni+o
    UIUY+wx569ix2HEs48ZWqDMjuvtL+qbvWNFZCA8LBKlKRyiDpYOWaaam2sWpPoF4
    V8Sx6iUM563jDtg1cDaSslGa3hr2u0hayX0TJr+kmhySloGbJC+e7OCvGqxQuxxr
    WU+ne+xubg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
    header.i=@oracle.com header.b=B+UiLTe1 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com
      header.i=@oracle.com header.b=B+UiLTe1 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF2dsN/vMfmDUzHwMQfELd/mvZw2Lu7ajqUkAZGAVYo/XEZ0lu/59RQei0wOnRQMEpRXOW7WIcKPBeB4Vm1XgD8UeOqmrWujjaDLoRbfBWD6frqzeuB3
    tknVhXOBpFoZykSL0/dikiAh852mwNE4eXXWXyABGcOXEU9LefOxuiste0L2E3fPYOY5E4EQiUhEE26Ss66pAphSmMKuMq+YYM00fWhmtlXLrcLaoyTGksiI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=gUWFq7lbW8kar5QlpssA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeEGSye (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 14:54:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeEGSyd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 May 2018 14:54:33 -0400
Subject: Re: [PATCH 1/1] x86/xen: Reset VCPU0 info pointer after shared_info
 remap
To: "van der Linden, Frank" <fllinden@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jgross@suse.com" <jgross@suse.com>,
        stable <stable@vger.kernel.org>
References: <C508E5F5-024E-4F71-A91E-7BB0BE046F5D@amazon.com>
 <965354d1-e2e7-1764-a14e-bb4258b9ed13@oracle.com>
 <B3C02FE4-651D-4A89-90BB-78E389764688@amazon.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <ab71bf69-5074-ca7d-ceb5-1b42b0a70457@oracle.com>
Date: Mon, 7 May 2018 14:57:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <B3C02FE4-651D-4A89-90BB-78E389764688@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070188
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 02:00 PM, van der Linden, Frank wrote:
> Hi Boris,
>
> Thanks for the feedback.
>
> ﻿On 5/7/18, 8:13 AM, "Boris Ostrovsky" <boris.ostrovsky@oracle.com> wrote:
>
>     > diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
>     > index 6b424da1ce75..c78b3e8fb2e5 100644
>     > --- a/arch/x86/xen/enlighten_hvm.c
>     > +++ b/arch/x86/xen/enlighten_hvm.c
>     > @@ -71,6 +71,19 @@ static void __init xen_hvm_init_mem_mapping(void)
>     >  {
>     >  	early_memunmap(HYPERVISOR_shared_info, PAGE_SIZE);
>     >  	HYPERVISOR_shared_info = __va(PFN_PHYS(shared_info_pfn));
>     > +
>     > +	/*
>     > +	 * The virtual address of the shared_info page has changed, so
>     > +	 * the vcpu_info pointer for VCPU 0 is now stale.
>     
>     Is it "has changed" or "has changed if kaslr is on"?
>
> It's "has changed".  See commit 4ca83dcf4e3bc0c98836dbb97553792ca7ea5429 .  It's a way to make kaslr work, but it's done regardless of whether it's enabled or not.


I completely forgot about this one.


>  
>     > +	 *
>     > +	 * The prepare_boot_cpu callback will re-initialize it via
>     > +	 * xen_vcpu_setup, but we can't rely on that to be called for
>     > +	 * old Xen versions (xen_have_vector_callback == 0).
>     > +	 *
>     > +	 * It is, in any case, bad to have a stale vcpu_info pointer
>     > +	 * so reset it now.
>     > +	 */
>     > +	xen_vcpu_info_reset(0);
>     
>     
>     Why not xen_vcpu_setup(0)?
>     
> Basically, I wanted to be minimally invasive. xen_vcpu_setup does a little more work (tries to do the VCPU placement hypercall), and will be called later in any case. So doing just the basic xen_vcpu_info_reset for VCPU 0 seems like the best way to do it; it just re-iterates what is done for VCPU 0 earlier in boot, which is also a vcpu_info_reset.


OK, fair enough. This should go to stable as well I think (4.12+),
copying them.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
