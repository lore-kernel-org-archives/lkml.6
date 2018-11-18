Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52677C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F372080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qFtxy9Et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F372080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeKSA0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:26:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45210 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeKSA0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:26:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id b141so14229524oii.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 06:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdSGCjRZgffsav7sk/SA8962uIMDzhoxqg1M+qofYag=;
        b=qFtxy9EtTcnDgJVi0xf6NikOOL2FKcnd74M2xYG29OjjUf8vnAWmEM9ORssOWgO4px
         qV3e84jlGD9g+WdtUM5cvmOpSkpjs+5l4hzl7Be9u0v2Jh2Ha56IlQXlzhuXoSoRV6eW
         irFxbMDJdnflcknjTTo3aSN+YO5HeyZrDSo3TU9WzRgRu/aRuidFbr9dPPCOM/yUBa/P
         LbO6xceNoeBR8FwLXDs6yrz/+WAnNlEDnfkZTXqFkMzY9s76AXy+miwFi5TSgVfeiFm7
         Nvy2cYfCF+tx4YyXnstr1KIAcenEnnKg8zfsG6wwzlnYSFCWuVc1o2lGRqWnjMjVAY+E
         +OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdSGCjRZgffsav7sk/SA8962uIMDzhoxqg1M+qofYag=;
        b=NMFbMAoxrfJKu6WmO3BrKmTNh6M+4EeOFHAJNA+tHJD4jj06BbTygKJJh8MWutSMtw
         mOpISEqzl8ivXxhp8VT5DgxkaaAQGcKkDoK446JYlq9L1NsDqWEqT9xB6qr5CUi5DD5X
         kl7fIMaceVR2Ny8W3BixjTxdFXG3XeLL5i2kEZUdE2OptpSNFdDCtrAFBjokRZ3ieuu9
         QBXlQSOW1UfQTfMSmzx9CYp2wpHeUNtddG5urE+pobJohEZE41BUh9fq9FnEUzUskORU
         L9NRIqITuKF1lV1ahvl1hBtVyMnk92WQ+gfZ3RU2qUC+OnIVjY+U8S/bnWc+EdkNsvwK
         Iksw==
X-Gm-Message-State: AGRZ1gL6/O9g8OcmAuL+rwc0pebL3xRSE/SJoSQ9jgG6M80FBUFIzL25
        ne6wEuEVkFrvCD5fv7XeWeZCDanY0ZtqpAJtmz8=
X-Google-Smtp-Source: AJdET5cuLjDSSGmDaHP4TjWgCbdRaPVgQYI5g7EwjcuT32H48hvvmcpzwVq/BzqcE6iA5a2/i6jyTr6YY/SSnxCzygU=
X-Received: by 2002:aca:bf55:: with SMTP id p82-v6mr5328762oif.181.1542549956854;
 Sun, 18 Nov 2018 06:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20181118135024.30720-1-narmstrong@baylibre.com>
In-Reply-To: <20181118135024.30720-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Nov 2018 15:05:45 +0100
Message-ID: <CAFBinCB-X0T5mhOkPV=xaKs=RimFZedA8LuqJigD2FfKb28nrg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Amlogic Meson GX SoC Clock Measure Driver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 2:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clocks frequencies.
> The precision is determined by stepping into the duration until the counter
> overflows.
> The debugfs shows a pretty summary and each clock can be measured
> individually aswell.
>
> This patchset includes the dt-bindings, driver and the DT node added to the
> meson-gx dtsi.
>
> Changes since v2 at [2]:
> - Removed all reference to GX
> - Added compatibles for meson8/meson8b
> - Used Martin's suggestions on the divider naming
> - Added Martin's meson8/meson8b clk id table
> - Added Martin's fixes to support 32bit SoCs
thank you for the updates Neil!

here's the output from Odroid-C1:
# cat /sys/kernel/debug/meson-clk-msr/measure_summary
 clock                     rate    precision
---------------------------------------------
ring_osc_out_ee0              0    +/-3125Hz
ring_osc_out_ee1              0    +/-3125Hz
ring_osc_out_ee2              0    +/-3125Hz
a9_ring_osck                  0    +/-3125Hz
vid_pll               148497596    +/-4807Hz
clk81                 159372396    +/-5208Hz
encp                  148497596    +/-4807Hz
encl                          0    +/-3125Hz
eth_rmii              125000000    +/-3906Hz
amclk                         0    +/-3125Hz
fec_clk_0                     0    +/-3125Hz
fec_clk_1                     0    +/-3125Hz
fec_clk_2                     0    +/-3125Hz
a9_clk_div16           74998438    +/-3125Hz
hdmi_sys                      0    +/-3125Hz
rtc_osc_clk_out           32813    +/-3125Hz
i2s_clk_in_src0               0    +/-3125Hz
clk_rmii_from_pad             0    +/-3125Hz
hdmi_ch0_tmds          74248438    +/-3125Hz
lvds_fifo                     0    +/-3125Hz
sc_clk_int                    0    +/-3125Hz
sar_adc                 1140625    +/-3125Hz
mpll_clk_test_out             0    +/-3125Hz
audac_clkpi                   0    +/-3125Hz
vdac                          0    +/-3125Hz
sdhc_rx                       0    +/-3125Hz
sdhc_sd                       0    +/-3125Hz
mali                          0    +/-3125Hz
hdmi_tx_pixel          74250000    +/-3125Hz
vdin_meas                     0    +/-3125Hz
pcm_sclk                      0    +/-3125Hz
pcm_mclk                      0    +/-3125Hz
eth_rx_tx                     0    +/-3125Hz
pwm_d                         0    +/-3125Hz
pwm_c                  24000000    +/-3125Hz
pwm_b                         0    +/-3125Hz
pwm_a                         0    +/-3125Hz
pcm2_sclk                     0    +/-3125Hz
ddr_dpll_pt                   0    +/-3125Hz
pwm_f                         0    +/-3125Hz
pwm_e                         0    +/-3125Hz
hcodec                        0    +/-3125Hz
usb_32k_alt                   0    +/-3125Hz
gpio                          0    +/-3125Hz
vid2_pll                      0    +/-3125Hz
mipi_csi_cfg                  0    +/-3125Hz
