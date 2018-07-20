Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECE8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC53820833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 03:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqHjYJmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC53820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeGTEgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:36:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38072 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeGTEgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:36:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so5616339pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 20:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CEnOMmXj1PSytsHYEuA+E29Sq6QGkC9YGpuPwIBA0TI=;
        b=UqHjYJmFdkoKfMq9NXt4TWgJXrJZYle4QfLCWDT+1aNBaRM/RIB+6GB2rEgoOrXIR7
         J/lRuVVZdRN+wW0lIFp5UPXqcdq4GmqvtFKL7o/0hBk2AOUP/mfY5Fo4SnaK0y0xla4d
         3+/QRGp0hSoqfHkYDzesaWJQeEEdFjVF4ODagDDdmL5ZhEpdzL3/kwHmEdGPloPvMmJ5
         eg+ilqHX8/rRsxRO+tiFm3mdu/ZluuUCSGxNrUG0Nixtlg6Nyk0FhPHg+N4Et/JllAva
         hyg78MBGuwbZ2no4Cs37IOrMJ/7M/JtP6LoNXnBGNcttUCdUVx9C6bhEGt4ZiVQldKrB
         kQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CEnOMmXj1PSytsHYEuA+E29Sq6QGkC9YGpuPwIBA0TI=;
        b=ieN4nPTkvmrTSqGtBv4gAKsDlLeSid/RMY8YjCgrmnF7I72inRyyGKB+aDzxgABcZg
         E0CTHbFfLWbaK5w5A7LTnmMB5aRvDNX+h9AG0leF4p3cNxg32qIb6DNu1GEHUUhkABVK
         TVKhOC0QNi6Hb2FxC5YTxVQ5/XsiXBfwQbk5VL/oBv3cxTW3CoKdqZcUPUOKbEmq0fcL
         WRlT7uq8i0eqM2W9YZWChZYk3bUg8yE2yd5Qda8LrVatgjMQFIT6MjEHdiURzAy6NR89
         97jc/yrVPSoHRfZtVOG7ocVdCPEG47cWOQRxk6C10eDtg2oP7Nw0W0Cubo/niqsL6pT/
         vE2Q==
X-Gm-Message-State: AOUpUlHwS/AxPjCGsda37G2MxsA37p49godvAHgbJ7p3fjDlQ5ovzYkI
        JJtDvar+mNtTAnpVmvi5K/0=
X-Google-Smtp-Source: AAOMgpe2ApovVfXy0fmYCoxLBPVcWoOvA7F+HWzzy/nl3MWgiSz6ALcx1IsvN6bYgNhCsU9dZZJlUw==
X-Received: by 2002:a62:225d:: with SMTP id i90-v6mr457979pfi.246.1532058594429;
        Thu, 19 Jul 2018 20:49:54 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id x66-v6sm864255pff.123.2018.07.19.20.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 20:49:53 -0700 (PDT)
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
Subject: [PATCH 05/20] staging: gasket: remove unnecessary code in coherent allocator
Date:   Thu, 19 Jul 2018 20:49:05 -0700
Message-Id: <20180720034920.77320-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180720034920.77320-1-toddpoynor@gmail.com>
References: <20180720034920.77320-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove extraneous statement in gasket_config_coherent_allocator()

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 0c2f85cf54480..d0142ed048a65 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -420,10 +420,8 @@ static int gasket_config_coherent_allocator(
 	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
 		return -EFAULT;
 
-	if (ibuf.size > PAGE_SIZE * MAX_NUM_COHERENT_PAGES) {
-		ibuf.size = PAGE_SIZE * MAX_NUM_COHERENT_PAGES;
+	if (ibuf.size > PAGE_SIZE * MAX_NUM_COHERENT_PAGES)
 		return -ENOMEM;
-	}
 
 	if (ibuf.enable == 0) {
 		ret = gasket_free_coherent_memory(
-- 
2.18.0.233.g985f88cf7e-goog

