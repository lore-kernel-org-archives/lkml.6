Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC056C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E4B23DDD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l939bJtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E4B23DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeGFQSk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 12:18:40 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45451 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFQSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 12:18:38 -0400
Received: by mail-oi0-f68.google.com with SMTP id m2-v6so24457021oim.12;
        Fri, 06 Jul 2018 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZbIY7uEoUaymklLNjogXttQNsOSdhp8raYe4qqAVFfo=;
        b=l939bJtbvauoIzYatheiyutgoAZ5q6dQlSHBSgtcgZJLJdRh/cWQkk/6vu3DnVzFhL
         hNYEDIpqoacDNnowFW2YFPc1+EZGNzA9me3bzFHZQICZDez7wpl3qgqRPA3jW+doGzz4
         +kQpYCK8Ood5GsA3YyWXO4HL14CfEOAKpg4/ivJ97fUPM9FgjSBKRXZtzDq0lpjTpYmf
         oXeWb7av4Oo52MSMnNo8tXKTkVlMs0XW0CvE/WvxBDgv3975m5F+nmSRqqQ1MzZXusvw
         +uQLVX7gzydKa/SD7gI/gpI+SVXWwlDp4/e1SZAhXL1Kk2Pl/vmqzagA1kIeKvOVjN5x
         rpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZbIY7uEoUaymklLNjogXttQNsOSdhp8raYe4qqAVFfo=;
        b=Cdy3Mxj3uzjNPm1FOqkYWvVN0F2OHBNMxXWHw5fclKY1LS6B6oWSESKpjnXQMX3mU7
         eqC9T0BJncbiakHzKtvTxtATbWnH4qhbxBGGlLDfpOI/9VUt5SRXxJ2XoFedDLQXDOxj
         kmeICX0YrqGotlVZbW52pS9DeqMo0Nh/h1y9dojqW/s4A8cyCKmMLmiET+zpSNYttacK
         MVhw1jznkcf3nXfSST3ASfZCTviJ7MG1xJx3iW6mnltFWG11T8A3VBn0eUISGg1TH9kq
         SyqhNkAiKt+U1Dk+Hue1aqmTy6XmhT9AjlNfxxZ46lMFZLE6uGdw/Wuq1D7wIfP7BWH0
         /ing==
X-Gm-Message-State: APt69E3MghFr3LPJ8hA2svDGWKKlzwDH03B5F+xHnMr6L49XN8tzz7lc
        Dpak0eXdQnQEMa6lMaYlJYXOjHLd
X-Google-Smtp-Source: AAOMgpcAjF6I1H8869vqSALGG62q5KRNebMJvxt8cUM9OAmU8RMS0VpxCST19/cRmPqIwHmOUWaQJA==
X-Received: by 2002:aca:ebd8:: with SMTP id j207-v6mr12531297oih.206.1530893917623;
        Fri, 06 Jul 2018 09:18:37 -0700 (PDT)
Received: from [192.168.0.2] (cpe-70-124-142-160.austin.res.rr.com. [70.124.142.160])
        by smtp.gmail.com with ESMTPSA id e1-v6sm8772576oiy.19.2018.07.06.09.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:18:36 -0700 (PDT)
Subject: [PATCH resend v4] dell_rbu: make firmware payload memory uncachable
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        dvhart@infradead.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <eb0db565-5f8a-ab1e-2bf3-2def3ec3eddc@gmail.com>
Message-ID: <5318cc53-31b4-5c83-abb7-c3ff5d892af2@gmail.com>
Date:   Fri, 6 Jul 2018 11:18:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <eb0db565-5f8a-ab1e-2bf3-2def3ec3eddc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 180706-4, 07/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dell_rbu driver takes firmware update payloads and puts them in memory so
the system BIOS can find them after a reboot.  This sometimes fails (though
rarely), because the memory containing the payload is in the CPU cache but
never gets written back to main memory before the system is rebooted (CPU
cache contents are lost on reboot).

With this patch, the payload memory will be changed to uncachable to ensure
that the payload is actually in main memory before the system is rebooted.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v2 Added include, removed extra parentheses
v3 Corrected formatting and include line
v4 Moved set_memory_uc() outside the while loop so that the memory is
   definitely allocated before it is set to uncachable

This driver has no maintainer.


diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index 2f452f1f7c8a..53f27a6e2d76 100644
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
