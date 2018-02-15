Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719323-2-6276034439939934327
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719323; b=gqrYFu/lQ+o3Z/9uNJwwppfAmByQLQWmAbkTPxFZQ6goWqD
    1vmat9E7cN5BQfwBBO3kmqfxTe3ub7xoQ0I24QFZd3/xRQWIuTpC5AsW+J6dB1bT
    z80NskdrvNr2Q6wwIiNvausCLUY8MZ+FW/30nt+vZcgKgNutjIJHkV1LpACm4GTZ
    mNtmLtwvpABAsf7wCeVoEyXDTYVvOR9DnppE6YYip4UnqZRjWGszU4Heb9W29MZJ
    Wu8rajQUuLr1c1ofGhk2ILikJyfJYm7ofoMzmAyVVs8uYi9YaUtk07cd94DULGpd
    qXpkJRn5uvdJNPdPhqkS5AbsuzeXRwIYWoAZAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518719323; bh=hXGja0F5cEOedIDdss7xyBKOrx
    1HLtk8FV6iWiSgKFA=; b=cFjj4vqmLjlPMip6TONeLbO77f1H09nGnqow3yFdIp
    zuG+bw+yfqChIzvksHSnjVCQ0zJaaLTypQahHFS8o+ctLEbTo3zQ/NPL09t7Scic
    vXNIbTg7hbgy+XTkDgozwCCxi7VM4amdnC9MiKK39hlK6RmT6ZsrUP46LCkSl4UA
    hXQTExwDn+wSq4mOz+l2dqCDlL7UpLdE42rVrCf8F2ht3ZEvsXsHREzCASTZjXxy
    2HrbeuCPEZ3vbQVDjgR0dtE0fKHTPw5QKWk0+WdkBrxVoWPGLmCH0dJoErR7KImT
    zWxEMQrL9Nlfr/mTrI56uETw+yFdr44juwebxkn0NNSg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163178AbeBOPZ0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:25:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162134AbeBOPZX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Feb 2018 10:25:23 -0500
Date: Thu, 15 Feb 2018 09:25:21 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
Message-ID: <20180215152521.eoz6mhgw22ekyaev@treble>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble>
 <20180214224525.esxiqt7yjjjpzyz4@treble>
 <CAK8P3a1Q8O7=Wt71RkB0hqZA1dPGZMaBxVwyrx0+d2pPsDb8gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a1Q8O7=Wt71RkB0hqZA1dPGZMaBxVwyrx0+d2pPsDb8gQ@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 04:01:57PM +0100, Arnd Bergmann wrote:
> On Wed, Feb 14, 2018 at 11:45 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
> >> On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
> >> > Hi Josh,
> >> >
> >> > I recently did some randconfig testing with a plain 4.14-stable kernel
> >> > and gcc-7.3.0, and came across three distinct objtool warnings:
> >> >
> >> > drivers/misc/lkdtm_bugs.o: warning: objtool:
> >> > lkdtm_CORRUPT_LIST_ADD()+0x15: return with modified stack frame
> >
> > While this is probably an objtool bug, the code is very odd:
> >
> > 00000000000001a8 <lkdtm_CORRUPT_LIST_ADD>:
> >  1a8:   e8 00 00 00 00          callq  1ad <lkdtm_CORRUPT_LIST_ADD+0x5>
> >                         1a9: R_X86_64_PC32      __fentry__-0x4
> >  1ad:   55                      push   %rbp
> >  1ae:   48 89 e5                mov    %rsp,%rbp
> >  1b1:   48 83 e4 f0             and    $0xfffffffffffffff0,%rsp
> >  1b5:   48 83 ec 20             sub    $0x20,%rsp
> >  1b9:   48 89 ec                mov    %rbp,%rsp
> >  1bc:   5d                      pop    %rbp
> >  1bd:   c3                      retq
> >
> > The function just allocates/aligns its stack space and then returns.  It
> > seems like GCC was too smart for its own good here, as the function
> > doesn't test what it's supposed to.
> 
> AFAIU, there is an optimization step in gcc that eliminates basic blocks
> that contain an unconditional NULL pointer dereference, based on the
> assumption that it's undefined behavior, and if we ever get here, it is
> free to drop not only code after but also before it as long as it doesn't
> have any side-effects.

Ok, I expected something like that.  GCC "undefined behavior" strikes
again.

Kees, I suppose you'll need to obfuscate the code to stay one step ahead
of GCC.

While this may be an objtool bug, I might not fix it because it served a
useful purpose here in finding GCC crap.

> I would have expected an actual NULL pointer dereference to remain
> in the function though, or at least another trapping instruction.
> 
> >  Can you share the config for this one?
> 
> https://pastebin.com/qFV6SPWP

Would be interesting to analyze that config to understand what options
are causing GCC to do that.  I don't see this "optimization" with my
config.

-- 
Josh
