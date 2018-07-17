Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D175CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D66A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8YBTyRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D66A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbeGQVj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39679 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so967422pgs.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sFOYZchG5aNHLXLp146UdEXMW7F8alJ8AxLF3XjI9+4=;
        b=O8YBTyRvFkgWwuZ5ROIKo9gNMUi9Zq4Wh/GG39NflTt5FsxkSZZf8MKKLEwkvUjaCj
         J86Sv9jwzSuAsxRkZrseNa7x8iG6PHicZvns/PUnetCcpr02iHVzvDkmy8cedwK6vDw2
         EJX91L6Y3j0KSKXvCxl9panbKNkAfz080E48hqTqN5hO7erO9HsAhGTVUPTZFC3CMTnD
         +zxyQGbLibfSrt1DzA9c1pmyGNcl9DGxmDNcub7swrfI5gi2gcrToCLOTMSSiEI5/Oz0
         kjbxEFOH47bVYMeocCDJcokqaas2N0p1+E6VVSJUUmWI9NflItHoMeZj3z3oILfXjQRF
         KD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sFOYZchG5aNHLXLp146UdEXMW7F8alJ8AxLF3XjI9+4=;
        b=KF+xyGBQcuQN79YV4GDe79hYtLMzbBQz+AUvjCqowRYdvC86MaOebrieDfN8WlTlW4
         kqxpVA+CAMeQQtgFOi46tLeXCzvZa7K/jCdki3rj/2eAHx9V9DmqPi4MJm27CxkomUz/
         6mGpc9X3lAfEkEqF0lUra1JdNJ+596ak4cB2Ey61LgTcWbv0W9NuWOOkxCt8JIO4RGpG
         X8blHyYfO0GbYe/noAMpbdUMcc0Uc0O8nrt8Z5G85JrQh/E7E9q9TzYjtoVQHOTlPlqq
         TGSeCIcUgD3k0Cz3yJXGPmctuzy71H9BxUtTCrz+dXn/g3CgOqXnAX6h1rw9JEjy8l5V
         NpSQ==
X-Gm-Message-State: AOUpUlE6UQMAeejZeT0p0yiTYBvobaM5q35hpZwvgX+uOZLRT4apa68c
        A1oiA9LOfq3yJ+LLZQASnVY=
X-Google-Smtp-Source: AAOMgpc4EbaCVw3Dr4bW0He8/2+9bkjATP3JRTKd5FHyMAo5UOWtWwkdaDS0P7/ZbDwi0gs5uCWsBQ==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr3172272pgc.119.1531861495994;
        Tue, 17 Jul 2018 14:04:55 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:55 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 09/32] staging: gasket: convert gasket_mmap_has_permissions to bool return
Date:   Tue, 17 Jul 2018 13:56:49 -0700
Message-Id: <20180717205712.29495-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_mmap_has_permissions() should return a boolean value.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2ff328652356a..248d717e1df65 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1241,19 +1241,19 @@ static int gasket_release(struct inode *inode, struct file *file)
  * that the provided descriptor/range is of adequate size to hold the range to
  * be mapped.
  */
-static int gasket_mmap_has_permissions(
+static bool gasket_mmap_has_permissions(
 	struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
 	int bar_permissions)
 {
 	int requested_permissions;
 	/* Always allow sysadmin to access. */
 	if (capable(CAP_SYS_ADMIN))
-		return 1;
+		return true;
 
 	/* Never allow non-sysadmins to access to a dead device. */
 	if (gasket_dev->status != GASKET_STATUS_ALIVE) {
 		gasket_log_info(gasket_dev, "Device is dead.");
-		return 0;
+		return false;
 	}
 
 	/* Make sure that no wrong flags are set. */
@@ -1265,7 +1265,7 @@ static int gasket_mmap_has_permissions(
 			"Attempting to map a region with requested permissions "
 			"0x%x, but region has permissions 0x%x.",
 			requested_permissions, bar_permissions);
-		return 0;
+		return false;
 	}
 
 	/* Do not allow a non-owner to write. */
@@ -1275,10 +1275,10 @@ static int gasket_mmap_has_permissions(
 			gasket_dev,
 			"Attempting to mmap a region for write without owning "
 			"device.");
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /*
-- 
2.18.0.203.gfac676dfb9-goog

