Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-490242-1518290528-2-2552766101501589569
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518290527; b=Y7XgYu53jV+uRCBESt3lt5lzseuoWWku0FePSIYw1UJ7nEZ
    C1vjHmbRwQ2tWxeMv+U5dXzfmUWKoUDwcw5mfCS/5qIKf/csMc693T7RMnwlpLiL
    YefN7hbDwDJEPUISTACS4MLMNw1QJHrnLkE1x3uDvDnuXiLGBBlgOgmiY3IMxEZL
    +LSWOpKNpWOKPmgduCdlgskI6AluKzUIfJN6zilvCO5a+C4k/AX985AWqMAybR4L
    oojtyOBueIYnrNLL5YYIJwZnl3ZKmh+ZTHPsrwY/6V70K7/fyz6jvwDS7nSzkN0F
    UtYtWwhgJBiufGewJNOugh1vpVfBBFAu2wnDKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518290527; bh=R5+AUEq
    lWHj7MUgzfihCRfYWTkgp3OMCH8Uyw99VdLA=; b=DaSPS6baeYJ30cr6hoiqN57
    p68rUd/97guftUi/fGwnbj1JciiGYk8sTYh+GBfXW7Myck/Svi+2fxGIKD0lzNEi
    5YERuJRacJcYQYZDxLiKe6UzUCrWzerg4ziIy6efpKn9fY/fFvUh3ag943yVF5gP
    /bUDYOFg8iJrOVEjG4MIsdTrft4Hyh7mTA70oyWQeSefypmHW7dyo2wpDT1ze7+o
    LoK/2Ry/cQehaArQ5sB0PbseW3yBDLpxrxntc4bAz8jDc/VDOlHRWsMXHGdGvxdl
    O7iSU9EIhVzzUwOZcJWJydsQLUoH2iX/DJ0HNrnSq0PuaHhptcA/gM+yPq5mncg=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBJTWD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 14:22:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:42616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbeBJTWD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 10 Feb 2018 14:22:03 -0500
Date: Sat, 10 Feb 2018 20:21:36 +0100
From: Borislav Petkov <bp@suse.de>
To: Kees Cook <keescook@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Paul Turner <pjt@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 4.9 46/92] x86/alternative: Print unadorned pointers
Message-ID: <20180210192136.GE4866@pd.tnic>
References: <20180209133931.211869118@linuxfoundation.org>
 <20180209133934.472824776@linuxfoundation.org>
 <CAGXu5jJ2K3SziXQsy-w5VOu9-V3H79w0OFQQFFnZiezUyc53Vg@mail.gmail.com>
 <20180210072340.GC8814@kroah.com>
 <CAGXu5jK=46Oz63Q5rPbDuGzGxDPFpx5asE3-RLunuvQkEsF4cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXu5jK=46Oz63Q5rPbDuGzGxDPFpx5asE3-RLunuvQkEsF4cA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 11:14:18AM -0800, Kees Cook wrote:
> I would just revert this commit from kernels earlier than 4.15; this
> %p usage is in debugging, so %pK doesn't make much sense here.

Yes, just drop it. That's only for debugging alternatives and not really
needed in stable.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
