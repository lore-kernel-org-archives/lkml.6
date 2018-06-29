Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3F6C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C992803C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MmjhFaPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C992803C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755580AbeF2PJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:09:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51557 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753472AbeF2PJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:09:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id w137-v6so2562684wmw.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p0iNMq74EaIWDzZOtcNDjg4hyX7LOBKjGX0AJcEi0z4=;
        b=MmjhFaPdNrLby6q5dj9BHgg3TDgdTx25uAV083J6nHHU8pm6Fv8sU3wsnhgsgoXTh8
         TGiwF0WiwM8ErYIbZFd4GCxPwvoHHJana0VdYnuCQ3pHAxuS+JwI/efKXbTbAJn8oWrO
         XExjfOlpsz7XH6TcbuPBR4SE1c3qb5OMxsflBCE+vfyVSFEknzNLEyh8y1RmeCivgKrV
         slGdwVtENTfvd2mAnAW/osBqAPyrfEWCmeQxhEVRi84+lmYsP85tMqMJT62Xrt8cosfW
         u9job/cYDpTBgEDzR6rI0JvMjSYk1jneyBhmroMbIS8DyLPbtv93oVMuFyF+4h9sZ7t0
         CXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p0iNMq74EaIWDzZOtcNDjg4hyX7LOBKjGX0AJcEi0z4=;
        b=CH/JFDEZd+2+WKDdjzRHXUgHKaaO/8o6yXt0N4b4jUMp51PJfWvCDGzhB2FCS04UjV
         bNRH+3cC87SOFsKb0Hse0TznNkubHht2i7CZSrzuw1NloC5SbHlT3oIYMpRGh2gRzc/m
         N3n30hHNZ/qlUIVay5ID00d0Q9JGwD8rtUIadRJfx/tFO9WgsOn1JYiCkc+KKUPGn1g0
         MdnSJtSAfuk/bz1yd+ScrxfM8ew53+lVL1V+weiQiA+/TZ4+ctS8KoP184zlgu2mZoR+
         UQXWA6lexNL8lJX9g9mL0eP2kwsq8M2sZblh1dafbRn0KMsZO2sVpW6g/cqWEXfNEGv7
         gXYw==
X-Gm-Message-State: APt69E11Pk5o7KUavx1rFJsDEAPXDF/pdJom1TrtWj95geQIVcdnRuKm
        iQokI7SUpWfzBQzR0j297KHIFQ==
X-Google-Smtp-Source: AAOMgpd3vk/FIuRtUkNL9hIUgatofs4MfhqFIOUZhg/OIReronUGn6t2WoN2dabQXDPYB8YLGuVKjA==
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr2155934wmf.146.1530284970623;
        Fri, 29 Jun 2018 08:09:30 -0700 (PDT)
Received: from localhost.localdomain (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id b6-v6sm11944222wro.52.2018.06.29.08.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:09:30 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] ASoC: es7134: driver updates
Date:   Fri, 29 Jun 2018 17:09:19 +0200
Message-Id: <20180629150924.18197-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset provides several updates for the es7134 driver
It removes unsupported sample rates, add runtime check of the mclk-fs
ratio as documented in the datasheet and adds the component power
supplies.

Finally support for the es7154 is added.

Jerome Brunet (5):
  ASoC: es7134: remove 64kHz rate from the supported rates
  ASoC: es7134: check if mclk rate is valid
  ASoC: es7134: update DT binding with new compatible and supplies
  ASoC: es7134: Add VDD and AVDD power supplies
  ASoC: es7134: add support for the es7154

 .../devicetree/bindings/sound/everest,es7134.txt   |   8 +-
 sound/soc/codecs/es7134.c                          | 176 ++++++++++++++++++++-
 2 files changed, 179 insertions(+), 5 deletions(-)

-- 
2.14.4

