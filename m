Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38ADC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B3A2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk4L4uCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfAHDLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:11:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38335 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfAHDLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:11:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so2792061ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 19:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sGZK5k3+us1fsD2MJBky8yVgRarUBxYg3xvOC2DjMcw=;
        b=jk4L4uCCMugxV7KKFGnDO+g8gI6TxRUPRGCCM61IxytOksHrPiV76B7NnfAudsplEB
         N4huuCEWt09uYINpw+MPg0hGzsE9E3TUmr8ywolb1vCMUWdJrZ4ijJRf6+fC7gSklAjD
         txKbT0lREV7zZoGhJ98g2WuI8ukO34cHVsZA6JU64+7ODsdvsyXH65gDOJgyHpFGeUYe
         dR513Skqay7NUi6lxoIwIKGx8bJbP4wrKr+3H6uUUYm7MCSxxRcj704Is3lBwUBiYKYB
         wPsmm5nQ73JTcwEGS0hQsLgRqXrMDkQszcH/7OBEZpujcXW9YNzurs4LVA4mcLY9L7Qv
         5DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sGZK5k3+us1fsD2MJBky8yVgRarUBxYg3xvOC2DjMcw=;
        b=hJmrk0q2dTA5adzULWujmwdguC1syPCov8+7CPIYoFgPXlhbOpDZSWMDyPFUSDRMVi
         2tkmcRRnA3D6eTa6rMuZsByeBU7f35qSpB6qGN4979AsSKbFTOXTcTB/ih3GeizqMtDk
         HHXcXpMbRzseZh1BDBpeoPN7WSygdUcJ6CzMV6wwx3MxZ+hAcTyz+E0D7Gr6ZKc+UuAc
         d5kaHvZWVmn2nypj6FkhRhn5EP+ErulQvOU55VFB9IJBWXICLb0lFAcJDc2mGH6aOxIn
         D3tTdzZ5destsDRW3CuoLXMTFwypT7M5bLz5DmFK3hwhPxu7pHF+bG+bXaTZUK3dXkB/
         izhg==
X-Gm-Message-State: AJcUukdgODIcXLRXyMGkYAcvNvlV6vilsMOlc7cns6JUzd3JtKhsDKV9
        4bBkcZNwSr4mMA1yZ/d51OI=
X-Google-Smtp-Source: ALg8bN5Owb0uiyk8LF3ypZixAjQiJZcBnSIdXGSt/JvXX8sFyv2Q9sGvl1tBfOdJp/NHDvJO0zMr6A==
X-Received: by 2002:a17:906:6c14:: with SMTP id j20-v6mr309750ejr.41.1546917065804;
        Mon, 07 Jan 2019 19:11:05 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id s3sm30036635edm.31.2019.01.07.19.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:11:05 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH v4 1/2] kobject: use pr_warn to replace printk
Date:   Mon,  7 Jan 2019 22:10:58 -0500
Message-Id: <8c73ad4b2b29bda53f2dfb6624b8b7984b52e307.1546915794.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1546915794.git.tsu.yubo@gmail.com>
References: <cover.1546915794.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix to replace printk with pr_warn

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 lib/kobject_uevent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 27c6118afd1c..499dfcdafcb0 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 out:
 	if (r) {
 		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		printk(KERN_WARNING "synth uevent: %s: %s",
+		pr_warn("synth uevent: %s: %s",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
-- 
2.11.0

