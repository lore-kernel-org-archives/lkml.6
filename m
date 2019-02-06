Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A934BC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738A22175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="B22LoFYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfBFALk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40979 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfBFALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id p15so196192edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzD4I9vSpLa0znPUX8loomCgIT/NSp02B5H14ewm4us=;
        b=B22LoFYVPi1fl9O8ZekaIEXsOLWdDBYXEyJ+jFGPSErEr0gLGmuxj39025meESR5kw
         gjEEyYb3f3YtumzddUY4SGJiZ+w5nWlzmWXkx9qCpWLR7qKoECS8ZFeMUsGZgB2PHcKR
         k2XaFD4ctvRhnTVI1ya+HPlA1Z7wRE+B1O0yJ/bSHcWn1PrvGRMtvzRoXQV7n/NgHOSA
         ktH0QUIVVBgnfvxUCweGmedRTmsFPb2iiQdqMMu2JiLZOsEz6ZATzq30OjMdOT8N+I7x
         LcthBQdIyE/yGbwGVlnVeyCvrXf7F1M/QFJJY0AmXjplz9b0xwnsY5N/6OLZM5/RVcTA
         kBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzD4I9vSpLa0znPUX8loomCgIT/NSp02B5H14ewm4us=;
        b=L2mz/kbDgt/cNSOEKLGdbuXaywz5MuRjqh9uFoChjfGzQizUNCzCVTyt7D5muMNv7a
         QU2GzyozLV3ivPUCJmfvywfqiiRiOHK79TDjZtuLOhU1csMeWu0kKjFILHTTcYU5FGFh
         VlCFDeFphycE5ZuA4lWr9dpfvHwyxhl4S2Mga8bfIfFzEaFbXDFwezyOSg2MPo00hFGr
         4CY5Tc110fFx/b9r36G4hK/T2yVrXC+6Fvp3G8Vx9qFn3YAiEqT647VLXia9dZ/VL+67
         DZ1v8ZVamXvbTyFlWe/5AmF0/i9K3JAZLuiJ2pYaDZ1iMGVvZRVKG2HHSJDnNzeUotoT
         ScuA==
X-Gm-Message-State: AHQUAubfVxh5nhX2nvcs9jVESgm3jxaZaksHTWWFFu97fPetGFcq9AsD
        SjohUpVb0k69DD+gL39hRPgW6EHocNc=
X-Google-Smtp-Source: AHgI3IaChhpAxLHOWCxz+K1RzvpAQcmIhZTJlCNg6caTn54vndPLfV9IEMpKsl2jyWE3iKin+b5clQ==
X-Received: by 2002:aa7:c906:: with SMTP id b6mr6039575edt.17.1549411896522;
        Tue, 05 Feb 2019 16:11:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:35 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 20/32] x86/vdso: Initialize timens 64-bit vdso
Date:   Wed,  6 Feb 2019 00:10:54 +0000
Message-Id: <20190206001107.16488-21-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize both 64-bit VDSO(s): host .so and timens one that has code
for adding timens offsets.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c   | 4 ++++
 arch/x86/include/asm/vdso.h | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index d1031db94093..56a62076a320 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -343,6 +343,10 @@ static int __init init_vdso(void)
 {
 	init_vdso_image(&vdso_image_64);
 
+#ifdef CONFIG_TIME_NS
+	init_vdso_image(&vdso_image_64_timens);
+#endif
+
 #ifdef CONFIG_X86_X32_ABI
 	init_vdso_image(&vdso_image_x32);
 #endif
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 619322065b8e..b6a1a028ac62 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -32,6 +32,9 @@ struct vdso_image {
 
 #ifdef CONFIG_X86_64
 extern const struct vdso_image vdso_image_64;
+#ifdef CONFIG_TIME_NS
+extern const struct vdso_image vdso_image_64_timens;
+#endif
 #endif
 
 #ifdef CONFIG_X86_X32
@@ -40,6 +43,9 @@ extern const struct vdso_image vdso_image_x32;
 
 #if defined CONFIG_X86_32 || defined CONFIG_COMPAT
 extern const struct vdso_image vdso_image_32;
+#ifdef CONFIG_TIME_NS
+extern const struct vdso_image vdso_image_32_timens;
+#endif
 #endif
 
 extern void __init init_vdso_image(const struct vdso_image *image);
-- 
2.20.1

