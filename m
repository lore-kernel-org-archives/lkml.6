Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813D7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3753C20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIOGKswM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3753C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeGUNuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38768 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeGUNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so9022163pgq.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GyTpDiqCSzoAxLUvfs7PhBh1s33xbPdf/OCeCQ4KrSw=;
        b=eIOGKswMcWPA0HOKJ/4qlEacZeDTJgfB35HmLrN233w6deCHOqAkoZ8nMXAujjziEX
         +OgdWBg4KFyYwOJIIa859nXGCJvGqNEigvKbOw+kpazPdTLF7+9YP44zywJkCfk0amMw
         EtEo1oxcoNvGFBJvbWBxKgxIfN5QfTen3peq2ZRtaI0gD/dejaXqbgs4GQwkF/nyQBh9
         YCNMjAbhYCN5f0n5di1+qWTYo7AudGfFcXm/gvjtUBIiN9uZLEe1aiivH7ueA5h4v485
         GzDDdFfT6hQDJqdMpLypq3bUPnzDFgFda6UNjQmEmXVj3F39D3Vx1jAz90woAo83SnB5
         bncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GyTpDiqCSzoAxLUvfs7PhBh1s33xbPdf/OCeCQ4KrSw=;
        b=RcMNGFN3f66WvRxD8cjFDtnf3GCyu9qOxHceOiv9Zl6dkym96tKUXOFqUgPytyMPc7
         vl5ZiYXkInOKR+Cr1FJVWv9OIbOLiVuK/3RelIHwQjEcluLGZEC9hgNeaBs1q1+hrw08
         wup6JrxPNEU7pPu3qrJnjjFxTXPgQiqrddVD6yTZhqsQnusqVrcKtWEymYUi99GoBb6v
         YflpGrEdisQWO7PwikQVP0OvF4IpvQNgLhg/3gIcfLfBkDDTPHiDQZDeknxG4SibU3dv
         Pmz+VdqcB42HFrKHPc0v4mUcjGo/5In8pWg72O+46ArvHc2MbcdKt7yGenuPQVZ4+PqN
         C9lQ==
X-Gm-Message-State: AOUpUlEYkXGoA9fNQ8FBI33vrwZp7lYY1QtAtvJndgNO59Z6N7iMLx1o
        NR8usNvOFOZrBITpuQhfZko=
X-Google-Smtp-Source: AAOMgpfmMeJrU0MN5krCM2QXeOJLjVYM5BOZ7YBi/BlsXjRK3QZKtB9NayeVwS2zOj6bRMrUytCirg==
X-Received: by 2002:a62:a018:: with SMTP id r24-v6mr6010881pfe.144.1532177861439;
        Sat, 21 Jul 2018 05:57:41 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:40 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/14] staging: gasket: print mmap starting address as unsigned long
Date:   Sat, 21 Jul 2018 05:56:48 -0700
Message-Id: <20180721125713.88501-10-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Page alignment error log should print the offending value as an unsigned
long, not as a kernel pointer.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2cd232230845c..11ab049854493 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1596,8 +1596,8 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	if (vma->vm_start & ~PAGE_MASK) {
 		gasket_log_error(
-			gasket_dev, "Base address not page-aligned: 0x%p\n",
-			(void *)vma->vm_start);
+			gasket_dev, "Base address not page-aligned: 0x%lx\n",
+			vma->vm_start);
 		trace_gasket_mmap_exit(-EINVAL);
 		return -EINVAL;
 	}
-- 
2.18.0.233.g985f88cf7e-goog

