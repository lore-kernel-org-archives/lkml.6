Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A63C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C17A20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyHevpfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C17A20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935494AbeFRULz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:11:55 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33456 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbeFRULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:11:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so9080884plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eGGP3f0VC+tPueeqA/sY74JbbVT+2IwRnKI9mKciZG8=;
        b=RyHevpfXn/pkwKYmVjiCprxDoexyJL2jdQUgraq3M9EmGhC9uGlWV/Sblka1bqxuXN
         vncrL+adTrnCRgzGk4fd7GC4P3GbkjwR1KYa+LOJseD4sptuEwPx/Sul7NrFfhTVlt2R
         Z0jY22ACyKE4z8Jo36/7aEXr29PC4HatSQXOBJODSs0Bs1qtLGbUKKfPFbWGgFR9UPZ1
         NHx+X1Z9FWSWbQWTBnsYmk/+PhiI+kcyn1h33JMKtGzrEt/TEKnHdVvIb0a8DQhJRClw
         Ns56pmyEs4AiUyi9nYbggNjHeZYq7Pb3jXGXtpJ69bg3isV73YCKIk+WcIKmG+O32hlD
         dyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eGGP3f0VC+tPueeqA/sY74JbbVT+2IwRnKI9mKciZG8=;
        b=QDX/86LkgM177NeTAm5jrjfzhmqZTOlmJ/UXAm6kYHwkImEJIv574n1cnVA3F2k5I3
         Alw9cM2+m/UOv8U4otuBSsQra5kw8sgwsLXirZlZM9q5XGxly6sDBCPw5BKw1PCzLVT3
         xzCIYD17qtfgopGPnUH3/2DQBJxTDP7gLoH/7sCr4x42BEdgVMnFr6Tszuyhg03aGobs
         dJuFxXLru2Ya4b5fcZq9EIv1Yi7kU/4IqVc3tlfnz389MqTJ9nUsi5DksxlraKNA5usP
         GIhUHMhZCgOnXXF9g8w0ueCLF3GRhorB14CVM6kpH8HITAqvXv07cYnjsGfr9vu8aQeU
         o5QQ==
X-Gm-Message-State: APt69E2C20b57BAUGR+IShf3E+BlEpePDgZwI3QhYk5JrMW+wuIJPxvQ
        GLsePw6tx/jJ5+Ul8mxgbi72rw==
X-Google-Smtp-Source: ADUXVKLQa5X6L0FY00fO4Ix7/X2DUUgw1nUjWN0Q2EwvgUkJEeW27KnCw5ZDnnnRduVHT/MYOkDT0A==
X-Received: by 2002:a17:902:b483:: with SMTP id y3-v6mr15790806plr.66.1529352713004;
        Mon, 18 Jun 2018 13:11:53 -0700 (PDT)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.googlemail.com with ESMTPSA id z18-v6sm22675114pgc.0.2018.06.18.13.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 13:11:52 -0700 (PDT)
From:   Ivid Suvarna <ivid.suvarna@gmail.com>
To:     arnd@arndb.de, tglx@linutronix.de
Cc:     deepa.kernel@gmail.com, y2038@lists.linaro.org,
        o-takashi@sakamocchi.jp, Ivid Suvarna <ivid.suvarna@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] posix-timers: use ktime_get_raw_ts64() instead of getrawmonotonic64()
Date:   Tue, 19 Jun 2018 01:41:00 +0530
Message-Id: <20180618201100.2238-1-ivid.suvarna@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

getrawmonotonic64() is deprecated. This follows Arnd Bergmann's patch[1]
for replacing deprecated functions.

[1] https://patchwork.kernel.org/patch/10472141/

Signed-off-by: Ivid Suvarna <ivid.suvarna@gmail.com>
---
 kernel/time/posix-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index e08ce3f27447..2f50ac8c258f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -228,7 +228,7 @@ static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
  */
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
-	getrawmonotonic64(tp);
+	ktime_get_raw_ts64(tp);
 	return 0;
 }
 
