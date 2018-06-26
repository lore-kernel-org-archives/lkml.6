Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE1E26B60
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kbCiQ+T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE1E26B60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeFZRlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:41:12 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44055 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeFZRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:41:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id p12-v6so16455287wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Rh3kSpUuWpVPNl32U6cNxPvbZ+Kl80+44OoIakcjCAI=;
        b=kbCiQ+T4Y+uZT1FwswUpLkc9VyqwVVziiuaoEWSEOJ+funnbOLsVcDcJfozetzffvV
         KKmAshiri/3zv2WMPeT7JyO4SQP4e/nJeslDip+wIdAbftKQLBPVVmskP7SnvtRQLYmQ
         5hk35/4UzNk++j/48A37EBdMMAxF/42nnrUqlMzFQLeVMaOQnmZvkp96enxpEZ2BPnUY
         D6d/xcPU/E8D/k2DudXkKwgVkMfdvqwcfiCIMMcET8WUMgdNNHrj0BjdwjXTtQam//zs
         T4fJXKVGXPv7z4ZdDOPUOmn0sXFv0JePu0YoI3nUZrvLA8lAvHdmFDeQZ/KEtYmmLwUK
         KYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rh3kSpUuWpVPNl32U6cNxPvbZ+Kl80+44OoIakcjCAI=;
        b=FFY7JM3nSZKC7daJaxaOdbjSobL/FiCWZp/UchlB4bDGVjZqwtfe4i3WPTgywII5wL
         gUW7Eur76Q3nC6QnsarIlVwPTWkLY443Llc4dKWdv1JJOiwRgqWg5QSWR5+8nd25AdmM
         39Xt1MzVxyJqHHz4+p53IHTuEvEXEU9YeHTE0vqYOOqO5UM05P0xpyELdKyJwHhqZFVs
         SVedR/laHW4QFTu6vwleC4ujyxNIjXzPYOsMBYM0C766esWzYh1hPkHO32tJAJjPCwAi
         /VOezKJSb+/Lz7Hljs60cb1eDM3garzzlOxh9lbVeQ5OrBo2Nj86gHDxSqOGx/HYK/5Z
         s9Jw==
X-Gm-Message-State: APt69E3IBKuXCo8LxiNLoUNv9Kco7pQ27QVR+5X5bpAenQdErbUR3E25
        TchVbGNj2lG7c98nEYaZwQ3qwg==
X-Google-Smtp-Source: AAOMgpca/LbtCpCjHnyR3ixUWd3TAPDciIEB2v0Dq6+Glgt3y8DaEHzpr0qqfoqH+gcEMoDxBTZKqw==
X-Received: by 2002:adf:be03:: with SMTP id n3-v6mr2401216wrh.267.1530034868988;
        Tue, 26 Jun 2018 10:41:08 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i4-v6sm1580462wrq.28.2018.06.26.10.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:41:08 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 0/2] ASoC: add tas5707 support
Date:   Tue, 26 Jun 2018 19:40:54 +0200
Message-Id: <20180626174056.6400-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset extends the tas571x driver to support the tas5707
audio power amplifier.

Jerome Brunet (2):
  ASoC: tas571x: add tas5707 compatible
  ASoC: tas517x: add tas5707 support

 .../devicetree/bindings/sound/tas571x.txt          |   1 +
 sound/soc/codecs/Kconfig                           |   5 +-
 sound/soc/codecs/tas571x.c                         | 110 +++++++++++++++++++++
 sound/soc/codecs/tas571x.h                         |  16 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

-- 
2.14.4

