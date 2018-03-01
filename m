Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032764AbeCAQIa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:08:30 -0500
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:54481 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031777AbeCAQI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:08:29 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1437:1534:1541:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3352:3867:5007:6261:6642:10004:10848:11026:11658:11914:12043:12296:12555:12679:12895:13069:13311:13357:13972:14181:14384:14394:14721:21080:21433:21627:30054,0,RBL:46.188.144.227:@perches.com:.lbl8.mailshell.net-62.8.110.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: ghost40_49b1b6b786929
X-Filterd-Recvd-Size: 2055
From: Joe Perches <joe@perches.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: wmi: Fix misuse of vsprintf extension %pULL
Date: Thu,  1 Mar 2018 08:08:23 -0800
Message-Id: <77b9d62ee2600bb01c08c618e67b63c8aaa35f49.1519920316.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%pULL doesn't officially exist but %pUL does.

Miscellanea:

o Add missing newlines to a couple logging messages

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/platform/x86/wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index f90ba83359f5..8e3d0146ff8c 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -936,7 +936,7 @@ static int wmi_dev_probe(struct device *dev)
 		wblock->char_dev.mode = 0444;
 		ret = misc_register(&wblock->char_dev);
 		if (ret) {
-			dev_warn(dev, "failed to register char dev: %d", ret);
+			dev_warn(dev, "failed to register char dev: %d\n", ret);
 			ret = -ENOMEM;
 			goto probe_misc_failure;
 		}
@@ -1039,7 +1039,7 @@ static int wmi_create_device(struct device *wmi_bus_dev,
 
 	if (result) {
 		dev_warn(wmi_bus_dev,
-			 "%s data block query control method not found",
+			 "%s data block query control method not found\n",
 			 method);
 		return result;
 	}
@@ -1189,7 +1189,7 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 
 		retval = device_add(&wblock->dev.dev);
 		if (retval) {
-			dev_err(wmi_bus_dev, "failed to register %pULL\n",
+			dev_err(wmi_bus_dev, "failed to register %pUL\n",
 				wblock->gblock.guid);
 			if (debug_event)
 				wmi_method_enable(wblock, 0);
-- 
2.15.0
