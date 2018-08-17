Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8D1208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8D1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lxorguk.ukuu.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeHQUEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:04:47 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:48812 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbeHQUEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:04:46 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id w7HH0KMj018702;
        Fri, 17 Aug 2018 18:00:20 +0100
Date:   Fri, 17 Aug 2018 18:00:19 +0100
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
Message-ID: <20180817180019.3f4366be@alans-desktop>
In-Reply-To: <1534431585.3166.4.camel@HansenPartnership.com>
References: <1534429345.3166.1.camel@HansenPartnership.com>
        <20180815185812.GC29541@redhat.com>
        <20180815100053.13609-1-yannik@sembritzki.me>
        <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
        <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
        <20180815174247.GB29541@redhat.com>
        <4911.1534421610@warthog.procyon.org.uk>
        <25236.1534430630@warthog.procyon.org.uk>
        <1534431585.3166.4.camel@HansenPartnership.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm actually not talking about UEFI storage, just the UEFI secure boot
> database.  I think we might come up with a viable model for adding keys
> from a UEFI variable that isn't part of the secure boot database.

You also need to be able to remove or not trust the existing ones
including the Microsoft keys. Not trust probably makes the most sense.

If you trust those you are dead already, because there are existing
signed kernel images and Windows boot images that have known remote ring 0
exploits so I can just boot one of those and own you.

Since you are never going to make a Fedora update blacklist the previous
kernel image it's also not going to get fixed because it's a usability
problem.

> The reason for keeping this boundary is to do with the politics of
> breaches.  If we get a breach to the secure boot boundary, Microsoft
> and all the ODMs will help us hunt it down and plug it (They have no
> option because Windows is threatened by any breach to that boundary). 
> If we use the keys beyond the secure boot boundary and get a breach
> that only affects our use case no-one will help us because no-one will
> care.

Also the politics of control. A world where Red Hat, Microsoft and some
other parties together effectively control who gets to load modules into
a free OS for most users is not a good one - whatever the module licence.

Plus I'd have thought if your lawyers are scared of signing keys they'll
be even more terrified of the competition law impacts of gatekeeping 8)

Alan
