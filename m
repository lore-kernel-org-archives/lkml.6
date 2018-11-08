Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ED620837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfL3UTNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ED620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeKHLyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:54:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45620 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKHLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:54:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id g10so16768449otl.12;
        Wed, 07 Nov 2018 18:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfulK6y0TmSOofhkgrb/ZQyeyjv5YvqQ4s/da2+6Jls=;
        b=HfL3UTNOcFZL3tvKxV6ljtRlsaJ50xuSMzDkuvqedresIaaWzbHyvmHqBbaLb3imlr
         nmmwj4mvHOjHTfJOsJX6VjxpPXMsInk1eQr9JXGgPGG+HNELGRXs2QmoTmDC/u65LZza
         i/Nn3maBGMZJ6tF25k7V3gtxCA/uReW8jlcvcH+PiaLih1Lef9prEfWICiPqil30fD8M
         WIR4d08speweAI+kDVHxF3RWeKNXmFFq/x09ttTaueCd3PKzvm5VsRA5SkmNrCcKeRwy
         UDpuCTAzohQbn2Hf7teOI2eCHxHQnZi1RnMO4UFSDQWQTZ7TqJhRwOIJPMUCprCUfbEJ
         NJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfulK6y0TmSOofhkgrb/ZQyeyjv5YvqQ4s/da2+6Jls=;
        b=tuxfw9b+0SI/0+r/ovJLh69bMa2hqFGg/Q/bIF67rsgsTaawgFIrjL5NOLAoRF++R0
         tTeRQMx6otbgS/Wu2b66qmTs6p53NJBxjXmiAfGusxi1jtM8W57hT0CNtmDqWkIJBTBB
         y21gPuRHNjbK6nNYb31jpAsPqFcpWL14+CQykDD2/bgsya6z0jSTz1yOKqwLm0rvIC+C
         D09I1vj282FyUNlYP1aiHov/ezPz1CAzx9kYOdVpL6rSsuMCd8aCZH/sLuBZxvrwSrFE
         xRcuYtGOwuMc0SuV2dMgQ3N52mA5sBMUMD1ICyE/0vrBRayHJj9Y2KQFrGY+3zsYlINI
         SXpw==
X-Gm-Message-State: AGRZ1gJcjWLlQ78bZMCAiEA4bgdX5Se1fY6RT0dH2YJx1dY+Sb4k980f
        sAy4XE2LsOfAPAkeoIHz++GoivHDPPZANi+c1xQ=
X-Google-Smtp-Source: AJdET5eGw+q6Wq7K1YuB6VMmgzNB3DMbE8Pp1jd9mVeZGzgR1zBKiOxs9Azw/GKDyvbwV1Gr2mzvHwLkZX5fuFEX1AY=
X-Received: by 2002:a9d:437d:: with SMTP id y58mr1621407oti.287.1541643652985;
 Wed, 07 Nov 2018 18:20:52 -0800 (PST)
MIME-Version: 1.0
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com> <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 8 Nov 2018 00:20:45 -0200
Message-ID: <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Nov 7, 2018 at 11:24 PM Anson Huang <anson.huang@nxp.com> wrote:

> Regarding the fec2 settings in imx7d-sdb.dts, originally it uses Rev-A board (but some nodes are
> using Rev-B board), in this patch, I clean up all the settings in imx7d-sdb.dts using Rev-B board,
> so below is added to imx7d-sdb.dts for Rev-B board, and in imx7d-sdb-reva.dts I have to
> delete it, since Rev-A board has no this pin.
>
> -       pinctrl-0 = <&pinctrl_enet2>;
> +       pinctrl-0 = <&pinctrl_enet2 &pinctrl_enet2_epdc0_en>;
> +       pinctrl-assert-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;

"pinctrl-assert-gpios" only exists in the NXP vendor kernel, so you
cannot use such property in mainline.
