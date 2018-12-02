Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC5C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE97B20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Rx8SBlLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE97B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbeLBVmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:42:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLBVmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:42:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so10154993wrt.11;
        Sun, 02 Dec 2018 13:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1FNrPYfWMF3/vBQtyNC2xejvYpCaQUsX5uXu6fwKsI=;
        b=Rx8SBlLChYpA1IXqetgitpRqkTb9nY7sFJpn4/5eFmjAUhTnHQu0BtA0E5rhCjJ0zu
         e8NJfHczroVmvcedNvlnmUHyYngPz4kY1hf/sig+ts7nfW+x6//TDUqE7WGOhk/oIlpo
         Qsn0a4LJw4yf7HKokuxFg7XzP1PC1vCZ7gQJmSDLeJjjBbZU8jVToqR/76d2REnZFkXw
         yXmN2GqcX1Sn8Agzdv2eUgxudO6ClNxn7YDdoYKHnCsP/M6vk+GlOX3mtVO9GPhmKRT8
         71pthcQA8nDnXGItjDZwl/YG1usCxpAiO0+6oMNXcfJPVSW//uaHkPJSqEBr/VQPfEx+
         EQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1FNrPYfWMF3/vBQtyNC2xejvYpCaQUsX5uXu6fwKsI=;
        b=WPimPgnIe/d2ajF54Vr1AwwBCLnVwtqJp++PYzpBFDDRkcSBeT/RzBA3XS5jvuysq2
         ibOtxb+a4iVEBFXqCr2CAKtP8Hg4kxBGdwrgnnV6NkexPDcypTwtauKryDv4jiN4HIv6
         4kevZMwt+tJSrKvKrGpdX9E0NbbssCWww1zVKkqiTVVsvb78RZU8vaOqP2cqfcUV9M+w
         L8PpTYqjIVIitsat+vgbG5qyWgrtgdhDOPBFkUAHbellJmvwvodgMDTyH0p6Z34S6poi
         GnsfQV0yXDmreVCtXPWmjxrMlIfYdVGWTlTsqhLeav4E3kJfYsj5qpvGAysR74Wi7TZB
         NnOA==
X-Gm-Message-State: AA+aEWZMpuzBTHx8uI93EzxyZJbJmWbxOehZuPhxUWdvQCAzoH9oixJC
        Otx8lNZEG669qWB6DvA0FtU=
X-Google-Smtp-Source: AFSGD/Xf5ccIaKr/r81nR0nHttMVPKYxQP8sDDbrOT9k1N+ZAW62Nih0l5FYNS30Ircux4C5dbThkQ==
X-Received: by 2002:adf:900f:: with SMTP id h15mr11731230wrh.18.1543786957114;
        Sun, 02 Dec 2018 13:42:37 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
        by smtp.googlemail.com with ESMTPSA id a18sm13073110wrp.13.2018.12.02.13.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 13:42:36 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] - clk: meson8b: add the (read-only) video clock trees
Date:   Sun,  2 Dec 2018 22:42:17 +0100
Message-Id: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the Meson8b variant of Neil's series from [0] called "- clk:
meson: Add video clocks path".
GXBB and newer use a -- vid_pll divider IP block which doesn't exist on
the 32-bit SoCs. Instead the 32-bit SoCs use three simple dividers,
a few muxes and some fixed dividers.

I used Neil's GXBB patches as initial reference, together with Amlogic's
3.10 kernel sources (drivers/amlogic/display/vout/enc_clk_config.c): [1]

With Jianxin's help I was able to get the clock tree into a state where
the code is now able to recalculate the frequencies of the video clocks.
I am using the clock measurer as "expected" values, together with the
data from enc_clk_config.c where all the dividers are documented. My
test protocol on Meson8b and Meson8m2 is attached below.

One note for all brave people who look at enc_clk_config.c from
Amlogic's 3.10 kernel: some frequencies seem to be doubled there.
VMODE_1080P is defined with hpll_clk_out = 2970, but it's only using
the following PLL parameters: M = 61, N = 1, FRAC = 3584. At first I
though that there's a pre-multiplier like on GXBB, but after digging
deeper into the code I don't believe that pre-multiplier exists. The
reason for this is for example VMODE_1080P_30HZ which uses
hpll_clk_out = 1485 with the same PLL parameters as 2970 MHz. However,
since the current code can recalculate the frequencies correctly I will
leave it to a future patch to solve this "frequency doubling" - more
work is needed anyways for actually changing the PLL's frequency (as
there are many bits in HHI_VID_PLL_CNTL2, HHI_VID_PLL_CNTL3,
HHI_VID_PLL_CNTL4 and HHI_VID_PLL_CNTL5 which the Amlogic 3.10 kernel
is changing together with the M/N/FRAC values.


[0] https://patchwork.kernel.org/cover/10670657/
[1] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/drivers/amlogic/display/vout/enc_clk_config.c


