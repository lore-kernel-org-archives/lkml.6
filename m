Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD38AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FD420645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJhtjcj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfAOPoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:44:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39491 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfAOPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:44:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so1391350pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=cIuxEpWisEjPVqKp+w4O77xsXl6q6AEveTBf7dv44mk=;
        b=CJhtjcj4bBHRn9bqCE5k+WxGTGaV5pGUp3b1VKvRWsbHdpPMbBm1PtQezpnPv3eByY
         bC7wyo9zsw6fBkC2cW3wP6wcc8kdBsqWOiiPy/f88jUe7Dcw/Bo5ZK+J5KTsTEJKL/Rr
         wRZlu8ERUI9qlD3zIEFCGWF4EMSKK/uSjvsGzPghTRmNCYRthPXeiBf9CLVRFZo+ZsJH
         AI7cTV08LD02t1PVAYYoLKPJGAz1/Kef8ppRs9AUVzMjADu7y9SDeHDgDdbstEESJNMR
         FUd8l39jAv8D1/6kD6UfyyuRZcEWWWRAmdiMeYf9HNslfBWhvFfcsQrqOfOJheFC6zve
         lDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=cIuxEpWisEjPVqKp+w4O77xsXl6q6AEveTBf7dv44mk=;
        b=Rsb0f97T/Jf5j/lRlZC5KFD8jJmLjh1SvNuWyzyb1K05nxQrKn+I/f4lIPVP7UE3DU
         NNks+ApGd6I/U2gjLlBKqk+MOkjg+k8TZ+QW5mOIqsALZJpzYHCA0IUQfk/vkafTp3k+
         A2l532026VIyslIV73qwidB6mOGpG0xq/z73kIqp5Aa6Ys1dr/oJAvyW17fJEWCZq5xQ
         +i7FCs/9fHKkHZbAnkg7pW6BKx+15ndwEq5PWN+rvWPlCKJuxY9cU7eGFzcBjp7RhmeW
         No1DvPKBYNzbrsMb0O70AGfnzSyI4FEx7a52v265hjb0ML/s3S8mrhNV4APNf0qszAmk
         A4Hw==
X-Gm-Message-State: AJcUukea2FEwV2i20uOOjcHam1t4QqU4mS+eRU+q443Qfku/bIco1D55
        tDLNddrSAy0ag0DS9YMgvqk=
X-Google-Smtp-Source: ALg8bN4PmsjIL7Xcwuqwmq5KYGu2Nr+zvl/1/N4Xq0dmlQCetSEl1wvpZN+eJtMhNu7ABBwt0QZAeg==
X-Received: by 2002:a62:f54f:: with SMTP id n76mr4667444pfh.59.1547567083733;
        Tue, 15 Jan 2019 07:44:43 -0800 (PST)
Received: from localhost.localdomain.com ([203.109.101.34])
        by smtp.googlemail.com with ESMTPSA id 62sm4002742pgc.61.2019.01.15.07.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 07:44:43 -0800 (PST)
From:   Jitendra Khasdev <jkhasdev@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: Removed not necessary braces for single block
Date:   Tue, 15 Jan 2019 21:06:56 +0530
Message-Id: <20190115153656.10913-1-jkhasdev@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to remove not necessary braces for single if block.

Signed-off-by: Jitendra Khasdev <jkhasdev@gmail.com>
---
 drivers/staging/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 5d2fcbfe02af..38980fad8be4 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1605,9 +1605,9 @@ static int do_insn_ioctl(struct comedi_device *dev,
 	unsigned int n_data = MIN_SAMPLES;
 	int ret = 0;
 
-	if (copy_from_user(&insn, arg, sizeof(insn))) {
+	if (copy_from_user(&insn, arg, sizeof(insn)))
 		return -EFAULT;
-	}
+
 
 	n_data = max(n_data, insn.n);
 
-- 
2.13.6

