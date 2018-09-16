Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA17ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED84121470
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZcpvYNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED84121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIPF0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:26:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36136 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeIPF0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:26:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id j192-v6so5644600wmj.1;
        Sat, 15 Sep 2018 17:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePPE5nOvq9PGbffnL7xK3U8smTmc9I0pPN98G8vGmQo=;
        b=WZcpvYNK6mToZzUA30Bqh576gjAPdRE5uRKXAZ1nrDCOxnIrFS2OseGm1Vv/4vSO4v
         64G9d3VEBil2B2LHIVrtkuAhvxGWkWJfsUrSzk8hBjgq3iFx96J6GFd2Tiv9QPOmaFj8
         mPG9bKjhVWmS2G83yNJ95/vpF/j4vFqjkDAf5z7LbvrKTT8RRjJKdW8wQTvOrMTV6Rzm
         XIKdTrIH16lVO2emusQ+gmQhzcuHWqQmeSfrrYIVgMEFTEvAHvRkyOjc1yFIvp+Ly6wg
         7WjF6E/FX1Y3I9rq0QOvApnDaL0V5Q/L4E+nPoXMA5mPk0ydDlksJtUBrUXVO3rVcl16
         w3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePPE5nOvq9PGbffnL7xK3U8smTmc9I0pPN98G8vGmQo=;
        b=LxNJRmOyjs/CDyFeXnLV26NIrnmcm0EgWjFJ96P5kfRlT88EocIzUbtBc8NpLorphy
         5x5+xWrUz/iZtEST4kAC2ptHM680z1jtr+73mCv/ROOSgZr73OcOuV47s28HoroxzNdn
         Qzfo81op2+FnQvD4atQ7IyTVhJYZv5NoOq4WL67H4IipZLFdMRGSQ6qRiB3lYe/ii7MW
         72TnbOnqJYCx90gmqE5XdMdckOCM0qQv+nVIY1e+smJDu3KRXWks7oTRxUu9SdnTA7ub
         OdeNjXd3O2p7iDq+AlWiqzjQdy8BaOIaDDC100DV5k88+gbqM+xQ80fLh1lE9HcANJYM
         EuYA==
X-Gm-Message-State: APzg51CpI5tSWNcHceN2sFEuGKnVfZQVYATGdSBKrGUi0w5agFJNYfng
        NVvFLjDkGEhspbSoSKPsUNY=
X-Google-Smtp-Source: ANB0VdZMTBXB0FO0UGjCLPkTuA27TPJFYuO+T8BFTCLjsRygqVS4Y5If80Z1qEdCm4FxF10wqUgY7w==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr6612781wmy.81.1537056330622;
        Sat, 15 Sep 2018 17:05:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 127-v6sm2718808wmb.30.2018.09.15.17.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 17:05:29 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] hwmon: scmi: Remove redundant pointer check
Date:   Sat, 15 Sep 2018 17:05:07 -0700
Message-Id: <20180916000506.28905-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when the address of a pointer is used in a boolean context
as it will always return true.

drivers/hwmon/scmi-hwmon.c:59:24: warning: address of array
'sensor->name' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (sensor && sensor->name)
                   ~~ ~~~~~~~~^~~~
1 warning generated.

Remove the check as it isn't doing anything currently; if validation
of the contents of the data structure was intended by the original
author (since this line has been present from the first version of
this driver), it can be added in a follow-up patch.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/hwmon/scmi-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 91976b6ca300..2e005edee0c9 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -56,7 +56,7 @@ scmi_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
 	const struct scmi_sensors *scmi_sensors = drvdata;
 
 	sensor = *(scmi_sensors->info[type] + channel);
-	if (sensor && sensor->name)
+	if (sensor)
 		return S_IRUGO;
 
 	return 0;
-- 
2.19.0

