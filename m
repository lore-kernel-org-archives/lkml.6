Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8EEECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D2420C03
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frIOKOfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D2420C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeGQCkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37219 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbeGQCkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so16093623plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7HuNJfIbORF/T96LskyrEBdY0S/0KM2D2Kis+3+fGF0=;
        b=frIOKOfZVnsiAknNlz1AjYaIIoDsBDcY+8+q+PvB6TedtflUxkN7G6brIt2lhWX/ps
         hvwUuYD9gUQToXEjL/ACNXGWVf5h0ge73yS29nEASs2sR0ue0Y6Z0bmoY/hr+v3MK/WR
         TQo2gKfxvaJpxAR5XGL19OJNQYlpZgINRpAir83jJzSuKoOpPK/00a4eUnXufLIoWZYe
         R4ABOGEYcsqE2ToR6vBWo+YTuMvBC1igouUj2JsoHrjxC1duNtSP3yxF1fFGYqI2r59x
         rUYkoM7cpxay79Rx3DWI4QMzJn+ldxssKt2jT0RJw4hc66QqzXt8HvHXUrgb6RbU1TNO
         xZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7HuNJfIbORF/T96LskyrEBdY0S/0KM2D2Kis+3+fGF0=;
        b=HZQf0shwrAh8Ly1o9wj6QRdHaKpMi5s9fNwsVBvS3Bk9nxJXe3kA8Z8lEO6q0QQKxj
         3FwHdwhQhOgz+GFXFvZuFTNhpbmqWWA4LvgS4oWZCGjkm+Fvs0KDQLI6iMVfwFflE4WX
         IvU+slScKlcU95uHvi+IBedyQInSCfL/gHj8nsfkXeYKxn9NJnHTbiBUqhdaiu8t87vj
         YDp2Wo2CsatzIg6j6siM3448TUzJY5gumqtmdRK8KMgLRChMjXYeayaIQxwSZ6qpe9fm
         iMi1t4rnJfqJCUjN2yKyDs8mgZ/36aJ+DOIBlM+MOEv6UQFVPH53aRbjsCFd5MRq1OBt
         powQ==
X-Gm-Message-State: AOUpUlHN7EZpdFi6lKP6knf/yIPSFbQcDUePHaXzaT3ZcjpbenPYcuvK
        kb4s27F+HqUuoD3yHNX3sCc=
X-Google-Smtp-Source: AAOMgpc/U/zQg+2GGSpZ4yUBp7f54Q9rlwVRcFbcKSjgJrU5BW73nEswPndlNCUvHxZKQ8GNGDvXlw==
X-Received: by 2002:a17:902:bf0b:: with SMTP id bi11-v6mr18380721plb.25.1531793429185;
        Mon, 16 Jul 2018 19:10:29 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:28 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 30/32] staging: gasket: gasket_mmap use PAGE_MASK
Date:   Mon, 16 Jul 2018 19:09:24 -0700
Message-Id: <20180717020926.176408-31-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Instead of math on PAGE_SIZE.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 1d979772217bf..01740a8184594 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1594,7 +1594,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 	}
 	driver_desc = gasket_dev->internal_desc->driver_desc;
 
-	if (vma->vm_start & (PAGE_SIZE - 1)) {
+	if (vma->vm_start & ~PAGE_MASK) {
 		gasket_log_error(
 			gasket_dev, "Base address not page-aligned: 0x%p\n",
 			(void *)vma->vm_start);
-- 
2.18.0.203.gfac676dfb9-goog

