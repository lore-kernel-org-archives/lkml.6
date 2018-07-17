Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE73ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC40206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q41zp5V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC40206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeGQVj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37126 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so969761pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MeVy67ewCmPR1Q82p7qaXQR9E6CkKHJQQufRfm4M3Yc=;
        b=q41zp5V69L9X2JN/8zUd/UOOfQX0Twv0VNlcmGH7ZuEmyKpWI9gcirWXLOqUVJQoX0
         N4pA1y73SP+vbH4Y+SykfjhTH/JKDGB2PBg9W6SqG36YtF+TcA21UsIEDFh6euhgX3aN
         6UqI3eqDoCQfLy6bJM9TtZMvyKLFika58/9a12m/41w+cYE3h5NZybxQ9TY7apzS8TsM
         ur61sZbFtKBn8KSWr3h5mFjZ93m8I2WokiOHfgQuDrbTsO3EeViZ8CEoaNp7mPeKoQSM
         8Vv4KfvuBQ3YsA7qJvDBTIsDNioOXz2gYq1s8oX7U62Am3VEijaMvQgfjnRdoAGu0YGa
         9vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MeVy67ewCmPR1Q82p7qaXQR9E6CkKHJQQufRfm4M3Yc=;
        b=a6/3tbyr1T2b+e7UYdHNnYdm2zPvPDvuTdF9qPI9Q7EAVphEeDMP3IWoJVzkwYnA+d
         GV4X4iI74tYXSyz6rpwgca3er8S/Am1bASb1yaFgksUD0cgw+Tihgm8m9vCu/jZTYQAO
         whAj8h1xEeqmJKY3Pp9Pu+0NVwfptiOpL9I41a+i5DJoLHMDA4hpCATLb8dExauuyNdZ
         U0Lf9Z9J8c7209ESc5s4ny/BzZG26ijRSNBvxlCUzgyHMk1QISSoY5HR4MGlMnh7Om40
         ncjaA5jWJTcxKiUEPTw/zfVcZ268tr7vJhTLQbJ049wu9VvVnU2I9dn8oos9j7maV0vQ
         Oh0g==
X-Gm-Message-State: AOUpUlHCvP6wQdQW3M+Rr40RHoVX4hX/ij7MhJ50dDAmQaSWk8RXdhFb
        FhK4uwRPI1E9Fuc3VZ3Nbzg=
X-Google-Smtp-Source: AAOMgpd0jmpCdMHcj1TdcQUNVoIEJHaZ1Zb0bzvGDnPBkZwBtsqIGXBSUZysu+m7v2qkaEA4ftUC+Q==
X-Received: by 2002:a62:3ece:: with SMTP id y75-v6mr2308847pfj.7.1531861501635;
        Tue, 17 Jul 2018 14:05:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:00 -0700 (PDT)
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
Subject: [PATCH 14/32] staging: gasket: bail out of reset sequence on device callback error
Date:   Tue, 17 Jul 2018 13:56:54 -0700
Message-Id: <20180717205712.29495-15-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

If device reset callback returns an error, error out at the gasket
level.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 94e64b900380d..bc3662eafb63d 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1875,9 +1875,11 @@ int gasket_reset_nolock(struct gasket_dev *gasket_dev, uint reset_type)
 
 	/* Perform a device reset of the requested type. */
 	ret = driver_desc->device_reset_cb(gasket_dev, reset_type);
-	if (ret)
+	if (ret) {
 		gasket_log_error(
 			gasket_dev, "Device reset cb returned %d.", ret);
+		return ret;
+	}
 
 	/* Reinitialize the page tables and interrupt framework. */
 	for (i = 0; i < driver_desc->num_page_tables; ++i)
-- 
2.18.0.203.gfac676dfb9-goog

