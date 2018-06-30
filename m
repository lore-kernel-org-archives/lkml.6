Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD5BC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735CA2562F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P3fSNCS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735CA2562F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeF3RWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:22:49 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38475 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeF3RWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:22:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id w16-v6so3889405wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3lSCAuzOcUJkuPsGwUNaiHcLWafANUv2zGsoOR61bvQ=;
        b=P3fSNCS7O2SiWdz76G1BnjQTDpDu3RJv2qZLJ6N3oxOj1mu4p0FAqbkRS94j2kZPiQ
         cqPw9FzpBIJ7qTBIBe+s8FxPtvQ5TfInwHZP4KnkDykUibzmOiNjpLLI19GnekYDD/U0
         QIzQu33IQComLT9/Uz8RgvkUZb/jkryfwIbVlLEDZflVzKkE9KVUp/6Vx7ENJHU8NYtA
         kl0gkvnSDQQcH/erHSlyoNnlNd64IX7NLdlaIT71m/bxUd1UY233MnxawgLI6Z7UYV0S
         UcLdnBTarNxYrWKvHcYi0pAQwmwUixrcOK2yiWZvqWy03Fi5eoZV56xZfbfKor3TldwW
         ZFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3lSCAuzOcUJkuPsGwUNaiHcLWafANUv2zGsoOR61bvQ=;
        b=S982AMCDFiSThnUs5T3xcz5s+hZQgWbqUB9WjxqeSIK7qhhAvIL/1bFeSfCeE+Hqnt
         aqWrHPhJ3bO8NORoQQX0Auni7R5hk4CJAdHs65fGlMKYf5jzGAolcZ4VkFCKQ/8u7MRE
         FzdkcLIYK3c7sueHs0MeIGuO63aU6VgNPkj0GWSoCmP95uRKU73RAxrybRP0guVF9CfT
         4yqCABsTdRMXujJjTfzN06h8fWs2eT0AFwVm/cBbag/iWxjxiiZxP1+D26fe+tWoUqat
         GU4VeI0gbFUM5bzDYfZXiMkm+GEjMJs9SK+bcFD3dCz2R1hY89SUtSARHoY4C4zb3+pi
         TS1w==
X-Gm-Message-State: APt69E3EtGXPZmSpAh2SI7E6VQ8muhT8ZHbznJ4YBSp92SDtOs+sv/Yk
        H95RSwvFAwDnkoDLVB7ekerOwA==
X-Google-Smtp-Source: AAOMgpf1kL1A/0ga9oT3Jq3pBYrc1c2GEZsojX6qLQRqRCj2ulEb98AJ1Y1YN0HKg95Dzvh4Db4ZpQ==
X-Received: by 2002:adf:a581:: with SMTP id g1-v6mr15881422wrc.233.1530379367086;
        Sat, 30 Jun 2018 10:22:47 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id h1-v6sm16854885wri.90.2018.06.30.10.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 10:22:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ASoC: add es7241 support
Date:   Sat, 30 Jun 2018 19:22:39 +0200
Message-Id: <20180630172241.10806-1-jbrunet@baylibre.com>
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

[0]: https://lkml.kernel.org/r/20180629152444.21525-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20180630082829.qwnhkk4f76n32omm@mwanda

Jerome Brunet (2):
  ASoC: es7241: add dt-bindings documentation for the es7241 adc
  ASoC: es7241: add es7241 codec support

 .../devicetree/bindings/sound/everest,es7241.txt   |  23 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es7241.c                          | 308 +++++++++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt
 create mode 100644 sound/soc/codecs/es7241.c

-- 
2.14.4

