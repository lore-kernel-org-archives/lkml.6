Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2726463-1526393156-2-10850706155584667325
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526393154; b=bJuhMsAiHZAMR0tpz+cOYGTaqCzQhIWFzVpXuvP/sXPm3lDQ5t
    b/P4lroU3Eeh7K7J6n92geYf+lbEOm9Mtgh+ujVBo6p23LFhRtLG0yG4VvFpgRb1
    g/bpARoaaYmPEXbL5WsY1xZGdklSv1zm/ILM9qSnRjs12D2BYQG9RDQHR+VQD9bO
    QiAM74csZC+Nd0aKDbE6osUdWyczszoLQ+/LO/NVGbIIFJ1dd0PVLCWTjn9Txozk
    tDLb5pWVTPIjRr6gqJlObzFhOtg4dVOFGMyI3618k1pMjfraNfQ1vS1fR92TIC7g
    +Rt29x7qSaocytvCwNCGITQe4rMPpAhAlbKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526393154; bh=octjuWHzJQLM+InwMHKXm+S0QWA/7C
    eWwN2p8xmsafI=; b=WVPmum9KECwIuqChJ8IuleOLeE/QhxWEZ3Tc8ctlRe7Zj+
    FXmccK1S6CJvhGzNlWxsEqLZ6Gm7S48K5EHsqdcxqgY4ooxyekn//5tPMtB9Zr7C
    4EIdqcJE5wqMCmENXry9lHwTBHtwrFKklOl+R/i8zpzjhQ+WkCk6XjhnwkN8o7mi
    SCDryaH48SU+oXYaldoxKcLrU/X2KC3FsaDN5gF+zuu+ViLIrT8ItpszDicsXZRD
    g8aff578aBC3Pi4Yg+ocfXQpWEqHLpG57dMbW/ACFvE58x3n170MRdeuv5xHBcnZ
    jmSy6TKMB+wFhyNf/KUutXuz6U1py/jQ4hVog5Fw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=8bytes.org header.i=@8bytes.org header.b=Pxh4qMe8 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=8bytes.org header.i=@8bytes.org header.b=Pxh4qMe8 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=mail-1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=8bytes.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=8bytes.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFAl/c4Z14W8xXbsi61rZNYXIYbLWqeiJBU5jqolLCa5eYhVc1kvFeoThSTDjNE7BpTqsroGd9ia/AgrMgNBYcjnXFRuL5T7cVA/vfqi8nbBp95ehdap
    VsDv228rb5JXs19gTkh7tRKwtGn1fAa0S8s6Qj8Fi4iraxbZ9R7IU3Yd3fsVNfCMIegjTa0N6hKSo0/Krj472MHnNvaRx8xWo308PS84yvkaIhOsdRQ4ziFZ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=WASgddmXSnwkYHkFhjsA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeEOOFv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 10:05:51 -0400
Received: from 8bytes.org ([81.169.241.247]:48228 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752483AbeEOOFu (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 15 May 2018 10:05:50 -0400
Date: Tue, 15 May 2018 16:05:49 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, cpandya@codeaurora.org,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/mm: add TLB purge to free pmd/pte page interfaces
Message-ID: <20180515140549.GE18595@8bytes.org>
References: <20180430175925.2657-1-toshi.kani@hpe.com>
 <20180430175925.2657-3-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430175925.2657-3-toshi.kani@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:59:24AM -0600, Toshi Kani wrote:
>  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  {
> -	pmd_t *pmd;
> +	pmd_t *pmd, *pmd_sv;
> +	pte_t *pte;
>  	int i;
>  
>  	if (pud_none(*pud))
>  		return 1;
>  
>  	pmd = (pmd_t *)pud_page_vaddr(*pud);
> +	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);

So you need to allocate a page to free a page? It is better to put the
pages into a list with a list_head on the stack.

I am still on favour of just reverting the broken commit and do a
correct and working fix for the/a merge window.


	Joerg
