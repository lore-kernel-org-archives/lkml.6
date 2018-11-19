Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17F620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="kv9OvgbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17F620823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeKSQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 11:35:17 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40886 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeKSQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 11:35:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so13350008pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 22:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=MMUm3eNkpyPQHHD2Gp64vHeM9nQZHTseSiKVjNaXq+Q=;
        b=kv9OvgbX0jXRr6DOGZLs7A8UmehgZimV9NLWu2CAlxgNvsCt2Zwk1uLg4DQdoT44N+
         PA+ANHP/bC6ACVmDVQlSSnaF1FfBLcTSGdRApwt0mwRgeVHpQLYJHEnJ5xAg0KyotSde
         LnrtS9clvePHrqi38c8ALBTKnIqNaeD8zkiGQdHId7uxiQxSZiARwPXx1ebIP7qFKDR3
         cH51S5qRuM5Sram0DJaQuyDll+qB03BNsIhsrrfUcVERHN6wPJWhUi7qV5hwo3ZBLWvy
         AzNIvSMWD/ViZ9h/H52tOBGQtP2yIXsKTJf+90dfkfOnxYkktCxsQ2DZus7rGCYD5gMZ
         ULCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MMUm3eNkpyPQHHD2Gp64vHeM9nQZHTseSiKVjNaXq+Q=;
        b=leycH7GkThvNEM5gXC+fcDORBFk7zI78U+f4CosarvQPxwQye/jEuPc97jdjhxWvWH
         yEQf7YEp80VkzZainZdWYcbtZWFYxxqZQ76iPp34NodXXxPeX0KM1WO4NKHR8QB7S3m5
         UHuwCurTTuTBU4vofFDMk2KluyoULyZ2C+a/xf4Tgmy331zyBhahbsKTtVVbFHuq+3Fg
         0R4Dorscq7Tp4lz/jw6KWY2h8PbnCZvMPtkoGI0RMe7ZkGL4HEEhuMsFoa/JyQUkaWbm
         8pUWGHQUUuqRAkBBs2UaeEflnYsPodInAOqyoj1cli6o3aRfNhIzfVH53bdcaRjDdFij
         vokQ==
X-Gm-Message-State: AGRZ1gIRT8vg3E3sHiYWnW7HpJldIE6jx5yaRvhs0xJXymRLMTrHtaZ9
        cVrZxQePblt6TVuUoPj5x+vrAA==
X-Google-Smtp-Source: AJdET5fcLhsbrVoaCd4D+9vKRfCouJQ7gGNfGwjw0jCEsKlG/K7xq5FmZN1iRE+0MaW17fUaJuMZyA==
X-Received: by 2002:a62:37c7:: with SMTP id e190-v6mr21206743pfa.145.1542607959782;
        Sun, 18 Nov 2018 22:12:39 -0800 (PST)
Received: from endless.endlessm-sf.com (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.googlemail.com with ESMTPSA id r4sm47469591pgn.54.2018.11.18.22.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 22:12:39 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling
Date:   Mon, 19 Nov 2018 14:12:19 +0800
Message-Id: <20181119061219.14238-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the description of st_sensor_settings and st_sensor_data
structures' comments:
- bootime: samples to discard when sensor passing from power-down to
power-up.
- odr: Output data rate of the sensor [Hz].

The sleep time should be
sdata->sensor_settings->bootime + 1000 / sdata->odr ms.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 26fbd1bd9413..6b87ea657a92 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 		if (err < 0)
 			goto out;
 
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+		msleep(sdata->sensor_settings->bootime + 1000 / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
 			goto out;
-- 
2.11.0

