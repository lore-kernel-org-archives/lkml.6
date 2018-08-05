Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5406C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60955217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAQ4GRQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60955217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHEFZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 01:25:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35483 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHEFZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 01:25:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so5193408pfh.2;
        Sat, 04 Aug 2018 20:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BuAGMZTZB/GaeZ9hAVW5Hp8cL/O3vjOO5otgQqkjJTg=;
        b=tAQ4GRQxO3D64fH/A/1Zkmewy+Ov0PaWEkjb9+3rHII4BoHHxHqMpum7zf+7j0Z4ae
         D7Y3Ew46FxO77EzT3o5IM/Fjx77F5bLExlTuVOjs5D0Vif9Klw4PVeqYXOrVAKEYw33Y
         vlwxN6rQ51zqqUPSZ6lzI/+fwDgngrNwh0tuOZ6wMXR9FgS/CqDwSSM4ZHi1DxaJJ4d3
         NJfoR8CpysUW71NNNpBnzhWAjI3H/tIwsAyGeohnjo81ALX6xBYhcqprjiSjDn/NmuDY
         lbo1mGjEx2XNAZFwhGoacRKhfZ4PxQpbUcLYlBTZw5qO6/0pRHz5HHsL/4KJkDOfWRWo
         9eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BuAGMZTZB/GaeZ9hAVW5Hp8cL/O3vjOO5otgQqkjJTg=;
        b=N8EWIK30JqC25NFyAvkxPGLd4jMVesXbM+Kk6H2up+wIyxaxmp/wpnDJpNC79rXbBa
         YrnCD5Zf/PILmbpMMYP9vD+O3DHqvnDXMzpv6tjmt/uk/cZqXsupIQgHNDu4y/Pqxc6+
         agNyauFvsZ8uLznHUzuUxD7ZbQ95BpZwYsaT8Co83DqGWlMA50NOErQ95GRlD/2WZF9Y
         Bcver97qjjv53EhFfrcTh4UO5U1Hcmz7pW1SKOyVYbUgEdDrqxc8S7lGhkeaoTyoW/K5
         vkt4/dfoYAkNR/D6PpO+/ddVtJ4aAkOmUVvPLtBB7ZURURdX8W5et4WqJURbzqL34/1v
         nMPw==
X-Gm-Message-State: AOUpUlGziQOMpzJKJvVqoigetS3ZsD6QjYjDmPjCBCfV/eOwnGyHYFNq
        8V2LNoSRK0gCgJ5//k6YKozx5kCU
X-Google-Smtp-Source: AAOMgpfXDcznHRLHzoMuyO2yi2gJlMmBwnUE6ukG2QwGCPEXm5ryvs81/q2DiAgAjXP4oN8HxYF+Bg==
X-Received: by 2002:a62:3a9d:: with SMTP id v29-v6mr11271519pfj.215.1533439361801;
        Sat, 04 Aug 2018 20:22:41 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id x87-v6sm15971922pfa.143.2018.08.04.20.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 20:22:41 -0700 (PDT)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 2/6] efi: the function transfers status to string
Date:   Sun,  5 Aug 2018 11:21:15 +0800
Message-Id: <20180805032119.20485-3-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180805032119.20485-1-jlee@suse.com>
References: <20180805032119.20485-1-jlee@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function can be used to transfer EFI status code to string
for printing out debug message.

Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Ryan Chen <yu.chen.surf@gmail.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 include/linux/efi.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/efi.h b/include/linux/efi.h
index 56add823f190..744cf92fe18e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1651,4 +1651,30 @@ struct linux_efi_tpm_eventlog {
 
 extern int efi_tpm_eventlog_init(void);
 
+#define EFI_STATUS_STR(_status) \
+case EFI_##_status: \
+	return "EFI_" __stringify(_status);
+
+static inline char *
+efi_status_to_str(efi_status_t status)
+{
+	switch (status) {
+	EFI_STATUS_STR(SUCCESS)
+	EFI_STATUS_STR(LOAD_ERROR)
+	EFI_STATUS_STR(INVALID_PARAMETER)
+	EFI_STATUS_STR(UNSUPPORTED)
+	EFI_STATUS_STR(BAD_BUFFER_SIZE)
+	EFI_STATUS_STR(BUFFER_TOO_SMALL)
+	EFI_STATUS_STR(NOT_READY)
+	EFI_STATUS_STR(DEVICE_ERROR)
+	EFI_STATUS_STR(WRITE_PROTECTED)
+	EFI_STATUS_STR(OUT_OF_RESOURCES)
+	EFI_STATUS_STR(NOT_FOUND)
+	EFI_STATUS_STR(ABORTED)
+	EFI_STATUS_STR(SECURITY_VIOLATION)
+	}
+
+	return "";
+}
+
 #endif /* _LINUX_EFI_H */
-- 
2.13.6

