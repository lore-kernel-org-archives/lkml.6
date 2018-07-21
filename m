Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6195ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5992A20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/CtUiGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5992A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeGUUES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43121 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so14124849wrv.10;
        Sat, 21 Jul 2018 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GCrPruLhZuUTGlT9o6hYH6/BFwQHXTby7KIZNp0S4WE=;
        b=o/CtUiGL8gGI4hDKHSuJqwdqHQEkUztP7ep2Whm2dS2k+6DQn8j31ZrY8zfQ1j4TmN
         mFwpFEthd14QApID1DJytrsH9K1zWhTlVn8mA0HhETvgpc+Kubb0TFWa6hilAVgMnSs1
         aBWQe2TqpOfL01dQcB4nYxdSIXO6nn31/qvlM8zZT6x2ZqSK6VyKnnAdgRCPuAzMXZG0
         p9v9pf9ekGlMsyBE36MGO+x3o/KzxX1r4c6QQpSNrXdDMEvtNIFGRerVxcgXP2ZY9Mac
         vTFt1a0trjOUhCUq3gfjmEiZ4ERkqkZjjDuxWGorpDJ4et4NGkXb/WXB66e+23NEfYSZ
         rnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GCrPruLhZuUTGlT9o6hYH6/BFwQHXTby7KIZNp0S4WE=;
        b=TbYkS9WD1/ulBT+sLct/qvTO2H6NO7O+9Xs2CUflOqCHsnYgzF5wspchN8Ar/P98Rp
         IYJB4kPgWwXW5VoYiBGBSPQj8ydDSsvgDBUOo5APdMEWDGOXTS2dzCRKuwZ0KJl5+lIg
         pGkEwE4DZi+GNlSnalco1ZITpSFHIADS0mp4/iw25kUMxArr5e2DBBPzhVv1BOBT8g3x
         rMlIAQ6RRNwzu7EulqezggvveMQ6wRHRZN63+toMZ/qjqohXp0DPjHjD7Rm0Rwxhz7aq
         MHR4AwKjcKFEigPS4nZ12oEzsLfzJGHJbAgo558NKpQJk4sKAz+cY4lN3vB1Lhiw8idh
         rBSQ==
X-Gm-Message-State: AOUpUlHEAks8xoZ9Eo+yBZdIjkvIW8CFMio8pIPzI+O5IqPLY98mArK6
        DTuSshLOpn7mTNwlpsu38nE=
X-Google-Smtp-Source: AAOMgpdkWDEwrhB56K1nJ7MCnz9u7egVvruqKYZ2qDCEPxid/wNCHhBimurqchk9TEWZHLyYrDkT8w==
X-Received: by 2002:adf:fb92:: with SMTP id a18-v6mr4312299wrr.278.1532200230629;
        Sat, 21 Jul 2018 12:10:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:10:30 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] touchscreen: ad7877: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:42 +0530
Message-Id: <20180721191029.25658-1-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
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

