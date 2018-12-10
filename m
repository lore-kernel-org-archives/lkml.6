Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C991DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD6C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tNJJY9ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD6C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbeLJPKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:10:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51279 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeLJPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:10:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so11341112wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xn0c2g9I4A6GeuvdRgNLZiM25mP/rkvFh6YP4YMUT00=;
        b=tNJJY9ah12owl3SqFyZTSccJjUigyd9SdMQ9gr85oBQmFf0Y/WFxWEPaeyDIRfUyO/
         HGL90irdnOzI8v7KfACzqWtQWPWJEcSQdS6KS8ZGQkmkKf9XakxIFfTdzGvRahAMqJzI
         sd2oZfo72Hur4j60LfaT89G15HnDmtdiV3lqQyS17mn4ZmAMNLZuwxAHeXE7PBQpEyPr
         55GS4BJ+msicmQGtWAahd7ZEc7pW4gh2fvzlNAfTL7BY+NssZnZDuJJcsTGKh1aNTwHY
         qxs8kFe7NXUl1Voe/W/fg0T+C5vDZgAbrh2FLDQe3EjyPD82CgRt3/t6m6mnvpNh7/Wu
         pTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xn0c2g9I4A6GeuvdRgNLZiM25mP/rkvFh6YP4YMUT00=;
        b=ajhL/jEJ0piQQsMcBPq0HxhvVG1KO610Ca97+QT5gNvUcIb1XIyp6N5+VKy9NKrAI9
         wVOL67CoKiM2Wbe7pz+KjhwTMRDThuBQNn+dpBUG5U8oDRAJReuD7gh2ttMrS2Hz3c7E
         b4mmIukdi0OZ5+7rP2aF9U3Xo1mDcqaOq1NEusvUqyx/z2k7i3iEp7CC02kA+cf0Twv9
         A5RX1HkCZah37ieyL6MUbS4WT7ioQEzx95PH4tjrujsyuUeO+n5ywDKpB37VDtToqkdI
         QFmY/J/IMwOssXj9dYvFakrCmfmN/z7IGGLS6EQBPMdPI3gEQLxrE9A78tAloHRtHh3u
         WiLg==
X-Gm-Message-State: AA+aEWZs2lP6Ift+GRCrk6ltHEkixHEdYHYDzpcw6LJ7NhzuS/TxCf4j
        LesmY2+mm1cYTurmDbihiTUYIA==
X-Google-Smtp-Source: AFSGD/XD/VaNvHooa1U8MF4EcsyUD5eENPKTyc/elIU8AEOCUfZUO1AZ2Sf5pswhiZstcskvyYRyqA==
X-Received: by 2002:a1c:bd82:: with SMTP id n124mr10573230wmf.105.1544454636309;
        Mon, 10 Dec 2018 07:10:36 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id y8sm11755720wmg.13.2018.12.10.07.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:10:35 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] regulator: stepping set voltage for regmap users
Date:   Mon, 10 Dec 2018 16:10:22 +0100
Message-Id: <20181210151024.3906-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a regulator driver for a PMIC whose programming manual
suggests manual ramping of the regulator output voltage one step at a
time (when the regulator is enabled).

Initially I wanted to simply put it into the driver but noticed that
some other modules (e.g. rk808) seem to be doing the same and could
potentially benefit from putting this helper into the regulator core
code.

The first patch makes _regulator_is_enabled() available to regulator
code outside core.c. The second provides the helper described above.

If accepted this will be used in a driver submitted for review after
the 4.21 merge window.

Bartosz Golaszewski (2):
  regulator: make _regulator_is_enabled() available in internal.h
  regulator: provide regulator_set_voltage_sel_regmap_step() helper

 drivers/regulator/core.c         |  3 +-
 drivers/regulator/helpers.c      | 48 ++++++++++++++++++++++++++++++++
 drivers/regulator/internal.h     |  1 +
 include/linux/regulator/driver.h |  2 ++
 4 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.19.1

