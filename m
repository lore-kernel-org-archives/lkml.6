Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397BBECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF0820854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 19:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCxbVxA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF0820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeGUUEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 16:04:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39886 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUUEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 16:04:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so12643840wmb.4;
        Sat, 21 Jul 2018 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7uafs0jiKUh7lUwZ0AA5KAIpK1U6UC7U/ESXulHGeeE=;
        b=UCxbVxA9XUsECyLTFuTq2VBRqvpftTYDG6X7u3GTSYQ/nvdJiKsclpIJI8U+n2fwuX
         9OUL8DLakUHyjIEySJaL6ex+nXjdwyJUT51NIvNgsg6GY4YwZaIW3suWxQvh6ZDALKOs
         kk3MzrLHI1IsxYrOv+bfZtakeCdhWs8jOCCpyUwI7obXGPsflNnakBtqqWpqm4tzlDgr
         bHH9XmDOAJLAvg0mcCu8YWAygemF2yatcO0MyKhBRLevx4GDMlXYdN/LCscr+hw/eZpB
         t7FLCyYwmghKLG72vik6WUZ3BfemTcjgFeHCmbOiX/NJ0CuPSRMOzJG8rMs2K1g5xl4t
         qcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7uafs0jiKUh7lUwZ0AA5KAIpK1U6UC7U/ESXulHGeeE=;
        b=NSp/R1khHvXCTMCURDl8knDnMXAqRdJjtRFeTOvQHOqGvIzyIgaEf9zhOE2yA6ghmN
         Xo6fIODpFfqJhScUkdSuMmo2PWhTCKJAcZjUKpAth0PvrsTCvYYztQfUH4XuvTDS8/oo
         4KzytvGPJgsApAhiqirGH9FIZvOmZIyYC+bUvdM7dt+Fgq8yARLl0cRFd4RIYkaASmig
         cfmiSX97aSee1qX91LtepBFwukXwshrCeibDT3xHzsA4c5in8OyKAar6JnKhw5z1R0o9
         ii1ILKif1hnpp5DWbWa7bXhC+O7qE2/kk/4hFVvq4k9H7Z0pdgEMFg1+nlb1LZQNoPE3
         ME8A==
X-Gm-Message-State: AOUpUlFXrZY6fUYEXyq1+YPFZR1d7+W8oZgBf/K9NfvgNd8VpM0MpqGv
        5bwVj3Kpk/oMvifAc9fZ1Rc=
X-Google-Smtp-Source: AAOMgpeM8oPALGjAEHEHZoTGQZiCqa56MPAT3IOzLG49IXtl9hWY8np3p+YyvhaSTJ5Db2y1OGgPXQ==
X-Received: by 2002:a1c:b157:: with SMTP id a84-v6mr3856952wmf.18.1532200261143;
        Sat, 21 Jul 2018 12:11:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id x19-v6sm4241933wrd.32.2018.07.21.12.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 12:11:00 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jeffrey Lin <jeffrey.lin@rad-ic.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] touchscreen: raydium_ts: Use octal permissions
Date:   Sun, 22 Jul 2018 00:39:49 +0530
Message-Id: <20180721191029.25658-8-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index d1c09e6a2cb6..eddbb51e55dd 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -934,9 +934,9 @@ static ssize_t raydium_i2c_calibrate_store(struct device *dev,
 	return error ?: count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);
-static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);
-static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);
+static DEVICE_ATTR(fw_version, 0444, raydium_i2c_fw_ver_show, NULL);
+static DEVICE_ATTR(hw_version, 0444, raydium_i2c_hw_ver_show, NULL);
+static DEVICE_ATTR(boot_mode, 0444, raydium_i2c_boot_mode_show, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);
 static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);
 
-- 
2.17.1

