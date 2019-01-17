Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CE5C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F5E20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547741889;
	bh=lNXozYOQUcjQzfMz9W0qROc8mz8jYhttZGPahphyo6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IeZvJEPGeY6D8DrVuSVTq0SmSI/BzRSeKtTs/waDoTPEieTWRBPCEEY2bNNiuEyu6
	 fgitBGVUWD7Ipr7R90F9yUWmf8wvGneBJxxHVKwbA6aSN7x3fknjYrP3uzdZBN5L2y
	 vvwJJ+YSgXorWcGl9cLp/e5Z8Stbjeh9FC52CE3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfAQQSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:18:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46153 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfAQQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:18:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so6543037oif.13;
        Thu, 17 Jan 2019 08:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SH8kFksfY6PHQ8H5TEKZ3PasvULOOTnq0NYxnZLpymU=;
        b=B7voyNsSvs0EFKuyPc9y1rOO//ILYnGB6T6/9pj3Iq4NFsMzshs4rrFmMhvjigw55H
         Zs/YwXSLmtPY5U1b4Dvwp2LanRKRgDB1++rBj3LdPqPA92b8PiGSochpjJJMWPSbufR/
         iiAIBbidbaNGg0DY16e+eJI37z2qPVEYoj6L4v9VvXteGH34uY1f+kgKza3gsr5yPAVF
         VnczDPS/QcmiV2Mi45b6zSdhZ4i+9fLmw5/eRHjq/vzN8Na1emtgUg/RiFfntewTLNyF
         8iuN7dt3npB9KE9Ad73twTDIefTu2tdETP0UFDnc2crJZet5TdUngE1M2btyS2gGXA8L
         7TkA==
X-Gm-Message-State: AJcUukeZdTUJBGpslCDZwWOFRPAatArZ/YGZEI/hb8fkZ8azfgEdgRIn
        +1Dj0QACLPnEQIFXHx1EPw==
X-Google-Smtp-Source: ALg8bN4UOLyZ3cFya8Ty86igEAaKIJWx9rpXM8gCL/Y2ZhPcPEByP777nr6zG504n1NHYoIgYuJvfA==
X-Received: by 2002:aca:3209:: with SMTP id y9mr6613048oiy.198.1547741885350;
        Thu, 17 Jan 2019 08:18:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u109sm767931otb.8.2019.01.17.08.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:18:04 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:18:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190117161804.GA5760@bogus>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:46:25PM +0000, Viorel Suman wrote:
> The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> drivers and related DT bindings documentation.
> 
> Changes since V2:
> 1. Moved "dais" node from machine driver DTS node to device driver DTS node
>   as suggested by Rob.

That was not what I suggested. You still have a virtual node which looks 
to me to be unnecessary.

> 
> Changes since V1:
> 1. Original patch split into distinct patches for the device driver and
>   DT binding documentation.
> 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
>   RM-compliant.
> 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> 4. Added machine driver and related DT binding documentation.
> 
> Viorel Suman (4):
>   ASoC: fsl: Add Audio Mixer CPU DAI driver
>   ASoC: add fsl_audmix DT binding documentation
>   ASoC: fsl: Add Audio Mixer machine driver
>   ASoC: add imx-audmix DT binding documentation
> 
>  .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
>  .../devicetree/bindings/sound/imx-audmix.txt       |  18 +
>  sound/soc/fsl/Kconfig                              |  16 +
>  sound/soc/fsl/Makefile                             |   5 +
>  sound/soc/fsl/fsl_audmix.c                         | 551 +++++++++++++++++++++
>  sound/soc/fsl/fsl_audmix.h                         | 102 ++++
>  sound/soc/fsl/imx-audmix.c                         | 334 +++++++++++++
>  7 files changed, 1076 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
>  create mode 100644 sound/soc/fsl/fsl_audmix.c
>  create mode 100644 sound/soc/fsl/fsl_audmix.h
>  create mode 100644 sound/soc/fsl/imx-audmix.c
> 
> -- 
> 2.7.4
> 
