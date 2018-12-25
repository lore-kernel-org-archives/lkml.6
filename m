Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84007C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B802173C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Pajcvthm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbeLYIZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 03:25:20 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40622 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeLYIZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 03:25:20 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 228B4B50
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 08:25:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9lR-KPQT68Cs for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 02:25:19 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id E3293B1D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 02:25:18 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id h7so16044220iof.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 00:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6qNZfrc4EKMKaFzzyYba8gTwStzHjGtP7ctPBGn2W3M=;
        b=PajcvthmPcm4pEZAVZRo5mfmSz6/1HGHKEXOvDYt614P0XUArtZ40+lrVjiPH+1dPE
         PmT+dvDczIeFPjIIxLF1+g4sX01gvK9I+5P0RTQ4qDufjpoYharhPzP3vJqjmUqqi+GW
         /K4kJ705LPII+MKS2NFrMZj9OB6gRNX5W7c7uurT1aJbdlVCe9G18u0m5l8e696Ni3NH
         XqGNiIFaV8YjAeJZ6ozm9qDqwSoFsxs9dSxqV2gc6bHB/kQQANh6s2/BtGbnj1WXfco6
         leVTR3SVacNtHcmrTZj/Yc8kgz8CsviZ84mXYMN6hfkDA+RZiIWOQGSXSftzqz4KB5m/
         7MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6qNZfrc4EKMKaFzzyYba8gTwStzHjGtP7ctPBGn2W3M=;
        b=eG3Pkkp0vkmt3sIOubujNp8OPvMqxbxx5lHwuY9TrKzjcLEti6xADgxIOOxp3J8WmB
         cXUHXxkPAf0UrM5wxKrauEgEJ8cVAQbdW0iB7AAZQNvCpDQ8GKQz/CRURAxrwMkmQ5Ti
         8lKDpND30vgabghMMuTAnko4ePFcpRMZijyoCcFgrKqAiZN0Ua/v7zEfI0UtSSJoYmGV
         UA4x8mAMZLn/xZkRqq/ZCETNbaJ8uGfFWWdbVyJUN8gqJNzu/FViRmk4cYFwD+N1nge/
         YWGd/WXYFIq/EYPN8FYJgY8t3DqFI8avAppGo/yx7PhugV+ukK10sXTaffF4hlTWUM0W
         zo4A==
X-Gm-Message-State: AA+aEWbhJzGeFAWa5CUQTZW952vVzDzFMSi3d4jH17o711gRFXuX6RKW
        YC3p+hzMdMxmTMl3CvAGOlMDkFKsIeRSCXIkQMQUb+w5ifpH0igQ7EUj5Flzp5snTsiSkpC4c2m
        pxd0U8nYBfZ/LUmgzBxEBSP4BCn9x
X-Received: by 2002:a24:630b:: with SMTP id j11mr10057836itc.28.1545726318562;
        Tue, 25 Dec 2018 00:25:18 -0800 (PST)
X-Google-Smtp-Source: AFSGD/V0yob2b2qAn86m8ta3ftp6aGAaVEm1GSF3ZrmZ9XHAm6vsLYgMhBlkm1rOikSYf81lZO0bWg==
X-Received: by 2002:a24:630b:: with SMTP id j11mr10057829itc.28.1545726318327;
        Tue, 25 Dec 2018 00:25:18 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 137sm12255794itm.21.2018.12.25.00.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 00:25:17 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gspca: add a missed check for goto_low_power
Date:   Tue, 25 Dec 2018 02:24:41 -0600
Message-Id: <20181225082443.68379-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix checks if goto_low_power() fails, and if so, issues an error
message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/media/usb/gspca/cpia1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index 23fbda56fc91..7c817a4a93c4 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -1434,6 +1434,7 @@ static int sd_config(struct gspca_dev *gspca_dev,
 {
 	struct sd *sd = (struct sd *) gspca_dev;
 	struct cam *cam;
+	int ret;
 
 	sd->mainsFreq = FREQ_DEF == V4L2_CID_POWER_LINE_FREQUENCY_60HZ;
 	reset_camera_params(gspca_dev);
@@ -1445,7 +1446,10 @@ static int sd_config(struct gspca_dev *gspca_dev,
 	cam->cam_mode = mode;
 	cam->nmodes = ARRAY_SIZE(mode);
 
-	goto_low_power(gspca_dev);
+	ret = goto_low_power(gspca_dev);
+	if (ret)
+		gspca_err(gspca_dev, "Cannot go to low power mode: %d\n",
+			  ret);
 	/* Check the firmware version. */
 	sd->params.version.firmwareVersion = 0;
 	get_version_information(gspca_dev);
-- 
2.17.2 (Apple Git-113)

