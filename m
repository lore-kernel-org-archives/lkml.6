Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E872DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554E32086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MjV9W1rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554E32086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGPVIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:08:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55818 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeGPVIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:08:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so4223618wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Jlwlyp0v1NOFFzLA7OAqWNkfuY4tRmhdNTOjy/4vq0k=;
        b=MjV9W1rEnczOySVkXO07RyKk3bQOFdSc3dZK8rekVO6JVt4V/u6JROQZ/TypJL6II9
         eLHZVRm1ZtltCc0JdEylb/gHuBzebGVcEIyItaBj/I57fzHrNUZ00OCIdPFXMbg6Kd1e
         LTQGhkvZchuec47wUA6SXVNeeSiNSjTHlgddHsduapN7gATySCB9lz+0IPbGufO+EY5O
         5Fa7NVYs9i04/xxjQqbCP5vM/XZa1PE16F+dWM03jYdqZntvD+N5l8JJMvecvisPFKMm
         amiBevfSgGk2pSv7sHOAiw1hq1zLGsRyaPrpWQkWOeXs5gV9zgxAh+vFH2wYRTKxfHZ0
         T9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jlwlyp0v1NOFFzLA7OAqWNkfuY4tRmhdNTOjy/4vq0k=;
        b=Rl98D0uo6sbafEglsqHiDAZaBOld/S0RzTkSAWaZjhx52Qy9LUYebQIDExDVaqShCz
         rEJNE8Sbgsq2xEbOw6Hf4aRBGrnWOHrrw4R2JSoybG+L97YzSy34Z/J+F1b7f9wvg9fW
         BPXMcJSKlc68c2Oh6mzf47ITpqrqi6vlsduTtIzNDe8ErvKcoX0sjLXkAaaO0QSUf5D7
         U2UKimozX9s2kv/9oiVUzkaDTzjjJVLI/Z9R0GtPI9l9xMV/M++vN14eSX9zsfeN4Qeh
         mSWeOhwwrlvs/Jel1MLm8EFczY6YJQqO2lIu8s4aS+FPcAlihSixaP+N4kwTK9Z62sFh
         OiYA==
X-Gm-Message-State: AOUpUlFN8P87bJYiTQ8S5fckK6m74T2AhnZwiQRXupdRQlJoOekKmBFx
        8xEaT8r8KXTrn4n9Evj9WXy5cg==
X-Google-Smtp-Source: AAOMgpfXxSETIa6xz+rx/EetjAZBHegms2kcPdDgyCu/c26xfkWRklyozYrAQtTchi5h2L2vAzhyYQ==
X-Received: by 2002:a1c:90cf:: with SMTP id s198-v6mr11078705wmd.5.1531773545439;
        Mon, 16 Jul 2018 13:39:05 -0700 (PDT)
Received: from bender.home (LFbn-MAR-1-570-38.w90-118.abo.wanadoo.fr. [90.118.15.38])
        by smtp.gmail.com with ESMTPSA id j43-v6sm53533686wrj.1.2018.07.16.13.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 13:39:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     tony@atomide.com, daniel.lezcano@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, drivshin@awxrd.com
Subject: [RFC PATCH 0/4] Fix dmtimer parent clock setup
Date:   Mon, 16 Jul 2018 22:38:58 +0200
Message-Id: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the move to clocksource, the omap_dm_timer_of_set_source() broke
because the "fclk" clock is now defined in the DT.
The omap_dm_timer_of_set_source() was using the first clock declared in the
timer node, but now this clock must be named as "src" and clk_get() use
"src" as clock name to permit specifiying the parent clock of the timer "fclk".

The 3 first patches adds the "fck" clocks to all timer nodes of SoCs using
the Clock Framework to pass this clock to the dmtimer driver.

Adam, David, can you check if this solves the issue reported at [1] ?

[1] https://www.spinics.net/lists/linux-clk/msg27638.html

Neil Armstrong (4):
  ARM: dts: am33xx: Add all fck timer clocks
  ARM: dts: am4372: Add all fck timer clocks
  ARM: dts: dm816x: Add all fck timer clocks
  timer-ti-dm: Fix omap_dm_timer_of_set_source()

 arch/arm/boot/dts/am33xx.dtsi     | 10 ++++++++++
 arch/arm/boot/dts/am4372.dtsi     | 18 ++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi     | 10 ++++++++++
 drivers/clocksource/timer-ti-dm.c |  2 +-
 4 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.7.4

