Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1BE20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlqOhAcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1BE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeGUO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36395 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeGUO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so5632269pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E+xqQH42AHWVqN+bkEZOAkIfwyNU3aQ8/q5uyepghOU=;
        b=FlqOhAcVv9Mk8JEZ93ewGGpkziIByd6e5eJBDPkMqRG6rkVCjXb52i4EQhXSZfEfSb
         YMap+lDZw2Qm+DAobWoXNo/Hdiftk5BrQYTG+ylNthmifNhfueqpfjNqV1hoMBgN5v/B
         0mFACpdN0ltdTKkjX9W/w1yLnBprdLeeGMxNxOSGPoulKndGLouZnoiNfdbWwr3Zib8/
         7zTNULx6YWPyfsWXHJc1A9Fs/en5tqfqUkRDRrLeUA9cszOoO/d6jfsyfTRZevSbctSn
         10rl4Xi4yAW4xC1eOZHUXfK36y4kZPX3i7Hl6W5v1Wn2AUqdWIxh+XhAP75xqCVP8NPB
         A8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E+xqQH42AHWVqN+bkEZOAkIfwyNU3aQ8/q5uyepghOU=;
        b=ZpI1YjbfQDzBsJ3X5JSIa+3HSKyAHfuO9OIF72Vssa9cyjFmo4V4i07Pq1dlGsaV28
         vNz5UAF/eWiz3141w0OtOVLHevfQfxV5S7+fzsC3VPcyNW3a29F7FQhWgi8pe7hMrDbZ
         CB+pNLEYH5V+UIB1ATTShCzzG8r4vOucKMuE5S5RxvHeXhqCN/YPw8vyIPiRXT9xWPB4
         nNKkPm0olWMYQDgCCkImeHJcRBADleqVXs6brijDGx2S7BLC51JA+s+uZADmbgQpI2Ag
         30+FQ/hNswOuHQItt3QFt3UqFMtQKfExbxwuPC/gKSNHm9E9/etafo+2vuk1jCl3YoIc
         T2DQ==
X-Gm-Message-State: AOUpUlH3YC+8TZiBULoC0iLV9hJYY/k5SPQZ3ClF4+Xq6RXD8Z9c21nF
        WSJzlpzK2EKXniaNkwt2fP0=
X-Google-Smtp-Source: AAOMgpfQWdI8tk2AXG0RyjmVSPLRB9pUGKgf1Ix8qlPVihd4FSeyiGgYoIb16E3aYo4SLQ8udw/2rg==
X-Received: by 2002:a65:520d:: with SMTP id o13-v6mr5593696pgp.282.1532180120712;
        Sat, 21 Jul 2018 06:35:20 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:20 -0700 (PDT)
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
Subject: [PATCH 01/14] staging: gasket: fix check_and_invoke_callback log param
Date:   Sat, 21 Jul 2018 06:34:54 -0700
Message-Id: <20180721133507.95599-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

The message should be passed the callback function pointer, not
the pointer to the gasket device.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 40e46ca5228c8..2cd232230845c 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -205,7 +205,7 @@ static inline int check_and_invoke_callback(
 {
 	int ret = 0;
 
-	gasket_nodev_error("check_and_invoke_callback %p", gasket_dev);
+	gasket_nodev_error("check_and_invoke_callback %p", cb_function);
 	if (cb_function) {
 		mutex_lock(&gasket_dev->mutex);
 		ret = cb_function(gasket_dev);
-- 
2.18.0.233.g985f88cf7e-goog

