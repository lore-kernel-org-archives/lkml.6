Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F0EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379DB20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K5LNRQ48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379DB20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLFPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:18:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40198 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:18:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so852898wrt.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kxcYZ5L42j1jO324rbmlL1PwuJ7eyUnUniDRBwVrQ8=;
        b=K5LNRQ48nxsm8TNpfFObhraZlNiaal9mG/dOUMgnwy1V1b0i1AsZU8BHZJi5yCzKwF
         VfGjxv9Ou7KEDaVHic1wqxVHwuPdBaK/qNXDAboM/J25qxuHLJNWWPYHG0YFMYJKh5fz
         AZqBG7SnFBAsk3chjySj1OrrXq+2pJmIsvjwsbAeb4zlqST4yqSRdJd8Js0BRW9KfehK
         RC8odlWu39Z4IlJzGevJecbUqS69eYMxg5hgJZoXRisc7sI0nuWzos6+4WTJ88aFM+lY
         VT0qyLWVlbLp71O8cKGAhSphmk7MOgHPnx9Ih58oG7ItleJ5L8Xj8iU4lMk8+R+0+BI0
         SDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0kxcYZ5L42j1jO324rbmlL1PwuJ7eyUnUniDRBwVrQ8=;
        b=g7v2HvPLypQWKxbnzGXHB9ffHZ7Uc1sVdpVpYJavTijCqE6vec9rISDQCjSltxHW+r
         PhSzYPA8nATRlJvgcH8RXp2AlM+okWP3kjYYHO46y2VUY0On1TDzfODQFYPxT/ublsdB
         xYiMaRHNfsPvkDvsg+5XFh/pQLwimLE60oJD9L7YPm77/JzMRkHV0xOiKpQLjSZXjeWR
         W++3IEryM36c8s50l03dxCSyKYNHhMaFXutV3fEfPMWR96tAE329Lffc2tgM1eeds/8+
         vVf/OV2kzEyeJ3wagOlK5mYUjXUZObGgdd7E+FDG4MyEOcJu2bN9jdF5blFoz2HISKux
         OMIA==
X-Gm-Message-State: AA+aEWZSq1K7z4sx4C7Ay74740YWjjvKRx3sZWR4PvH43B+3qZq5fWWv
        luWy1ht8RPkswILDnNwPhCmhdQ==
X-Google-Smtp-Source: AFSGD/WXgD9EMDbWVRhpui4eQTBX20TrL6Kx7h59E0LnRduCTChVh5v8N3zP1LQdeWBAiYbJ7qdLTA==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr24836376wra.282.1544109515959;
        Thu, 06 Dec 2018 07:18:35 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j33sm939652wre.91.2018.12.06.07.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:18:35 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mmc: meson-gx: chained descriptor fixup and improvements
Date:   Thu,  6 Dec 2018 16:18:24 +0100
Message-Id: <20181206151828.24417-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of the patchset was mainly to address the following warning:

WARNING: CPU: 0 PID: 0 at /usr/src/kernel/drivers/mmc/host/meson-gx-mmc.c:1025 meson_mmc_irq+0xc0/0x1e0
Modules linked in: crc32_ce crct10dif_ce ipv6 overlay
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         4.19.1 #1
Hardware name: Some A113 Board (DT)
pstate: 40000085 (nZcv daIf -PAN -UAO)
pc : meson_mmc_irq+0xc0/0x1e0
lr : __handle_irq_event_percpu+0x70/0x180
sp : ffff000008003980
x29: ffff000008003980 x28: 0000000000000000
[...]
x1 : ffff80001a71bd40 x0 : 0000000000000000
Call trace:
 meson_mmc_irq+0xc0/0x1e0
 __handle_irq_event_percpu+0x70/0x180
 handle_irq_event_percpu+0x34/0x88
 handle_irq_event+0x48/0x78
 handle_fasteoi_irq+0xa0/0x180
 generic_handle_irq+0x24/0x38
 __handle_domain_irq+0x5c/0xb8
 gic_handle_irq+0x58/0xa8

This happens when using the chained descriptor mode. If there is an
error, we call mmc_request_done(), loosing any reference to the cmd. It
turns out that the chained descriptor does really stops when we do so, at
least not completly. Most of the time, it can be seen with this harmless
warning because the descriptor will raise another unexpected IRQ. On rare
occasion, it will completly break the MMC.

This is mostly adressed by patch #1.
With this fixed, I took (yet) another look at the ultra-high speed modes
and the tuning.

I came up with new settings in patch 3 and 4. I've tested them on eMMC,
sdcard and sdio on the following platforms:
 * gxbb p200
 * gxl p230, libretech (eMMC only), kvim.
 * axg s400

So far, these new settings seems to be working great but I think it
would be nice if others could test this and provide their feedback.
This why  patch 3 and 4 are RFT tagged.

Jerome Brunet (4):
  mmc: meson-gx: make sure the descriptor is stopped on errors
  mmc: meson-gx: remove useless lock
  mmc: meson-gx: align default phase on soc vendor tree
  mmc: meson-gx: add signal resampling

 drivers/mmc/host/meson-gx-mmc.c | 100 ++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 25 deletions(-)

-- 
2.19.2

