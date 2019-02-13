Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F3C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA7521872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lVOadcU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394346AbfBMTtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:49:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40282 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733137AbfBMTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:49:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so1667126pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 11:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mypbCqQv96xEnaOn1SOItCUfj0eOMDOPhX5eddQM5J8=;
        b=lVOadcU0qHeZzxsusfoq2QP6mV65pIiNmJ9vwGxuToCtnbSjcd24vukDb9kBGXsuPJ
         7daR0+orAEEqbC0ajjXvyCnPEUUHz4hXDpmwlwE2PQsDHmZR0cXrMwte6ibaDKAQZUfq
         fW/bcPGMVgEYDXXuHmHYHQnHMw6MNLkPgI10FA1GkEx1UZkxdd+o9+eGeKse1XkVAWN1
         Q7mwWAkUTftrLlTAQPHfL2v3u03o1nS92giCAAqYn5fE1wjj+gZ6i8IO1ke3kRnmAfND
         huyMut6KlLCyhPr/gOwoqrTUtrbZ21hnCTO6aMjFMNZl3vTpNqDmftBWMAWBEHgWbN88
         Ky5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mypbCqQv96xEnaOn1SOItCUfj0eOMDOPhX5eddQM5J8=;
        b=OhejZ6wC/AvxSVZrMwlnKCFQi8XqUfmpMoY3KxV1BDsnSasp4Lkdqk6V0253r7oYSR
         rMpNGM1ow/qg17e3ChdQtLLnKYYiIwOf8YleZyKxojAmdCsndt5i+lwSI0Gy2u+TXLJ1
         aiLm7VDND66lQUzH8Xrz4+2t9dSrdUC1Ba8Vn0YRgV/wLFEeS2CFu72f7F5CGioWwPJP
         WtLQ/UrNyFd/UlhX/ATIIWIUPpHutiYsGPT9Bs1bRTp//xl4hYQFR7j0kuCVklUUf3i1
         ZH599k/batv+Zu3jMDaz1VEcqXfRIbwflfMcXSm+rpFp4pT83udlYsDmoQSgyZ1mRwj2
         UV2Q==
X-Gm-Message-State: AHQUAuam0szj+z6XXofamB2UVZGrx4wsY3Vy6w3vfiH1nyN0eVaPAAsd
        EIryZlR8BhdI2Wwhwk+/Csi9ig==
X-Google-Smtp-Source: AHgI3IZPrKXbuv52F/2Yzv4AhFgGgU9XVLJp1Yrkmiv66xXHNFs/cnEv1iBjB1GIgVchyohwrll8GA==
X-Received: by 2002:a65:6684:: with SMTP id b4mr1964880pgw.55.1550087346469;
        Wed, 13 Feb 2019 11:49:06 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id b12sm187019pfb.30.2019.02.13.11.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 11:49:05 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] binder: fix sparse issue in binder_alloc_selftest.c
Date:   Wed, 13 Feb 2019 11:48:53 -0800
Message-Id: <20190213194853.14952-1-tkjos@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sparse issues reported by the kbuild test robot running
on https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
char-misc-testing: bde4a19fc04f5 ("binder: use userspace pointer as base
of buffer space")

Error output (drivers/android/binder_alloc_selftest.c):
sparse: warning: incorrect type in assignment (different address spaces)
sparse:    expected void *page_addr
sparse:    got void [noderef] <asn:1> *user_data
sparse: error: subtraction of different types can't work

Fixed by adding necessary "__user" tags.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder_alloc_selftest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index f0f4d7d026351..b72708918b06b 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -102,10 +102,11 @@ static bool check_buffer_pages_allocated(struct binder_alloc *alloc,
 					 struct binder_buffer *buffer,
 					 size_t size)
 {
-	void *page_addr, *end;
+	void __user *page_addr;
+	void __user *end;
 	int page_index;
 
-	end = (void *)PAGE_ALIGN((uintptr_t)buffer->user_data + size);
+	end = (void __user *)PAGE_ALIGN((uintptr_t)buffer->user_data + size);
 	page_addr = buffer->user_data;
 	for (; page_addr < end; page_addr += PAGE_SIZE) {
 		page_index = (page_addr - alloc->buffer) / PAGE_SIZE;
-- 
2.20.1.791.gb4d0f1c61a-goog

