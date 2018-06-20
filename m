Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5DEC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CEF20875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHm/n4nX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CEF20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeFTVaj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:30:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41743 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933225AbeFTVai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:30:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so455028ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PBz+0DnkwfO9eUi//oOfOJWDzma/hvrGDyYaqjRL1t8=;
        b=nHm/n4nXnWdkiCDrH19fvS42elVx8gVKFAbTnVCDdfjXbBWpPCCsVONAWKWSgcuhOA
         LndocqzZsYD5wiPKiKu3JwsTO5GLmlv2rzwqU2w7z0iK3dlW+DPCYC1UNevjy/tw1542
         W2lBAQWbS+a8+axn/ch7qGiEbVW0t3MwSTKBimbPIHPH4scfQLOiiorzhe5TzaEycj+j
         UvakhNRDXPhfdSqygLBtoboKFtqEhwdQ5+WViyWOBOvy6vEuc/0M0QkX3Z8/pUdYTGcb
         +pHtQcwzZuRelQXyBDVFJht/Jxbt5MCO6NlWFOZegHcQAH99T7SM4nG7V0I0/8u87mB1
         NnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PBz+0DnkwfO9eUi//oOfOJWDzma/hvrGDyYaqjRL1t8=;
        b=Co6vWOUD8je8oUKtDNS2omqb3vqkYU/sLT5rRgVkVrswe2YFQE0OcjXazFfZarQtgQ
         hlYWpjDn3VWmEgZ06xBAOIBwW//Xge5guUYU6D75Jj7YHHL5RZiBiIR9EJhlrc6y4bGM
         BQg8DJzHZ/FODQ6y14wVk4evH8eLjSPFn+sD3bgRuEzFIPMK/OJrMMXi8OUKXLUR0VDu
         txx5uQHJcqRGHUiG7mwpB6etY2oLAK3CTHre0RbN7i7tS3tMedhTybIw1yLztTYbPDsd
         Rhx8AAYC7qiRGU4Uje/oiHZmafOEqLdmoxahx8tUzQX7XoVKfS+7+C4KEOiOM78HRu+H
         gDXw==
X-Gm-Message-State: APt69E0WVfipJh6B7HMC8lkU3PSCA2iBktikjPym6kxK1U91v0OwDX3+
        BULOOnFw2v99gz8YmyIgAoQ=
X-Google-Smtp-Source: ADUXVKIcKj8Av7zOfdXrkCvA/d28WEuAcJTurhSP8AJs5zjjcE6pSkCLZJ5Y49jdsz6KNJwRd6q8cg==
X-Received: by 2002:a17:902:a610:: with SMTP id u16-v6mr25439794plq.195.1529530237477;
        Wed, 20 Jun 2018 14:30:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id z74-v6sm8228028pff.54.2018.06.20.14.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 14:30:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH 1/2] Revert "mfd: cros_ec: Remove unused __remove function"
Date:   Wed, 20 Jun 2018 14:30:32 -0700
Message-Id: <20180620213033.100455-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 556c242045f0c1613aac2e64dc5b2ff0e4bc89e1.

The patch that this change is purported to fix is broken and should be
reverted; thus we reverting this one as well.
---

Lee,

I see the broken code is already in Linus' tree, so please merge send
it on at your earliest convenience.

Thanks,
Dmitry


 drivers/mfd/cros_ec_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 306e1fd109bd..4b1dbe81fcb6 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -262,6 +262,8 @@ static const struct file_operations fops = {
 #endif
 };
 
+static void __remove(struct device *dev) { }
+
 static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 {
 	/*
-- 
2.18.0.rc1.244.gcf134e6275-goog

