Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D51C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5247420883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uD3n+ZhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5247420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeKJFbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:31:33 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36648 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbeKJFbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:31:33 -0500
Received: by mail-io1-f67.google.com with SMTP id o19-v6so2125328iod.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 11:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJATO+9KiyXp5QyBy/QxIPnCaa+xVOhOAcJwwMDNVIE=;
        b=uD3n+ZhTEK3CH38Y7hBgrdHB//3VwtAVyQIp+0YkSBTLfIjdmt7g6g6JhTiRZR/jn3
         oEykcRSfdVMqO9XPiGFXeIFNu+B9rWGyq/hS+7wLSnlNRomDiThKFIvLFz0MvbGrF+1r
         7AbiJDP89j77FJGoSxQeYSwZtlj0xS7wLI6Ayl93VHXgsqX4KKkhKGuiUs6TebaqcSL5
         9tXP5B5hmEvSLQ/nvUOd1aBb6zN40j3VhEPjSaQJ7CZFTahGphZIdtoEeuazBRBrMEKu
         ujkxxEzdbmaPe1nhCKvCbsg3W+4WVlBFhHLYLa5mdr1zbRn9tBuSlnqv+td5QxfIOcAF
         fS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJATO+9KiyXp5QyBy/QxIPnCaa+xVOhOAcJwwMDNVIE=;
        b=kohJDYhWdZ7rTY1qBpieYjuf4lxcDNiYja2uR7UvknaCMw6A/iectPcT3wXc2snc5S
         i1iOvG8JuNBgXt7j6LQARWl7nlQNmcH/mD2gJjapVxK3ALfPqnnphQ0SbSY4hGNTqQcU
         4JvrgMVkp46hwwMb+ml0aXddjou7q4vPd26cevkZo4WeIUo5bT4aeEeE83GyAe9kN1Wq
         0acjemxs4dwKc4OedLZfO2ZNuUCWup5T1Fxfb6h9UsDstHvqsf4imbbxKrytdCDYvoot
         /BvYhNbnLt9bkmmg6QQGHifP/1Om7kpT3ryy8kSuyqdqCqqIhtvE+YrkJIisdqJlF9H5
         bjpA==
X-Gm-Message-State: AGRZ1gLZkyYS75xlY4hylkkIFsJtKRU7+RNRWKOe8PqEHJRS77g0lm8Z
        3aiYRKW6Ev7WOxM/t2ja6NzE9DagFP2n1AWWk0vn0Q==
X-Google-Smtp-Source: AJdET5cBZpxN+8YHAA9a+1ccIxtp3g+WnWg4ycxt8Symp7haFkNSx4kpfspUWUQOPMuRmIhy2VVlTui4WIljGXjdgyM=
X-Received: by 2002:a6b:bb44:: with SMTP id l65-v6mr8264662iof.185.1541792969360;
 Fri, 09 Nov 2018 11:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20181010174923.GA29921@connor-Z97X-Gaming-7> <s5hmur3pzg2.wl-tiwai@suse.de>
 <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
 <CAM8Agx38RCN5xUPwV-YP0JyMtxNj9tveou4fHCDK1zyvE0a+Tg@mail.gmail.com> <CAM8Agx1VK3QNV52RmiSsrD8042oFRKZg-w6WFa7SPfebVa4hQQ@mail.gmail.com>
In-Reply-To: <CAM8Agx1VK3QNV52RmiSsrD8042oFRKZg-w6WFa7SPfebVa4hQQ@mail.gmail.com>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Fri, 9 Nov 2018 14:49:22 -0500
Message-ID: <CAM8Agx2KYOZK97J7yiM9JvNF1bxiAKNtA_YDegtLMVAYiWKEXQ@mail.gmail.com>
Subject: Re: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
To:     jwboyer@kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, linux-firmware@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay... So, my contact at Creative gave me an email as the 'sign-off
party' for firmware submission. As far as I'm aware, sign-offs also
need names attached, correct? So I'll ask for that. However, they
still want me to send it.

Will that be okay? Would you be more comfortable if I get you in
contact with someone at Creative,Josh?

I apologize for being kind of difficult, I'm doing what I can. Let me
know what I need to do, and I'll do my best.

Thanks,
Connor.
On Sun, Nov 4, 2018 at 1:00 AM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Okay, just got a response from the guy at Creative. He said they'll
> try to sort it out this week. Just a heads up. :)
> On Wed, Oct 24, 2018 at 12:22 PM Connor McAdams <conmanx360@gmail.com> wrote:
> >
> > Understood. I will see what I can do. I already had them contact
> > Takashi, but I will ask if they're willing to give a sign-off. If
> > they're having trouble, is it okay to have them contact you Josh?
> >
> > Let me know.
> > On Wed, Oct 24, 2018 at 9:44 AM Josh Boyer <jwboyer@kernel.org> wrote:
> > >
> > > On Wed, Oct 24, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Wed, 10 Oct 2018 19:49:23 +0200,
> > > > Connor McAdams wrote:
> > > > >
> > > > > The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:
> > > > >
> > > > >   Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)
> > > > >
> > > > > are available in the git repository at:
> > > > >
> > > > >   git@github.com:Conmanx360/linux-firmware.git
> > > > >
> > > > > for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:
> > > > >
> > > > >   linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > These are additional firmware files for CA0132 based sound cards.
> > > > >
> > > > > Creative has given me permission through email to send these to the
> > > > > linux-firmware repository under the same license as the previous ca0132
> > > > > firmware. I asked my contact if they would sign-off on it, but they said
> > > > > to go ahead and submit it and that if there was any issue to contact
> > > > > them.
> > > > >
> > > > > If you need to contact them, or if there's more info needed, let me know
> > > > > and I can get see what I can do.
> > >
> > > I'd really like to see a Sign-off from someone at Creative.  It's not
> > > that I don't trust your word that they agreed to it, but we have
> > > nothing to go back and verify they actually agreed to allow this to be
> > > redistributable, etc.
> > >
> > > josh
> > >
> > > > > ----------------------------------------------------------------
> > > > > Connor McAdams (1):
> > > > >       linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec
> > > > >
> > > > >  WHENCE            |   2 ++
> > > > >  ctefx-desktop.bin | Bin 0 -> 655856 bytes
> > > > >  ctefx-r3di.bin    | Bin 0 -> 655816 bytes
> > > > >  3 files changed, 2 insertions(+)
> > > > >  create mode 100644 ctefx-desktop.bin
> > > > >  create mode 100644 ctefx-r3di.bin
> > > >
> > > > Please can anyone take a look at this pull request?
> > > >
> > > > It's mandatory for the CA0132-based cards that are now supported
> > > > better in the upstream kernel tree.
> > > >
> > > >
> > > > Thanks!
> > > >
> > > > Takashi
