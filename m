Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2283497-1522784955-2-2425852388635190228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522784955; b=eqGLjDJ5rhwMin31AGZKMolKGcEA05vgpsE8U3BQNf7QHVSTSR
    gnoImAC+uqv5Nf3Od92tSc2GWB8aSCLBnVI3vFfuKq+vM431fY8umg/NWlFmZfT5
    0hetiaOCMVH5anpYaqxswXVu2DABJSHuMTTd52Yb/2d6UJ/5LKWaDqYUXvzPLgsF
    uqtINZ1stuuYb1JJQtT/g5sp8vtHZd9Uewx0kxqkobviT6ifkro/xxYuuiyDyB9u
    fcx68HenNO0nT46Bx0SofDPqGId41dCfHgwmHLQDmhggvp/4JilqsNa0g0Uwyo6i
    zwYF1CI6+tUdjDksnyyyXwNuaCFQPSuJebZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-transfer-encoding:date
    :message-id:sender:list-id; s=fm2; t=1522784955; bh=TnoXjwkK+jo4
    z8BXdJJtAmY0Bt4NIoadEJvkY/S9EqQ=; b=B4bzIwUQ1MVI33QZ+aDxadpGNmwI
    NFzik7NDbccmrk4LBe5xoESolJjn1buuXc+R1Q8zNs0BGM2n4m7Uz3wSSgadw2nu
    +2LsWBKn6+IT1kiM670fen2abamU00lC0qxYbAqfBoKi2r5FuuIzdPVZcUm/uLz7
    njPvx2elenudKVtA+WeZuRjWxgCB4isTZe50R3slvK7cb8xtouton+hG1luZt+Yp
    ORK1m7ueObcFbJgNONWYPjxT/OAnXPwQhEGCF9+uep6O/ZeRn8+ITSvKik1478W1
    WiH+aEUMBUflD09XFOPSmjM/4Kk9oSnqa1Ebula9JwuD4xKxBWyr9+y7/g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNc2cdQJ4TCh+LuXuHZxLepSmV68a9JlR4WylXJY/SiOTXmsPxj/RH3RfcPtna6Q6ZfE6Y0oVrv5b6amm4xfvSO/9yFM7A/FbWzN1H3Yzy7JCYxFkEof
    ArpvmSrDvUDI5LyaYSpVe5S4j8FEcKTbFDPtqQnK959yobAlMxEZprilB4cpweEE9xnBncBSu2ttuSzgG47N+/9vNq5hC7SKysjvjDGOrMdE/VE00o+sI3Ut
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=YNvgIY0GIA5ngrT3QewA:9 a=4zs0w9JVrZFrrPAq:21
    a=2bq9cp5e3dVfFakc:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeDCTtO convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Tue, 3 Apr 2018 15:49:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752420AbeDCTtN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 15:49:13 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
References: <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com> <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk> <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <9758.1522775763@warthog.procyon.org.uk>
To: Andy Lutomirski <luto@kernel.org>
Cc: dhowells@redhat.com, Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date: Tue, 03 Apr 2018 20:49:04 +0100
Message-ID: <13189.1522784944@warthog.procyon.org.uk>
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andy Lutomirski <luto@kernel.org> wrote:

> >>> A kernel that allows users arbitrary access to ring 0 is just an
> >>> overfeatured bootloader. Why would you want secure boot in that case?
> >>
> >> To get a chain of trust.
> >
> > You don't have a chain of trust that you can trust in that case.
> >
> Please elaborate on why I can’t trust it.

If the user can arbitrarily modify the running kernel image, you cannot trust
anything.  You cannot determine the trustworthiness of something because your
basis for determining that trust can be compromised.

> Please also elaborate on how lockdown helps at all.

Stopping the kernel from being arbitrarily modified allows you to preserve
your trust.

Stopping the kernel from being arbitrarily read stops any encryption keys it
may be using from being retrieved.

And, if you can't guarantee the trustworthiness of your own image, you can't
pass the trust onto the next image that you kexec.

Now, I can't guarantee that my patches close every hole, they just close all
the holes I know about - including some obscure ones like using DMA-capable
ISA devices to hack/access the kernel image.

David
