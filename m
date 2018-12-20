Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A3C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8425A21903
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 23:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM0NuhBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbeLTXrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 18:47:09 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45845 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeLTXrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 18:47:09 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so1401531ywd.12;
        Thu, 20 Dec 2018 15:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iAHArxFfXZYy/6vc0+poju4QM5xfJMtRGvQyj6f2z/4=;
        b=hM0NuhBgF+smrSgNOAadrsErKakj/bzQu0+w2IK+S6NJVew/0FWLlapFX6vwEE7tPP
         aTEgsmUyMBMA6vacoNkb8R2T8Rn/uF/BvUw4dmM6VTkpfSW/AmDVjcsMiu1GMUvgNnEW
         WqLlKP5NV+isarv8btKVpsOy79K4AsN4V5L5kJl5aTwB2F11e5qq1MP5lVQUqVbn5kL3
         7eaFHJ0uSPonQx4wgxHfYwm8d2JWohHWbxWajgOYKw1FI4P6Z/G9f7iucs4bGkUiu1Va
         r1UnTDgIeLK0vq7eFVp/4UmDd8S+YqrAtElwCRL/MBDOu3Sh9pvHV0Wm7eZxRMENT5oM
         6gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iAHArxFfXZYy/6vc0+poju4QM5xfJMtRGvQyj6f2z/4=;
        b=Pc/jQJdajoNYv8tZ0RQkh9vbiZwwQP05ozoL4c47VQ3JrvksWQ/3+ceN1JmzOW5VTd
         AUDwTf/5Om+kb4ZpDm63c7E4Xv+krKQ3j+cjZkwOGyIzvDntmX/DzdRbkkh9Lk0m6CL+
         TDIoGBwa9cUkNGx77qLR30Znnz3gdtKF8jMlr816zbWAKL1h//qAwUqbRD8NrU0Z2MBI
         rUE+vQyTrb9eE6Jn5/poDGsu3j/HtRHqcaUe+m/lMpAhzmMsG5xojs+Qe4TLZfDUm39t
         pgnU4riICgE4knT4wb5pvQ/FL0y40a9L2qqupi54uSzYAl5D6pVt4R9drCsmcO4CQ8Cg
         zLGg==
X-Gm-Message-State: AA+aEWY0usaGb4H0lu6XC6FzmW6LIm2vJ9PBjMi7xkXFs1gOo7fGWXR8
        tessnTbwth26cP8qttcZXs4=
X-Google-Smtp-Source: AFSGD/X91G+p0Y5VSgxoWP2QpuSN9NjAtiKNfle7RA5SdMyXXL6jJbj/09qP+hyAop+9iA0gK45CKA==
X-Received: by 2002:a81:e40d:: with SMTP id r13mr246194ywl.265.1545349628518;
        Thu, 20 Dec 2018 15:47:08 -0800 (PST)
Received: from localhost.localdomain ([67.191.186.148])
        by smtp.googlemail.com with ESMTPSA id u4sm10141576ywu.92.2018.12.20.15.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 15:47:07 -0800 (PST)
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Subject: [PATCH 2/2] Staging: iio: adis16203: fixed a SPDX identifier tag mistake
Date:   Thu, 20 Dec 2018 15:46:53 -0800
Message-Id: <1545349613-4607-1-git-send-email-indigoomega021@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style mistake by adding the SPDX identifier tag to the
first line of the code

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 5cc96c80..4ae5b74 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADIS16203 Programmable 360 Degrees Inclinometer
  *
  * Copyright 2010 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/delay.h>
-- 
2.7.4

