Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2224084-1527180694-2-3085021943268673466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527180694; b=VimMDvBqqa2Q9fF1Y+Jzg1rNc1nvJo0Yj7wZO5BeToyn6Acvae
    wfxCT6EJDybSx7cXEjBPZU0vU850u12yK+gk4BpYkBB7h91xBwz9LdHQ3TCyeHlS
    t2w8A36r+24/r+dDLIlcTfFlVCGSrKaN1jm3a7RYVBmpT9yOKxThJ0/nTof2Yj5d
    /FS7eCfzIsRRWUnGZ7HDNjwK43w6m95PmSf3T1tFRAGoz9AFlcYYcwIOkZ4LRLOC
    ubjcNdh0ITERd1n5xdANV9HR3WhssLXs1OstSuJ9N9pCZa/gJ+hFEdJz/5ArXfJ0
    hkHhdpDoi2jY6t8MKbKSVPCR5Tfxy4sV7lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527180694; bh=hUQrp4q9BvHL1cnKQawt02oj9oxtZt
    FIai3QoI41UOE=; b=Nb45Soe3kIrVtOxYFAUBsmXBOGGVC3GTRpHUbqdEM9TqH7
    +FAHl+VYrgdZQdXhu8oSYC2F2BjwiM47/4qsVcgYk3o6oaNYvMNWktelLWLCdmad
    bpqlR/FO/Rw5FOKm5aZAdRmU+ZWysuqO82+f+dRFn6d1g7G+k1xExwXNwRda8Bnn
    Hsx58XCuMyBG0iebvXhVTgxJ5PLDNfvkg5WJYrS1vr0bbgqimaW/kAsrs7RQUN+h
    J52qA2dm/70b4lKksRsjWSTOKZFaw/LNMW6idBLKV71UqqKdSIFXzNnJivjFdklI
    uydt3FE/Wfusn0kvfi0/yO4JCwD94uvgtlQf1SJw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMLHiVrSAb48CQqECopZo3Xa0h7JyyvDsxPlka9+5+HK9KS1eiTpMqtydF2oUiobkegdfyvnWzRdwR80bIu7/jAhLtHnV8UDDR7HWZi8ISkGYd70J82v
    uhPxz0h2esWmcSN8Lqu11Dn+NfOWh/pZOazYWel7AI7q5t8Y+HdzMJuMkfjek4jo0TD2pMp/kAH8lXFQbCbgIMNKDpEUrnvg9RS7qTz2Iug3F58pUTXcCsfC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=cv-6mQJGC8kYWSJHWUIA:9
    a=W8rxVJ2ykvI03HBt:21 a=tnlwgL_m8dP3-88i:21 a=CjuIK1q_8ugA:10
    a=AlIIF0cMT2hfDT4axODj:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033925AbeEXQvb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 12:51:31 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:57036 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032311AbeEXQva (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 12:51:30 -0400
Date: Thu, 24 May 2018 09:36:17 -0700
From: Paul Burton <paul.burton@mips.com>
To: "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
Message-ID: <20180524163617.dts46enhigc2yjfo@pburton-laptop>
References: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527180687-382908-624-56785-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193318
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender
        Domain Matches Recipient Domain
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Maciej,

On Tue, May 15, 2018 at 11:04:44PM +0100, Maciej W. Rozycki wrote:
> Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e. 
> Status.FR) is not supported as the lone purpose of Config5.FRE is to 
> emulate Status.FR=0 handling on FPU hardware that has Status.FR=1 
> hardwired[1][2].  Also we do not handle this case elsewhere, and assume 
> throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot 
> be set both at once for a task, leading to inconsistent behaviour if 
> this does happen.

Reviewing the code I think we should actually end up with FR=1 in this
case, because neither __own_fpu() nor the FPU emulator depend on the
value of TIF_32BIT_FPREGS if TIF_HYBRID_FPREGS is set. So it's not too
awful & I don't see the kernel doing anything too crazy, but it
definitely isn't what the user asked for.

> Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting 
> PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to 
> modes allowed by `mips_set_personality_fp'.

Looks good to me:

  Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
  Paul

> References:
> 
> [1] "MIPS Architecture For Programmers, Vol. III: MIPS32 / microMIPS32
>     Privileged Resource Architecture", Imagination Technologies,
>     Document Number: MD00090, Revision 6.02, July 10, 2015, Table 9.69 
>     "Config5 Register Field Descriptions", p. 262
> 
> [2] "MIPS Architecture For Programmers, Volume III: MIPS64 / microMIPS64 
>     Privileged Resource Architecture", Imagination Technologies, 
>     Document Number: MD00091, Revision 6.03, December 22, 2015, Table 
>     9.72 "Config5 Register Field Descriptions", p. 288
> 
> Cc: stable@vger.kernel.org # 4.0+
> Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for MIPS")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
>  arch/mips/kernel/process.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> linux-mips-set-process-fp-mode-fr-fre.diff
> Index: linux/arch/mips/kernel/process.c
> ===================================================================
> --- linux.orig/arch/mips/kernel/process.c	2018-05-12 22:52:11.000000000 +0100
> +++ linux/arch/mips/kernel/process.c	2018-05-12 23:07:15.147112000 +0100
> @@ -721,6 +721,10 @@ int mips_set_process_fp_mode(struct task
>  	if (value & ~known_bits)
>  		return -EOPNOTSUPP;
>  
> +	/* Setting FRE without FR is not supported.  */
> +	if ((value & (PR_FP_MODE_FR | PR_FP_MODE_FRE)) == PR_FP_MODE_FRE)
> +		return -EOPNOTSUPP;
> +
>  	/* Avoid inadvertently triggering emulation */
>  	if ((value & PR_FP_MODE_FR) && raw_cpu_has_fpu &&
>  	    !(raw_current_cpu_data.fpu_id & MIPS_FPIR_F64))
> 
