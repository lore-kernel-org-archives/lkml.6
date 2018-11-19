Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB3DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5A92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnR4IUMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5A92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbeKTG4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:56:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37512 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbeKTG4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:56:44 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so12716191pfm.4;
        Mon, 19 Nov 2018 12:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qsErZEFmxBc/B63p3QJR+myJ+mmlcz/hg4isze/y40c=;
        b=GnR4IUMJ1nGnUEzQEXhbdvx4BQN4T0qKAvZGoiuGT30Zo8Y/INvlIERaUr6TTOr8UH
         cGidAx5bDq75LW9BDJ9PdzCwVeSAS6mTX0P+A+Q1/UpP3bl+E914xAbYtTWthkk1RwmU
         QXVlpBgRfrD7XbFDqT5VZFPHEbkeRUg7d9krxy41VockWd+PjwW21/9JFaDneRzNnAQB
         GkddmYdgX6agD+nIr0uk2dQLCxlyZ/Wvxtfx2PKJUf+cFptIcGf3D2Ah+SkLVBABSfWq
         Qna91x/k5MJlbJ51iA6OEBRamKbW8LAKoPtEs0+LNfx79hNl6Aqpw7pXb64APqgxlyih
         1Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qsErZEFmxBc/B63p3QJR+myJ+mmlcz/hg4isze/y40c=;
        b=YsdZxYATM/eAXUzq7MR/6jWHgu2/fC1t1WXqX/MJeFSb/1/hlu8bdqzdvhjVe67dod
         RA4tVHKsEP0bnuOD5++y0cxxXXK/05jxWgth/zLZgpbLWIpXD6wpcs6DeFbbLgOI0M6H
         p2msDf0vmuZR7mZ7RsaNeMguja/rxEVImbi76MdTw6smuS95EdaOdhWg6DzG2mO0kep7
         jYcF8rPX7FCx0J9uCsuEpe7Piru3O/f2+0tG0hpw0NEOJMrvMB3Q+gbDPLrhGV1mnv16
         BfEaZkBXSjqi+5ycgq/X29JeKLCtdLA4SzHcoBtnnvknwof+CRY+3tWFd4zvgtauoEZL
         ANIg==
X-Gm-Message-State: AGRZ1gJwhHwRVnt8Yi1goxJq4RVEHoX/mz1Ot8Edtob8YasgWCsKW4hH
        wYuI/R7/wl72cFkK+tpCDQSGzupB
X-Google-Smtp-Source: AJdET5eHkzNHiv9dlZX32EDSCnC4tIRWJYFkbByje5oCJ7v1JsPjVwWb75sShi9rvJZc6r+p61gJ5g==
X-Received: by 2002:a63:5153:: with SMTP id r19mr21331516pgl.281.1542659484740;
        Mon, 19 Nov 2018 12:31:24 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6251920pfi.66.2018.11.19.12.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 12:31:24 -0800 (PST)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: hwmon: Add descriptions for ina2xx sysfs entries
Date:   Mon, 19 Nov 2018 12:31:16 -0800
Message-Id: <20181119203116.25589-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few sysfs entries being exposed to user space by the
ina2xx hwmon driver while not getting explicitly documented. So
this patch just adds a description section for them.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/hwmon/ina2xx | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index b8df81f6d6bc..0f36c021192d 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -62,3 +62,18 @@ bus and shunt voltage conversion times multiplied by the averaging rate. We
 don't touch the conversion times and only modify the number of averages. The
 lower limit of the update_interval is 2 ms, the upper limit is 2253 ms.
 The actual programmed interval may vary from the desired value.
+
+General sysfs entries
+-------------
+
+in0_input		Shunt voltage(mV) channel
+in1_input		Bus voltage(mV) channel
+curr1_input		Current(mA) measurement channel
+power1_input		Power(uW) measurement channel
+shunt_resistor		Shunt resistance(uOhm) channel
+
+Sysfs entries for ina226, ina230 and ina231 only
+-------------
+
+update_interval		data conversion time; affects number of samples used
+			to average results for shunt and bus voltages.
-- 
2.17.1

