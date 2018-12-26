Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BE7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314E0214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 18:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="fo0U+hhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeLZSh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 13:37:26 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:38178 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeLZShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 13:37:25 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 56B3176
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sWOj0mrybHIZ for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 12:37:24 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 288D0239
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:37:24 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id 123so20478394itv.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 10:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RPQseQNPwNQ7VvbUJ24R0rEYhsQQrKhb/1O5ll63oVc=;
        b=fo0U+hhIGalpABVj3V/7JMmfGRFwCWJbfd43HT1Ce95gHt1UnBaUNoCxOiRUGQH4dn
         WYDQIfWq76XMU+7HcV+V8tJGf88iXmWsB1jriQVZOlaukmz4llJrihDKTNA59w0ByVrv
         PGbHM62AEQbNO9LoGWCvwf1W/0ZJOFRrI/1WarmfIbmLbZB1j9fS33HjDyaNglSmoRTE
         Q5R0MyP2D30YgTSjEpGbqXnB1PON5/fGrHuX2XKftPUNyoq0AU6CvfIX+ylHC5qMnZoM
         sGBGcSFWuZjex71Yaph1fOdmy2nMw0/AOtbEAQlISSaRQuXLE273wLUMP8Cxfk4OyiNX
         f4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RPQseQNPwNQ7VvbUJ24R0rEYhsQQrKhb/1O5ll63oVc=;
        b=XsXxnh85VjUtIiYSJaRM7ip2nb/4U+49p7M9rBV3bYbuVx8fpRTR41D8L/dUXKvo5U
         j1eG6yjGsg40odElO7F/xhzhne5+GuFsP5/azuWZHvmSJVErTOSwX3UTSnuao3VXuOUB
         0rC28bBDCyZR0A7N4SgEkA8sS3jhZhV1kPqXj0wAWjYmwxy48k1VcLyJ+rtHyfzPWPaD
         fRa+W6MYO/Y65vHrH9s3x4kY+iiTkL68aIiUFjJSSjKWBgTX7gNd6ReAxmPWyO8sKbWM
         fTZHaUhNz0gVHD3/M084e3Yt5vkWdIlnwktq032Y312FGSwNeciRCK/R5qN/hYLb52TF
         2czQ==
X-Gm-Message-State: AA+aEWaIRPO5E+XiQBbgm5URQ1BRn2yP7OeWyyzUJa62WR+xwkYwSU84
        4dTaoBs6xpAtwT6Q5p9qOAlXTG9w3mxmf3vdGWGHmjZ/c89TwexELLki3MWGroFkBP5eySq2c2a
        xd0MqdMxc0borgxfsRrinhKg1DIIh
X-Received: by 2002:a02:734b:: with SMTP id a11mr12719695jae.62.1545849443722;
        Wed, 26 Dec 2018 10:37:23 -0800 (PST)
X-Google-Smtp-Source: AFSGD/W/suF6Jy0rOEWzsl8pPdXLNxVk3ZUY3DVOdrjZBWHn2aab/5LLp+KZLNhjNY6HBZ4tlE9w8w==
X-Received: by 2002:a02:734b:: with SMTP id a11mr12719685jae.62.1545849443496;
        Wed, 26 Dec 2018 10:37:23 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id v202sm13032846ita.13.2018.12.26.10.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Dec 2018 10:37:22 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: chipidea: add a check for the availability of next child
Date:   Wed, 26 Dec 2018 12:36:43 -0600
Message-Id: <20181226183643.76912-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_next_available_child returns NULL when no child nodes are found.
The fix checks its return value instead of assuming a child is found.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 880009987460..b7f7acef72d4 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -250,6 +250,10 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	ulpi_node = of_get_child_by_name(pdev->dev.of_node, "ulpi");
 	if (ulpi_node) {
 		phy_node = of_get_next_available_child(ulpi_node, NULL);
+		if (!phy_node) {
+			dev_err(&pdev->dev, "no child nodes found\n");
+			return -ENODEV;
+		}
 		ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
 		of_node_put(phy_node);
 	}
-- 
2.17.2 (Apple Git-113)

