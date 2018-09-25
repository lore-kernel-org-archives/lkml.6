Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B3C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5412086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk32287w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5412086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIZBni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:43:38 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44220 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeIZBng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:43:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id 36-v6so25647317oth.11;
        Tue, 25 Sep 2018 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VeVzFeKaOoNtesWNemDDHsBAC/S6Qic/S2k/F1Uysxc=;
        b=Qk32287wMAxZUhn8Cjk6hL7/SJyPzbNdKNxARBOlwrVE3H0N2qGoo0K4sP5CSo6YRB
         0IUdOjMq9V+gdiE40Jg4L00ovgRPOEyQyIoYDuO9EiaYkDrh1/A5LqWq36703Z20EV9W
         IBpypC9OucPq1uEVaCHOR8FAz+a09M5toEPXtH95kpOHPYerujFZupzeTyEgCMpBgIBE
         kqsFTNlndxth0MayAWZBGEOd7VuSSp1NazeC0Adn4zOg3DKvQOW4Uf9OPD3NaC6iMoaJ
         kpFIUST0yIV/6k2wlf+i0jbiJ8ddEG0BCx2aWi7PsTWlnklqAY8RiK6tubzHj4PGsXR1
         ujCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VeVzFeKaOoNtesWNemDDHsBAC/S6Qic/S2k/F1Uysxc=;
        b=lpu5iRabvCweUJzX+CFPZAUC4k8EXR5cyakzh4uqMq+ocDwihDJtcQ5IMvirfSoZLK
         5AJeyAVj6dY3QRT8513h4va23YfOgC00tydCnQ2kb2U99uhIuzBLuqjykyYgLl3BFghI
         0bBH6xVmEvfsa89nGFnlJAE2laLcvjPSiaGyJkQV85JYz/n8VTKq9F9GW/3XfFXw7HX3
         a+4iyxKtDzeAhKJf1ZodevQKbJlM2WpgQa2sKIPTF8dbxaacvYtEgIXZMGqdMSNDDUzM
         OpI++cCsUIRzrHKi5+50gemzLrAf+GippFYAc80VJWwhUlLL1MrGhk9AgjwO67TPeb3m
         rkNQ==
X-Gm-Message-State: ABuFfoiHUNR9ZQ57cuUr8jSUkSgKLLa4najm+LRGMjtRA+YsheHd5evd
        rmvm+mwq+f8Q/FfosrQfwdQ=
X-Google-Smtp-Source: ACcGV63UPkKTQD7AKtvOAAvJ7wi02qLET5+fwjc1tRPUwIUrDrbSv5uPPi6vnW7xjE+WE/uaonffcg==
X-Received: by 2002:a9d:1b4c:: with SMTP id l70-v6mr1901897otl.107.1537904071242;
        Tue, 25 Sep 2018 12:34:31 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1049193otl.43.2018.09.25.12.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:34:30 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
X-Google-Original-From: Stuart Hayes <stuart.hayes@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH 1/5] firmware: dell_rbu: Make payload memory uncachable
Date:   Tue, 25 Sep 2018 14:34:14 -0500
Message-Id: <20180925193418.28493-2-stuart.hayes@dell.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925193418.28493-1-stuart.hayes@dell.com>
References: <20180925193418.28493-1-stuart.hayes@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayes <stuart.w.hayes@gmail.com>

The dell_rbu driver takes firmware update payloads and puts them in memory so
the system BIOS can find them after a reboot.  This sometimes fails (though
rarely), because the memory containing the payload is in the CPU cache but
never gets written back to main memory before the system is rebooted (CPU
cache contents are lost on reboot).

With this patch, the payload memory will be changed to uncachable to ensure
that the payload is actually in main memory before the system is rebooted.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
This patch has been discussed previously, see history at
https://patchwork.kernel.org/patch/10512079/


 drivers/firmware/dell_rbu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index fb8af5cb7c9b..ccefa84f7305 100644
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -45,6 +45,7 @@
 #include <linux/moduleparam.h>
 #include <linux/firmware.h>
 #include <linux/dma-mapping.h>
+#include <asm/set_memory.h>
 
 MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
 MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
@@ -181,6 +182,11 @@ static int create_packet(void *data, size_t length)
 			packet_data_temp_buf = NULL;
 		}
 	}
+	/*
+	 * set to uncachable or it may never get written back before reboot
+	 */
+	set_memory_uc((unsigned long)packet_data_temp_buf, 1 << ordernum);
+
 	spin_lock(&rbu_data.lock);
 
 	newpacket->data = packet_data_temp_buf;
@@ -349,6 +355,8 @@ static void packet_empty_list(void)
 		 * to make sure there are no stale RBU packets left in memory
 		 */
 		memset(newpacket->data, 0, rbu_data.packetsize);
+		set_memory_wb((unsigned long)newpacket->data,
+			1 << newpacket->ordernum);
 		free_pages((unsigned long) newpacket->data,
 			newpacket->ordernum);
 		kfree(newpacket);
-- 
2.19.0.221.g150f307af

