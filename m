Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2837347-1518874707-2-4228027546540859210
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518874706; b=b3rrwkyP4dXC6QGjAnV8jVW88vLzgrKWlSQbfwspEsecyyX
    K9nZAT2gD4WCKw+4awhQAopJj07XsCQQqYFWb9lVdcHpKbra9oYcwc03m6HI1RGt
    3Lxlh5vjCYxMtxpdZv+4al3lJ6DCTlLQqpBk+bNQHjpSFXr17H1dnBY2AVNZob+k
    X87QRdDvePFlB//Bp6il+3rnT2QlegzjHkvlHatPyAzWqbW52uuSqTYzPIdnE6Rm
    6f4rNccspH8K85pTUsdRlandxipRYbZ/TyTTTyFWcJ+oPNMCJT1sORcl81Z77LJ0
    pklFSlfpPmUwqATUHF1nazpICJ0tGVRYevEXuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518874706; bh=xaiJZ2JUwWLWsFn9OQW8DD+kst
    SIz1OoI6jeWK9ZnO0=; b=dIY/Q2r7wJW7jgnML3LQnK/8x6jCBQaUy3gPAf1IOs
    rhcmVqelhLd4ZLO9JJSaybnO+w70lh+em2FqkN5RooDlhWYYVTfc/3SEzQQUkrKa
    v5btnlltJjG2e6QfEsLIuGuWIIGUjUmvgKHeBffQd/lOstVdnhahd0bPHiYS2v7z
    ZNunmWw5vjykkVq55ik5DPUeWxkru9INJeAU3H60gR8WAkA2B/VRk5fzBTtydO71
    epQYHM5Drbz8f0Y750dsmsr/2H2QA6VL8FpXdo5uhWVaRr3oYwS6ilv3z/+Mgr2U
    eEIOsJtgq85zOjSoSndVfDURPgNHvzuy5xVnMyuzN42g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeBQNiY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Feb 2018 08:38:24 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbeBQNiX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Feb 2018 08:38:23 -0500
Date: Sat, 17 Feb 2018 14:32:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E . MORIN" <yann.morin.1998@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <mmarek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] Kconfig: disable PROFILE_ALL_BRANCHES for compile
 testing
Message-ID: <20180217133224.GA25994@kroah.com>
References: <20180216214117.1947175-1-arnd@arndb.de>
 <20180216214117.1947175-2-arnd@arndb.de>
 <20180216170346.497114b3@gandalf.local.home>
 <CAK8P3a1ZvA3dk8qRXaF_yjirYTYkvuCggh8x7QU_p+vMxpTPNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ZvA3dk8qRXaF_yjirYTYkvuCggh8x7QU_p+vMxpTPNA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:14:42PM +0100, Arnd Bergmann wrote:
> On Fri, Feb 16, 2018 at 11:03 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Fri, 16 Feb 2018 22:41:11 +0100
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >> This can easily double the time for compiling a driver but does not
> >> provide any benefit for the compile tester, so it's better left disabled.
> >>
> >> In addition, any 'inline' function that is not also 'static' and that
> >> contains an 'if' causes a warning like
> >>
> >> include/linux/string.h:212:2: note: in expansion of macro 'if'
> >>   if (strscpy(p, q, p_size < q_size ? p_size : q_size) < 0)
> >>   ^~
> >> include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
> >>
> >> without this patch, and I could not come up with a nice fix for that.
> >> In combination with my patch to always enable 'CONFIG_COMPILE_TEST'
> >> during 'randconfig' builds, we can at least hide these warnings for
> >> most users.
> >
> > This looks like it fixes the same issue that was already fixed and is
> > in Linus's tree.
> >
> >  http://lkml.kernel.org/r/9199446b-a141-c0c3-9678-a3f9107f2750@infradead.org
> >
> > See commit 68e76e034b6b1 ("tracing: Prevent PROFILE_ALL_BRANCHES when
> > FORTIFY_SOURCE=y")
> 
> Ah, right. I missed that when I wrote the new changelog text for this old
> patch of mine. It also means I should rebase the patch so it applies
> on mainline, as I still want PROFILE_ALL_BRANCHES to be disabled
> in COMPILE_TEST kernels for the build speed aspect.
> 
> Greg, could you add the 68e76e034b6b1 commit to 4.14-stable and
> 4.15-stable in the meantime?

It's already in 4.15, so I'll just queue it up to 4.14.y.

thanks,

greg k-h
