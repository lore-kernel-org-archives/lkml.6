Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E7EC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D61217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="oXpybZ65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfBFALo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35248 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbfBFALl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:41 -0500
Received: by mail-ed1-f65.google.com with SMTP id b17so322530eds.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GYtWgsYIrbQ+wXLZQ6GRDMo0YzwFjr2Z8S6W7O2LBTk=;
        b=oXpybZ65zOtlwlrNVV8Yjeex71UpqY5Rgkc3a9e2a1zA5iFgEUgjOTCqINQfhqZU/j
         OK3h98L2SbrO86GYKrZ4tMgkj09Vix1yirSNGGDEhEn4ReOnQWO5oHYlnT4S1q/wDq3A
         lgbbCaZ66TaRnh2j9uLXvENEIvi9S98TDglvK4WR9eenUiCp/ybuqNqlfIF4/rrUB3/M
         vE61TPBmaRhPuscVhgcVse30bb53qDoV8Fs/J/VgngYFGKgl+6E053T9zMZ85AfKGxWR
         jc71d+6fhgOjb55VZOIkp+FfXBrt9lCVwSokgJNdfWrMADt/TZEJmxrBPULJ2JO6AG2l
         9Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GYtWgsYIrbQ+wXLZQ6GRDMo0YzwFjr2Z8S6W7O2LBTk=;
        b=kpn3HCNsamZrvCYHSFTkvngf9kkUtNKmznSIp67mpUAj1FGCVGrj6c+PuvJRKkx0O7
         g/tE7N2Mo+nTA/p3La/oUOO9dA3OvTfgRQ5mHLqtsuO1BCsD11eq+J0d1hbvBie7+8N2
         8yyKX7SDEVkr2kp43au5bD0Wt5kcfsXStdO8JFZGMxSSGp4Tji/EKIvI2e6BWUQgHG5z
         XrlGgmKSrLapzdOGvpuvj+RL9Bt5QfmlgHYti+GYNZtZ219e5zXMv2BjDsvza5ZzMHyG
         T1DCXbB6kg23/muHfRc342DSSRL5eiG3zGnMdZt4MKlyF23UZrlvIzTfnqZcIzBC3/Bf
         hB5A==
X-Gm-Message-State: AHQUAuakRGXbLS3n+p9L92m9vcB0m1EAdQXynB76g2fgt8iXwvXkbXf6
        /mirbJ656U2m3WJCRqnBbPpvSS6bJF0=
X-Google-Smtp-Source: AHgI3IZBgA0WgbRyskGX5wgPcmIoKRoeaNeGe3Zjf9nareDBLe6AlYLT5zA0QGeIUkhFHGADpHfHNQ==
X-Received: by 2002:a17:906:d29b:: with SMTP id ay27mr5260960ejb.119.1549411899093;
        Tue, 05 Feb 2019 16:11:39 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:38 -0800 (PST)
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
Subject: [PATCH 22/32] timens: Add align for timens_offsets
Date:   Wed,  6 Feb 2019 00:10:56 +0000
Message-Id: <20190206001107.16488-23-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align offsets so that time namespace will work for ia32 applications on
x86_64 host.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/timens_offsets.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 777530c46852..f2a03d4f7a91 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -2,9 +2,17 @@
 #ifndef _LINUX_TIME_OFFSETS_H
 #define _LINUX_TIME_OFFSETS_H
 
+/*
+ * Time offsets need align as they're placed on VVAR page,
+ * which is used by x86_64 and ia32 VDSO code.
+ * On ia32 offset::tv_sec (u64) has align(4), so re-align offsets
+ * to the same positions as 64-bit offsets.
+ * On 64-bit big-endian systems VDSO should convert to timespec64
+ * to timespec because of a padding occurring between the fields.
+ */
 struct timens_offsets {
-	struct timespec64  monotonic_time_offset;
-	struct timespec64  monotonic_boottime_offset;
+	struct timespec64  monotonic_time_offset __aligned(8);
+	struct timespec64  monotonic_boottime_offset __aligned(8);
 };
 
 #endif
-- 
2.20.1

