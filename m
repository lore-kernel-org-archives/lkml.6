Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAEAC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83C420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544392776;
	bh=5wGf3qyPehsrYRxZaTRKLNeZ4gXD2S8Jq5t+ECwZoz0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uIgk3IyCLbfpc45xEjbrvmk1qcEihlEJm5M5LytEL6M1oZHonaPKAzNpAK+qOH9TM
	 yOg+id2TxJ+1jf9AWU5+PDOg2EwoPemKoptHvYMP3RzuywrAdHJNabABAGiFEpWPkd
	 r3eyvRlzl4LqRM5VCfOaP6MPThbMQDVi0SdCdGNY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83C420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeLIV7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:59:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42963 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeLIV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:59:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so8579975wrx.9;
        Sun, 09 Dec 2018 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NDYpLgJpoRRGtpA4VBVeK3gg9scW7e9ypFbeJq0AK74=;
        b=qi8DMLyOv4LlUs3CucGGwvkDSX7VXQKuhYcdkkAeJAN3VMGuWq/4lnUpTs751zoZOR
         FPufxxGMMwPctxKBVhYQOABTT+MPNkwnU1/9Shqu2beEvrKpE34n589vWv57RUaneIrJ
         DaV4VSbW6aZgbTr5IK5oBmAbd8kQtVClttj88kS4w3WxOqDBrAJkbHuWLQzvYhleBY7R
         UDvwd2fjDZIQwKkEnIfRuFUUF7DsIADgRVxdrV5YL2+7Sjaq/uvUw83+U6S1g+qrYTgs
         3QhK4l00YIMbCqJvsQd9g5atsCKin+Gbl3/m+Oe4GdfIRzf9pEoM99ZZUe6x8e8X9gnz
         V/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=NDYpLgJpoRRGtpA4VBVeK3gg9scW7e9ypFbeJq0AK74=;
        b=gOgGqrOU0gaa+2zfA3N9YdCDZ17NdPh+vloHDUn8IJeqkKvGp4unblKKpzweO/PIHV
         tXnO6x7Yh2VxYtDA1e6RlxAdtYIUC6YHWLeKt2NFhWSMw7a/elgZsNNBqLYEEQwmxO68
         VmXA0bYsmhi2hDBIm1z0eXKkFHPFuif0R+LAWLZYGf4C1h056i8uFHs14kCQzpHgVW6n
         /WFbSZQNEAvBTtEKt431SZqBQMhPIRyD8Yz1f54DGJfjX3dISuz7SVUmxnk5XvKygAX1
         v4CRh9de3GpqBljBePgqB7SiO9zPDjlbmevvejOL0GKY4fvD2wjfL2h+gYUYvfRJlILr
         YRww==
X-Gm-Message-State: AA+aEWZ8qs/JkV5FdXMLMkRgDYI/OWacj8vEqY5omWLbfrHC3x30adzv
        UOcwj7VVQWab1DPIyo8Cstk=
X-Google-Smtp-Source: AFSGD/XCERDwBIsUttWgVc27a2AdsKalymsfkZYmGW51SdpQrq6IO5WIsNTdhHYdcg55/ccTbtrxOw==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr7437084wrw.316.1544392763808;
        Sun, 09 Dec 2018 13:59:23 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h10sm7096205wmf.44.2018.12.09.13.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 13:59:23 -0800 (PST)
Date:   Sun, 9 Dec 2018 22:59:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI fixes
Message-ID: <20181209215921.GA64177@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 79c2206d369b87b19ac29cb47601059b6bf5c291 x86/earlyprintk/efi: Fix infinite loop on some screen widths

Two fixes: a large-system fix and an earlyprintk fix with certain 
resolutions.

 Thanks,

	Ingo

------------------>
Eric Snowberg (1):
      x86/efi: Allocate e820 buffer before calling efi_exit_boot_service

