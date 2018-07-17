Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400C7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFA2206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p865+fT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFA2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeGQVj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37124 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so969735pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2qyllyI7aOVIpdaIhLG6KLtNZiRhj1jRgXJKalK9xDA=;
        b=p865+fT7unu1eZIL5RUPa/TOr0Mpm8h6A3yq9PyVZeZjwDFZawPxisD5TrGNzmeR8Z
         hEFvKExpXPeqpAnb9RAC6kpACDUtQFBDVf60urfLChuXHTLbibzNDQoW6u+564YBt0PF
         Gs/NiqXoNguEhXIQUX+M/HXWtQRYrZllP85QzQloYbgByvSFO8PmQS2iIdKd/qfNVHac
         mUlDZaSd93AGYAM69RFo2nNCDn8z9wxTI9ed3waBNK6RbWCVmjHDkrEtdRqmRd3nrwSw
         6teFA7OeiLs+nvHoMwXSYi9CIWyXGzRcQLLAa4ReKM7y+v/UE6MzR4CUmpl8E1gUoHHr
         ABWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2qyllyI7aOVIpdaIhLG6KLtNZiRhj1jRgXJKalK9xDA=;
        b=nWT8vGJogNfZDoAkH1jD46N534iKic1ag/UZnUevrHcy3qLH0S4xVm+tD1UANDERs6
         O0mf9+HxNItNypY7oBmUtt8k6D4IGJnQzl+ytUym3ryOQgSVlDf+MicPvG1LWkebNU9W
         b+WYmUg95Ww2xFKMhSeSufTlOsx7ueXUMLOeJNYcsvmQgstqTKVBkJsQfOdQcavLcaXW
         Vi1sTgzfd5PexJb0zz0prT1h3Ji1xnWmRtYZsgjEg3Ey91QnI2thL18Kkrqi1kS+liSP
         RZ6Jcz9R5Yj5HbRU1DxO3aWzO0MKErG+pF5MApzZUftFk2D10K3tlR9c5Zz3nIOqC2Ms
         APlw==
X-Gm-Message-State: AOUpUlHXFSNcfz7t17dCeq4QO5FnKNjb6PbLRT+agYzpKu2OLFQsXoJ8
        hctxkRfDo6ynfxLY/pQcmPA=
X-Google-Smtp-Source: AAOMgpcLt1qi/+na+6Tb7vSJL0dDrAydmVXchQOF1CYdN7qD+BukVf4XgteEyHdPykFL1z/EEzd0/w==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr3007199pgs.390.1531861500510;
        Tue, 17 Jul 2018 14:05:00 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:59 -0700 (PDT)
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
Subject: [PATCH 13/32] staging: gasket: gasket_wait_with_reschedule use 32 bits of retry count
Date:   Tue, 17 Jul 2018 13:56:53 -0700
Message-Id: <20180717205712.29495-14-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Don't need a 64-bit retry counter.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++--
 drivers/staging/gasket/gasket_core.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 5ae3d44f6166e..94e64b900380d 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2089,9 +2089,9 @@ struct device *gasket_get_device(struct gasket_dev *dev)
  **/
 int gasket_wait_with_reschedule(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 max_retries, u64 delay_ms)
+	uint max_retries, u64 delay_ms)
 {
-	u64 retries = 0;
+	uint retries = 0;
 	u64 tmp;
 
 	while (retries < max_retries) {
diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 94a5537bff2c2..50ad0c8853183 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -702,6 +702,6 @@ struct device *gasket_get_device(struct gasket_dev *dev);
 /* Helper function, Asynchronous waits on a given set of bits. */
 int gasket_wait_with_reschedule(
 	struct gasket_dev *gasket_dev, int bar, u64 offset, u64 mask, u64 val,
-	u64 max_retries, u64 delay_ms);
+	uint max_retries, u64 delay_ms);
 
 #endif /* __GASKET_CORE_H__ */
-- 
2.18.0.203.gfac676dfb9-goog

