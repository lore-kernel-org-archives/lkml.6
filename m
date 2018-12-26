Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC08C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A353B2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MUF/wEuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLZDcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:32:11 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:55730 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeLZDcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:32:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B05B89BB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RFyGRToSHCvm for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:32:09 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 833A8643
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:32:09 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id x2so17886445ioa.23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DjDT9bGjjAJ7pRB5k0HMVHTe9WqGZCaiEpkS/aDlJiM=;
        b=MUF/wEuAGpFlom/7Qo3HBytvBIt/Z22uy/OnNKvVPxNGESZVVTVc2bOG9aF4FNry38
         lLO3ayBHENq1UeyX9fhnZWC7BjnYLAspmcg+XJIzODoGJSJ6xblaszkql7/so0gEK45k
         tgXDDU/ebDbg3kCBmfJMmINl4o0UMMiTDImRc9VAxENHtP9fBycLcI7rKROp0t96coi1
         n2KSIIkWgPiTuxLG5VMd8FyY9YXCH8zS2ObQ8XekQwxOQ8MG9971WzIkaA/GuITecaSl
         TI9zct61QcGXLwYUZjjL8ihW42SIuuHCsN3oGLdMHWQ75i9njXEiopZ9TDzkpw+HW+Xf
         5Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DjDT9bGjjAJ7pRB5k0HMVHTe9WqGZCaiEpkS/aDlJiM=;
        b=R+MjU+RYxDqPoYYYYtj8TUjkqU72FKmgW6VMwnRvaDHCzy6/aUSuBkoHbhVsqiFyQX
         yODXyojpTQTSwhdX1QmU7PGvk6OsA9QUfJQcXmyrAe8uOTt/EHYRzmMa3Ns6/3Bpdga3
         hBFJmgxrxbb/Pt98tGo4/5/0cMmwjBwFv+17ipWOvsYn+MarYckifFhgU4C/Q/PaBvtd
         dHT5mtkcSzkVH/pbtppL7JVjuFA9/f9yiztTY0jcK/l0MXzuS9t20mbr3vFuR/YNSSrT
         ds0UotKrp61Io35pbDQUgYEh6jVZtBECJdmudOc7EhIQMiVfQfoV87q5vNXG4W5mDJ78
         SQpA==
X-Gm-Message-State: AJcUukdGmhfkCVhIc5iCKTv7biBXrgi4JBXzAV/2gsRnVsnTqABklo1W
        6ZK9LA6p7DAEzAZazWPEyD+BDjQhbBhRscvw1FG4TYKHbL8KJxo1k8ci5/gWSacepm/WqhDjLbD
        3mbCvdHTff/fj9lDvVCA580dOruPn
X-Received: by 2002:a24:67c6:: with SMTP id u189mr11861969itc.106.1545795128919;
        Tue, 25 Dec 2018 19:32:08 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UwbKFy+iuV16PkbogYYY53fEPhyM8xAJ03j6ppcg/yV8BUSigfvdnhylQqB//mCPthsbOJ9A==
X-Received: by 2002:a24:67c6:: with SMTP id u189mr11861963itc.106.1545795128706;
        Tue, 25 Dec 2018 19:32:08 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id f21sm11948655itc.14.2018.12.25.19.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:32:07 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: line6: fix a missing check of snd_card_register
Date:   Tue, 25 Dec 2018 21:31:40 -0600
Message-Id: <20181226033142.73180-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_card_register() may fail, so let's check its status and issue an
error message if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/usb/line6/variax.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index e8c852b2ce35..b0caa9ea1f5f 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -167,7 +167,8 @@ static void variax_startup6(struct work_struct *work)
 	CHECK_STARTUP_PROGRESS(variax->startup_progress, VARIAX_STARTUP_SETUP);
 
 	/* ALSA audio interface: */
-	snd_card_register(variax->line6.card);
+	if (snd_card_register(variax->line6.card))
+		dev_err(variax->line6.ifcdev, "Failed to register variax card.\n");
 }
 
 /*
-- 
2.17.2 (Apple Git-113)

