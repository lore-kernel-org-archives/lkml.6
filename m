Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8152192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+CP5nR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfBOTEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:04:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35406 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBOTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:04:42 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so5397247plo.2;
        Fri, 15 Feb 2019 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vAmkJKpKjbcU4YV6qJDo5SKqHHC6M8bye+VBPOPUYfk=;
        b=s+CP5nR19k91190z515VCZ8SVidFb2UurVRqtYT3iwX2HscarCw18wZFWzILIfO/6G
         2MJFdqTUBnh+/IjP98ER/g8mQ8Jzu4VNE1A13rqK5wkeOCMQW4fRRIQ1bG6BaMP3DKRV
         PBJnc8oASGtspH9cnShlHctK5FniUCE7dvAA2p4Kv4EW2ZA/aHwCF5g6G6AT99NpOEaJ
         vc8hStHHtAEicD5lex/E9sjdlV0JvldqRhRYWl6p+qdTwX30qyxgTdPnx+qjyP6fhFk2
         NDTxuhO8G8trrnpnWUQt+lFn8Ee0h1yL2tdn9FFXX5s53+mNP7gFb3DzGEJCFbC7xp0I
         dnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vAmkJKpKjbcU4YV6qJDo5SKqHHC6M8bye+VBPOPUYfk=;
        b=hwDlhE1Yk/4sXpauxq/RG4TLeg0s9kGD9mqgllbe/QCKtM4qaXZx95oSag6mXUAW0p
         QZp/yN/eAGRDRA0zJFyLeMWHoybzf+1U8z+StTWSHP3v77G0rqbNcDm5qbvVT0WAG5K1
         o/V+XPVFxVpj+2l1Qtyb+4BgNBqtHv8XGapS3uA9GyF6+oZDB0W3DapN49EJ95VsbgU1
         +nc3Zu9G2RncL8fmBp+uCA/MS4Vy9XYwm9U6pkZyCRuTQCilMTRgyKRIMKW5UNhqdqn7
         9x7jd+UzRKa/aaQ7/5Y9udjyBZ9dmVAPtH9p50toT4/o5xYMe9SevRSOb9gLVq5d4kKx
         5abA==
X-Gm-Message-State: AHQUAuYYTbkqKuW0uDYLtSdPZ/uSG35Gx7wsg+ejNPqos54xS5Sv1esA
        FkPs6nOIYRXKsu0hBKGz/mM=
X-Google-Smtp-Source: AHgI3IZX40vn+XPUzARhqOkTlnNb5+igf/ucD5TK3wbuZU2Aop03oXppp6EuCpRNz7LMIudJoexS4w==
X-Received: by 2002:a17:902:c05:: with SMTP id 5mr11779238pls.155.1550257482128;
        Fri, 15 Feb 2019 11:04:42 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f6sm10225864pfc.88.2019.02.15.11.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 11:04:41 -0800 (PST)
Date:   Fri, 15 Feb 2019 11:04:39 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
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
Subject: Re: [PATCH v5 0/3] Add NXP AUDMIX device and machine drivers
Message-ID: <20190215190438.GB19299@Asurada-Nvidia.nvidia.com>
References: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 02:01:32PM +0000, Viorel Suman wrote:
> The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> drivers and related DT bindings documentation.

For this series,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

And Rob gave his at the previous version already.

Thanks.

> Changes since V4:
> 1. Removed "model" attribute from device driver DT bindings documentation
>    as suggested by Nicolin.
> 
> Changes since V3:
> 1. Removed machine driver DT bindings documentation.
> 2. Trigger machine driver probe from device driver as suggested by Nicolin.
> 
> Changes since V2:
> 1. Moved "dais" node from machine driver DTS node to device driver DTS node
>   as suggested by Rob.
> 
> Changes since V1:
> 1. Original patch split into distinct patches for the device driver and
>   DT binding documentation.
> 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
>   RM-compliant.
> 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> 4. Added machine driver and related DT binding documentation.
> 
> Viorel Suman (3):
>   ASoC: fsl: Add Audio Mixer CPU DAI driver
>   ASoC: add fsl_audmix DT binding documentation
>   ASoC: fsl: Add Audio Mixer machine driver
> 
>  .../devicetree/bindings/sound/fsl,audmix.txt       |  50 ++
>  sound/soc/fsl/Kconfig                              |  16 +
>  sound/soc/fsl/Makefile                             |   5 +
>  sound/soc/fsl/fsl_audmix.c                         | 578 +++++++++++++++++++++
>  sound/soc/fsl/fsl_audmix.h                         | 102 ++++
>  sound/soc/fsl/imx-audmix.c                         | 327 ++++++++++++
>  6 files changed, 1078 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
>  create mode 100644 sound/soc/fsl/fsl_audmix.c
>  create mode 100644 sound/soc/fsl/fsl_audmix.h
>  create mode 100644 sound/soc/fsl/imx-audmix.c
> 
> -- 
> 2.7.4
> 