1080P / Meson8b Odroid-C1
- u-boot:
-- odroidc#video dev open 1080P
-- mode = 8 vic = 16
-- set HDMI vic: 16
-- mode is: 8
-- viu chan = 1
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148497596 +/-4807Hz
-- encp 148497596 +/-4807Hz
-- encl 0 +/-3125Hz
-- hdmi_ch0_tmds 148500000 +/-4807Hz
-- hdmi_tx_pixel 148497596 +/-4807Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 148500000 0 0 50000

720P / Meson8b Odroid-C1
- u-boot:
-- odroidc#video dev open 720P
-- mode = 6 vic = 4
-- set HDMI vic: 4
-- mode is: 6
-- viu chan = 1
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148497596 +/-4807Hz
-- encp 148497596 +/-4807Hz
-- encl 0 +/-3125Hz
-- hdmi_ch0_tmds 74250000 +/-3125Hz
-- hdmi_tx_pixel 74248438 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 74250000 0 0 50000

480P / Meson8b Odroid-C1
- u-boot:
-- odroidc#video dev open 480P
-- mode = 2 vic = 3
-- set HDMI vic: 3
-- mode is: 2
-- viu chan = 1
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 215996528 +/-6944Hz
-- encp 53998438 +/-3125Hz
-- encl 0 +/-3125Hz
-- hdmi_ch0_tmds 26998438 +/-3125Hz
-- hdmi_tx_pixel 27000000 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1080000000 0 0 50000
-- vid_pll 0 0 0 216000000 0 0 50000
-- cts_encp 0 0 0 54000000 0 0 50000
-- cts_encl 0 0 0 54000000 0 0 50000
-- hdmi_tx_pixel 0 0 0 27000000 0 0 50000


4K2K30HZ / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 4K2K30HZ
-- mode = 13 vic = 68
-- set HDMI vic: 68
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 297000000 +/-10416Hz
-- encp 296989583 +/-10416Hz
-- encl 296989583 +/-10416Hz
-- hdmi_ch0_tmds 296984375 +/-10416Hz
-- hdmi_tx_pixel 296979167 +/-10416Hz
-- hdmi_sys 23998438 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 297000000 0 0 50000
-- cts_encp 0 0 0 297000000 0 0 50000
-- cts_encl 0 0 0 297000000 0 0 50000
-- hdmi_tx_pixel 0 0 0 297000000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000

1080P / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 1080P
-- mode = 8 vic = 16
-- set HDMI vic: 16
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148500000 +/-4807Hz
-- encp 148500000 +/-4807Hz
-- encl 148497596 +/-4807Hz
-- hdmi_ch0_tmds 148497596 +/-4807Hz
-- hdmi_tx_pixel 148497596 +/-4807Hz
-- hdmi_sys 24000000 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 148500000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000

720P / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 720P
-- mode = 6 vic = 4
-- set HDMI vic: 4
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- clkmsr:
-- vid_pll 148500000 +/-4807Hz
-- encp 148500000 +/-4807Hz
-- encl 148497596 +/-4807Hz
-- hdmi_ch0_tmds 74248438 +/-3125Hz
-- hdmi_tx_pixel 74248438 +/-3125Hz
-- hdmi_sys 24000000 +/-3125Hz
- clk:
-- hdmi_pll_dco 0 0 0 1485000000 0 0 50000
-- vid_pll 0 0 0 148500000 0 0 50000
-- cts_encp 0 0 0 148500000 0 0 50000
-- cts_encl 0 0 0 148500000 0 0 50000
-- hdmi_tx_pixel 0 0 0 74250000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000

480P / Meson8m2 M8S
- u-boot:
-- m8m2_n200_v1#video dev open 480P
-- mode = 2 vic = 3
-- set HDMI vic: 3
-- config HPLL
-- config HPLL done
-- reconfig packet setting done
- - clkmsr:
-- vid_pll 215996528 +/-6944Hz
-- encp 54000000 +/-3125Hz
-- encl 53998438 +/-3125Hz
-- hdmi_ch0_tmds 27000000 +/-3125Hz
-- hdmi_tx_pixel 27000000 +/-3125Hz
-- hdmi_sys 24000000 +/-3125Hz
- - clk:
-- hdmi_pll_dco 0 0 0 1080000000 0 0 50000
-- vid_pll 0 0 0 216000000 0 0 50000
-- cts_encp 0 0 0 54000000 0 0 50000
-- cts_encl 0 0 0 54000000 0 0 50000
-- hdmi_tx_pixel 0 0 0 27000000 0 0 50000
-- hdmi_sys 0 0 0 24000000 0 0 50000


Martin Blumenstingl (3):
  - clk: meson: meson8b: fix the offset of -- vid_pll_dco's N value
  - clk: meson: meson8b: add the fractional divider for -- vid_pll_dco
  - clk: meson: meson8b: add the read-only video clock trees

 drivers/clk/meson/meson8b.c | 746 +++++++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson8b.h |  54 ++-
 2 files changed, 789 insertions(+), 11 deletions(-)

-- 
2.19.2

