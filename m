Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C52ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651D120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMoX2Dve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651D120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbeGWOVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46706 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388053AbeGWOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so664878wrw.13;
        Mon, 23 Jul 2018 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BObdpk6HN1vRa6o+1/RlFHnMb4FU0uQpaSfZRoJcZ8s=;
        b=DMoX2Dvewx/sZdU+jLETbYnTbdeJNDOydYlIVogh3RP/72uXXI/PIIxsH0aNm7ylUY
         laGSbk1SAiKsN1C1ocyAZhAZ3l00Lgufv41am9OShlFZIMV5crWPQpSvj7WuAXKebiTX
         8gOZhd+pbDpEd8wKEzKPDJ56L9DRc89pTf7E0mRRtw2iq3weLqc6dJTrJrbyRSB6gkR+
         pOCkxfc8HJhZpKjKRcXPQjVfSB51o8oJTrkRiV+MJiwN62ztdEET6jxErNh++pJOKBCg
         nvlo1wurFv4aSA3uEwmArnFCpUjfFFy1CjaHucmxdOQUSwfC/mECe1B0PRkPFyIn5R4e
         OUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BObdpk6HN1vRa6o+1/RlFHnMb4FU0uQpaSfZRoJcZ8s=;
        b=PYeiiMJTjSNBTqoVENBUZbqb/FYMXAUsOHW9f5cEuM3XRyb7YsWSnCRSg+DQ83eQcy
         UNdqRJ7BMLWwRPPDs6f1YMT9P8GmeGFKCAbVh0OGzk/1jb1yJ+hk7WiQZBcytAV9U8Rl
         50Q8Sseixbu5HPDVPKjutj86LxmJIi3b3Zd7n0TN6oYtoPeQs2YSn2hAE8YP6TBuAYwE
         mYegX3uBGARegGEN85D+xUdE7eA2NFNSv/grQ9kAm4QYYSH9bPMbWh1yDErSToWF50PS
         5ppcNUAi8YuiJhZ0lyWnXfQyXu28HekRhSn+wmYOsAjqMiJ/G5giLtB8cP/RlMa0taG0
         Gmvw==
X-Gm-Message-State: AOUpUlFsf6NKSrJW6ktLDi/pxf5Wm62SGozQT+tNAzKQmOiIBYq5zwP/
        hSlGxAjtMDXT85JJkVzU+HY=
X-Google-Smtp-Source: AAOMgpeUExfpGhaclgivaM62ji8SyjD1N9yfOu7+fcJc9Cpc6TuP+dBvw0Xac7wnxeq8x8LFw4koKQ==
X-Received: by 2002:adf:96b2:: with SMTP id u47-v6mr8741890wrb.204.1532351996573;
        Mon, 23 Jul 2018 06:19:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:19:55 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] touchscreen: ad7877: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:17 +0530
Message-Id: <20180723131954.30739-1-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/ad7877.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 5cfe477ec992..4b4a9d84195e 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -461,7 +461,7 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 		return v; \
 	return sprintf(buf, "%u\n", (unsigned) v); \
 } \
-static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+static DEVICE_ATTR(name, 0444, name ## _show, NULL);
 
 SHOW(aux1)
 SHOW(aux2)
-- 
2.17.1

