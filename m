Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A90C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DB12081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF10LUmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DB12081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbeLJPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:44:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38189 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeLJPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:44:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so5431227plb.5;
        Mon, 10 Dec 2018 07:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sNObouxbtDAuzbYoJ9Ku1TKX/BO+cq7xwr74jzSdRjI=;
        b=fF10LUmOgRT+WaKcbYthnRy65MZXg4Uqeu75taS9YlEenNE7dbPs0282ego5eC2/Q/
         Wh62HghVckKQN2thrAe2G7cvI6jE8eczckKkY3p1VgFkJxtUsYSmFJFT8bHqM3JJ6vJw
         5QcdKQ7nhu7KIVYMKTajpu9ZHQe+OhuigaflXThc9kzdjtz5H3AAXIGKVqMkoqszDME+
         RV2yHVhh4rfJMA6u8YtypPWjksjGb+9lw9TUzfByM2hBe2UizvjIkx1idtO1w6xgL+1I
         vR/7G4N9y2iIkr8n4c3vB4YwudJ6PiTsLSixMBgLEEXQZj19DtkVdTqbzcR8N+kHuNLn
         p5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sNObouxbtDAuzbYoJ9Ku1TKX/BO+cq7xwr74jzSdRjI=;
        b=PastYZxF4k09V47tYvRdDEXztx6HEamCfVC5Ed7xG0Ig65fSU4TVe0WEofd7rOOyLk
         T2md5jATIqvm36QkpVqEP2IEJOSqflJ/ljPKB/ENOthfoeVC8AQ3Pp1gxiqvVQ0tE+E8
         WGMmnyt5qkgcDMybF36fFqpXSzGedPsLL8sA0IHMcDlHRABaBY2AfqhNzicS4o8Nl6zk
         HygA7mP4jLHD0uvLMuQtEmNsdrH/BpbxF+79OAvLMaMYOqU761F0NhNtP2pC3N8c70Ag
         ySh1RoXfddHQgseNOzyIIrTzNYsl3tmBXVNLV/cw/IVBD+pOR7gfbO1L3NZ3A4D5w1g8
         /5/A==
X-Gm-Message-State: AA+aEWYmYELl7V1sxrrcDGv7jR9FU4X+Cqq+MTC5Xqk7ypz7Xd9TOLW6
        FxtkV3Dz1vuPUdH0CjhyXAM=
X-Google-Smtp-Source: AFSGD/W8U3Zn2FwdBeeejB5/KybQYa+Mp69pG6X4ZIB9wpWGKDETRk5WUuN4oPbqpGpSz3ECk+jViQ==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr12734968plm.154.1544456681409;
        Mon, 10 Dec 2018 07:44:41 -0800 (PST)
Received: from localhost.localdomain ([106.51.67.149])
        by smtp.googlemail.com with ESMTPSA id f67sm23211227pff.29.2018.12.10.07.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 07:44:40 -0800 (PST)
From:   Hardik Singh Rathore <hardiksingh.k@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     michael.hennerich@analog.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>
Subject: [PATCH] Input: touchscreen: ad7879: Fix ERROR: foo* bar should be "foo *bar"
Date:   Mon, 10 Dec 2018 21:14:33 +0530
Message-Id: <20181210154433.28319-1-hardiksingh.k@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the coding style problem reported by checkpatch.pl.

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
 drivers/input/touchscreen/ad7879.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 6bad23ee47a1..b68902c17f2e 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -290,7 +290,7 @@ static int ad7879_open(struct input_dev *input)
 	return 0;
 }
 
-static void ad7879_close(struct input_dev* input)
+static void ad7879_close(struct input_dev *input)
 {
 	struct ad7879 *ts = input_get_drvdata(input);
 
-- 
2.17.1

