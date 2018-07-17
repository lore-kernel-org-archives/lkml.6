Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867F0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DA72089B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ndwn0CpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DA72089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbeGQQKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:10:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52787 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbeGQQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:10:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so1959844wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=iovYSCzRi0xRYQ6uF5MbKxolaTioFjQxXQAfu2kGBJQ=;
        b=ndwn0CpPdNsM/o4bo2+tmUK0QtJ7ZIxmsRivpZOxFSPQRPuKyjd+0LBgz7SzG5iYj5
         WAQe4d41tECIetuFq6ZJB3U1imiD8hr92UTPBMxMC5l4DLeDljyaOSIu9w8ukKqUIHqM
         yC7Q6Payk1zIiAovqhbxW7UnlJ9XU4GuBBMDtpNxC5xK5Vsr2q/7U9Lfe2j10QFeerf+
         o9WvLRpqsX8NSaQILjl2cOhdLzmkgx5XFXF+/h/0vv79RSetoOIdeYEcbSSt7N1hFd9g
         G5Y0LeOb5nNLEjdt/nTvSxNc60rhNgWtsqU5YjvJ8hmybxQQ0M7jxnvmJkRf3FvDuzqi
         KgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iovYSCzRi0xRYQ6uF5MbKxolaTioFjQxXQAfu2kGBJQ=;
        b=j9h7dcz1E2OuhGAokTzoLoWedhooeoPUATHSXfy/lyoMlepApYK6MrmWZ/zOWsSBwz
         ZQSFtvYChrGnAYXmIhaJAv65UebvtWM9UuBDPOJ1XQ15rR4/qiAvhkt6XVaXxj/dZhZj
         wwaIv1G232axqEYaf6abxO6v0wL9UZl41rA00rNeyLby/ohTcXKFhNUh3mMsVb5aBP5K
         0knSJ0LyGR2STXN6oUXeawUPlcmUYJ0gbbmVks1seYdAcKc0HnuAaz/ahVHa3ks80HKN
         cBcIBoTR6m4wVhkbUrtVZaXT0MpvXolSA1+2YjyFE+58afVU2SCFaz/fujKwYbahPT6p
         Ikxw==
X-Gm-Message-State: AOUpUlGP2RAtEHExmBAaVukENiM42OMpi0zuYo6OMflobADI0CL3xpY3
        e6bASdss6vRMTK+QIrk4GdJ6CGDj
X-Google-Smtp-Source: AAOMgpexS2r1xpwz9Sn8DUpEvaKRrEI/92siEazTaNltHRwirMB7qjW2cVKr8k5CncSVIo9EsSK2ew==
X-Received: by 2002:a1c:f216:: with SMTP id s22-v6mr1809033wmc.50.1531841807232;
        Tue, 17 Jul 2018 08:36:47 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16971464wmb.3.2018.07.17.08.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 08:36:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 00/15] ASoC: meson: add axg audio subsystem support
Date:   Tue, 17 Jul 2018 17:36:24 +0200
Message-Id: <20180717153643.8806-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the audio subsystem found on Amlogic's
axg SoC family. The first SoC of this family is the A113D/X targeted
at smart speaker application. The G12a SoC family, Amlogic next-gen
STB chipset, will reuse this audio subsystem with a few changes.

This patchset implements the DPCM machine driver and the different
components it made of. Several components are still missing, such
spdif input and pdm, and will submitted later on.

The fancier part of this patchset is probably around the TDM. Properly
modeling the SoC architecture and its capatilities made things a little
more complex than usual (details in the related commit descriptions)

If necessary, this patchset could broken into smaller series. For the
intial submission, I wanted to give a global view of the subsystem.
Hopefully, it will make it a bit easier to understand.

Jerome Brunet (15):
  ASoC: meson: add axg fifos DT binding documentation
  ASoC: meson: add axg fifo base driver
  ASoC: meson: add axg frddr driver
  ASoC: meson: add axg toddr driver
  ASoC: meson: add axg spdif output DT bindings documentation
  ASoC: meson: add axg spdif output
  ASoC: meson: add axg tdm formatters DT bindings documentation
  ASoC: meson: add axg tdm interface DT bindings documentation
  ASoC: meson: add tdm formatter base driver
  ASoC: meson: add tdm interface driver
  ASoC: meson: add tdm output driver
  ASoC: meson: add tdm input driver
  ASoC: export snd_soc_of_get_slot_mask
  ASoC: meson: add axg sound card DT bindings documentation
  ASoC: meson: add axg sound card support

 .../devicetree/bindings/sound/amlogic,axg-fifo.txt |  23 +
 .../bindings/sound/amlogic,axg-sound-card.txt      | 124 ++++
 .../bindings/sound/amlogic,axg-spdifout.txt        |  20 +
 .../bindings/sound/amlogic,axg-tdm-formatters.txt  |  28 +
 .../bindings/sound/amlogic,axg-tdm-iface.txt       |  22 +
 include/sound/soc.h                                |   3 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/meson/Kconfig                            |  64 ++
 sound/soc/meson/Makefile                           |  21 +
 sound/soc/meson/axg-card.c                         | 671 +++++++++++++++++++++
 sound/soc/meson/axg-fifo.c                         | 341 +++++++++++
 sound/soc/meson/axg-fifo.h                         |  80 +++
 sound/soc/meson/axg-frddr.c                        | 141 +++++
 sound/soc/meson/axg-spdifout.c                     | 456 ++++++++++++++
 sound/soc/meson/axg-tdm-formatter.c                | 381 ++++++++++++
 sound/soc/meson/axg-tdm-formatter.h                |  39 ++
 sound/soc/meson/axg-tdm-interface.c                | 542 +++++++++++++++++
 sound/soc/meson/axg-tdm.h                          |  78 +++
 sound/soc/meson/axg-tdmin.c                        | 229 +++++++
 sound/soc/meson/axg-tdmout.c                       | 259 ++++++++
 sound/soc/meson/axg-toddr.c                        | 199 ++++++
 sound/soc/soc-core.c                               |   7 +-
 23 files changed, 3727 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-formatters.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
 create mode 100644 sound/soc/meson/Kconfig
 create mode 100644 sound/soc/meson/Makefile
 create mode 100644 sound/soc/meson/axg-card.c
 create mode 100644 sound/soc/meson/axg-fifo.c
 create mode 100644 sound/soc/meson/axg-fifo.h
 create mode 100644 sound/soc/meson/axg-frddr.c
 create mode 100644 sound/soc/meson/axg-spdifout.c
 create mode 100644 sound/soc/meson/axg-tdm-formatter.c
 create mode 100644 sound/soc/meson/axg-tdm-formatter.h
 create mode 100644 sound/soc/meson/axg-tdm-interface.c
 create mode 100644 sound/soc/meson/axg-tdm.h
 create mode 100644 sound/soc/meson/axg-tdmin.c
 create mode 100644 sound/soc/meson/axg-tdmout.c
 create mode 100644 sound/soc/meson/axg-toddr.c

-- 
2.14.4

