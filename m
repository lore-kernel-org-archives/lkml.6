Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39FAC65BD0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670FA2064D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrHfXD8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670FA2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbeJFHAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:00:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35027 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFHAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:00:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so5390290pgb.2;
        Fri, 05 Oct 2018 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zm+SvJc4gLtErAgGRGbdtjMsdDxcCRJ8UY3+KbVruaM=;
        b=QrHfXD8CjKfbj4CbNQwrPBj/07h0OKnkZoPedvjEh/grMXx9FIlKwl7IznGIMlcz7U
         X+fRvjZtp4N18r5ilNe4IMOQm31sBVJ0jK/z+Dt3lgcjZ2lhF21gf84vkSaw7C2ezbAA
         mQ5a4+PHNgxspE/s6wanXLCtffsLvitLJOdyfikh3pYMGSSOGyAlXIf0Lm/FiAX7MHR7
         /mx7/+jE7/Y6ZSBYTMSrl9QR1EKoXpC7Q/iZATfR+nV5ZoG9DavPKA1rcPnJHIHEeXJr
         H+Tb1VNY0DL6OP3GUCHzE/f7C9pM5X6CciiRTNkHuXHD99ciANg5aRaBmpQEaf+gm9aA
         SNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zm+SvJc4gLtErAgGRGbdtjMsdDxcCRJ8UY3+KbVruaM=;
        b=mODrS68JIKc8IA1zaePt1ZfP2b9QdjBVYHBZlPAwgqqwMtD/paV8kbY7r+ePQVP8jP
         7LSbibcABfpvIihOjaxyt9zyL5WDP7ohwl0uB0/YgP2bZj3WkvhHDDXPtlYYp5MdvkTH
         56yOLxSCoAcX7NF7+ITVWILYNyqbPsCSDhsKWyqsYLz6QzHcB6ixJ82Rf16Y+CSHuflK
         Eb7hRf7neGbJ7CTAN6ItQwr0DGxpzgYvS1d3ZX4n7+7/pmvryPKcxBvOwSEbIh4rEOvO
         55YvbxzyVe+3MMtKrhnf96fKYcwWNimoZIK+0+PT2HhQhR61crIFzSNRVAP/Fjf+OKhP
         LC/A==
X-Gm-Message-State: ABuFfohADNBX04BIUvEe5NIGYe7kotOYFmqSWmbBJfTdjEFnm6s7lSws
        K0ZI0fWWF6QOQvbCVk9PbQ4=
X-Google-Smtp-Source: ACcGV61/HGuMlBp7mTCVKfhkz06mPdUK2hUiSRr8Pa8MRrdIelC4BASuzn0AIxNMRehKObfZLuwUsQ==
X-Received: by 2002:a62:dd01:: with SMTP id w1-v6mr14054269pff.129.1538783954710;
        Fri, 05 Oct 2018 16:59:14 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x24-v6sm12137181pfh.67.2018.10.05.16.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 16:59:14 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (core) Add hwmon_in_enable attribute
Date:   Fri,  5 Oct 2018 16:59:04 -0700
Message-Id: <20181005235905.29403-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005235905.29403-1-nicoleotsuka@gmail.com>
References: <20181005235905.29403-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to hwmon ABI, in%d_enable is a sysfs interface that
allows user space to enable and disable the input sensor. So
this patch just simply adds the attribute to the list.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/hwmon.c | 1 +
 include/linux/hwmon.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 33d51281272b..ac1cdf88840f 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -356,6 +356,7 @@ static const char * const hwmon_in_attr_templates[] = {
 	[hwmon_in_max_alarm] = "in%d_max_alarm",
 	[hwmon_in_lcrit_alarm] = "in%d_lcrit_alarm",
 	[hwmon_in_crit_alarm] = "in%d_crit_alarm",
+	[hwmon_in_enable] = "in%d_enable",
 };
 
 static const char * const hwmon_curr_attr_templates[] = {
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 9493d4a388db..99e0c1b0b5fb 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -118,6 +118,7 @@ enum hwmon_in_attributes {
 	hwmon_in_max_alarm,
 	hwmon_in_lcrit_alarm,
 	hwmon_in_crit_alarm,
+	hwmon_in_enable,
 };
 
 #define HWMON_I_INPUT		BIT(hwmon_in_input)
@@ -135,6 +136,7 @@ enum hwmon_in_attributes {
 #define HWMON_I_MAX_ALARM	BIT(hwmon_in_max_alarm)
 #define HWMON_I_LCRIT_ALARM	BIT(hwmon_in_lcrit_alarm)
 #define HWMON_I_CRIT_ALARM	BIT(hwmon_in_crit_alarm)
+#define HWMON_I_ENABLE		BIT(hwmon_in_enable)
 
 enum hwmon_curr_attributes {
 	hwmon_curr_input,
-- 
2.17.1

