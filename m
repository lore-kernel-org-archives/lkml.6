Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A74C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4068021473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3IJKOfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbeLQWGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:06:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45736 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeLQWGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:06:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so10656204lfa.12;
        Mon, 17 Dec 2018 14:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MW5cW5OZpC1DDC/FTy5FPQ5EYY6bZ36cj/A6J4kdUxE=;
        b=q3IJKOfC36zGz1QP/b2n0vGPXgdfuAqG7CTt8OP8DyZdb3En2f+6xT7feg8kLhb2i0
         wSXWHv388pP/TW9FPh4ewAw66tMLxbWzK1pTroCNq+CiX2KJxYKO2NvhoAg2Yy0rK+pD
         WwNuQ+gQv8bPyD1SkkTBBC9bUHR68zgUAy8qRDlhkKEHmuXVciTR2ep9fBf7bI5zD0h4
         uKAeaRbS/hlmGnWJcuatgEvk4WFPsE8SzXMyVerp7FMfBg/Z9pkUcf7mVkbzkre91xnx
         l4+uVbsQqj1yMZlxqdl2GXzzTx/dp14gmXPUuVgwr5qPcr0SR2z5ofb/y03jLeztV0Oi
         bszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MW5cW5OZpC1DDC/FTy5FPQ5EYY6bZ36cj/A6J4kdUxE=;
        b=B9krOprPp4cuIKOriDeNOV5mefhPuLwbB5nFaeyIu0oYgXbQl/U8iGJ88WJ/f/D8yZ
         YjnICukxEJHwkmq76s8PqO2oKO3qWpdRlP65p5RGRxZQ7t2Z+a9mCSSXZ5jUYJ/J/m4e
         lo3eKp3+uvYvT70n73w71B7oxXhCW9pfSInTfgSU7/yzMif4vSGwPVdH8k45RLzP5YMs
         L0ttM9HWjqo8SYJsJ7oSMzIuivHaPCOhsTWdaHBrzyvJp3lyS5bkobO+gKl87D+7U2jM
         2DLW6g7/qmVvqZQlNq+ijU5C8vcIh3kdc2IbifOEdf6rb7g1h19IAfwemFaFcnb94AWq
         3RUw==
X-Gm-Message-State: AA+aEWbycBaRRIqREh2zu86VlmPPLyj8M0/PQ/wa65s9T/7J6qohcHrT
        WMlx+WSq/z7Ve4Ajlx52uBQ=
X-Google-Smtp-Source: AFSGD/U7hXlJK/c1LaWsx7S1qIXkiPk30v4nQoNzgHtZH6TnAImZKZkVTlU2eQRhnIHtP7kcnYXjxA==
X-Received: by 2002:a19:c995:: with SMTP id z143mr7099601lff.79.1545084375077;
        Mon, 17 Dec 2018 14:06:15 -0800 (PST)
Received: from localhost.localdomain (ppp79-139-228-252.pppoe.spdop.ru. [79.139.228.252])
        by smtp.gmail.com with ESMTPSA id m13-v6sm2724741ljg.56.2018.12.17.14.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Dec 2018 14:06:14 -0800 (PST)
From:   Sergey Efimochkin <sergeyanton2007@gmail.com>
X-Google-Original-From: Sergey Efimochkin <efimochkin.sv@phystech.edu>
Cc:     dan.carpenter@oracle.com,
        Sergey Efimochkin <efimochkin.sv@phystech.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: adc: ad7280a: fix codestyle in ad7280_event_handler
Date:   Tue, 18 Dec 2018 01:06:01 +0300
Message-Id: <20181217220602.89406-1-efimochkin.sv@phystech.edu>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20181217074540.GC15451@kadam>
References: <20181217074540.GC15451@kadam>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

staging: iio: adc: ad7280a: fix codestyle in ad7280_event_handler
Signed-off-by: Sergey Efimochkin <efimochkin.sv@phystech.edu>
---
Changes in v2:
- changed patch prefix
- changed patch description
- removed incorrect fixes to codestyle
 drivers/staging/iio/adc/ad7280a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..f167ee1b2127 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -725,8 +725,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		} else {
 			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
+					       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 							0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_RISING),
@@ -734,8 +733,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 			else if (((channels[i] >> 11) & 0xFFF) <=
 				st->aux_threshlow)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
+					       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
 							0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_FALLING),
-- 
2.15.1 (Apple Git-101)

