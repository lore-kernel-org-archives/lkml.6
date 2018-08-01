Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5EDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D65F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St+SRIWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D65F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbeHBBKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:10:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45414 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHBBKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:10:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so141407pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 16:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=4t2T8LeEMUOdj6LCpH9g0l+vBl3lfGEwJz3iSuGgrOM=;
        b=St+SRIWIyDb7dck3pMR/i3+JnSUYXwzBEXt3lmckPQQAVsJ2fPCIvJeQtMzEWVPLr3
         nJdlJlXRysxkWsaxubUI4WHvUAO4Vifp1L8nY57lHLYhee8RYe+sEzhKcXeEp5gEShgC
         AXk5kA9lm2E2llq3yy2QA2LJV9osCWEaphgfHfC6SmThIIGQ/muOaLgx2olpswhK0VFN
         bQA1FSZi2UdEOek9b55Vf8zKK9Uxhtj1RpQCU/Mb4caPA+dj3Q1Io3kk5r7/qZkxHUJJ
         ccUb1Wd3ErNlOstSlb4RB9fV15Xd6uz2yiOLHGOaCGjmCFF0Q5G6oGuqG9GvS8KRcYXO
         QVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4t2T8LeEMUOdj6LCpH9g0l+vBl3lfGEwJz3iSuGgrOM=;
        b=JTmiwhoD3eNNhT8e6SMRkEPtE1ZRyBQ/NXr2A7YH5uTI3YrO45Wbq/reqTs1Z/oZ2X
         RX16/vSjHyJj8J+EBe2lEPIgfjr5SFzaZpfu3I5VIKjRmZA8BW9KDqCS0FbmBkBxfgmt
         msqiqbv3UOHJtH3E4YfNvctbYGOevpOJi3P6ObTX2I0Xvujb0LvlLIx3ytNOWMjZF9kl
         WyYbI1narKwvI4E4rwrkaUYMqU/q8Xt18bLJul4Zm0odBUiAM2Mp+3wLuFdozI/mGQkW
         y+T8tlfudaRwUyPrFdrEyhkOqignkfWVQeZIpxFXg8TKxIx+wiXRhD+mpmEgC3hVKbvl
         AALg==
X-Gm-Message-State: AOUpUlFLxSp9x5VEABoLZeKxhRjQQuzG61Nt1OZQZi3jP0C9cFaalKnN
        VmaKDrmlxQ7Tof+54fJGyNM=
X-Google-Smtp-Source: AAOMgpcKgWWv0Y2qIxSmnuR5saqZOZ0uTI2GFgYPlc/v7mRpwkgKqDLow9vF6ZAWUMzALz8hkyFuWQ==
X-Received: by 2002:a65:4304:: with SMTP id j4-v6mr340160pgq.109.1533165761310;
        Wed, 01 Aug 2018 16:22:41 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.207])
        by smtp.gmail.com with ESMTPSA id p17-v6sm138211pgv.26.2018.08.01.16.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 16:22:40 -0700 (PDT)
From:   mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH char-misc 1/1] Drivers: hv: vmbus: Cleanup synic memory free path
Date:   Wed,  1 Aug 2018 15:45:13 -0700
Message-Id: <1533163513-10764-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

clk_evt memory is not being freed when the synic is shutdown
or when there is an allocation error.  Add the appropriate
kfree() call, along with a comment to clarify how the memory
gets freed after an allocation error.  Make the free path
consistent by removing checks for NULL since kfree() and
free_page() already do the check.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/hv/hv.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 8d4fe0e..1fb9a6b 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -240,6 +240,10 @@ int hv_synic_alloc(void)
 
 	return 0;
 err:
+	/*
+	 * Any memory allocations that succeeded will be freed when
+	 * the caller cleans up by calling hv_synic_free()
+	 */
 	return -ENOMEM;
 }
 
@@ -252,12 +256,10 @@ void hv_synic_free(void)
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
-		if (hv_cpu->synic_event_page)
-			free_page((unsigned long)hv_cpu->synic_event_page);
-		if (hv_cpu->synic_message_page)
-			free_page((unsigned long)hv_cpu->synic_message_page);
-		if (hv_cpu->post_msg_page)
-			free_page((unsigned long)hv_cpu->post_msg_page);
+		kfree(hv_cpu->clk_evt);
+		free_page((unsigned long)hv_cpu->synic_event_page);
+		free_page((unsigned long)hv_cpu->synic_message_page);
+		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
-- 
1.8.3.1

