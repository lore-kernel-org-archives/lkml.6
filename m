Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C73C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC8020841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0JVvnqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC8020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeIAMX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:23:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35863 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeIAMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:23:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so6450011pgo.3;
        Sat, 01 Sep 2018 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yc+htbF4R6nRAyGSXNiAP4+3KXevwqppPAqtSDiglT0=;
        b=c0JVvnqB0wt21GivQD6Te6IHx9e80knXcCfHMeLHGW7+PRge4j5+4hVrFMwU093yc8
         12AUdqsspDWUuLQsXo+u5v/E2NeDrtRx9F4BuVWH69bY1Sw7HPTnUFQ35bkCSd2d6LyQ
         R2g6cTWa44BybYxx4oPx72U6BDdIBW6N8NytFL8GBZc+OowKJCfN6QAJURHsLPDEDdan
         hDwRWCzh+UGKGvW4dJYAAA9aGjVF5U7PnThdA6hxeCpA8vS0cliynOERtvZFTTaHoR01
         3mEOWDawn+CX+u0deBgYzb9xilXmPLecfog0UaGJPIlSlWo7OPHNX8dyWMWMqdYgqRwO
         E3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yc+htbF4R6nRAyGSXNiAP4+3KXevwqppPAqtSDiglT0=;
        b=htmdt2pXFlNP4J/0qDfWG5s16bztoT1eZQPJ3OJNOGEUtLULp64lo/32a0c5vIEic4
         rquMRYRcI+BRd+LjNZflaZQsa1bObmZX4De331sV+FANVXdn/Bzd/rgVHYirBt6oL6zp
         EcjqKecYY4rJeEM8UDhnnPNJaMMgNa+TepXeHFmz/dvzMpk8ddv18VlzOaUdoC89EHcX
         X5yXX+on1G/WuFydb5Ojib8yfv1B1MdayAt9vwi9t2320XCoisjaB3hkcG9r9tf64JRe
         ZOrJB4b4ngmZLsU7GZ9g/5xjcw6SIIdgTRNN7IRoNXF5Rlq3JqneE/nrhm2WCIqaomDD
         2p7A==
X-Gm-Message-State: APzg51DPVjpV+A14Zk2RqcZQTZ5sHrytXMwyX0Xr+VPnfb2vK41GMWxW
        TPBu7P5buFf7d7tQ7dXRHbg=
X-Google-Smtp-Source: ANB0VdY8FcLaYs42LWm4orLOUUr/gG3K0CqmDg8L+azafGgs7NICRf5L+gdHO14lERkN2qXH1TNrPg==
X-Received: by 2002:a62:6bc5:: with SMTP id g188-v6mr15768159pfc.91.1535789540584;
        Sat, 01 Sep 2018 01:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4130:91db:5d72:621b])
        by smtp.gmail.com with ESMTPSA id d9-v6sm34347562pfb.86.2018.09.01.01.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 01:12:20 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org, bjorn@mork.no,
        mingo@kernel.org, oneukum@suse.com, viro@zeniv.linux.org.uk,
        mark.rutland@arm.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()
Date:   Sat,  1 Sep 2018 16:12:10 +0800
Message-Id: <20180901081210.16655-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wdm_in_callback() is a completion handler function for the USB driver.
So it should not sleep. But it calls service_outstanding_interrupt(), 
which calls usb_submit_urb() with GFP_KERNEL. 

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
 * Add more description.
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index a0d284ef3f40..632a2bfabc08 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -458,7 +458,7 @@ static int service_outstanding_interrupt(struct wdm_device *desc)
 
 	set_bit(WDM_RESPONDING, &desc->flags);
 	spin_unlock_irq(&desc->iuspin);
-	rv = usb_submit_urb(desc->response, GFP_KERNEL);
+	rv = usb_submit_urb(desc->response, GFP_ATOMIC);
 	spin_lock_irq(&desc->iuspin);
 	if (rv) {
 		dev_err(&desc->intf->dev,
-- 
2.17.0

