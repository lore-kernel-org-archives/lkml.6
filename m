Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B84C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE76D21473
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9152IgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE76D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeJLXiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:38:11 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:38043 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeJLXiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:38:10 -0400
Received: by mail-yw1-f74.google.com with SMTP id j144-v6so7484535ywa.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r8ggDEeJtgMIZpCxzFcUwPxBx0c0aMgzrt9OHfAlRck=;
        b=V9152IgQxAZ5uY+zWh2rOO5LbSH5jahrBJQiYzdrTSIhnrKNae4Mrp0/ZVwEj4+Qru
         SeQLR77AyYtWJ0Wa5FN2VzzUxWzrb6X9HiP+S/UupBXZSaV9s5PTIfsmOihW+AioawRK
         zdKvOanz/+T8uoyn8HvJeVpHrqcPsXER7jgjRVdIh2v3s/a1OjigP9qZpZ3wW/Sn4aMR
         X3hok6kaAJPjXshoVgPwkQZPRGNkk5Et2BRlT4PpwxpYbbU7Hpz7n7Oj7EJk/wsACbsE
         O+VCjEWELg1D4FHj8wYB7Zb07kgEHfHoVvHxP5PlQsShmgPkSDRBzx4Fn8RhabbJwfzL
         5Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r8ggDEeJtgMIZpCxzFcUwPxBx0c0aMgzrt9OHfAlRck=;
        b=a9DR5au3VcvrL0G8nQu/6bNkXObdvH+5/OSAhjqa/7hhmYy61y68uwrmKK1nDPUomX
         t91HEZvk48nM9oQnmjInArv/kj4OvCbRlxQ/xoqARGAUuFvSnaoM9fMYPKe/fR6mzQz3
         02H/SRe8/fBCHBe9s9FjdQ8q8lA5SM7fs3xHm/pdB0S6wwsLzj83Od2E7eJ/ae/ZoedO
         JXYWouEaxpZ6An3MCANuopouyxdbXK1cIcKlf7B08blBrwCRigXIiagyROSIEwGqGxOD
         eHGjwK9/a8usLabzh9auX/UKwnSiYoYlTHb6rh1GtkkD5D7fbHswYrUnc44tHA/DDuqe
         PTZQ==
X-Gm-Message-State: ABuFfoiW22aFUfRbEFwO3SThgQroGhNtD7PNiR3IaxQwTRSVgvi3k9Pz
        Em0t//SCmhjRt25+j6WOgg7qe623I1fa
X-Google-Smtp-Source: ACcGV62llf6bLqw+32Jy8IMu6LvNRDi0PP+KOcnomp7O/89zFxD0aAj4L2bk8RBT0cEKsk2/a2vevvzsFM0/
X-Received: by 2002:a25:cf88:: with SMTP id f130-v6mr3714675ybg.29.1539360300292;
 Fri, 12 Oct 2018 09:05:00 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:04:47 -0600
In-Reply-To: <20181012160448.79018-1-zwisler@google.com>
Message-Id: <20181012160448.79018-4-zwisler@google.com>
Mime-Version: 1.0
References: <20181012160448.79018-1-zwisler@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 3/4] gsmi: Remove autoselected dependency on EFI and EFI_VARS
From:   Ross Zwisler <zwisler@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Duncan Laurie <dlaurie@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Ben Zhang <benzh@chromium.org>,
        Filipe Brandenburger <filbranden@chromium.org>,
        Furquan Shaikh <furquan@google.com>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@chromium.org>

Instead of selecting EFI and EFI_VARS automatically when GSMI is
enabled let that portion of the driver be conditionally compiled
if EFI and EFI_VARS are enabled.

This allows the rest of the driver (specifically event log) to
be used if EFI_VARS is not enabled.

To test:
1) verify that EFI_VARS is not automatically selected when
CONFIG_GOOGLE_GSMI is enabled
2) verify that the kernel boots on Link and that GSMI event log
is still available and functional
3) specifically boot the kernel on Alex to ensure it does not
try to load efivars and that gsmi also does not load because it
is not in the supported DMI table

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Filipe Brandenburger <filbranden@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@google.com>
Tested-by: Furquan Shaikh <furquan@chromium.org>
Reviewed-by: Aaron Durbin <adurbin@chromium.org>
[zwisler: update changelog for upstream]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/firmware/google/Kconfig |  6 +++---
 drivers/firmware/google/gsmi.c  | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
index a456a000048b..9ac36762e503 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/google/Kconfig
@@ -10,12 +10,12 @@ if GOOGLE_FIRMWARE
 
 config GOOGLE_SMI
 	tristate "SMI interface for Google platforms"
-	depends on X86 && ACPI && DMI && EFI
-	select EFI_VARS
+	depends on X86 && ACPI && DMI
 	help
 	  Say Y here if you want to enable SMI callbacks for Google
 	  platforms.  This provides an interface for writing to and
-	  clearing the EFI event log and reading and writing NVRAM
+	  clearing the event log.  If EFI_VARS is also enabled this
+	  driver provides an interface for reading and writing NVRAM
 	  variables.
 
 config GOOGLE_COREBOOT_TABLE
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 252884787266..edab00cc6bba 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -289,6 +289,10 @@ static int gsmi_exec(u8 func, u8 sub)
 	return rc;
 }
 
+#ifdef CONFIG_EFI_VARS
+
+static struct efivars efivars;
+
 static efi_status_t gsmi_get_variable(efi_char16_t *name,
 				      efi_guid_t *vendor, u32 *attr,
 				      unsigned long *data_size,
@@ -466,6 +470,8 @@ static const struct efivar_operations efivar_ops = {
 	.get_next_variable = gsmi_get_next_variable,
 };
 
+#endif /* CONFIG_EFI_VARS */
+
 static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
 			       char *buf, loff_t pos, size_t count)
@@ -767,7 +773,6 @@ static __init int gsmi_system_valid(void)
 }
 
 static struct kobject *gsmi_kobj;
-static struct efivars efivars;
 
 static const struct platform_device_info gsmi_dev_info = {
 	.name		= "gsmi",
@@ -891,11 +896,14 @@ static __init int gsmi_init(void)
 		goto out_remove_bin_file;
 	}
 
+#ifdef CONFIG_EFI_VARS
 	ret = efivars_register(&efivars, &efivar_ops, gsmi_kobj);
 	if (ret) {
 		printk(KERN_INFO "gsmi: Failed to register efivars\n");
-		goto out_remove_sysfs_files;
+		sysfs_remove_files(gsmi_kobj, gsmi_attrs);
+		goto out_remove_bin_file;
 	}
+#endif
 
 	register_reboot_notifier(&gsmi_reboot_notifier);
 	register_die_notifier(&gsmi_die_notifier);
@@ -906,8 +914,6 @@ static __init int gsmi_init(void)
 
 	return 0;
 
-out_remove_sysfs_files:
-	sysfs_remove_files(gsmi_kobj, gsmi_attrs);
 out_remove_bin_file:
 	sysfs_remove_bin_file(gsmi_kobj, &eventlog_bin_attr);
 out_err:
@@ -927,7 +933,9 @@ static void __exit gsmi_exit(void)
 	unregister_die_notifier(&gsmi_die_notifier);
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &gsmi_panic_notifier);
+#ifdef CONFIG_EFI_VARS
 	efivars_unregister(&efivars);
+#endif
 
 	sysfs_remove_files(gsmi_kobj, gsmi_attrs);
 	sysfs_remove_bin_file(gsmi_kobj, &eventlog_bin_attr);
-- 
2.19.0.605.g01d371f741-goog

