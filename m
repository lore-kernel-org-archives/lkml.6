Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8C1ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821C6208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nu/a/eQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821C6208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeGNOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 10:55:45 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45721 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbeGNOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 10:55:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so41695666oic.12;
        Sat, 14 Jul 2018 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TGt5jlVQ89vHBH7LGrpPW5YsixjskXx/cetx6/zrrtA=;
        b=nu/a/eQAkZ9N0fTqAdAz004mLEbq7yqg/aWkeJIS2wrw+PxnVEs4BcrwSEDUJi70uP
         pkLq3r+GXRdXJ7aMXDmvk8uetyV9r4jNMQAUisncNb3heTjAorCtqLygnBAH0hIjsw75
         Zx1vuAly7EC33tMRWDyGK6UN8M3vh8kiipfZr6OuIMaZtYS6dbtxiThxMNRTAAn/tVWk
         3QGgCftMD0bnzUWKls2iQl/wZIKcCCmi8USRzFN2S6sNwToKSQCAkYu21Bf2sWIaKIgZ
         DfyKc8V1fVSNqFl8Zj1WCVzBJXdIx9kJBk99MDzrpf7UxykRHauFKduvlSJJ7jL7+jZp
         hv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TGt5jlVQ89vHBH7LGrpPW5YsixjskXx/cetx6/zrrtA=;
        b=nvwtQSrkpDH62OMwvhQGGjMPQ9BoKqQYurwlPso6Hmejk64xEFWUdip9CrxTqB8zi6
         uk/JvWdJX3QfkRsBUEZ5LwSeCLcMycFM01py5tbDvU9hBVTjJTTnlg2d3I+DymT+a+H3
         Awc5HVS5mvo4a07hGDxvZuxZDwAMIaB4vjhXoTB8U/NkSQg6hsu6m8Mjh5HtCESByhJq
         45lhMw/0L8Ojeq3Wz7r9lnF4aQLdSGTkNCpCgOIdUTzDpnX75VDRmtauu+WwbVCmZa1U
         mBGOnzAmXglPiIQxpFY71CD8Va06mU5nHSsuquPqgxwStEyH7+sW0kPM1K9WRhZukQ35
         oMjw==
X-Gm-Message-State: AOUpUlFfwc/QGddVB9gowlPsCWiBxr4aX6I6CZzq14CQ6kJYmuEirT94
        m0n7iqXPIXD24bdS5kM5y2xO82hqO52ZEaqktgk=
X-Google-Smtp-Source: AAOMgpdddxVk9GaTJ5sOY5vU5brtexaFHOiKvQoGT11ix5UWFReOUojbqaW+v7mLHt89rSoMTSmxX5aEw+KGw9Mwd7E=
X-Received: by 2002:aca:c70f:: with SMTP id x15-v6mr11765582oif.97.1531578986909;
 Sat, 14 Jul 2018 07:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180704224511.29350-1-yixun.lan@amlogic.com> <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
 <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
In-Reply-To: <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 14 Jul 2018 16:36:15 +0200
Message-ID: <CAFBinCDqHEh_9Gt65FHgt-4e8o1T-YZqp9_kqS1ajqqxJ1qfuw@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
To:     linus.walleij@linaro.org
Cc:     yixun.lan@amlogic.com, carlo@caione.org, b.galvani@gmail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com, robh@kernel.org, xingyu.chen@amlogic.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:07 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Linus,
>
> On Mon, Jul 9, 2018 at 3:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Wed, Jul 4, 2018 at 4:48 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
> > >
> > > This patch series try to add pinctrl driver support for
> > > the Meson-G12A SoC.
> > >
> > >
> > > Yixun Lan (3):
> > >   documentation: Add compatibles for Amlogic Meson G12A pin controllers
> > >   dt-bindings: pinctrl: meson-g12a: document pin name
> > >   pinctrl: meson-g12a: add pinctrl driver support
> >
> > Overall this looks good to me, could we get some review or ACKs
> > from Beniamino, Martin and/or Carlo as an indication that everything
> > seems all right before I apply the series?
> I do not have any documentation for this hardware (I'm not even sure
> if this is the successor to AXG/"the Audio SoCs" or rather a successor
> of GXL or GXM/"the OTT/STB SoCs"
for those who are interested: according to [0] the marketing name of
this SoC will be "A311D" - specs from the linked PDF:
- CPU: Quad Cortex-A73 + Dual Cortex-A53 (max frequency: TBD)
- GPU: ARM G52 MP4 (4ppc)
- Memory: DDR3/4 LPDDR3/4
- Video decoding: 4K H265&VP9&AVS2
- Video Encoding: 1080P H264 H265
- HDMI-Tx: 4K2K
- Ethernet: 10/100M/1000M
- AV output: CVBS
- IP License: Dolby, DTS

W400 is the reference board for this SoC, it comes with:
- EMMC
- WIFI AP6398S
- DDR 2GB

if I had to guess then I would say it's the successor of the GXL (or
GXM?) family


Regards
Martin


[0] http://openlinux.amlogic.com:8000/download/doc/Amlogic_A311D_Buildroot_Preview_Release_Notes_V20180706.pdf
