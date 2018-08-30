Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7201C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451712082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy6fwv80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451712082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeH3WSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:18:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36988 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbeH3WSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:18:06 -0400
Received: by mail-oi0-f68.google.com with SMTP id p84-v6so17115301oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=d90bqEHBTVQOfGET0TXrJUTUboz5zwiNRbBkm8ZwpUc=;
        b=iy6fwv80XtRnyxfaC2DkHHjxMvQ5W/p3NLucf2ZgvXlBQuuij2y5niGgtn0a3s8tU3
         H4/ncvqpuQ8jHXu6LXVUAZqCsq/tIifBsdj3Z3ArYq2n6nzPDIgYa06w4IDmvJdUvMe7
         UPAlYow8oHYc7Y5EcjbR9GMdSTrJIDKpXJUiI6BhD8d2QdvG0XPsmE6SmbEQSwydkUCi
         ggGI5FWP/Ga9hD74oQTcMIuZRz6RgBmopVExze/KQO2+NVq3ZNqaN9GxG25NJdvTriYR
         y/BrjBS7M3DATyc7ahjz4/PjHtbFK709JKlPg6by+4/XB2A0fkBSV5ldUPnRJLp5rjoB
         8zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=d90bqEHBTVQOfGET0TXrJUTUboz5zwiNRbBkm8ZwpUc=;
        b=KsnDpEfapGFQ5RYYiHVxKsowq1DULVEPcykq6zzeJitBvwuVuXSn+oXa4SqZn1ZBT5
         1NApeqGVLX0JwZcTJ+98qv2T39U0qkLA2t4kQWb/fyzakhGhFgtHktWNnQa/lAcHC9FA
         /sQYjblNMX4Ev/S8ww5jvLN58jlNRBalIJyynJk0EokEKT76Fp7MED0fXohlLz2pQXVZ
         AIP+nk36eO6zhKbT4Xmvlxyec0iMx+kjZ6wXlPXCqE5njk6i15GJt1Ry+u2SQHkxqHM6
         9wVcI6g0jPgUoQoc7Sfma1b8yAJc0VUHu/HYaDH+6czxN2ZoM0mbal6mNHp1yJ0t1Hxn
         IEqg==
X-Gm-Message-State: APzg51BIgFnrJBCs9cvqMcMDmJ9FRBq2LBZGQgmC7AIVudNl0PF7mucE
        mlpt/VIqfjnYa+fOJOa4sDUe7qE=
X-Google-Smtp-Source: ANB0VdayVuvD+aH8IrrjtukkJq7zPs7bm29PPag11Ew7q7OmADxHvyTLTTWAX4/MkzMPG5R5yfqQ6w==
X-Received: by 2002:aca:3f55:: with SMTP id m82-v6mr3907302oia.237.1535652881899;
        Thu, 30 Aug 2018 11:14:41 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id 5-v6sm3632595oil.50.2018.08.30.11.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:14:40 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPA id 3E9D0677;
        Thu, 30 Aug 2018 13:14:09 -0500 (CDT)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 9A34630014E; Thu, 30 Aug 2018 13:14:08 -0500 (CDT)
From:   minyard@acm.org
To:     George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] ipmi: Fix I2C client removal in the SSIF driver
Date:   Thu, 30 Aug 2018 13:14:06 -0500
Message-Id: <1535652846-17636-1-git-send-email-minyard@acm.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

The SSIF driver was removing any client that came in through the
platform interface, but it should only remove clients that it
added.  On a failure in the probe function, this could result
in the following oops when the driver is removed and the
client gets unregistered twice:

 CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
 Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference firmware version 7.0 08/04/2018
 pstate: 60400009 (nZCv daif +PAN -UAO)
 pc : kernfs_find_ns+0x28/0x120
 lr : kernfs_find_and_get_ns+0x40/0x60
 sp : ffff00002310fb50
 x29: ffff00002310fb50 x28: ffff800a8240f800
 x27: 0000000000000000 x26: 0000000000000000
 x25: 0000000056000000 x24: ffff000009073000
 x23: ffff000008998b38 x22: 0000000000000000
 x21: ffff800ed86de820 x20: 0000000000000000
 x19: ffff00000913a1d8 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000000 x14: 5300737265766972
 x13: 643d4d4554535953 x12: 0000000000000030
 x11: 0000000000000030 x10: 0101010101010101
 x9 : ffff800ea06cc3f9 x8 : 0000000000000000
 x7 : 0000000000000141 x6 : ffff000009073000
 x5 : ffff800adb706b00 x4 : 0000000000000000
 x3 : 00000000ffffffff x2 : 0000000000000000
 x1 : ffff000008998b38 x0 : ffff000008356760
 Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
 Call trace:
  kernfs_find_ns+0x28/0x120
  kernfs_find_and_get_ns+0x40/0x60
  sysfs_unmerge_group+0x2c/0x6c
  dpm_sysfs_remove+0x34/0x70
  device_del+0x58/0x30c
  device_unregister+0x30/0x7c
  i2c_unregister_device+0x84/0x90 [i2c_core]
  ssif_platform_remove+0x38/0x98 [ipmi_ssif]
  platform_drv_remove+0x2c/0x6c
  device_release_driver_internal+0x168/0x1f8
  driver_detach+0x50/0xbc
  bus_remove_driver+0x74/0xe8
  driver_unregister+0x34/0x5c
  platform_driver_unregister+0x20/0x2c
  cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
  __arm64_sys_delete_module+0x1b4/0x220
  el0_svc_handler+0x104/0x160
  el0_svc+0x8/0xc
 Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
 ---[ end trace 09f0e34cce8e2d8c ]---
 Kernel panic - not syncing: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x23800c38

So track the clients that the SSIF driver adds and only remove
those.

Reported-by: George Cherian <george.cherian@cavium.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

George, your fix was close, but not quite right.  The following
should fix the problem, obvious in hindsight :-).  Thanks for working
with me on this.

-corey

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index e7e8b86..ca4f7c4 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -182,6 +182,8 @@ struct ssif_addr_info {
 	struct device *dev;
 	struct i2c_client *client;
 
+	struct i2c_client *added_client;
+
 	struct mutex clients_mutex;
 	struct list_head clients;
 
@@ -1639,15 +1641,7 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
  out:
 	if (rv) {
-		/*
-		 * Note that if addr_info->client is assigned, we
-		 * leave it.  The i2c client hangs around even if we
-		 * return a failure here, and the failure here is not
-		 * propagated back to the i2c code.  This seems to be
-		 * design intent, strange as it may be.  But if we
-		 * don't leave it, ssif_platform_remove will not remove
-		 * the client like it should.
-		 */
+		addr_info->client = NULL;
 		dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", rv);
 		kfree(ssif_info);
 	}
@@ -1667,7 +1661,8 @@ static int ssif_adapter_handler(struct device *adev, void *opaque)
 	if (adev->type != &i2c_adapter_type)
 		return 0;
 
-	i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
+	addr_info->added_client = i2c_new_device(to_i2c_adapter(adev),
+						 &addr_info->binfo);
 
 	if (!addr_info->adapter_name)
 		return 1; /* Only try the first I2C adapter by default. */
@@ -1840,7 +1835,7 @@ static int ssif_platform_remove(struct platform_device *dev)
 		return 0;
 
 	mutex_lock(&ssif_infos_mutex);
-	i2c_unregister_device(addr_info->client);
+	i2c_unregister_device(addr_info->added_client);
 
 	list_del(&addr_info->link);
 	kfree(addr_info);
-- 
2.7.4

