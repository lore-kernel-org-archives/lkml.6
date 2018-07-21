Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9555BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D3C20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b13ghsMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D3C20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeGUUEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so14117685wrr.8;
        Sat, 21 Jul 2018 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vyjd9FGJMy0+TxbD7vXkSRtycDBsk85CQ0K4UBHKE3I=;
        b=b13ghsMwCn49x6zIuqIF7fwHWATRXhwNTG76khSpodNpCrKknq7olHeXdYg8tY6Jeb
         7Vs3Bjq5lNJxMiMkbliAh/O0fr+pulHiFAAXaN+BUPPjao28Rpst5UuRxtKiU+A1/WtC
         CUafuylOV66+XqSfUauqB0N6JR4X33RbyzLIus0lR0h8sVbHsygGORmQKIO3gg5JePqf
         08SvhpLAQE1o2BO7SJowvd8+nr7TuPxtH7kOkfaQAFBosLg2uFQ8IU1B8TclXQJcAdBK
         CJNu8/u8zZVfUXz/jNsOwfX6QWWsjhUJD0377Etd0i2iyU6t6/n/kyaZesAnuaVQmXDL
         VJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vyjd9FGJMy0+TxbD7vXkSRtycDBsk85CQ0K4UBHKE3I=;
        b=WO5AsFpxS6PfEFFw9jclQ/FGWDngIcyW9MiwQyJgZRIsmRiKDsnrOY6DoFldL4IO4t
         SBAZQBGBvBENXnAiGGG7Stfy1w2jYmfaI0Dt0337RpV3sqS4LQlyDcKNl180Df6h6GF6
         8cFXeen/adO3v+wcdIhW4kwaa5pR894GZlB54H9Yi61X0d7QhvFOuEseKUZnWNj/I+vq
         PW4UwmJkXQZIPtkL6vVYwFOauhrgTEDF7qWoIHQ517O3LVDU31eaiaLdbAGojP8I+/9R
         sR/CrjKoQuytkym1IKhgV8/u0ti44oCLo0MDRW4gndY0Y8eDaRUgH2zmv0E6qJiiHp1N
         F9pQ==
X-Gm-Message-State: AOUpUlHpqVLv9SUr6zSUWCnQ8v7Mq5tM4fehv5OnyxnA1s0hXD9ZL+Qs
        H80+MZWxU8+Q4OvSJF6/+bg=
X-Google-Smtp-Source: AAOMgpcYljecTMm9MRpmiuhdCgDAqKG7T6aCGjGkXUIQ04qhobkNHhmdu5Sj3mVKcNePm2vkL+kiuw==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr4775766wrd.273.1532200236390;
        Sat, 21 Jul 2018 12:10:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:10:35 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] touchscreen: amtel: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:44 +0530
Message-Id: <20180721191029.25658-3-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(fw_version, S_IRUGO, mxt_fw_version_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(hw_version, S_IRUGO, mxt_hw_version_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 54fe190fd4bc..5202a8244f1d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2892,10 +2892,10 @@ static ssize_t mxt_update_fw_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, mxt_fw_version_show, NULL);
-static DEVICE_ATTR(hw_version, S_IRUGO, mxt_hw_version_show, NULL);
-static DEVICE_ATTR(object, S_IRUGO, mxt_object_show, NULL);
-static DEVICE_ATTR(update_fw, S_IWUSR, NULL, mxt_update_fw_store);
+static DEVICE_ATTR(fw_version, 0444, mxt_fw_version_show, NULL);
+static DEVICE_ATTR(hw_version, 0444, mxt_hw_version_show, NULL);
+static DEVICE_ATTR(object, 0444, mxt_object_show, NULL);
+static DEVICE_ATTR(update_fw, 0200, NULL, mxt_update_fw_store);
 
 static struct attribute *mxt_attrs[] = {
 	&dev_attr_fw_version.attr,
-- 
2.17.1

