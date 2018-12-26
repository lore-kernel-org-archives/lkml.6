Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF17C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3357214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="PLt2ZUZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLZCwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:52:01 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:35086 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeLZCwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:52:01 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 8C182B71
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id muRY2rb-gpMH for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:51:59 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 5E4C6A30
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:51:59 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id c128so18647530itc.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LTAUb8ZlXXSBaT+frIJV5q+/AHl16R33kedMarZQU4I=;
        b=PLt2ZUZdkxNjZlaBI3Jfhl0SL4RJOm7xzbmHMzQqOqYtipujq7OGR90+DgkGupNxgF
         enMiNl/msJ20QD8a7Mr/AyVJNUK6GPmhuTywsp/wULYuz9EHXY8tpZRyLvOIMf1yHqv1
         zu6Uo1+XNu/Khv7FgUt5qRxyNjXK8/rjUJQvmwX1r/+wcBzxjjfPeod41s9p+3+fI6h8
         CJv4OjoxGlLLX4MmMthrR3G010ZUsbtnbCdBIYqfY9WboyfxoKYI3tSyUhZ+5yarLvMA
         qTA61In9YVHLRlo3cXfKEyClnG5hezOFen0LislBKz90QN7NYeHKt5jTevTiTZcsa9Rs
         LgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LTAUb8ZlXXSBaT+frIJV5q+/AHl16R33kedMarZQU4I=;
        b=Rg4Zp14DYpNffovzPTDXvjWVQtPesz8w20YKMUmtX8DzaIpOZgha+/nQQrmCz+JZdp
         I+6OG5qF+CHWh2T3hItecV8F5OZuAR/A+Yrd+z92JuFmDHE9uj2f9VExyKWD7qw3pXiH
         ChbBdo8x3m7nNzX2/1JrAZz3LT84ZBTyqr3rwQh70O8NzyPALuY2CfgvMc4Y10O1qJ+l
         0houoW52/l92GRXa/DK6xGPtt27k08blq6Jux+Cfj4oiEHMRP5FyEsuNwQC9qD0lCyKY
         Bhh2UO0Nqwp+AzwVCwh+8ZtUluV+yUBNS/dKgxup6Ij69VNvzXM3A+U1Mtq2P/vRNlIO
         yHbw==
X-Gm-Message-State: AA+aEWbIESuMT4QyIkHy3WeahvhIpepBcGpJgl3tpYtuFrLgz3WutET3
        /5or8N998ihfCSJ5BsySgFSA6/0SOKJ61ls8O4kGRd/IaiC8Z8FML+gQ9snGKbbBr0IFy0wY7dA
        ZHndrx86W63HBd4Whn+1Ja8PFa59B
X-Received: by 2002:a24:fdc4:: with SMTP id m187mr11103497ith.75.1545792719012;
        Tue, 25 Dec 2018 18:51:59 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4VpF6Qem+klUnZw2fPdmCta8XEsjfCYRjsCC5L1cxGGSJW9HhwcDjGPHMYBGpOG1WyS1oTlg==
X-Received: by 2002:a24:fdc4:: with SMTP id m187mr11103489ith.75.1545792718775;
        Tue, 25 Dec 2018 18:51:58 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id k4sm14951990ion.61.2018.12.25.18.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:51:58 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: fix a missing check of clk_prepare
Date:   Tue, 25 Dec 2018 20:51:31 -0600
Message-Id: <20181226025132.72399-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_prepare() could fail, so let's check its status, and if it fails,
issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/clocksource/sh_cmt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 55d3e03f2cd4..60a70832cfa9 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -764,7 +764,10 @@ static void sh_cmt_clock_event_resume(struct clock_event_device *ced)
 {
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
 
-	clk_prepare(ch->cmt->clk);
+	if (clk_prepare(ch->cmt->clk))
+		dev_err(&ch->cmt->pdev->dev, "ch%u: failed to prepare clk\n",
+			ch->index);
+
 	pm_genpd_syscore_poweron(&ch->cmt->pdev->dev);
 }
 
-- 
2.17.2 (Apple Git-113)

