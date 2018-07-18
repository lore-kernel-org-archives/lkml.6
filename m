Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0E4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F1020652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTb3nAHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeGRNed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:34:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33787 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeGRNed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:34:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id c15-v6so3867550qtp.0;
        Wed, 18 Jul 2018 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zhZPCrE3V6ereZd3mN+n2gDPruxVjBDDiTXKFLxXsOw=;
        b=DTb3nAHdlnYGtI3UT834veO2mZ25ii+GEyzhy1MELSjRDAhDpL72BOfMm3jLfpq534
         vpsvQIgDYn1iyZd+60NsimjQuAPuG1GGSTWsU0aOuW5nobusqTXPyM5jcc/91g30s8UH
         vnGG8Q+pZ4f80IT3BXeL1FTumLiDqIqXMLvCnFHAHu3jLXAAu7NJO44mZrQgAky6sfhd
         scOZru3BMKuKDl9fTUpeloVSZ4cdR/SUkZ8MWrsiMsDdtDQX26mnd82YIO67r57327Vd
         1bIyzWE0nAOPh74NERlYZnkBvru9stATWcJuLvr1ECQFzGpQl4FztJklF5vYnxgAToNR
         jyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zhZPCrE3V6ereZd3mN+n2gDPruxVjBDDiTXKFLxXsOw=;
        b=OlnrqGhhS/CsOYW3mrz7EhR8Iq6rJZE2a81uAnKLjZQtBcPz8IBwEce6ZxAAC7eQ7O
         G2piCkfhrbNZtI9lSD648TeG98IOP/dk+ESrPQYO+/3scxD3J9CVIxgn38OOqvQD5Tav
         WpyZqoPTIfRLzGyJjATCSD7cM+Et/sxW0b/NBIxkZKsv13fhPG7+VXbwDWh0rMWoYF5b
         rJ5wBIOllWl/nd8s1ElUS33PBM6HilWb7nyrOU+T2hBZ39QXdCGu7WEj7ja+3CHCkt6c
         rVhfgLMV74p4S6hqOphYJmHhzotJLTuk1uX9pbTr4f9u5/nrXZiwcqeRq2oX7qIKFVX6
         qnmw==
X-Gm-Message-State: AOUpUlEGAhzpPu8K9aqxMjhzHnx6NjUDjjivkgDBX2nA3Ln+K7Q6O7u9
        FAMGTEYgOBOcZvwYyYJFT5ORwuUAGZPko1UShZ0=
X-Google-Smtp-Source: AAOMgpfW7ENTO7J2TOoLoGLqkv33N9wPe3BZ8GN6NkvFsRRPS+Itj7oZsilE9sAzgjTcm2EEedI9/u9vd2WitcuHoJo=
X-Received: by 2002:ac8:26ee:: with SMTP id 43-v6mr5615865qtp.274.1531918603596;
 Wed, 18 Jul 2018 05:56:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a37:298b:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 05:56:43
 -0700 (PDT)
In-Reply-To: <20180718124448.2s2b3jxbsqt46cgu@flea>
References: <20180718105458.22304-1-jagan@amarulasolutions.com> <20180718124448.2s2b3jxbsqt46cgu@flea>
From:   Jagan Teki <jagannadh.teki@gmail.com>
Date:   Wed, 18 Jul 2018 18:26:43 +0530
Message-ID: <CAD6G_RQQyS=zeqvhBP8vVf5sHZgLwqX1SP0SKLHea_L4Od3woQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] arm64: allwinner: Add A64 DE2 HDMI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 6:14 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Wed, Jul 18, 2018 at 04:24:40PM +0530, Jagan Teki wrote:
>> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.
>>
>> A64 behaviour similar to Allwinner A83T where
>> Mixer0 => TCON0 => LVDS/RGB/MIPI-DSI
>> Mixer1 => TCON1 => HDMI
>> as per Display System Block Diagram from Allwinner_A64_User_Manual_V1.1.pdf
>>
>> This is third patch-set followed with previous RFC[1], first and second
>> series[2][3] and merely concentrated on HDMI pipeline through TCON1 and
>> rest will add eventually.
>>
>> This series fixed previous version comments
>> - Rebasing on linux-next
>> - sqash all pipeline components in one patch
>> - Enable all pipeline components in board dts
>> - about documenting fallback compatibles
>> - adding new compatible for mixer1
>
> You still haven't figured out the SRAM parts. We asked you to fix this
> in the v1 and the v2 already, and we're not going to merge this
> without those bits figured out properly.

Sorry I'm not sure what I'm trying to do on SRAM here because the last
mail, I have waited for Icenowy changes about simple_fb with sram_c on
ccu node and those are merged. can you elaborate please.

>
>> Log:
>> [    1.450984] Jagan: sun8i_mixer_probe
>> [    1.464981] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_mixer_ops)
>> [    1.472572] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_ops)
>> [    1.480676] sun8i-dw-hdmi 1ee0000.hdmi: Linked as a consumer to regulator.10
>> [    1.488738] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
>> [    1.498879] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
>> [    1.507372] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw_hdmi_ops)
>> [    1.514778] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [    1.521398] [drm] No driver support for vblank timestamp query.
>> [    1.684611] random: fast init done
>> [    2.011575] Console: switching to colour frame buffer device 180x56
>> [    2.049858] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
>> [    2.057268] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
>>
>> Note:
>> Pine64 boards are unable to get edid by default like other A64 boards,
>> but forcing 'video=HDMI-A-1:1920x1080@60D' kernel command line can
>> create edid with display on penel
>
> Then that needs to be figured out before it's enabled, instead of
> having a hack that barely works.

Any suggestion to work.
