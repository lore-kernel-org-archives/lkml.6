Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-854779-1522739238-2-2305210359161906524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522739237; b=lvFGnIO2PQY/VeeCjmcPbEy8WsDiyUKXs1zjb5/piCzG7pwNYW
    pkZvMC7aaJwDsRgGGzmrEI4PFN/feGVI7Odb+lc712RifK8IkdyMtq8VrnrDSGwG
    UcmLP1vXP9m7PFPJP7XJl3OJQ91D0qQDiYtlVpN0rU3L1yygl3mw3tVktvpX15i9
    Mw2Q8I/TmMzGFKtCSeAwAFm8ovhBCjzpvoZu3mb9O+JeIRBilXgf26rsasUkDg2b
    YbGteAz55STnMSUiRAUzvpOm1XtkKVa55LKpxyVMERhlcgx3FC6dwXKsFfmpvDdM
    7uvZtp+l2Wlrf1ObrVJAUNZELxTr7rKYY+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:content-transfer-encoding
    :date:message-id:sender:list-id; s=fm2; t=1522739237; bh=3ausOKo
    2C+BZks6AZWye3+tFBEYx+aPA8PzKCa1PfZ4=; b=E2FAQu6bUmJtsSBJPxTwO5X
    W21jI3sJQgIEUiPY5qutCeug0A0U1QWEVt661rQEOl0WFCsweswRBr7w7eVa4qdx
    xPxNyTad8SPtANw/zKawTbB+zwrR5Ve9tybMhhVyv99jau+Ps9A1U5rRliiUCLs3
    r61tVViPS/8zhTxqEc3TIgPHe3k6fq2vrHtaMEqQ5W4ZIXlm2fkL9QGQBkzS/xz2
    n9Y2h7kuEzNEqH8NnWbb754fNQPbgEmQyrE7902VQ6e+55WZoLkBrtPAfygnA8Bz
    rt4+r44fWakHaMr1QBSUAkPFfc5Z9SXfGx2++Qtjy3g2tsI/FKph3QHlfn2RVMA=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFWKUm6T8RGJaIBfDoIV4c9+DKyQ1TFQMD29uDGY33x8Za0B7atjGOUfo8ZcLfV5CS4acF64v9lifjGtodDG6AcNDU43dgsItfyXvl0k6OVTnRy0M7/W
    Fpi2EYOvwHk9vrbtzftJgzOVig85Igo0kX8elbbspHUNGboAR847HBv8v/jQd+5X+KZ8TFRh456FDl64MG3PyTTkAIjPi3ru/K6J5x0uGsAyCO171+RfX3S1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=D19gQVrFAAAA:8 a=rRhUDPa2qvaMDsJWY6QA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbeDCHHG convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 3 Apr 2018 03:07:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754272AbeDCHHD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Apr 2018 03:07:03 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
References: <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: dhowells@redhat.com, James Morris <jmorris@namei.org>,
        gnomes@lxorguk.ukuu.org.uk,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mjg59@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jforbes@redhat.com,
        linux-man@vger.kernel.org, jlee@suse.com,
        linux-security-module@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30458.1522739219.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Tue, 03 Apr 2018 08:06:59 +0100
Message-ID: <30459.1522739219@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andy Lutomirski <luto@kernel.org> wrote:

> This is an attempt at a review.  I'm replying here because I can't find the
> actual relevant patch emails.

This was the latest post:

	https://lkml.org/lkml/2017/11/9/660

and they were posted multiple times before that, plus distributions, such as
Fedora, have been carrying them for a long while.

> For the rest of this review, I'm going to pretend that you actually want two
> features: "try-prevent-root-from-corrupting-the-kernel" and
> "try-to-prevent-root-from-reading-kernel-memory".

It theoretically boils down into those two, but the line is blurrier than you
think.

Further, some of the vectors that can be used to do one can potentially do the
other also and it starts getting to be a lot of extra work to distinguish the
two.

> I do *not* see why the mere act of using Secure Boot should have this
> effect.

To be able to pass secure boot mode over kexec, you have to make sure that the
kernel image doesn't get corrupted, lest someone blacklist your signing key in
the bootloader.

> In particular, UEFI Secure Boot should *not* enable
> "try-to-prevent-root-from-reading-kernel-memory", which means that, unless
> you actually implement the split, you should drop a bunch of the patches.

Yes it should.  If someone can read your kernel image, they can steal the
crypto keys you use to encrypt your filesystem.

> "Restrict /dev/{mem,kmem,port} when the kernel is locked down": this should
> probably split into one restriction for read and one for write.

Not so for /dev/port.  Read & Write here are _not_ the same as Read & Write
on, say, /dev/mem.  In fact, if /dev/mem gives you access to mmio ports, then
the same applies there.  Btw, Fedora hasn't even provided /dev/kmem for a
while.

> "bpf: Restrict kernel image access functions when the kernel is locked down":
> This patch just sucks in general.

Yes - but that's what Alexei Starovoitov specified.  bpf kind of sucks since
it gives you unrestricted access to the kernel.

> "debugfs: Restrict debugfs when the kernel is locked down": The logic is IMO
> nutty.  Why the 0444 restriction?  I see no reason that reading a 0644 file
> should be treated any differently from reading a 0444 file.

Yes.  IMO it should be locked down entirely.  However, it's been abused and
there are things in there that are apparently needed (ie. it's not
debugging-only now); unfortunately, it *also* contains files that directly map
hardware.

> "efi: Lock down the kernel if booted in secure boot mode": you have a stray
> change in fs/debugfs/inode.c in here.

Good catch, thanks.

> Also, as above, I really dislike this patch.

You dislike everything, but you didn't say so any of the times these patches
were posted...

> "lockdown: Print current->comm in restriction messages": Shouldn't this be
> folded in with whatever patch added that code in the first place?

Perhaps, but at the time I added it, I didn't want to go back and change the
existing patches again.  If I have to do so, I'll fold it in then.

David
