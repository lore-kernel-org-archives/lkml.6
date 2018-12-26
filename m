Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E49C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B57A214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 02:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="SvnhZm//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeLZCr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 21:47:29 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:39054 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeLZCr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 21:47:29 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 22838B16
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 02:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oB6L-0kQw_49 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 20:47:28 -0600 (CST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id E26545B1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:47:27 -0600 (CST)
Received: by mail-io1-f69.google.com with SMTP id s25so18139355ioc.14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4IP7lEE3jqbS6+6LgrTbIq2jOhRJhlrWOnkpcEf44QU=;
        b=SvnhZm//n5Vy0wyYBArKfKgfq7P4/poAbgpE1StCxegmWHWXr20OTjOfVC87oDlDyp
         QbBdWUbbNlj88bfFZo0D0WDzoCBYJKixEjSIH/XkESkGwFZUi7UAXZEvCxtu0xRpphI9
         iRwCbX6CyWsiHAqqVH1/2+RByeEUrY/5TUxERtxt5ZBz3cuTn8ie7BPmjc6dXN1va/jg
         tdwqOvQ5yv2YsQj+GnbylNSTVZlmNWZ9TAQjo2sfcMZfbE+v2p96ejgbwVBZuULoKh1k
         n+qOaLzhIJoFUx8ZJXm3OCFn1dnA6GaN6llKRz20F4HpZ90VR8e2VJe+Od2b9BHvr7Qa
         +aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4IP7lEE3jqbS6+6LgrTbIq2jOhRJhlrWOnkpcEf44QU=;
        b=ObPuWYabjLpIUEh9dRlcTCwpkseKsCVOygzdXZPk62qMzyN6AZHCVmwgybAuNXq5C/
         OUHUDCxO3mVzkyTOVprZqQ3lW5v9w96j115prkzzWwUK3iKNyQzJ9CI5S1E5oiLoj/oH
         N16HaJGn2S0M7tRWLgoupf2o8OsWQFPy2xz7IqY/loN6LOgLCxu0pAPdI7f0RJbTGlmV
         qdyC5LoaDHX6ICW8bLE06ZtTT5I8wvrJwsLbZrOxrM2hqqYXRFrOy8eYnKkCQRKx2tJm
         f2VaXg4S79uDFVAN/SknV6qvjjFFCqQ9mA+qXE8cy9vglDRSwWZWnxFV7bivvAbYs7yJ
         OcaQ==
X-Gm-Message-State: AA+aEWYzUiDsmNPHoSEAv9wTVYNUWxtW4cSt2vA6jzqkwfPKyDOvjAwY
        7+ZUkr3DW/wJRgtBGGJ7yAOwGxMRwNnIB/H1m06/U4360It6WzVQ5vD42jTIcFFJHYt7GIRwurx
        CmkzwXDhLS46uChlVWdLjMgaXaJ+p
X-Received: by 2002:a24:ed4f:: with SMTP id r76mr10986081ith.17.1545792447514;
        Tue, 25 Dec 2018 18:47:27 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UDIZCvKg4ThvdOJzmEXAQUfMZuXYESRSteaCR/98l+qLqS6TNCuf12xDpk7uPaN0qROmOiZQ==
X-Received: by 2002:a24:ed4f:: with SMTP id r76mr10986076ith.17.1545792447290;
        Tue, 25 Dec 2018 18:47:27 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id n4sm3086509iog.36.2018.12.25.18.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 18:47:26 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] base: fix a missing check of clk_prepare
Date:   Tue, 25 Dec 2018 20:47:00 -0600
Message-Id: <20181226024700.72318-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_prepare() could fail, so let's check its status, and if it fails,
issue an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/base/power/clock_ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 5a42ae4078c2..cb6144fb24e2 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 	if (IS_ERR(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
 	} else {
-		clk_prepare(ce->clk);
+		if (clk_prepare(ce->clk))
+			dev_err(dev, "clk_prepare failed.\n");
+
 		ce->status = PCE_STATUS_ACQUIRED;
 		dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
 			ce->clk, ce->con_id);
-- 
2.17.2 (Apple Git-113)

