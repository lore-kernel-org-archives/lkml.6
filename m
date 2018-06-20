Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499D3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0104E20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQeiWrWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0104E20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754012AbeFTKBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:01:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35168 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbeFTKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:01:32 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so1496493plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vTtXx9xvfYNAHzkc+ZWtqRbDljTl+RwzTlpylAuw6TU=;
        b=ZQeiWrWPrU+tI2vS1vUXBZtokxrUeoZVUIWg1VSL5MXy4BjfzAmvMm7N9VGFUScckJ
         zyiaHXXL+mR1St/K1baRFRZnHcMvAEPEpUaA+TNYWi97yZ5HCh5eyQBIFJiaq3MvZzYi
         WNHwjnEx3JApi90gGZGO35aymw2m3w9SsQH7YLdS2Kr1V8Y9l2WjRhkzTewyplerXotf
         9yc8KtgY4NggxQGDyrrF13uDaMSIWWp6JouTvGp5wHHs9rQAXzLZrbLUIDx+nIix+fyU
         K9ooWN45uFE+UQBkwOviEb8ErHBKyYsxPSh4j3ECQMJnUcQej6Z1mSvj1h9XqpKvoYWL
         zSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vTtXx9xvfYNAHzkc+ZWtqRbDljTl+RwzTlpylAuw6TU=;
        b=GPPiSLwMa2G887qP8gSbtYRh4Z9U8n0stCLjYKc8V1CygsaYjalBGCSL+V14Wq/nAM
         tnd96kB7BIlHx+R3fb4CkxMQWpzlDFAQVipOmq0zLoyLNQxwSQx/hmqAjAxLPrk/gqfW
         yAlk3FI3W8pDYG9vXxH0lowzTVdl2/NqnLYLliBxe/vmR3sYcg1PtvqzZkmoaAH8DNrZ
         jveqtSLQ4JXGbXKjzngP48udvzvBc8RQxHmGHXuqobVWJGjTijw7DfL60h7ukbxBRoi9
         bbcAkvGM7i68ratsml1dmjaWZ21OqfPQmbZY9I3nAtJd2NpM23MM1u3eqGw6+waGKea2
         R09w==
X-Gm-Message-State: APt69E1GTuvn49vWXFY9Fg4futulqw14tz9D6dI0y7WMXxelb4uTXdKf
        0T7nd5vaBrYfb9MFghVLAcM=
X-Google-Smtp-Source: ADUXVKJJwTI2HQEOx5RBfc4l85NTedOQH4JBC8HJ6O3r6yNreBkCuRfa4DEv9HfuIaDoeyeEiFBipA==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr23365145pll.186.1529488892288;
        Wed, 20 Jun 2018 03:01:32 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:1:4413:35c0:9e91:c7fc:672])
        by smtp.gmail.com with ESMTPSA id y17-v6sm3174901pfe.33.2018.06.20.03.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 03:01:31 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        jananis37@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Fix a possible sleep-in-atomic-context bug in rtw_disassoc_cmd()
Date:   Wed, 20 Jun 2018 18:01:19 +0800
Message-Id: <20180620100119.8740-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.16.7 are:

[FUNC] kzalloc(GFP_KERNEL)
drivers/staging/rtl8188eu/core/rtw_cmd.c, 502: 
		kzalloc in rtw_disassoc_cmd
drivers/staging/rtl8188eu/core/rtw_ioctl_set.c, 256: 
		rtw_disassoc_cmd in rtw_set_802_11_ssid
drivers/staging/rtl8188eu/core/rtw_ioctl_set.c, 235: 
		spin_lock_bh in rtw_set_802_11_ssid

[FUNC] kzalloc(GFP_KERNEL)
drivers/staging/rtl8188eu/core/rtw_cmd.c, 502: 
		kzalloc in rtw_disassoc_cmd
drivers/staging/rtl8188eu/core/rtw_ioctl_set.c, 352: 
		rtw_disassoc_cmd in rtw_set_802_11_infrastructure_mode
drivers/staging/rtl8188eu/core/rtw_ioctl_set.c, 336: 
		spin_lock_bh in rtw_set_802_11_infrastructure_mode

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool (DSAC-2) and checked by
my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index be8542676adf..f664fc935455 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -499,7 +499,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+%s\n", __func__));
 
 	/* prepare cmd parameter */
-	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	param = kzalloc(sizeof(*param), GFP_ATOMIC);
 	if (!param) {
 		res = _FAIL;
 		goto exit;
-- 
2.17.0

