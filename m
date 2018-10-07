Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA35C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAF12088F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcTsOViT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAF12088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJHEtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:49:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37685 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJHEs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id y11-v6so7968661wrd.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9iVR6Ieabsa8yWAr/NVgOitXv4IQZ0R9q4XUZNISWc=;
        b=hcTsOViTYHZGGWq2Wo2gjOGXp98R72u0caqlxr29pKlBxGblx81zZsqmMUN39QAJ5X
         XfVmFLincRXhg9uqcF8C+MaiyEJ01aICOR9l5ONTZIyX+Tr86yWcGQuCcGiAljld5efV
         gx75mIU9d4r4hb+C4l2u3/Mwj30+TkNCbyBWUwhcSWc+zdZN4w3FUx52nde3F4/HY54k
         dGWhDaa1TORllsty9med9Wx8HD92dDGNtYTG7R4m94n33KWtai1wwEdRcj46yCzmF/Q1
         LGY5qo67ZgEZEvzkYRde+R3qgEw1xvaTrsRGnijT70yeHT9NTC2bfFHMeWm+PbTB/QhJ
         gkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9iVR6Ieabsa8yWAr/NVgOitXv4IQZ0R9q4XUZNISWc=;
        b=ONrrK0qLMO9UNXumYfjTXqiN2msvhsxWbE6IubM5B5JQ9fz8QxjdbXYnfHRVvXWuBO
         58yekZgmba1Ttu7xPIxGMvTsdxSxUcCV7uswJL8VFkhBzRGUV/0Yu19R3sWB6JJDD30X
         XwlkAVsuViM307CjNPnBLux0t4Qq6tc+FFhVDq3IdS1ekUyG2km697APemJUM/jLCkc4
         8hCKRiJgSMnlFclW6+c+lxpCMCl6Dh14pGd0LKudJRb3bXsVmiToEtWMFh/Rp1rzksAS
         CFzFLwXb+e/Owwq3w8psVkeVWMz9tSCiesEA0idvJ8noN38SGyln6psk+2D+RPXq+Gss
         Flqw==
X-Gm-Message-State: ABuFfohjvzXjF8LvFuaBcqxr0P1l5F+YhBpPsZH7I9t8sPVmKhaAxd/i
        tReQ9qoJFWg17UswG5D6BbOf3f0j
X-Google-Smtp-Source: ACcGV60N/JIjLyzJKIOR+XCzabV9Sb5obhoVVIlG2aT7bSaK5wzME4weJ2o6naoBvwomOdG7TcOEqQ==
X-Received: by 2002:a5d:4706:: with SMTP id y6-v6mr13826615wrq.256.1538948421108;
        Sun, 07 Oct 2018 14:40:21 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:20 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/11] staging:rtl8192u: Correct code alignment - Style
Date:   Sun,  7 Oct 2018 22:40:24 +0100
Message-Id: <20181007214025.25469-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the alignment of a function, this clears checkpatch issue.

This is a simple coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 1b0f45f1bb84..5dc780119eff 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -244,7 +244,7 @@ static int show_debug_level(struct seq_file *m, void *v)
 }
 
 static ssize_t write_debug_level(struct file *file, const char __user *buffer,
-			     size_t count, loff_t *ppos)
+				 size_t count, loff_t *ppos)
 {
 	unsigned long val;
 	int err = kstrtoul_from_user(buffer, count, 0, &val);
-- 
2.19.0

