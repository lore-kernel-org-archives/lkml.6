Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C068C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2532C20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNTRuqhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfAJGN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:13:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44143 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfAJGN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:13:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so4735565plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 22:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OS3d67xknKUkrjT6zLxCzD6QQek0gwr/GJh8u/NiTvw=;
        b=HNTRuqhPzLVJYtVTfftJQUld9V/LSLDSQaGxlbhKbADdZi6YcVB/xt9RWLcgRIi/Qr
         CiMlHzH1dz+HyG1peyIW2WRprTVTwHU121pqLU8bB9N4BTg4OFsE8NJC248X2e8l8IJ2
         l+RwnrLaRtW2ZHjzmfH00WkU1Z+e3zqjGxS5pVdlboTG44NYT+1jXDF2cfyeJi14i9aM
         +S15pyDWXXEECWQ6HdNM6LdcAyCyK/dWxcSJKw6gEhYDC84kiBhMzEgyAzpShBSOjJ8S
         ToBEt/j0cl2eceUKLwEWmvO5RfQh5Cry/SC4CDxqMV2QXOaWmIZ4XOCUyX6VL7mFPT0x
         TJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OS3d67xknKUkrjT6zLxCzD6QQek0gwr/GJh8u/NiTvw=;
        b=FSX0L8Rp7NHsckNfQiqjtl2wltSFlnpiyTN1m3z4xQku4ZIF0ke6wzDaeHXjToCT9w
         cL0HJxWjX+VTgNq7RLyeBjdkr9HdiaFHOTFW4MIConP7H8xJn8aFVJrWXufZ68/xlteT
         +0dXBwlVxBG8ifXzh+i3cYwZl4VFKSUKjtSjhXCGhpZvcyVumRTeXGOX8Go8fXv7eX7P
         yEaiqju1UzUO65msVgxNudXcI1RWSmx9IPDRGowPTtW/HwH44MSxltITS7hrrFgKlNon
         fmei54j0DI5o5tMhjGNCMzq93iTTeSZujzPiKJm52PPhvpTlgMefteBM/yx6sKi+YVyH
         W7xg==
X-Gm-Message-State: AJcUukfgEhCubOhKsKxdKgdM5oFQnc4Q6lXfyzvV/QmQ36yZwfGPYeBT
        hStiNQgTi4to2wTPe7kAhhs=
X-Google-Smtp-Source: ALg8bN7NRuhQI4fc6qXkNTQsbRNwi7KA3tkyyWFVcrlkt7zQIDlALG31u7/hI6NIP4cO0PMwCtE37Q==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr8860344plo.59.1547100837375;
        Wed, 09 Jan 2019 22:13:57 -0800 (PST)
Received: from localhost.localdomain ([220.94.163.22])
        by smtp.gmail.com with ESMTPSA id r130sm131481686pfr.48.2019.01.09.22.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 22:13:56 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sidong Yang <realwakka@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vboxvideo: vbox_main: Remove unnecessary local variable
Date:   Thu, 10 Jan 2019 06:13:47 +0000
Message-Id: <20190110061347.31326-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed unnecessary local variable in have_hgsmi_mode_hints.
The result of hgsmi_query_conf should be directly compared without
assigning to local variable.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/vboxvideo/vbox_main.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
index e1fb70a42d32..62a69fde7435 100644
--- a/drivers/staging/vboxvideo/vbox_main.c
+++ b/drivers/staging/vboxvideo/vbox_main.c
@@ -170,18 +170,15 @@ static void vbox_accel_fini(struct vbox_private *vbox)
 static bool have_hgsmi_mode_hints(struct vbox_private *vbox)
 {
 	u32 have_hints, have_cursor;
-	int ret;
 
-	ret = hgsmi_query_conf(vbox->guest_pool,
-			       VBOX_VBVA_CONF32_MODE_HINT_REPORTING,
-			       &have_hints);
-	if (ret)
+	if (hgsmi_query_conf(vbox->guest_pool,
+			     VBOX_VBVA_CONF32_MODE_HINT_REPORTING,
+			     &have_hints))
 		return false;
 
-	ret = hgsmi_query_conf(vbox->guest_pool,
-			       VBOX_VBVA_CONF32_GUEST_CURSOR_REPORTING,
-			       &have_cursor);
-	if (ret)
+	if (hgsmi_query_conf(vbox->guest_pool,
+			     VBOX_VBVA_CONF32_GUEST_CURSOR_REPORTING,
+			     &have_cursor))
 		return false;
 
 	return have_hints == VINF_SUCCESS && have_cursor == VINF_SUCCESS;
-- 
2.17.1

