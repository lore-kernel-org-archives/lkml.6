Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94407ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AADE2154D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BOrkhkg6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AADE2154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbeITCab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:30:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35945 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732336AbeITCa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:30:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so6046611edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PQ4JZILf1wPuiGcYuzRMQXBJWimKQO+nHWv+GPkcK2A=;
        b=BOrkhkg6srttMHh8viMt1I07BhwLwtU170hEzjUXLacCyz8+edIzXxwjS7g40sOYcT
         qT3xgjMNN9fM4iEBUChIKLhG2cRp1RnXGfnYlF0uVlZGyb448oPoK3vZzgmIOXM093WM
         5X2QEzWoPtudKa6CGxSFAgiJkT2u1Ow4swSJHk7bKkG3+EwTIiDH56Qxg00vmbL34AzB
         GM/C+j2gEooTJYkJboHgVBg+CRtsi7u0ZSJ8MZppDOgCfXsdb2ZCIsYPwSOwhzhL4eN0
         TaWVizIs4vR1zRYIi/kzq1mCFo2Nzc2+dJgYbNph4VeI4m6m2unnm9kYBhh4SP52W562
         2ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PQ4JZILf1wPuiGcYuzRMQXBJWimKQO+nHWv+GPkcK2A=;
        b=lwT8z+HdtT1EHCrB2Wp1HufGcLPswZkZYV2ws1e4d0WhycMRU6aTdiFsE1aVIjZGYd
         +L4EiI0TiK7LOZLxSIDQwiiR4cHDgFyiFQKIcEKN1w3G7ZenItgLn4z3Aa+aLx+9dUf4
         B1/mpUsO/5Oids1rfMiTj3QDnhfjtjoQtObaD4dmT5G7FxAN+AKela0Akw7/avbWC6zs
         braZ+2LiCKEZdRs7zQlfZxit4yV2jdBOtQ/Ttctn3yoxPian2sEbtJMR80i3G7v2SINb
         1mYebe9pGwXHmoCVetpblgg9n2Ik7KITDvYZFzvh17B+bXir82cHfUGpzOJPlQQaC6cA
         Kwrw==
X-Gm-Message-State: APzg51CUjTYo8qB4N6vUXIfTb8FI5G3ss5iYCWOai7/6kGf0RDLCpuNu
        6pvDs8xeL5HG2ZSIHrhNlk5XJHaM4tU=
X-Google-Smtp-Source: ANB0VdajzB/0I56gYueALXPtqSYTP7pm4NsfjiUxDEV6FIrUXm8GvjUoro46WqnqIhPewEAa1WYgjg==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr61787971edm.40.1537390248054;
        Wed, 19 Sep 2018 13:50:48 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t17-v6sm1747729edb.27.2018.09.19.13.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 13:50:47 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [RFC 06/20] kernel: Take into account timens clock offsets in clock_nanosleep
Date:   Wed, 19 Sep 2018 21:50:23 +0100
Message-Id: <20180919205037.9574-7-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180919205037.9574-1-dima@arista.com>
References: <20180919205037.9574-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Wire up clock_nanosleep to timens offsets.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/hrtimer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e1a549c9e399..4fe80c1325b2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -51,6 +51,7 @@
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
+#include <linux/time_namespace.h>
 
 #include <linux/uaccess.h>
 
@@ -1730,9 +1731,16 @@ long hrtimer_nanosleep(const struct timespec64 *rqtp,
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
+	struct timespec64 tp;
 	int ret = 0;
 	u64 slack;
 
+	if (!(mode & HRTIMER_MODE_REL)) {
+		tp = *rqtp;
+		rqtp = &tp;
+		timens_clock_to_host(clockid, &tp);
+	}
+
 	slack = current->timer_slack_ns;
 	if (dl_task(current) || rt_task(current))
 		slack = 0;
-- 
2.13.6

