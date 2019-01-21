Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A22AC37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EF22089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbZxAtRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfAUUmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:42:31 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33268 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAUUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:42:31 -0500
Received: by mail-vk1-f196.google.com with SMTP id d201so4881338vka.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJYcVP/usOckgmCLmB4Oqgx37htYBs2I+48ZUfpqbBo=;
        b=hbZxAtRmwPiZ1YigJp5NqAYqsSrjLJwot+V0NasW03d7S7VIAcwAbx6eoja2OIQuSk
         7fxkjVxVX4VsTjJcMgXoW/zC5kUTAkVt41kgpg/oPG6SD5wZFJTjxUssLUBD2XTKxR/b
         N8Z31szkDhDiaqEQAI8He116VaHJ6x+1HNCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJYcVP/usOckgmCLmB4Oqgx37htYBs2I+48ZUfpqbBo=;
        b=BG4cRH1laFtLpZsvceS87K0gBVchS6MPzaf04YX0nXOtr/a4wDNgMyQsMMmO2VRkos
         lB8qUv7eKVotlzGi9Y5GiU69ZvbZh+x1hVGOvUkaYJjrE7xsQrJZ5KpkZxBPC96zTyFo
         A3FcGeDBeTWL2KMtYS8esAWuirzLvDAivcyDiI0No+KI9XFjgI2W/I9SXgtC0AuULnyQ
         ReT2t/n+yOSwc4G2ULvMaiyTqW5T380GswmacN9Q4S6zp2PIna6xCc6hSSbgkcVhViEw
         E5F0BLdBxgdW7uauX+et0bOSv/5t03wljGddZpgHIx0g6Az3IUrdupeG+fAoEgZH4p0x
         uIAg==
X-Gm-Message-State: AJcUukcLa1K78f2Awuq896Pl8Q7iQ6/sbP7jNRBDQCLXM2I+yKZPYWns
        BjbQfsZhB00Xr2cKgm9IFy40rIsUOm4=
X-Google-Smtp-Source: ALg8bN6eV30QAIB+sTap0+nqRlGH6C/27CMdcUKF5B80a5/IskZ9E9uIU/6JceVRhBbEMiUDg+7Icg==
X-Received: by 2002:a1f:b406:: with SMTP id d6mr11504281vkf.63.1548103348829;
        Mon, 21 Jan 2019 12:42:28 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id w65sm27421289vsc.16.2019.01.21.12.42.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 12:42:27 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id d19so7325205uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:42:26 -0800 (PST)
X-Received: by 2002:ab0:470d:: with SMTP id h13mr12693596uac.122.1548103346355;
 Mon, 21 Jan 2019 12:42:26 -0800 (PST)
MIME-Version: 1.0
References: <1548076208-6442-1-git-send-email-jsteckli@amazon.de>
 <20190121183618.GP6118@tassilo.jf.intel.com> <20190121191541.GB4026@kroah.com>
In-Reply-To: <20190121191541.GB4026@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Jan 2019 09:42:13 +1300
X-Gmail-Original-Message-ID: <CAGXu5j+h9RKAND8+SJR6P6CQY_YO3ezjsnfuzLGsQbY=O4XCuw@mail.gmail.com>
Message-ID: <CAGXu5j+h9RKAND8+SJR6P6CQY_YO3ezjsnfuzLGsQbY=O4XCuw@mail.gmail.com>
Subject: Re: [RFC] x86/speculation: add L1 Terminal Fault / Foreshadow demo
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Julian Stecklina <jsteckli@amazon.de>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 21, 2019 at 10:36:18AM -0800, Andi Kleen wrote:
> > > +   /* Check the start address: needs to be page-aligned.. */
> > > +-  if (start & ~PAGE_MASK)
> > > ++  if (start & ~PAGE_MASK) {
> > > ++
> > > ++          /*
> > > ++           * XXX Hack
> > > ++           *
> > > ++           * We re-use this error case to show case a cache load gadget:
> > > ++           * There is a mispredicted branch, which leads to prefetching
> > > ++           * the cache with attacker controlled data.
> > > ++           */
> > > ++          asm volatile (
> >
> > Obviously that can never be added to a standard kernel.
>
> No, that's why it is a patch, right?  People want to test things, it's
> nice to have a way to easily do this.

What about adding something like it to drivers/misc/lkdtm/ instead?

It's not a "production" module, but it regularly get built for selftest builds.

-- 
Kees Cook
