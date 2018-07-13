Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402D6208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 12:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aMhZcoc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402D6208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbeGMNFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:05:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbeGMNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:05:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so25012582wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2qE17HPTdG7g2tPmHe7x9j8zRBWCmIEP0yjLKyX/0ik=;
        b=aMhZcoc2eQS6XMoGvfBt9IkZ/P03stSztv0LSTt4tdT1BXcHJN1LCgjGfheJnrm9QT
         T2l/cqTDEA574umT+7WAPJWyAuyr/EMXna7kUeF+7jivDLVWNYagq1LAC91GO9ucl3WN
         FRof35OTF+hTYiux5eHZ9HbdAHdgyckZgmvhnqqvn6mwgmZuKgFwHDTF9kywRIOzj68m
         vwd1mFXuWC2sg/AXMM9EA599aWkwHEu6gu7QAIS5EBnb5F2Fhr5BsZrMlC8UWGGz3jRh
         cNscyjYXfA7uxtvquReOmb8XpMxVy0oXBo8aeXCGc0b8sbRyuohIZ6EOwtvTRLvWgujN
         eMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2qE17HPTdG7g2tPmHe7x9j8zRBWCmIEP0yjLKyX/0ik=;
        b=iS+3lPOnhxPFDcRfRE7X7ppNOGzY65IKUblj/9PsOtwJBup1juclFaUisRwk82vuE6
         nNajNO4PlcZt5VyqhgE8T3d6vP7GQhiHMsp2XgzsXLfHCWfZm4JmnR718lYdeOKeio80
         n7mWxI2W1PGImPWG4QFLR+xAvNEv/YxRsP7jw3h9LTcxBCTGD8tUDveM8ekGKH13eaP5
         kjTcZBG/lYBxHhgc14MO3O8OuBFgYk6avf1jXH85OKwiAntlTAohrb9RAfHgvXQUQWzY
         ftr4tKG1itsT3Nke4xSOTgE8Bx7tk1ZyL7EIYm60vgM35wO3juMCv9yxI77oy9gVY2Aa
         bOkg==
X-Gm-Message-State: AOUpUlHD5LGSwXB9GP9SM6oD7JULtHAUYcYEOYM5ZtETniW3pwW9KnO2
        nXD8UhvYWcafaqOavOgyJtJf8g==
X-Google-Smtp-Source: AAOMgpeoc1OpFCzELybiJmc+X/CLxrFH4pWunlypstB16CePqKP4qceJ9HumYR7P+feNn7darX3PlQ==
X-Received: by 2002:adf:9226:: with SMTP id 35-v6mr4509741wrj.44.1531486248417;
        Fri, 13 Jul 2018 05:50:48 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f76-v6sm8541524wme.30.2018.07.13.05.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 05:50:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: add sound-name-prefix property
Date:   Fri, 13 Jul 2018 14:50:41 +0200
Message-Id: <20180713125043.13242-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support in ASoC to pick up name prefix from the
component nodes when the component does not match the configuration
table provided to the card.

The need for this feature came from the platform I'm working on
(Amlogic A113). On this platform, the card is made of several instances
of each components. It relies heavily on prefixes to describe the
routing between these components.

The proposed solution benefits every other DT based sound cards, such as
the simple card family. It allows to express the routing easily even when
the card uses several instances of the same component, or different
components with the same sink/source names (Playback, Capture,
Output, etc ...)

Jerome Brunet (2):
  ASoC: add DT documentation for the sound-name-prefix property
  ASoC: allow soc-core to pick up name prefixes from component nodes

 .../devicetree/bindings/sound/name-prefix.txt      | 24 +++++++++++++++++++
 sound/soc/soc-core.c                               | 28 ++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt

-- 
2.14.4

