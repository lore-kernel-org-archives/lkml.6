Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646D120842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfBYJTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:19:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36531 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfBYJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:19:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id c2so4133335qkb.3;
        Mon, 25 Feb 2019 01:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl5z+HS6nWD0PvKbpb2FdFcWwLxwGMZEBWe8vjH+kyw=;
        b=Sp3cdysaMyUFrNThSKiUrS8HQv2bXpZZvtJ5cGUHMiSmtzw0RTX5/m2J+bZwPhYbon
         x5NJoFvbdfs2BJZHe6ERunEAcpf49/eMmtsPpKOhrN939xmUWccx9XWWoSTJLEy7kEL2
         nHBGqeqA0CpuF3CzQdauqRyWBdSninJxiZKA+a5H46ew3qr4wEsmmr/yVG3r86L/DFAp
         FA+Tyf6nDCgbsZI3nUBUYJvvpUSifaxfOPUT7c3rcQfvGxbHRbYxl7JPheKsrvEqBuAr
         rXDXIZMvk24n8axUqGtenO2uKBCXtvA2ZeF8QHCRWjNf9bgysA0SprfRRDEM//Me3Qh/
         dJ0g==
X-Gm-Message-State: AHQUAuaeYD1Kakx1zNKtODM6iADI2wDC/FJXBMp6vyekZInySYfzICLe
        D5WhjAtAXNFrRpVvCLeSTF+/nrnVUxsEO3Ef0rU=
X-Google-Smtp-Source: AHgI3IbBPTOyNgEcGfm+bE8oq5rwobqvkL3vpRy+Olk4dW5SlNNEjaU1+ZFShX0UcKPIjoxDR+oY5UzN66Xw1wfI9uU=
X-Received: by 2002:a37:d492:: with SMTP id s18mr11428837qks.343.1551086371433;
 Mon, 25 Feb 2019 01:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20190225123615.49bce7cd@canb.auug.org.au>
In-Reply-To: <20190225123615.49bce7cd@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Feb 2019 10:19:15 +0100
Message-ID: <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Takashi Iwai <tiwai@suse.de>, Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 2:36 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Takashi,
>
> Today's linux-next merge of the sound tree got conflicts in:
>
>   arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
>   arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>
> between commits:
>
>   5eef17ee764d ("arm64: tegra: p2972: Sort nodes properly")
>   be4f0dd347ad ("arm64: tegra: p2597: Sort nodes by unit-address")
>
> from the arm-soc tree and commit:
>
>   11ce4308307c ("arm64: tegra: custom name for hda sound card")
>
> from the sound tree.
>
> I fixed it up (see below - in tegra194-p2972-0000.dts. the line added
> just needed to be moved up a few lines) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

The merge looks fine to me, but I wonder about that commit
in the alsa tree, why does the sound card need a board specific
name?

I see this property being used in commit c0bde003a013 ("ALSA:
hda/tegra: sound card name from device tree"), which removes
a questionable use of the root compatible property, replacing
it with the new 'nvidia,model' property. We don't do this for any
other subsystem, so why does the sound subsystem export
information about the board as a string here?

(added ASoC maintainers to Cc for insight).

      Arnd
