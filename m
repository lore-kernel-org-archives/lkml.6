Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83477ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E75A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkG6z/q2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E75A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbeGWOVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45570 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388053AbeGWOVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id t13-v6so668500wrv.12;
        Mon, 23 Jul 2018 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mp3LaNPPkhyZvfO++aStv3wm/x6qr01HzaC/J4eqGS0=;
        b=fkG6z/q22Nfyi0Lo4lQfKZBgQ3V1x6u67NnDKgixCvienyGfofA1vKheQ9N0o3hbi7
         S9bd6XgwcGIcWcf7g7vmwo34dLr9qGji7hChvImnYCJiB/rURApFghr2PYw4Sh3DR3XQ
         sczo+h+CzSUs3zbeWW4LEY3yTYtjX8htvqdyFYQg9HIbzUqFDY1a0lKseZkPAHi7owYT
         fwLmusgGBRapdXmr/tJTFyxVY2szm6XVASAZl/FZ6d7HGvAo9RdHYe3qJvPTxongYHRu
         VbEgQ/OOmWGPFzfBepxex8VDwm+R5DhHVrOrzPYWwXqtyRIo5t4PCL6Da4aMjhn2j/pE
         t9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mp3LaNPPkhyZvfO++aStv3wm/x6qr01HzaC/J4eqGS0=;
        b=LeigdGRPgqbduuHr1F+uaYl6s46KXXTZJC6R71qoSSsuKCdA0Jm35EZei50ryXXXkS
         cNt6rSlJxsvqezH/ozNVPSXFbGOXfDfwtms/szzIvPQi9+t7w50WdH4g/3x3jlS4Dvzc
         qMTKtfEYn3OWtgRvOhAC/7zkxoedSryChI5/aMFLmmtzzMfMKLV40+IxabNEvwpHzT0r
         ldYbfYLSD6u11CP69pNhE/5Jjd7ou9+Z03cSfYLOe4Rzzm24WzOhVepZEPzIJu6SVBV+
         FJD5nRvplx0ZRixY8CXfIhhgknfc8F2CuuyvShkxbe/W23siFA4mGJEwtCmQwhjSpYtU
         /tEw==
X-Gm-Message-State: AOUpUlFrzQPROTNpoP5zZZ0u9xP7nuLzShzzFS/7R/Me4hOyVZ1mzkQA
        DiNUIeKNVxyZuT1W/w3kQF4=
X-Google-Smtp-Source: AAOMgpfoHw7jRYPdRYD7n91OZf77ykQk0S89AdxVyWtLbge81dwW7fKjo9k94v1MrVKSCMRl9KE4QQ==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr8496673wrv.33.1532352006049;
        Mon, 23 Jul 2018 06:20:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:05 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] touchscreen: amtel: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:19 +0530
Message-Id: <20180723131954.30739-3-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
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

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
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

