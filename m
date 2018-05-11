Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3307667-1526016355-2-14339013819863503789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526016354; b=KCXbE5yeolue6gEfzF4XbX4Emk1Lw8VzqP2xg7BZ0/wTsiH8eb
    2MQcDl4vStsJz2BjmWzcUlDCvyuVL0T7sU8n5lPy/jBSms3iJtY1c/mnPHF/Irty
    xRHTcGTptLXG398gEkK3+vDDFNLXgnTz47sDya8SULj+f5XtIcm3GTMOLRB3ccxN
    fUpwAVdq6siCrUZxtCA1z5StG7/Sb6SToyNGdubyxD5r2NdTAg5a6uNxIFPrOgSK
    fddfpPwDL7eLXCunntCkwRWjdAQeUwCFGATWaF3D4nNVveiqj8O1r+f221oAS2Sp
    ODdlJRMVGDEh9MzQmZnCBFhFccmrEY1pwHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526016354; bh=/vcFtdoSt4xAu9Ygh/yuUn3tnI4jIZ
    6WnDqAOofkDxg=; b=KbLEcnOncffUc8ceKwPYMG8BrXDE2rcW6VXltfgD6mWKMc
    N/POAbOadUX+2t8MMjDp51fCPl1ttjIffAxoE/j0myUXC/KNU3BbbZ+ezjp1kRxS
    wCV26ca9t5BAHSoCUlErBbdtDnQb6x6coYqUCX3EjxDeML2IUTeJR5jMA2yDz7db
    qyYIn6DGHv3QAuBhutLHt+h2Sfg0EyTL48HLpWYKQ0UX3qPGF6wMsGBfEWP4HEB1
    9cKiqMV6iVucfcZ2z0pNBTV3q/Udgu0sXp1zml2m28kGrF9Gyk9rdIOAGtgn+rh9
    nL0VPe2tcVwrqpGxBOVGCMoKCnwvASD/aPIBSBNQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=d2/8e8mP x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=d2/8e8mP x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG7EWftb9GuOp7FdjauZHWLjCoXzZJHoxMRe+wSuYkLng73jepG37u6c37y54w9/TuqNH+NJQ4Tyv33wUNblyx0cdFg+4o8JSN/MkLdJ6kfcmTeQqZ6i
    LpHmzK2iqd/L9hLT7q5AMmw2bRzPME1+CtN6va1tVzAWjSzbHc16Hzx3iInnTuAkDXdDHtWAO17NgkGt14YaRsUY7JxUxvALzy8oWVqq8wNpzez/Cvg1cC8m
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=MvuuwTCpAAAA:8 a=VwQbUJbxAAAA:8 a=qtOaUHC8MtkzDtABBPsA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=dVHiktpip_riXrfdqayU:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeEKFZi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 01:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbeEKFZg (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 01:25:36 -0400
Date: Fri, 11 May 2018 07:24:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mike.travis@hpe.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/platform/UV: Use new set memory block size
 function
Message-ID: <20180511052440.GD2902@kroah.com>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
 <20180510231832.321834876@stormcage.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231832.321834876@stormcage.americas.sgi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 06:18:34PM -0500, mike.travis@hpe.com wrote:
> Add a call to the new function to "adjust" the current fixed UV memory
> block size of 2GB so it can be changed to a different physical boundary.
> This accommodates changes in the Intel BIOS, and therefore UV BIOS, which
> now can align boundaries different than the previous UV standard of 2GB.
> It also flags any UV Mem boundaries that cause a change in the mem block
> size boundary.
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c |   49 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
