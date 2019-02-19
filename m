Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3138C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4A32147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 22:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLA3CV4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfBSWDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 17:03:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46416 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfBSWDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 17:03:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so10834632pfh.13;
        Tue, 19 Feb 2019 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=OLA3CV4tn6lzXLl6iKpHEQ9DD5iwCGH0PUshgOZysZoeGlzW3fYRQA4Bc3qSRtPu6E
         pVod7ci3kF6COGP+EgqKMHZ83TypdDXU5eEpxtXWzYhCHT/MvdmRQR/ylUalw2VXBMgy
         UevxePM5JkJSDxyn+sX0E+AvBq5NUuzK0/pbf3/JAoXFAhFvpMXLiAeEdfA1AKfzx6Zu
         mU5rAGN+PVMpYkiVIofsPVNMyUWV+RodDOWLYdHN4UJ07o78JVyA5Ob+ENkvZm18IKCq
         a9TL6bUekRePyZka7MzEPn93ObggbEHDb/t6yr+6WJL5pvt+O+EkdbACz3aAXJooBID+
         G5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXXdq7GrYAICjYexP9jF/A5d/mueQ96ws92MW4tT5O4=;
        b=S7RoRXxoo2MzDaHpqbGW8P7BEQ0D8mBSGL4+6pe4AyLnM9+kNHQO96Qq1W5ovqjdOf
         jB9LXx2Pt7Pz7Sju0NY2dCJDGC3PuSDRzZmCioZ16ka8L1t/cqu9JUzBJIgQpGCyoOeU
         ZnhuSVdkNp6hAcmJCxemY4JpgsqgK0M88mx7bKiKzqjPwqFvTFTkhUQBU2zUMdyIhSWE
         xCAwPkWbYWDTdj1sdZkifHpJ12QX2PkkIVydkWRT8AMHDOucC+kx/CP/hHn/99iNOtwm
         gu7uAZzgKHYTYpOz4i0Yv/TK6Ux0N8oIk/yHA1kooNda6iw7CokfKF0Rno67wn0SaXvu
         wAVw==
X-Gm-Message-State: AHQUAua2YIO8AWOfLG37JdC8IAQc9/0i76X26eF1F+KCd4lQ21IKZJdY
        1hCSFvRb7QeQsdJyPc49KkXZAJ1A5wg=
X-Google-Smtp-Source: AHgI3IbSX5U7gDzk8gFT1FTLG9K6pbcGKeJN7LyI9ZVatJDtSOS1Vh583QeAMvPUhksQsE+kdGsU7g==
X-Received: by 2002:a65:60c5:: with SMTP id r5mr26408736pgv.427.1550613787425;
        Tue, 19 Feb 2019 14:03:07 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:161b])
        by smtp.gmail.com with ESMTPSA id e6sm33539779pfe.59.2019.02.19.14.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 14:03:06 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH v8 5/7] kselftests: cgroup: don't fail on cg_kill_all() error in cg_destroy()
Date:   Tue, 19 Feb 2019 14:02:50 -0800
Message-Id: <20190219220252.4906-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219220252.4906-1-guro@fb.com>
References: <20190219220252.4906-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cgroup destruction races with an exit() of a belonging
process(es), cg_kill_all() may fail. It's not a good reason to make
cg_destroy() fail and leave the cgroup in place, potentially causing
next test runs to fail.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/cgroup/cgroup_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 14c9fe284806..eba06f94433b 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -227,9 +227,7 @@ int cg_destroy(const char *cgroup)
 retry:
 	ret = rmdir(cgroup);
 	if (ret && errno == EBUSY) {
-		ret = cg_killall(cgroup);
-		if (ret)
-			return ret;
+		cg_killall(cgroup);
 		usleep(100);
 		goto retry;
 	}
-- 
2.20.1

