Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6A5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91D52098A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="f2Bvx74Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91D52098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbeGFSn0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:43:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38438 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934112AbeGFSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:43:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so3250216pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zfKRbZMq9mOHM1/vd7Xr7W+qQNDHxQjowLpEdErHeKQ=;
        b=f2Bvx74ZB4f5I7aXyzVv4EzqruZUKvp2W4hlA5WxXKzMC6xyI40Yo7c/00id6xAC6M
         2pAIIJIGVvKLODjYm8ZLJG4wEluNpyHT/DMLI+z9fY7PAbc/a75fydORcfE8MbXd1+FD
         RiC1gUwy0g2sDncjIca+yTt2KZuUG0ClwYRUWQaAeLuBrfZjA5v8JNH6d38m+txpifbM
         KEAby4IoLxxO5ja70MFH6IUlgTDq2vdElXh8gnAYpWpqWL3iu+605zRJYlDBYm647gtY
         dfmB4UEKmTgptzz9wRmN79d7iWEWcvyjVnJzyoGharjdl6EycceEH6/3EZVkffrkWa7h
         f9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zfKRbZMq9mOHM1/vd7Xr7W+qQNDHxQjowLpEdErHeKQ=;
        b=dvbs/IhKPqsxJsQ8nGI5jj9vs6oM5MV58mVm30q9G4ScdZDWii2tkNzITZrpFkIUSz
         3L8ZGatEQOeiilgNhQ/qic3ucRSbnxFX7V4hOxoxCFKNkUoNgJGpputOi3afu1cGgylr
         SJZSg314Kg++PVZlcsKQwkeg6zWsBqqlHo1dUFuU08mTk4se5F6Mdt+XFeLVuQz6vtzB
         NK/NzNzaq/J3HR4RLTj5ht5YZgfjSpMSUkUzsjC+AVjQzyB6K2CqYve5ViXrxWXkAnXJ
         aAbuMonPYNKSZeV+aZx7sn3dyxO/O6Z7fr0vh9UK9FyTmETit3ZjwNnDcORZGiH++2A5
         kBTA==
X-Gm-Message-State: APt69E2WLhm1e+9lY44EvLNNa4sIExRetyQw0uUimyETpimOBidfn32D
        vsdsY0bFVVbIJQCJfa+kXOYv8HWy
X-Google-Smtp-Source: AAOMgpdl7SH8kei4KIgtfaL+ZfD0VKk5LsrMfEVE7C4Q67F1et7DTglPYCHLM3qGAQiv/3eRy9HB2g==
X-Received: by 2002:a17:902:6845:: with SMTP id f5-v6mr11262155pln.173.1530902604945;
        Fri, 06 Jul 2018 11:43:24 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id y2-v6sm22931691pfk.82.2018.07.06.11.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 11:43:23 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH] ipmi: initialize platform driver even when using passed-in config
Date:   Fri,  6 Jul 2018 11:43:01 -0700
Message-Id: <20180706184301.12890-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms where manual values are passed in when the module is loaded
(or through kernel command line), the device is instantiated with a
reference to the platform driver, but the platform driver never gets
initialized and loaded.

Instead, always initialize the driver, but override any SMBIOS-found
entries with the hardcoded values where they are in conflict.

Crash is as below:

[   20.052087] BUG: unable to handle kernel NULL pointer dereference at 0000000000000030
[   20.067730] PGD 0
[   20.071821] P4D 0
[   20.075836] Oops: 0000 [#1] SMP PTI
[   20.082864] CPU: 1 PID: 1330 Comm: systemd-udevd Not tainted 4.18.0-rc3-00134-g06c85639897c #10
[   20.100394] Hardware name: <...>
[   20.121583] RIP: 0010:sysfs_do_create_link_sd.isra.2+0x2f/0xa0
[   20.361345] RSP: 0018:ffffc9000fab7b10 EFLAGS: 00010246
[   20.371765] RAX: 0000000000000000 RBX: 0000000000000030 RCX: 0000000000000001
[   20.386072] RDX: 0000000000000001 RSI: 0000000000000030 RDI: ffffffff82a8ef2c
[   20.400312] RBP: ffffffff820dcdda R08: 0000000000000001 R09: 0000000000000044
[   20.414560] R10: 0000000000000220 R11: ffff883ff80471e9 R12: ffff881fee1646e8
[   20.428808] R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
[   20.443056] FS:  00007f9d6c1e7940(0000) GS:ffff881ffff80000(0000) knlGS:0000000000000000
[   20.459210] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.470685] CR2: 0000000000000030 CR3: 0000003fd1872006 CR4: 00000000007606e0
[   20.484934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.499182] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   20.513430] PKRU: 55555554
[   20.518837] Call Trace:
[   20.523729]  driver_sysfs_add+0x75/0xa0
[   20.531388]  device_bind_driver+0xf/0x50
[   20.539223]  __device_attach+0x89/0x100
[   20.546885]  ? kobject_uevent_env+0x109/0x530
[   20.555585]  bus_probe_device+0x8a/0xa0
[   20.563245]  device_add+0x3df/0x590
[   20.570214]  platform_device_add+0xb9/0x220
[   20.578571]  try_smi_init+0x785/0x930 [ipmi_si]
[   20.587618]  init_ipmi_si+0xfd/0x1a0 [ipmi_si]
[   20.596493]  ? cleanup_ipmi_si+0x80/0x80 [ipmi_si]
[   20.606060]  do_one_initcall+0x4e/0x1c9
[   20.613722]  ? kmem_cache_alloc_trace+0x14e/0x1a0
[   20.623118]  ? do_init_module+0x22/0x213
[   20.630950]  do_init_module+0x5a/0x213
[   20.638438]  load_module+0x1cef/0x2650
[   20.645927]  ? m_show+0x1c0/0x1c0
[   20.652550]  ? security_capable+0x3f/0x60
[   20.660555]  __do_sys_finit_module+0xb2/0xc0
[   20.669083]  do_syscall_64+0x49/0xf0
[   20.676225]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/char/ipmi/ipmi_si_intf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index dd758223c56d..6ddfc8be0c76 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2018,7 +2018,13 @@ int ipmi_si_add_smi(struct si_sm_io *io)
 	mutex_lock(&smi_infos_lock);
 	dup = find_dup_si(new_smi);
 	if (dup) {
-		if (new_smi->io.addr_source == SI_ACPI &&
+		if (new_smi->io.addr_source == SI_HARDCODED) {
+			/* Assume the user knew what they wanted when they hardcoded */
+			dev_info(dup->io.dev,
+				"Removing discovered %s state machine in favor of hardcoded\n",
+				si_to_str[new_smi->io.si_type]);
+			cleanup_one_si(dup);
+		} else if (new_smi->io.addr_source == SI_ACPI &&
 		    dup->io.addr_source == SI_SMBIOS) {
 			/* We prefer ACPI over SMBIOS. */
 			dev_info(dup->io.dev,
@@ -2341,12 +2347,13 @@ static int init_ipmi_si(void)
 
 	pr_info("IPMI System Interface driver.\n");
 
+	/* Always platform since hardcoded entries rely on it. */
+	ipmi_si_platform_init();
+
 	/* If the user gave us a device, they presumably want us to use it */
 	if (!ipmi_si_hardcode_find_bmc())
 		goto do_scan;
 
-	ipmi_si_platform_init();
-
 	ipmi_si_pci_init();
 
 	ipmi_si_parisc_init();
-- 
2.17.1

