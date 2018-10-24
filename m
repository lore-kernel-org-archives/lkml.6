Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443F4C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD882082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSkI9a05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD882082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJXWNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXWNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:13:10 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BFAD20832
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540388699;
        bh=YzCYg+37oMrgrJOtsUSI2cS7VONvRzHXTSbnYUzZl2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fSkI9a051DY4i85F6TBMYUT5dPcblIR3TqFeUKhwBE0y/qZBJVcaEuU9yJaoKKqZr
         3Wa1qAKtfRajNrNyfMKzoNP90Rbnx/A6xwn/+IP16+IgbyAjtG52XFHQ2DSnje9lGP
         cYQSSBhXuxaeuqeKwhhXHK/aNuxoCike1PxSeBE4=
Received: by mail-qk1-f174.google.com with SMTP id p3-v6so3149606qkb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 06:44:59 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKwd/giq91IncyrLbq6ubdWgtZ4GR6Vc4zHBOlrhx2npmvXQMH3
        0y6cjkjXbPjx+YH/ae6pZse5pcMFKM/JFLXLci8=
X-Google-Smtp-Source: AJdET5fV2FPefgDZL9MxMKOdilVY2hKUPBWNmU+noh+tx/3iWuAvUzNfvP0RR5yVZfiB55CK25hWIfNV34WMDGZF860=
X-Received: by 2002:a37:6882:: with SMTP id d124-v6mr2329345qkc.96.1540388698381;
 Wed, 24 Oct 2018 06:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181010174923.GA29921@connor-Z97X-Gaming-7> <s5hmur3pzg2.wl-tiwai@suse.de>
In-Reply-To: <s5hmur3pzg2.wl-tiwai@suse.de>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Wed, 24 Oct 2018 09:44:47 -0400
X-Gmail-Original-Message-ID: <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
Message-ID: <CA+5PVA5xQvz+NftESMLUNY=5vR+A1x76sL64eXCR-KPqi6G+gg@mail.gmail.com>
Subject: Re: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Firmware <linux-firmware@kernel.org>, conmanx360@gmail.com,
        alsa-devel@alsa-project.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 3:37 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 10 Oct 2018 19:49:23 +0200,
> Connor McAdams wrote:
> >
> > The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:
> >
> >   Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)
> >
> > are available in the git repository at:
> >
> >   git@github.com:Conmanx360/linux-firmware.git
> >
> > for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:
> >
> >   linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)
> >
> > ----------------------------------------------------------------
> > These are additional firmware files for CA0132 based sound cards.
> >
> > Creative has given me permission through email to send these to the
> > linux-firmware repository under the same license as the previous ca0132
> > firmware. I asked my contact if they would sign-off on it, but they said
> > to go ahead and submit it and that if there was any issue to contact
> > them.
> >
> > If you need to contact them, or if there's more info needed, let me know
> > and I can get see what I can do.

I'd really like to see a Sign-off from someone at Creative.  It's not
that I don't trust your word that they agreed to it, but we have
nothing to go back and verify they actually agreed to allow this to be
redistributable, etc.

josh

> > ----------------------------------------------------------------
> > Connor McAdams (1):
> >       linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec
> >
> >  WHENCE            |   2 ++
> >  ctefx-desktop.bin | Bin 0 -> 655856 bytes
> >  ctefx-r3di.bin    | Bin 0 -> 655816 bytes
> >  3 files changed, 2 insertions(+)
> >  create mode 100644 ctefx-desktop.bin
> >  create mode 100644 ctefx-r3di.bin
>
> Please can anyone take a look at this pull request?
>
> It's mandatory for the CA0132-based cards that are now supported
> better in the upstream kernel tree.
>
>
> Thanks!
>
> Takashi
