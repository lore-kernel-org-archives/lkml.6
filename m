Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864ABC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5802054F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gV0TyJet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5802054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLKNr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:47:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53557 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:47:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so2260115wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 05:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/C7VLcE6neAUUZaza/sZeOnT8Mpon/LIRJpBVmA7gU=;
        b=gV0TyJetEGPyH6Jop7rGLs6oAHPGRooYw55oH10unEiQB1lak76jW2AeK+OpXWbeAJ
         PC9atO9BrKwPIoGpw+t7PZ26o4X6vfwPcVetxbIlUd8zgVRIkzXNGQ3QBUJ7g8YndB5h
         +azQsns0w2dXMF2NT3JcV7PYOJHlkvh8sxmv/Fc+i+HR5qo70B4J52urzCBDWCBFvjqc
         pSfoqLan55VZaIDrhJQukV/oaySr7bCbS48+yrWWJtYd87NCdbLhH/517bSjPO92sBuN
         JEe9kT6ViSBasem/EdAha78HSEPIW6oTT1OsykmkGdOL0QVB8U+P0VK33KPlU+okpwDy
         N64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/C7VLcE6neAUUZaza/sZeOnT8Mpon/LIRJpBVmA7gU=;
        b=FHdF+UM5tlnWx0b920xoSC3PRHVIeawc5WbZryyA+/PChZZ01vD3G9Yhf1+UXC4n+y
         3BrT1yLaI605QHmOWO4bo/i8Ia9vZhlQ3vnvB1TVab2OtJ0yFYiRgouCkw6C4UINrZYi
         iy/GrYFsRphD8+RUM7jTcSbPM2EOE9hxZk1lobEMpjwgscxPm9kJLxp46EU0/22MKv7j
         KXd4t0+ZiA3nXXvhfMxNU+fzJsMu9yzxh1gvcvVfvz6xeqgZQcmtWYEq2D19WveDWWNk
         2WOM6br8MSb5UfMyVNv87E+rVqNyGXqudcF6W+gogMz+gpG/AY8Jft6ngpJLs3ej0gOX
         /3yA==
X-Gm-Message-State: AA+aEWbBy44vZiObC3L+jqUE4fhJwFbVIDjh6YVK2s/Gst8e357aZT0h
        HNOkDLbJzTexojq1Xd53/tVMFQ==
X-Google-Smtp-Source: AFSGD/W5IAKFcKXLyVegc31zxjtlss6GcifCY6G6uBgQ7picPNaxyyGAEe/4Xcc0yHGTm+jYtE6S0w==
X-Received: by 2002:a1c:128b:: with SMTP id 133mr2498350wms.22.1544536043939;
        Tue, 11 Dec 2018 05:47:23 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 126sm113768wmd.1.2018.12.11.05.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 05:47:23 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/4] ASoC: meson: add axg spdif input support
Date:   Tue, 11 Dec 2018 14:47:09 +0100
Message-Id: <20181211134713.4908-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the initial support the spdif input found on the
axg SoC family.

The capture itself works well but the rate detection could be enhanced in
the future.

Like several other drivers of this type, no check is done to verify if the
rate of the input stream is consistent with the rate requested in
hw_params()

The automatic rate detection mechanism of this device and the related IRQ
proved difficult to work with, as documented in the driver. Several
approaches to work around this minor issue have been tried but none
provided a complete and reliable solution so far. Hopefully more eyes on
this will help figure this out.

Since I authored all Amlogic ASoC drivers (and the related bugs) merged
so far, I have added myself as maintainer of them in the last patch of this
series.

Jerome Brunet (4):
  ASoC: meson: axg-toddr: add support for spdifin backend
  ASoC: meson: add axg spdif input DT binding documentation
  ASoC: meson: add axg spdif input
  MAINTAINERS: Add Amlogic sound drivers entry

 .../bindings/sound/amlogic,axg-spdifin.txt    |  22 +
 MAINTAINERS                                   |   7 +
 sound/soc/meson/Kconfig                       |   9 +-
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-fifo.h                    |   3 +-
 sound/soc/meson/axg-spdifin.c                 | 521 ++++++++++++++++++
 sound/soc/meson/axg-toddr.c                   |  15 +-
 7 files changed, 567 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
 create mode 100644 sound/soc/meson/axg-spdifin.c

-- 
2.19.2

