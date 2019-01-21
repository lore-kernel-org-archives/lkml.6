Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC94C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808D120870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV9jlAn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfAUKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:33:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36706 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfAUKdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:33:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id k98so20132068otk.3;
        Mon, 21 Jan 2019 02:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdEhnWJkCHWRNmblm2LB3908LN3Tl4HvTULto94/Z4A=;
        b=qV9jlAn8duyMT4YMfujODNu0NCHXuvvt4xRPRUqYnkVug+Nmx4nr525SFhFmkLajOX
         U8DtskhtzfHs+svP35gcd/ul50GrPsk9cP+zsdq0/aYLAalxcudvx2So8LG1xGj7LMhF
         8oqiB7ja81fIEKPHLf2EmMoJRCfKQkfq6BIopeVPwQplCPMzhLmn4ucxAsLHjVs6Ny9x
         khE/gXylNXcAr5UKXNQBg0xmnoOsUYy1aFmLV3EtObSRlnyo6PoJ2mQale5rI9u5/amK
         KjgP5nOP2JbN0mgysMWrp+AfLZs/cR2WAHD4IfET+hp6FESPZUVmZt2MrTllpYMqvuIU
         MDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdEhnWJkCHWRNmblm2LB3908LN3Tl4HvTULto94/Z4A=;
        b=GYJPVTwk+D2Q/czG0xPu4K75uyCqTpCGBs1Cw3cQ4cSpMcuuAICQ6fwC9TSJLIMYW8
         TAXLIfraSoVZh+2P3cZAtIgQ9YRuBpgzZMguObk9bepSpxOkFrrBMB6IrDc2S0G1UFLe
         U7ExYPE9dFQeue2Mf8nxAajNhVI4SSOb2ve+6PNh1CvzqRBNnk4kiAFbnREtOWRwgPr4
         Y+8G39BgL6WTJOhrA6Whzhn4U5wnJ3qY9dzeXMtStOZnWQcwO4sWTsuOEadX+dMGIQAf
         /WsncWOmCkA50oaWQd042vDP22qOTRYvD2JuMG2exMxBb0Jf6jggMkL6cZovxfAmV7iJ
         lnhA==
X-Gm-Message-State: AJcUukeb60DPDVqJ4eQeyOX4KyumfsUkP0imNA2AWqHisgfSINMWfYl6
        JOFkmURTOpvjsOk5tWyURJG+g8buLS8sapDayeMv0w==
X-Google-Smtp-Source: ALg8bN7WdAzUCUMd2hhS2kKW1WSYdT5D+150b4ozxU224ZZBm8H+z4Wlj9Q7gTOs/Pc4JM9lGEVGWjdcNFrgzuejO3c=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr18558997otl.196.1548066817545;
 Mon, 21 Jan 2019 02:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20190121095705.27452-1-martyn.welch@collabora.com> <20190121095705.27452-2-martyn.welch@collabora.com>
In-Reply-To: <20190121095705.27452-2-martyn.welch@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 21 Jan 2019 08:33:31 -0200
Message-ID: <CAOMZO5ADc2-U3AR0eepf619qD1i6-oGrn8p1yb0m3HfWtTPscQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6: Add support for Phytec phyBOARD
 i.MX6UL Segin
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Stefan_Riedm=C3=BCller?= <s.riedmueller@phytec.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Christian Hemp <c.hemp@phytec.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 7:57 AM Martyn Welch <martyn.welch@collabora.com> wrote:
>
> The Phytec phyBOARD Segin is i.MX6 based SBC, available with either an
> i.MX6UL or i.MX6ULL SOM and various add-on boards.
>
> The following adds support for the "Full Featured" version of the Segin,
> which is provided with the i.MX6UL SOM and the PEB-EVAL-01 evaluation
> module.
>
> Its hardware specifications are:
>
>  * 512MB DDR3 memory
>  * 512MB NAND flash
>  * Dual 10/100 Ethernet
>  * USB Host and USB OTG
>  * RS232
>  * MicroSD external storage
>  * Audio, RS232, I2C, SPI, CAN headers
>  * Further I/O options via A/V and Expansion headers
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