YiFei Zhu (1):
      x86/earlyprintk/efi: Fix infinite loop on some screen widths


 arch/x86/boot/compressed/eboot.c     | 65 +++++++++++++++++++++++-------------
 arch/x86/platform/efi/early_printk.c |  2 +-
 2 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 8b4c5e001157..544ac4fafd11 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -1,3 +1,4 @@
+
 /* -----------------------------------------------------------------------
  *
  *   Copyright 2011 Intel Corporation; author Matt Fleming
@@ -634,37 +635,54 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
 	return status;
 }
 
+static efi_status_t allocate_e820(struct boot_params *params,
+				  struct setup_data **e820ext,
+				  u32 *e820ext_size)
+{
+	unsigned long map_size, desc_size, buff_size;
+	struct efi_boot_memmap boot_map;
+	efi_memory_desc_t *map;
+	efi_status_t status;
+	__u32 nr_desc;
+
+	boot_map.map		= &map;
+	boot_map.map_size	= &map_size;
+	boot_map.desc_size	= &desc_size;
+	boot_map.desc_ver	= NULL;
+	boot_map.key_ptr	= NULL;
+	boot_map.buff_size	= &buff_size;
+
+	status = efi_get_memory_map(sys_table, &boot_map);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	nr_desc = buff_size / desc_size;
+
+	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
+		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
+
+		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
+		if (status != EFI_SUCCESS)
+			return status;
+	}
+
+	return EFI_SUCCESS;
+}
+
 struct exit_boot_struct {
 	struct boot_params	*boot_params;
 	struct efi_info		*efi;
-	struct setup_data	*e820ext;
-	__u32			e820ext_size;
 };
 
 static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
 				   struct efi_boot_memmap *map,
 				   void *priv)
 {
-	static bool first = true;
 	const char *signature;
 	__u32 nr_desc;
 	efi_status_t status;
 	struct exit_boot_struct *p = priv;
 
-	if (first) {
-		nr_desc = *map->buff_size / *map->desc_size;
-		if (nr_desc > ARRAY_SIZE(p->boot_params->e820_table)) {
-			u32 nr_e820ext = nr_desc -
-					ARRAY_SIZE(p->boot_params->e820_table);
-
-			status = alloc_e820ext(nr_e820ext, &p->e820ext,
-					       &p->e820ext_size);
-			if (status != EFI_SUCCESS)
-				return status;
-		}
-		first = false;
-	}
-
 	signature = efi_is_64bit() ? EFI64_LOADER_SIGNATURE
 				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
@@ -687,8 +705,8 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 {
 	unsigned long map_sz, key, desc_size, buff_size;
 	efi_memory_desc_t *mem_map;
-	struct setup_data *e820ext;
-	__u32 e820ext_size;
+	struct setup_data *e820ext = NULL;
+	__u32 e820ext_size = 0;
 	efi_status_t status;
 	__u32 desc_version;
 	struct efi_boot_memmap map;
@@ -702,8 +720,10 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	map.buff_size		= &buff_size;
 	priv.boot_params	= boot_params;
 	priv.efi		= &boot_params->efi_info;
-	priv.e820ext		= NULL;
-	priv.e820ext_size	= 0;
+
+	status = allocate_e820(boot_params, &e820ext, &e820ext_size);
+	if (status != EFI_SUCCESS)
+		return status;
 
 	/* Might as well exit boot services now */
 	status = efi_exit_boot_services(sys_table, handle, &map, &priv,
@@ -711,9 +731,6 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	e820ext			= priv.e820ext;
-	e820ext_size		= priv.e820ext_size;
-
 	/* Historic? */
 	boot_params->alt_mem_k	= 32 * 1024;
 
diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
index 7476b3b097e1..7138bc7a265c 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/arch/x86/platform/efi/early_printk.c
@@ -183,7 +183,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 			num--;
 		}
 
-		if (efi_x >= si->lfb_width) {
+		if (efi_x + font->width > si->lfb_width) {
 			efi_x = 0;
 			efi_y += font->height;
 		}
