Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D64CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57122083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sB0LbiWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57122083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeIADMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51964 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeIADMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so6538045wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wVrhZZ5plHSLk1j0gZpUxiGDkkVRhSGuBRihyKgcR8=;
        b=sB0LbiWUIHWsl87LJaq1i/C4QqRGPFJKKmxIXSIzc5/FNXJRQtYcQZtk9bSOOSCF6g
         h6U1dTXuv8kgax8orpz/VtLMgYvQ5lODhQyfRo489Glgdcrsv5ufXAnYJrzZuy1gpU/z
         Pn/gHwZnhjrNqOSIPv9j8Il006sHXzfCZFsmqGinRM5ubzIykBwepiZDXPFzQCFjW9tY
         B4wfkw7jck/+2k2LT1NeJULpRaHlLvtEZbXpvYFCLE44F8jzUQjZlUcFLaDdFad2Ft6B
         74ZuHhA2vqujop2IHi2h/F5IUCxBVBH+QuZabuYq/ZtORBrE4IkUmI7JvTkhX1X4LJ1u
         lJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wVrhZZ5plHSLk1j0gZpUxiGDkkVRhSGuBRihyKgcR8=;
        b=NhwZ34StfaPJxKY7/73ct1YG7AM9/ugIyarkjPo4qH8Bqp5bZH3Bl+kvDe4UHVsM00
         R7Fp1AUHpd/VQQ39WBiqWSoh7gkJnkEj3J9ke2LknH7/FSWDjoRWCMe5iC+D+lrR4MHp
         mLJkmvpZJK6ZRwsH3DOBp1oAMk+u0JgFkZbU2kz538oV4bO89XlhpA8W6K9qwv/WbgIl
         X+H7hgyZ2n/Lu8F7f2HRGurb8qd1BhAF2wds17A2ZXAyor2UaFhW2EF1KtNOpUyRlyk2
         oYYMslhykeyH332G7idrbOK3THkEuHV5furOKAwioC61AnqAoCTOfJHPDSOZ2HOsG7ZJ
         tuag==
X-Gm-Message-State: APzg51Cwr8q9Yqvz+vnoeWk1l3UVz5JqbRisSa274AttExcxgJIbCKIA
        eynIHWdFHPw3YCbVhsprwJzDI6ZA8KI=
X-Google-Smtp-Source: ANB0VdY5HReYAgPWOAlvXx0YRfYMxdHfWZKiPEsO+Y45Fql4YXAqgBHx8jHGcbmURr13/hUPiBF1NQ==
X-Received: by 2002:a1c:8e04:: with SMTP id q4-v6mr5960486wmd.150.1535756586051;
        Fri, 31 Aug 2018 16:03:06 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/20] staging:rtl8192u: Refactor RT_TRACE - Style
Date:   Sat,  1 Sep 2018 00:02:37 +0100
Message-Id: <20180831230250.16810-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the MACRO RT_TRACE to add parentheses around the parameter
'component', this clears the checkpatch warning with respect to
precedence issues.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index b5ad69af8dac..c613894a6088 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -52,7 +52,7 @@
 extern u32 rt_global_debug_component;
 #define RT_TRACE(component, x, args...) \
 	do {							\
-		if (rt_global_debug_component & component)	\
+		if (rt_global_debug_component & (component))	\
 			pr_debug("RTL8192U: " x "\n", ##args);	\
 	} while (0)
 
-- 
2.18.0

