Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4FA2480C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="q0+Sv1DK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4FA2480C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeGCN2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:28:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38718 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbeGCN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:28:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so2279531wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7+ULPtNZ4FXcUDQiaWp2oaPPCtDDVpbDPVnXrh987kE=;
        b=q0+Sv1DKsG1PTKADAVW5CwiN74MZKbwxvYadE7Bs4qQyoYgYAsMCWnTKR+t2SczHj0
         LbF8UBP6MhbmjN4bKIibS5Vt3Kop+Ak/hzqQmd7IJK5SrxMEFPYgyE1mL9NBNwoReVJt
         Wx315k40tP4P3NIY/KdmJu3Bd3hy9sqcYMiSiBFrpWZqn0YCQ0OcWbTfbAfxtmJ0TjXz
         tA5H4R194i6sVRFrde8VzthJNH0CiW9/5a+A/GxExRHmBTRvpoU2zitHMKlavfGj6N/o
         uz3MmBEYkzwJrsC1CeyOwq1GEOWTNULNvRZJGUFykYK+ynfvU7Jzbohow8roX53hlLt3
         s0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7+ULPtNZ4FXcUDQiaWp2oaPPCtDDVpbDPVnXrh987kE=;
        b=CZrCtgfEHP6Ms2vXAMes/mE5LTEafwBG0qagzaKbU0dcBl1qtQvIWzaBeWR0kiJiTB
         qFP7vIsv+dvFpDg0BHQXTsBhjIdqg9IBWyIdpRkhBTCJMk0e0iv3TAmMG/3sAlauEx7i
         6aygYc72/kWs4XKcj0q21BDARBnutomOKSpDxIyaMrwQ/VpcN3NDb3kHVR0k8VeYwOAC
         v59mvzjLDLz+NlssOEGHMWG2fi3XHFPFzRc61RCfPRjKNbvVtNr48YvtuSd+kX7BVWi9
         4LdNBlcTch4nViOpdN7vumlSC96PGsLfssYGGewuQz1/jO/hs2oO5KIKLZooUGZWVgew
         YxAw==
X-Gm-Message-State: APt69E31JCSV5szyl0jJseal7HtrbAsQUvzYtfyRfXJq9Q5EgOaagKaS
        7lNsKgf2UVpvo8uPHWLhWYCnkw==
X-Google-Smtp-Source: AAOMgpdAljhzi/JQReIalVLchNbwpolBQT/biISva2KVmTqBcRXC5wVVioCiCk9DlchlN7lH6kP/rQ==
X-Received: by 2002:a7b:c01a:: with SMTP id c26-v6mr11208671wmb.33.1530624530006;
        Tue, 03 Jul 2018 06:28:50 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id q140-v6sm2247763wmb.35.2018.07.03.06.28.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 06:28:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ASoC: add es7241 support
Date:   Tue,  3 Jul 2018 15:28:43 +0200
Message-Id: <20180703132845.26554-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the es7241 which is a simple 2 channels analog to
digital converter.

Changes since v1: [0]
 * Add missing break as reported by smatch [1]
   My device is hardwired in slave mode, which probably why this slipped
   through unnoticed.

Changes since v2: [2]
 * Supply are now required dt properties
 * Add a dt property to state the serial interface configuration

[0]: https://lkml.kernel.org/r/20180629152444.21525-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20180630082829.qwnhkk4f76n32omm@mwanda
[2]: https://lkml.kernel.org/r/20180630172241.10806-1-jbrunet@baylibre.com

Jerome Brunet (2):
  ASoC: es7241: add dt-bindings documentation for the es7241 adc
  ASoC: es7241: add es7241 codec support

 .../devicetree/bindings/sound/everest,es7241.txt   |  28 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es7241.c                          | 322 +++++++++++++++++++++
 4 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt
 create mode 100644 sound/soc/codecs/es7241.c

-- 
2.14.4

