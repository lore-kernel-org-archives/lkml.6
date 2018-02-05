Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1901562-1517819603-2-12612847819386932703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517819602; b=hPbOZcAXI35EkfTlUmc+SMJz1i0Fd7+zRIbb29Ls5LWRJO8
    V17zrmg4GYuMqQs/PHutQM1Fwrenb/9N8p/gJDmfNRVtzOSl0yuwczuhuPrmJzJY
    a3uVCYDG9R4fCqVw4D5/EzMcbVng5+VtKe9cQcmFnp7Gh8LQsbTzzg669mBERYYM
    j3WR8mMxWiicG6DYFFcW6Ck1pHkYzlg5oSPDKSkPUU4qC1dpyQOsVRdB6Y+hg30c
    eQIFXH+iY0RoO6kgZj0VhkwW1ksjgFXjP1dskC7xVmpCcwcklOIfNWSAyJt9xNnr
    3YbK577o29pgw5HUiGj+m8Kie1PbEd2lRTksmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517819602; bh=8yYRAUByUnYeg0V/nyvqkysIrF
    dI4GTmJ43YF2GFgQM=; b=tHncNMA4GXRo1IkscjhiBLtBwJKK+rwcvlbGuGil+V
    fG/HzJU/Jt6PrhcSoFc9MXij6uG7YBq+DJyCYwb2TNMAXgp64/iAC+y01HojEU5G
    kZ1wPTc7ph4oYTM9kgMSiEGb1JII/lRnwEuIYDN+sAnIlkZGrf2DyqoPyvQ8qtmZ
    +ICYDblAgK8UvufKyJ85B2pWIthqrxfY3sCkJCqoCH7xyoOuxPjD2MR2zVglFbjy
    2GH6aw9Ah9jnZa2lxzX30frZ8brCiRcJHGZZU1pxZctuMhZx5XJWNT5JXR5c/58C
    ezWC7PS60A4MIGXWWtEmThpNx/MoyI3Fo1l7FsxyGlgQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=PkxxmoRa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LYUngTyi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=PkxxmoRa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LYUngTyi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeBEIdU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 03:33:20 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39722 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeBEIdT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 03:33:19 -0500
X-Google-Smtp-Source: AH8x226hb3kGYebmrd2KoR9+K24PVx/Hr/dWDjrUOyYE7izvwkfdHEYhd/L7kdHyPuQYP8v+p/q1sQ==
Date: Mon, 5 Feb 2018 09:33:16 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: kvm: fix building with gcc-8
Message-ID: <20180205083316.GR21802@cbox>
References: <20180202150756.420422-1-arnd@arndb.de>
 <20180204184517.GQ21802@cbox>
 <CAK8P3a2EFdTcM6U4TU6EZz9vzGKK=hE=8yQ-1eTTxjGMRs5SKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2EFdTcM6U4TU6EZz9vzGKK=hE=8yQ-1eTTxjGMRs5SKQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 09:57:49PM +0100, Arnd Bergmann wrote:
> On Sun, Feb 4, 2018 at 7:45 PM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > Hi Arnd,
> >
> > On Fri, Feb 02, 2018 at 04:07:34PM +0100, Arnd Bergmann wrote:
> >> In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
> >> statement to allow compilation of a multi-CPU kernel for ARMv6
> >> and older ARMv7-A that don't normally support access to the banked
> >> registers.
> >>
> >> This is considered to be a programming error by the gcc developers
> >> and will no longer work in gcc-8, where we now get a build error:
> >>
> >> /tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_usr'
> >> /tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with this architecture. -- `mrs r3,ELR_hyp'
> >> /tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_svc'
> >> /tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with this architecture. -- `mrs r3,LR_svc'
> >> /tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with this architecture. -- `mrs r3,SPSR_svc'
> >> /tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with this architecture. -- `mrs r3,SP_abt'
> >>
> >> Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
> >> we know the functions won't ever be called on pre-ARMv7VE machines.
> >> Unfortunately, older compiler versions (4.8 and earlier) do not understand
> >> that flag, so we still need to keep the asm around.
> >
> > Does "not understand" mean "ignores" or do we get an error?
> 
> We get an error, which is why I used the $(call cc-option) Makefile
> helper to check if the compiler supports it.
> 

Right.

> >> Backporting to stable kernels (4.6+) is needed to allow those to be built
> >> with future compilers as well.
> >
> > This builds on the toolchains I have on my machine, so:
> >
> > Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> >
> > Are you applying this via a tree with other fixes or would you like me
> > to carry it in the kvmarm tree?
> 
> Please pick it up in your tree.
> 
Will do.

Thanks,
-Christoffer
