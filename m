Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8361C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320620855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f85AT9lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfAQWWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:22:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41277 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfAQWWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:22:22 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so5360181plm.8;
        Thu, 17 Jan 2019 14:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NWFyafAhtozSP94uFRAXRLbBQMHiYMJF3/gMNN6tQ9Y=;
        b=f85AT9lGNN/WCPVNtKsfupi8iRgN3+OkiFF7wsmR57H+A9CNoBy4V4sqWdEgMQJ1Qu
         Z3y6GMWzOUxv4scJqZatUyShstRMzEKzEkNi+4R+O50SkEX31+HEZ6kWWIsbcLK6q5V+
         LH+8D9tTi6vCNAvI7jnewwI3fCAHmEvz8d2GaHGEeB4erLMHQmSZ6N2JbfII56hGU+0x
         Qfcb78EyCH/LfXqScd7hr1MozH5VGzYZnt9Zrzv0RQGgigKAWc1Qda7vhO7Wxh/1ETNm
         abFbOyU4ErECeleaCIW0AXOTRnQ4ANuApFbccw9sNxpsvq1wbpqx4zE55WlyMURFwyOF
         IyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NWFyafAhtozSP94uFRAXRLbBQMHiYMJF3/gMNN6tQ9Y=;
        b=oCpeNf/iQxrB5gR9H5nZTwZtulj14jOQUZQCtDe3OWbBpnWkifMD4WRX8OG+KA3/IP
         9nHfLuz2hXognwhfkUOKoc3WUQHh8thHQF0j3qF9ZnADHQmEcyPoOMAmAyL4TEvUQPL1
         MY7UuKcxdNPqFyLkPaoPw+otxklUjfTXfXN2vB9Tp1IOqAxxtJ0MnQ3+wO4kVqDO/2/5
         b20AwyX/DYwadl8m14DrbRusgvQKQH/6IzRay+Y8fLsBXMayvtfwycDw/WLWyW/BTWM9
         FkJswEn3n3Ee3VxPkBd1AsMXS2BE/PkTAcpGUfVqjYZR2CDLNJ14HaKxJpJeoZ4JQMGL
         fj8w==
X-Gm-Message-State: AJcUukfW3DXqTKtN0hYjv9DD3x7Yt0seHFRPHZ5Y7XP9QJglWbaJWxEP
        fD2h1rszLf2ltrnHY5E3R+8=
X-Google-Smtp-Source: ALg8bN7fPcrP9wDsFoyyie8VdAFot+1nhrRla0jKnuWndA3gSKABPU2aCF+8sSwbbRp/s085+SxyLw==
X-Received: by 2002:a17:902:9047:: with SMTP id w7mr16857869plz.270.1547763741568;
        Thu, 17 Jan 2019 14:22:21 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z8sm3383479pgg.62.2019.01.17.14.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:22:21 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:22:18 -0800
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
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190117222218.GF16918@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Yea, it makes a lot of sense. Otherwise, since the connection
between IP blocks is fixed inside the SoC, the virtual sound
node would need to be put in the soc-level dtsi, which sounds
odd to me.

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

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
