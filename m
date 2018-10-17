Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBFECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6490A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6490A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeJREZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:25:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43064 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbeJREZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:25:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id s69-v6so22156632oie.10;
        Wed, 17 Oct 2018 13:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEcdy7QEDbNlcX07BFBN89zLOirmmnq91X/i2VMyaL8=;
        b=LBzmzB54J3c9Ulg9gv/o0GOVOyFrWdvy5AAoILkCJcfC+NlXWF6yCPLhYzYBVrpj5H
         /bSn4KbIoycfCE0MYURngdi6vjt+ZwqCQOHrMH2IBg5I3UtUaVmbQ5dJ7M9KVfszMdNZ
         wC9iTnoV8DRcWOwx9aeqRwKX9bm6fkff7h7+i0GpvP9pjjFBTv0vvc+kPlaoOmeSAvWZ
         bmaP6zBeNobmx9duXVKKcSwSUrcKuZ66Wr4WePu1BqRdToA7EczemTc7NjhmtCHNEWUf
         beuinU4ecTtURIh6SmGpGcHs8nlnqQkvXV+cOheqTxooHVUh8CDWjAlbXw1F4gCXsdFN
         lDzw==
X-Gm-Message-State: ABuFfojBwJ4Y3HttlKVEUMaARpatsZBMGPcuIHJ2PLF6N7HWvOEPkEUI
        bXI+sqcsjwwbov9OHpKcBiUrBJguzzR+bicwoTs=
X-Google-Smtp-Source: ACcGV63AaImc1z7tHmL0M6Msh6TSOdjWNVL1mke8ThowGM2MOldlYt/WOW24+5D3Tl4K3VZSolDd5sb68toPmLpKSvg=
X-Received: by 2002:aca:ab8b:: with SMTP id u133-v6mr15347446oie.57.1539808099156;
 Wed, 17 Oct 2018 13:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180606193811.16007-1-malat@debian.org> <20180606193811.16007-2-malat@debian.org>
In-Reply-To: <20180606193811.16007-2-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 17 Oct 2018 22:28:08 +0200
Message-ID: <CA+7wUswf1+3E12-qs0c0L7PjPWsndYo2oe_b=Gv5vXF0gd+Ttg@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: Ci20: Enable SND_JZ4740_SOC driver
To:     James Hogan <jhogan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 9:38 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> Update the Ci20's defconfig to enable the JZ4780's SND driver.
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/configs/ci20_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
> index e1c14f6af824..0c08c7675b42 100644
> --- a/arch/mips/configs/ci20_defconfig
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -104,6 +104,10 @@ CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_DEBUG=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  # CONFIG_VGA_CONSOLE is not set
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_JZ4740_SOC=y

technically I am also missing: CONFIG_SND_JZ4740_SOC_I2S=y

>  # CONFIG_HID is not set
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_MMC=y
> --
> 2.11.0
>
