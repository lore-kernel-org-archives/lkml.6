Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2242495-1524731494-2-12742890980653828091
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
    1524731493; b=nItAhDIz2lEx1uIuCUOa7jEKkRg6qeADYZB9npBsWC4Oqgi8g4
    6/LStS654kQ5kZp2DlwUezlDG8J1t7LvyVGbEI3YaxrN7bJZCiekweYcsZG8ve/m
    7Yf4YuKVQiClXmzmOnpHrZlTnLqrWC9+IIKH9PowLjsKRdkcOjA434mWZ1al/0jM
    Sfsed9ifRjpByquzTFOdngcESFUB6W3SEFJ72GwBr8wxRfQw21fiYi4aDs9huFh1
    rXyRkYKUNRz3QTMFCULw5FgwCOs5uaem+4QPFNqOwfbeLMLatANsVp7klKSYapJU
    eTNNMFmVSv5sNtDq/qnPU1zDUFLxg0gH6fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524731493; bh=rTghYZMSRtm5D8gfoHBx4NO3xgy2Pc
    GeiF0Tk86cSck=; b=BgA2FKxKCiELeVej1gWbaeDU9lWk0n2n897YBAdleji4xj
    gpbpVafZRVaU0DF+igNlbIJCxGbdPdNKIKgQ9fLdXFoW5rk6NRL2pW38RiyHIVpl
    KBZMOg7CPSvQoDiHlnIisgnewa38TapWNT5sguG9ZQDsMWG1BBbQPIfMnKsDIIo+
    bWEkOBhra6nlhmMjzEmlhRX5cJOtgWgGlzf3+tNHb6AVfG8R+VEQm02g8lF0U0ys
    ZmabiRMibnZ/Kl2wbHh7M9GZ3EJbTqMN24v8jzgFp3YjyOyfV1S002qiRDleyT1k
    WEw5f4LtKZNRqnAWa4DFvmjmPWApIhWAHDhslG2A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNJ+Pudgl1PZsy7VbbnRCnhDdfAleHvVQCCNVraba46vxNUPlt2vOfdReXDQuhl7G+40mE0H40cBKGFgPpeHDSCNAHhUHEykr8ae+JjW6nRtBoFlKdJJ
    CL2lC3jNZtsfwYDhKU4NFXnAXfjcumVEB8AtF/28psMdXsrne5N2+PB1l3BKTMSwAtg8C86P/VgkC6JCd4jJ318PRXfukMLGMgNXrBjH+sKJ/GK3G0VMcy9o
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=zNuUKi_QwwXcV8NCd9AA:9 a=CjuIK1q_8ugA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754046AbeDZIbb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:31:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48760 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754077AbeDZIb3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 04:31:29 -0400
Date: Thu, 26 Apr 2018 09:31:48 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        PaX Team <pageexec@freemail.hu>, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: export tishift functions to modules
Message-ID: <20180426083147.GB27583@arm.com>
References: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
 <20180424154055.GC25964@arm.com>
 <CAHmME9oa-DX721K_yRe14AbLk5-raOXEji2SWsf41UtUTP=guQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oa-DX721K_yRe14AbLk5-raOXEji2SWsf41UtUTP=guQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jason,

On Tue, Apr 24, 2018 at 05:56:39PM +0200, Jason A. Donenfeld wrote:
> On Tue, Apr 24, 2018 at 5:40 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Apr 24, 2018 at 03:43:04PM +0200, Jason A. Donenfeld wrote:
> >> On Tue, Apr 24, 2018 at 3:34 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> > I've not run into any build issues here -- is this specifically with some
> >> > out-of-tree module?
> >>
> >> I received a bug report email about this. I'm not sure which specific
> >> module, and I assumed from the email that it was actually a result of
> >> in-tree configuration options rather than an out-of-tree module, but
> >> I'm not sure exactly. Either way, I was able to reproduce the problem
> >> by coding up a little PoC out-of-tree module, so it is certainly a
> >> real problem.
> >
> > Any chance you could share the module, please? I tried to write one but
> > the compiler just inlines the __in128 arithmetic.
> 
> Sure. I didn't save my original but just cooked a new one up and
> verified it errors out. The below will get these errors on mainline
> when compiled as a module, even as an in-tree module:

Thanks for sharing the module source, I can reproduce the issue on my
machine. Putting both the prototype and the EXPORT_SYMBOL in arm64ksyms.c
appears to resolve the issue and is my preference since these functions
shouldn't be called directly anyway. Would you be able to spin a v2 doing
that, please? I can take it as fix.

I've also queued your clang int128 patch.

Cheers,

Will
