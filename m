Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3236225-1524584451-2-16055371584568594808
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524584451; b=mzpTH5qXmDw9dmzrdcbBASM8XEpTC8+Hl8nmPratOWJje7Dakf
    V8TpFbp2/QIbyWA/6mrMsnI5AaSE/NYeKfkmtuOgRzT/YZ4TAtdnn7zWdjXYl27k
    rQVMK3YFDJALqXt5LOMaGNmR7jU4LrWBAWD7rcBle6DTcgrMaXcZTLq3zaG4A0yZ
    lwfcYDkArnKsb4UQgx9T9POEPf2KRCkM+YNvkfEIfEBBMcgLH34yoU2SBPQhKnv1
    aBvXeQWRkP1Uj+mtHXp8d0upI1XEdpwqeRrCBObqeVSWMraX/Rmb+2PSW12hz+cP
    lQBBoeHRBLnEu3EUwa+VIMq7BqEDTpcNOBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524584451; bh=Nr8Rj5sdqS/vfMfr/OhJIEatqSqcGu
    zJFWQVaNXJMjI=; b=Gmjxlpq+Cew1EQZr9tzVh38ZXoJubgQhuR6VrBny3NXITA
    TwOVbX1l9+2uR2gkJjQG//037LWhRn/TAfLQSGKIotCwwlLck6MzcODg0KnOjOQO
    5D5Ca3KxFPGuYFlA/+v+czJtulcyrG7iZvFwQVaNr1R8zYU+ziLXw13UsfFyh3ZL
    EYUbPu0R6KN0Eye45edRRQqNf8jGVO+cKOzJH55TcR8g7S1GSSFrR1nxSuGe9L0Q
    tMef36DAEQbCbpLt8zVsfCMM3TnqMVkIj+cvdmYFj/4Dh/4lU0P4oJv52MoxNIM9
    NnM23c3/qGA+QTL5L9ZGQbyUFsOUrkEpYLU8k2HQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDgmpjURiz3zyT6kOwK7GoohDuRenjKSmYn9rXSD2SmOW5eGuHXsWkcDz3pG56ThgAjx2gS+3zOs8UmInj5JSSnaMNvsqK8pUI3POltO3djYfmfM0V2N
    Iwae9BMFCZIBifBfMASOkA6Kd/wwVXMwFhJSAOoE1lgKwJCsci2wFZzBUPp/fLyS6CrqSZHEhT4qbrYQEtL04bGQLAMqtBcdvhLfn+F8wTABlzg9zxYSa4yH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=qQOBG6BMcmcCusluoQEA:9 a=CjuIK1q_8ugA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750812AbeDXPki (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 11:40:38 -0400
Received: from foss.arm.com ([217.140.101.70]:55592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbeDXPkh (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 11:40:37 -0400
Date: Tue, 24 Apr 2018 16:40:56 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        PaX Team <pageexec@freemail.hu>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: export tishift functions to modules
Message-ID: <20180424154055.GC25964@arm.com>
References: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 03:43:04PM +0200, Jason A. Donenfeld wrote:
> On Tue, Apr 24, 2018 at 3:34 PM, Will Deacon <will.deacon@arm.com> wrote:
> > I've not run into any build issues here -- is this specifically with some
> > out-of-tree module?
> 
> I received a bug report email about this. I'm not sure which specific
> module, and I assumed from the email that it was actually a result of
> in-tree configuration options rather than an out-of-tree module, but
> I'm not sure exactly. Either way, I was able to reproduce the problem
> by coding up a little PoC out-of-tree module, so it is certainly a
> real problem.

Any chance you could share the module, please? I tried to write one but
the compiler just inlines the __in128 arithmetic.

Will
