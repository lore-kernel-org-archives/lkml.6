Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7B0C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C806C22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fl3hMS5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C806C22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeKOJDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:03:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35576 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeKOJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:03:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15-v6so16294795wmt.0;
        Wed, 14 Nov 2018 14:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+/Hf7JsCBuVFCzuyYowMXG14ZwLezEzin4Fj9FD7+Y=;
        b=fl3hMS5DXZJKuKCmTl7flStFHW6obyR1q+8M9em0Cyq3Ht6dVS5np+lS732pKLacZR
         Ox1RkxwDL7zR732ujX1wO5NyMp5jmKWGKYRHDAY6NW3dn6pNCxS08G1I8UrHYwdYp4Aq
         feddQ+IXb7RNTEM+pHGGqtOx+O1+ajIOQiipU/AQRd7JExjzIFi2YjwC7GyuprNn2V+W
         DMqZvS7MPCXmEEjcwdMDTQtrmwkmSASsjbcNAN0WASSY3fUiieCTwrAai0sgKUnlBc5V
         Hir9xNBofSJhPDyia1VcHNKfQfV5uIavBJnO9B1MOkQCb2d27MIBHr5NxJMlI8mNyFdR
         eF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+/Hf7JsCBuVFCzuyYowMXG14ZwLezEzin4Fj9FD7+Y=;
        b=Lb+6cQVwPghQpWzi3XBcfuYmFYLiy5J++Zh6qz+KeBjMfuxp378AllFdR2FI38NSKl
         JLlvxQmOBXHc3AL12A+Evh/qIjhDV2uZnogTp2hKLgHkwHwTz5kpHI+LC4iEuHsRAVWs
         8Gm9mdVoPx4qKFJlTfTaqzGE2epExrdjmai0xsnZnQmW/7o+s1RdC2xkj/YRNcoGh+kA
         NcnM17fHWz0U3K2mKLR/qfuPnEYN6vlVHTtStu0ER7qlo+3nQIGkO6jEH2Ie/HnvkjUY
         BtVAZlvA0V/COXrUYdh6gN8Bu1zjf6d9W1VvHn3xX1jYDbojuoGqHG0U+/8tLCd06Utc
         OKIQ==
X-Gm-Message-State: AGRZ1gJ+wlXQLM0Q6VNCl7ZJz9xu25pUMXeq70zdRIA/FKfFkvuv0EfH
        7SBX4mxSq0SvAgRg66auMPk=
X-Google-Smtp-Source: AJdET5crq9BB6HY4nUhLIqOpPWHXkDWwgo1fhSAvnEFbBQ75RtrRmUqur4fD+VedwDybx2XjKNSnJw==
X-Received: by 2002:a1c:2ecf:: with SMTP id u198-v6mr3546573wmu.77.1542236270641;
        Wed, 14 Nov 2018 14:57:50 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id n7-v6sm18987784wrt.60.2018.11.14.14.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:57:49 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC v1 0/7] Meson8b: make the CPU clock mutable
Date:   Wed, 14 Nov 2018 23:57:18 +0100
Message-Id: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows changing the CPU clock on the 32-bit Amlogic Meson SoCs
(Meson8, Meson8b and Meson8m2).
CPU frequency scaling will be enabled with a separate series by adding
the CPU clock and the OPP tables to meson8.dtsi and meson8b.dtsi.

While changing the CPU frequency (sys_pll or any of it's post-dividers)
we need to run the CPU clock off the XTAL clock. Otherwise the system
will lock up because we need to disable the sys_pll to change it's
rate.

This also makes the clk-pll's .enable hook a no-op if the clock is
already enabled. Otherwise we're getting lockups when calling the
first clk_{prepare_}enable on the sys_pll or any of it's children (as
the CCF propagates the enable event up to the sys_pll). This is because
the .enable hook unconditionally disables and enables the clock.
However, we can't disable that clock (not even temporarily) if the CPU
is running off sys_pll.

Additionally this adds support for more M/N combinations in sys_pll to
achieve all of the OPPs on Meson8b and all OPPs <= 1608 MHz on Meson8
and Meson8m2.

Compared to Amlogic's 3.10 kernel there's one notable difference: we
are actually allowing changes to the sys_pll. Amlogic's kernel sets
sys_pll to a fixed rate during boot and then uses a timer generate a
"virtual clock rate" by toggling between various dividers (for example:
sys_pll is set to 1536MHz. to achieve 1008MHz they are toggling every
2500us between 1536MHZ and 768MHz so the average over <period, for
example one second> is 1008MHz).
I could reproduce any situation where changing sys_pll failed (for
example due to high temperature). To prove that I ran "stress --cpu 4"
for multiple hours and then cycled through all available CPU
frequencies (while keeping "stress" running in the background). This
worked fine on my Meson8b Odroid-C1 and EC-100 boards as well as my
Meson8m2 board.


Martin Blumenstingl (7):
  clk: meson: meson8b: run from the XTAL when changing the CPU frequency
  clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
  clk: meson: clk-pll: check if the clock is already enabled
  clk: meson: clk-pll: add the is_enabled function in the clk_ops
  clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
  clk: meson: meson8b: add support for more M/N values in sys_pll
  clk: meson: meson8b: allow changing the CPU clock tree

 drivers/clk/meson/clk-pll.c | 23 +++++++++
 drivers/clk/meson/meson8b.c | 94 +++++++++++++++++++++++++++++++++----
 2 files changed, 108 insertions(+), 9 deletions(-)

-- 
2.19.1

