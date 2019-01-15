Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34F4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9E320657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547585651;
	bh=l5DanBIYIMzOPbxSSdN1GhDEgnQk7FcBx+02kEjAKMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J2tm0rNZoE8+qMDvVSJezrgzLNgxLXlN51MLAGnOiw57Y0zvgCVdtlD9d2NGLWgB5
	 6tDVwClZq7qODKYNdKq3uKKRlQGx6b7qXMHo2VkS5D6XAte3G32Ew6DPj8ZBZ+VVCk
	 Azti6Wnl7DCBlefD0eGkEunGmUmopNhQ0zIey54o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbfAOUyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:54:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39726 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbfAOUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:54:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so3263410oia.6;
        Tue, 15 Jan 2019 12:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tCufrnVtPaZqOkEYBnOPtUAF+6VFtPE6s/wKoCMVLps=;
        b=L4txQzisIurvtNc/U27aNRkRab84Rh6iFyB7NtlyG+7xBgzvI7tymITY2EhPfUACOt
         GyDa4wktiVHtfoXYq0qVurP7apSpvla82WBLGlZ2/XZkxaCvPKB8aoTNXnuKRI3+yeaG
         DfmLe3G3tEvlOoZg7m5L3+pGNi8XgfmziI4OiiTdxOBS3FOYNN8bVQZr4rzCyKWAEMH+
         bkpVZfgAL/UXZZscJYu8vxtAVX+gEfpNhXosAJnJtzk3eyIQVabt43K8buQAJsE/+8cM
         2Ol7xCBInj3cS3m5X0ZRJON9PqZyJDwmL+Daug7ByozMK1MrByrkV7jYfxAmoBFqMebQ
         Eoqg==
X-Gm-Message-State: AJcUukcf40MD4o6EthC5WdwTHu22dUtmbF90F1loyT5AQrPMuj+BVUOk
        uIu6NkGNznCfDAgCGAI9Aw==
X-Google-Smtp-Source: ALg8bN7q9lekpN6ufkUFXNwCbIBXkinQRwI9hfb5S1WrrQenRCh3yCTF4q6/rW13xAfvdmrkeHc4cg==
X-Received: by 2002:aca:ac13:: with SMTP id v19mr2866254oie.160.1547585648579;
        Tue, 15 Jan 2019 12:54:08 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id h24sm1929230otq.11.2019.01.15.12.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:54:07 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:54:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190115205407.GA3442@bogus>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952716-2743-3-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 13:05:47 +0000, Viorel Suman wrote:
> Add the DT binding documentation for NXP Audio Mixer
> CPU DAI driver.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,audmix.txt       | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
