Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D919C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF46F28053
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E3E4vimc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF46F28053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936605AbeF2PZF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:25:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50380 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932407AbeF2PZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:25:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so1620874wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Ec1ARjG/4Q2+DKWZJNs87A7bm0370oQjJPD7mXLnR3k=;
        b=E3E4vimcNoJnTTIChrmz6HH0AaeBRjLhzMdIuID35qGC7Gm3Xjx9G4z8HogOIQXtyO
         NxAH2aFQsvxVQJ2re3EJnrBJLU4zVgbptXVWBd6DYa65U0UXMVMgmkMAYqtAJubNT5BL
         anOauE3dowCOw5lNS7ZwYV2H8at/lf/O036EpwkK5G9lf+GOVgqYZ7Q0VRtfpWnbNS7/
         g/Mq+0qWNUsB6L3QhuLeIV7+poWW03ro6pX/83ax0GCy87wo1tAhrPB5tnd/mklp1ece
         YVG7QkC3/IVAqIuy4hPhWMjPnk/ziFLOFmjZJU+C1DT4I808SxaAx0Zio7YwsZuxM2+Y
         yHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ec1ARjG/4Q2+DKWZJNs87A7bm0370oQjJPD7mXLnR3k=;
        b=OdHJnLG5YdKFM3OOeuhBeVJWrNVeBz0VznlosOpGbeFuqDlvwKIl6zhNNB6DEzoH5y
         hLsUnngEgLai7+Ia6Is1JMIzcWPaVQQ0KpaXwLjoffT4KdnhGSNpaRHyIOm3XL82l+2D
         +Cx2M0ge6ZNHgin47ONp02s+4+jjewKwzRVPe8yWpO4nr5DXo9AETQFDKClJ5H+molWq
         /INpTqanF/0lAlBvJNCroA4ssdhpQsUql+OpkT/bXgi+Z17IPyu9S1qe7GIkjxQ6Xbzx
         uEy2eHprLjsvxbhOez6vGtmo6QQOLKnVJsY2586sm+GkmUXSbAW+hTbAeJemJfq8iynk
         Dlyg==
X-Gm-Message-State: APt69E3fC/ZsgK/gykvX+HbEVdvWh+x+ie3SBczqZe50ZUs8nAv0/OOF
        ylQuWLANEDZAUtpCm8RwfIEfHA==
X-Google-Smtp-Source: AAOMgpeeMPhOQPfgPApbCu7gJsIvK6bWtL2BPh7qKqkrxaABf2iKyMESKRp/3el8WkVJobxkgS7dsQ==
X-Received: by 2002:a1c:e618:: with SMTP id d24-v6mr2022102wmh.154.1530285902966;
        Fri, 29 Jun 2018 08:25:02 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q70-v6sm2754659wmd.45.2018.06.29.08.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:25:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ASoC: add es7241 support
Date:   Fri, 29 Jun 2018 17:24:42 +0200
Message-Id: <20180629152444.21525-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the es7241 which is a simple 2 channels analog to
digital converter.

Jerome Brunet (2):
  ASoC: es7241: add dt-bindings documentation for the es7241 adc
  ASoC: es7241: add es7241 codec support

 .../devicetree/bindings/sound/everest,es7241.txt   |  23 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es7241.c                          | 307 +++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt
 create mode 100644 sound/soc/codecs/es7241.c

-- 
2.14.4

