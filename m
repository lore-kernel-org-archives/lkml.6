Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB33C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44075218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WzfMDcgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBFALX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38094 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfBFALS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so4474794ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uawMTl34Wy4zvlww/d+EeMEwJUCgahJz96WHztiok1Q=;
        b=WzfMDcgfwTf10b1zzezHsTiAJSvNWEeGfqj6ThTTBe/ETHZRaRvPt5QkrmbIUxY8Kz
         tOso8kjTJWA3FdmFG7ImLY6GrPpe4xTkSiH3CxnOPXDKF1OZ4B/mg+hh7YHv7FY4XCI9
         QhXp/YG9YTnF6/sK8JOuP927PzEwP153RdAsxWz21yADd5qEDifg7EYdlWXwIO+WnPDT
         /lNvlYZsrYogLnUaq1yr7AmTfPRBP71KvlIG0jycc1ADeygSmODUm/uoGRM0Yt9Wa3cE
         eksE1xsTQ2BAx9E0dZF/9ewfKTiiPsVmNfYR6ZI6p6+GQ1WMbXYtw+JVBB+NURxe4FIe
         QYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uawMTl34Wy4zvlww/d+EeMEwJUCgahJz96WHztiok1Q=;
        b=kwMcW9a9V6sEi91iogyUKsedN78Jpv6LbRdz8CI4H0qTQscDCijLRTDYEtTIj90PGp
         zC0VwGBFUR2dmMlp4yEzE/7iDuriM4ep6ooxRFiD3YlkYJJO+dFT4kEsaqNYBKYLGB2S
         4Xj19BynDcCEOG117mX/Wg/qRj6gTNutWC7aJSpb1xIXipZ/0lox7tSt/euUvi6aTng7
         tVbSkEez/zzg9m59bbOUqrft26+kZGmjas3c2DQmrVli/NJ0QpxZcA7aOndzUm6AQPXM
         c+QB33sSHh2FbFYEaJUbo2ioBzu795lofsa4ADmjTy2wv0n4u80jpl6KBOyGY6/svola
         w41Q==
X-Gm-Message-State: AHQUAubuPEJkXfS0UqmZWLbWNrcJh7DRD3kR1XEjbSBSL2ZHMxI3AMZW
        +9aY6LVEMBSmJ1alFddKX+xWFlgBEpg=
X-Google-Smtp-Source: AHgI3IbWX2hpsHGrU4Tons9veEG+i0ncHnaZnUb1c0azw2mp6kmoeLl6unidS+eWEbdCilLe5xR1+w==
X-Received: by 2002:a05:6402:643:: with SMTP id u3mr5948010edx.276.1549411876142;
        Tue, 05 Feb 2019 16:11:16 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:15 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
Subject: [PATCH 05/32] timerfd/timens: Take into account ns clock offsets
Date:   Wed,  6 Feb 2019 00:10:39 +0000
Message-Id: <20190206001107.16488-6-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Make timerfd respect timens offsets.
Provide two helpers timens_clock_to_host() timens_clock_from_host() that
are useful to wire up timens to different kernel subsystems.
Following patches will use timens_clock_from_host(), added here for
completeness.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 803ca070d42e..c7ae1e371912 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -433,22 +434,27 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 }
 
 static int do_timerfd_settime(int ufd, int flags, 
-		const struct itimerspec64 *new,
+		struct itimerspec64 *new,
 		struct itimerspec64 *old)
 {
 	struct fd f;
 	struct timerfd_ctx *ctx;
 	int ret;
 
-	if ((flags & ~TFD_SETTIME_FLAGS) ||
-		 !itimerspec64_valid(new))
-		return -EINVAL;
-
 	ret = timerfd_fget(ufd, &f);
 	if (ret)
 		return ret;
 	ctx = f.file->private_data;
 
+	if (flags & TFD_TIMER_ABSTIME)
+		timens_clock_to_host(ctx->clockid, &new->it_value);
+
+	if ((flags & ~TFD_SETTIME_FLAGS) ||
+		 !itimerspec64_valid(new)) {
+		fdput(f);
+		return -EINVAL;
+	}
+
 	if (isalarm(ctx) && !capable(CAP_WAKE_ALARM)) {
 		fdput(f);
 		return -EPERM;
-- 
2.20.1

