Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D59C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE73E20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL8yL38k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE73E20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeK0B1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:27:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33244 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0B1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:27:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so6263703pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0s1LmIwll78meoPZUk/qCW9GeIiJg7cLWOl1WIyC0YE=;
        b=FL8yL38kK6IwsYoSgsFZi8WVnLp0ZMNSMbsxcIi3eMgm0cepU6qUX4G825Bw/1MMuw
         NmxJ6oa0gTWV3wBWts1XRCcni+4JlmjyygFPvZHLaKNE9XFp9rMTdHNHFxYOl/YnGEQD
         8UnEalf/cJ/dzIXjtrUVFPkVaXBJU5/XFu616+Uzl0FpMZHMq+O8bR8+YMMeOrbkVY5z
         AgR654fzn+RtNqo5rJ+sJje/etoKhbec4QwmRVb0OHhD+tivgdYuT+tl6+iAcrxDUxBQ
         5mwmOFeA0b9Vu3+PqX5IL+utjvjwwCVpwVw1K4mrrkdRfwSgde10+doTVTVcFyQRH+zV
         1pug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0s1LmIwll78meoPZUk/qCW9GeIiJg7cLWOl1WIyC0YE=;
        b=EliNI/3F5BF3BQbkh8oEorgxZimwD9Oq736sO7eqKY2tEb8CmyQwTH0GbVTadlDngO
         jpmetSsdacdCHhKyF27JPedjV/NMPSliJYS0bkBemoK3wf8U/W7BAtV6VlhGulkBr/Hb
         gsWWH6JYrxbGbyZto6RoPyiOYwbfvpiBTo3Ss9jOyl3TRzMg6/uGGK72fF6bwJoSloTj
         crMW0jlVQLBXqytjwO85hX8tpjRidsBLFsy+sS/qnO16Dp8oIWvLkZ2sW1B4hU9WHYcI
         r1ltGJ3ASxv1bbCdopUuQ8vdV1L/m6hosq4TvZRVPiyKam76tyuhHq1k74FykM1Z3fVa
         vSGA==
X-Gm-Message-State: AGRZ1gJhVbncnSpDNzUUQNZpnngIFku8hi2TfEh25qE7lpJT9CpI2reF
        xV+ct1BeYDAzNl94pDR2LP2iGYsIL7Y=
X-Google-Smtp-Source: AJdET5fQ5p17nvclNOMM/Yzt/aoNRSQk4+7PixqXHo5ypy8Y7wLa1Fuy+6p6H/QIDOSB3UsJtTAqcw==
X-Received: by 2002:a62:7f94:: with SMTP id a142mr28417500pfd.96.1543242810634;
        Mon, 26 Nov 2018 06:33:30 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id k15sm597716pfb.147.2018.11.26.06.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 06:33:29 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] workqueue: remove some duplicated includes
Date:   Mon, 26 Nov 2018 09:33:26 -0500
Message-Id: <20181126143326.31300-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

workqueue.h and kthread.h are included twice.It's unnecessary.
hence just remove them.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/workqueue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0280deac392e..7c62391ed5e5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -30,11 +30,9 @@
 #include <linux/init.h>
 #include <linux/signal.h>
 #include <linux/completion.h>
-#include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
-#include <linux/kthread.h>
 #include <linux/hardirq.h>
 #include <linux/mempolicy.h>
 #include <linux/freezer.h>
-- 
2.17.0

