Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5572BC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFD1214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ORB8mYV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLXWHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:07:51 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:35396 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeLXWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:07:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id DC660B53
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 22:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 48vS6UD2VYMS for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 16:07:48 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id AFFB86EB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 16:07:48 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id g7so15152701itg.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gKULAveRt1kNzkpVKLc/UkXJYbZ4gjKklLtzJ1WIMRo=;
        b=ORB8mYV3M1O3TPycZHMUe51VTXL+uF40KDc8OGuba7Wu8ADPowSCoWSPkjc0k4ck+F
         BSV7JcHPvtULQPvrRkZN8SWXD1B8OrwU4e0nICyCPkcCvKnV4u8YZLq/x2ysc3rCsWLg
         tV5ndElro+cXiPWePagBlfZ1H8WypBUISX5+qChz/JiGVIdV5sAcqcGHskQh2IlqH8my
         enj1HjOHoz/lnWNlCobAZbAoCCZJbGV/78eJnwqzpMHPhSytE/LrSDWX/X4h3HnqQtEk
         Up0w+Xdx65nfoamTCE6y75ATE5gCClTsqZN8w1Fnmhs98PcsXnmFvsJdkv1MLWWXFIPA
         MvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gKULAveRt1kNzkpVKLc/UkXJYbZ4gjKklLtzJ1WIMRo=;
        b=DWPnlPtk3kwYbJfEFjR/2cfwrxB76HSIhDms8Od03rhsEic1fFCFTJ/X/O3bQbMLZa
         JZuvSINRvk1PU5DZwqvfKTJBbai6gpRIf8PQCzMJnlHIjJ6znUBxmcZC/3vhRJ60ikUd
         eRYmXQEMGi++TxbG1L9Y5u8doTDEA8Dc5HbBFvcgGrcEC2lKIKZfRh697V64qjs5Rxdy
         9MjUFFxZK8PXWQfs1uB0UR+CobDO+No1m4Qag6EjdCL/1/CaPi1gZpz/OfuMQZ7ULLQO
         QMHYKfSb4h1A2twNPWC+jlo5Tf/p41w69K9plkyTQMI/krmd97W4a+S39q7Cy1CDLKsY
         0gxw==
X-Gm-Message-State: AJcUukfrFOstFbWK0GClHo3FUNXgkl7fCrMW6/vIIRxr21QW72sWfEYG
        CXMBzqVP5MCcifr2PoZ8d2dh7voW5OiQgFOx6/LOWybC6/UTJtFrDxgF5NWqLZkoffVM1mWcHq+
        UvxozAZrejwgagZr1xGhUhsYdhord
X-Received: by 2002:a5d:8049:: with SMTP id b9mr10283735ior.108.1545689268318;
        Mon, 24 Dec 2018 14:07:48 -0800 (PST)
X-Google-Smtp-Source: ALg8bN44sgMAZcMb11JUAmPEbfVqfi28kZEPoYmRqxa0Vg6NVPyCr6XucIZiXdmKQunFXNeVuSnfYg==
X-Received: by 2002:a5d:8049:: with SMTP id b9mr10283728ior.108.1545689268075;
        Mon, 24 Dec 2018 14:07:48 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m20sm12614899itm.29.2018.12.24.14.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 14:07:47 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform: x86: Add check for led_classdev_register
Date:   Mon, 24 Dec 2018 16:07:37 -0600
Message-Id: <20181224220737.27539-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function alienware_zone_init, the function led_classdev_register
can return an error on failure. The fix checks the error and frees
the allocated resources.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/platform/x86/alienware-wmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/alienware-wmi.c b/drivers/platform/x86/alienware-wmi.c
index f10af5c383c5..63ab6a2eb613 100644
--- a/drivers/platform/x86/alienware-wmi.c
+++ b/drivers/platform/x86/alienware-wmi.c
@@ -441,6 +441,7 @@ static int alienware_zone_init(struct platform_device *dev)
 	u8 zone;
 	char buffer[10];
 	char *name;
+	int ret;
 
 	if (interface == WMAX) {
 		lighting_control_state = WMAX_RUNNING;
@@ -492,7 +493,17 @@ static int alienware_zone_init(struct platform_device *dev)
 	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
 	zone_attribute_group.attrs = zone_attrs;
 
-	led_classdev_register(&dev->dev, &global_led);
+	ret = led_classdev_register(&dev->dev, &global_led);
+	if (ret < 0) {
+		if (zone_dev_attrs) {
+			for (zone = 0; zone < quirks->num_zones; zone++)
+				kfree(zone_dev_attrs[zone].attr.name);
+		}
+		kfree(zone_dev_attrs);
+		kfree(zone_data);
+		kfree(zone_attrs);
+		return ret;
+	}
 
 	return sysfs_create_group(&dev->dev.kobj, &zone_attribute_group);
 }
-- 
2.17.1

