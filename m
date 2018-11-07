Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9637AC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544122086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgmwegnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544122086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeKGJ4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:56:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37098 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387612AbeKGJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:56:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id p35so4868208qtc.4;
        Tue, 06 Nov 2018 16:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8YYIGNZntNxoGN5Qns8fwRv/RDB5XLH6GJobywbQwI=;
        b=pgmwegnXflxKviK1N9cTakgSHqq/eMx2+zN9ZBytnuJFZwT3rTpBwnjPDdq9ZXDocR
         G22I00RGMgWgT0xxdNWfFSHM2JRuJEwWV+NhIWDg0ke/sIWKsx1ci9ThaSfGTWT8zFz5
         TMaMEHS7qDzB/dkicX81zsvUmoayZ6H1ohqbkaOBMtBLhDCVhKbneuElLsuCxqx92hgN
         CEDftmYBo02p3msJ4RyHLoKj+df/Vr/RwI18zykBR6IRuxfa6AJtkNXDDbQWSITETTaJ
         j3GMFwIsUlx0XlwlblEeTsoHIzh/Y4c+Smhfu9/XyTLyLVkCPBZmHv0XKdveHE8bK/ST
         YYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8YYIGNZntNxoGN5Qns8fwRv/RDB5XLH6GJobywbQwI=;
        b=dAVlGdONFGrDhviNTSYwAZl2FfFHplGDyiUr1a8o8jV3bom5yMDr1SlS2AvVAkz2Di
         GsxPgU6Cdw6HOUvi7Ez0wMoctWtZIDrvRb1phFKwB9Qe8bSdbWFptMi6KLQZu3UYltNh
         psZBePJI27KSbDmNQAgHs9sEqVWUPvzRxoo4OsSggJWfFlPO8NUWEtElwC1r+J/qFGyO
         AbIGxDcmFl6mlSX7bjNadJ5TAH4D6irvf5/eNODiJkzjWlnonjOVFmP7MX3fz1tYJdos
         j7xYLFI1NBv74vZQfmVghXFET3oB0ak/tGrJ0pVqSUhaKbPATs7SUZNGvQ7/92VNf56y
         mIDg==
X-Gm-Message-State: AGRZ1gJYfWeiqw4cSMW1hQIWWMVqxRrx0aSIWu/p3veAyhhs2jpf0Mpw
        yLPmWczHooPueiT6Q9Jm12g=
X-Google-Smtp-Source: AJdET5dpCvr2MZ3fzdNIrqG7zudN7is5CzPLlsh9qeaRWre0j6RdWMYoz7njiEZnAVFBcQWrr4YsoQ==
X-Received: by 2002:aed:33a3:: with SMTP id v32mr3828415qtd.267.1541550498895;
        Tue, 06 Nov 2018 16:28:18 -0800 (PST)
Received: from debian-lais.ic.unicamp.br (wifi-177-220-85-225.wifi.ic.unicamp.br. [177.220.85.225])
        by smtp.googlemail.com with ESMTPSA id p3sm12462363qkp.48.2018.11.06.16.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:28:18 -0800 (PST)
From:   =?UTF-8?q?La=C3=ADs=20Pessine=20do=20Carmo?= <laispc19@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: sm750fb: Add spaces around '+'
Date:   Tue,  6 Nov 2018 22:28:04 -0200
Message-Id: <20181107002804.25345-1-laispc19@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+' to correct the following checkpath.pl warnings:

WARNING: line over 80 characters
+                       write_dpPort(accel, *(unsigned int *)(pSrcbuf +
(j * 4)));

WARNING: line over 80 characters
+                       memcpy(ajRemain, pSrcbuf+ul4BytesPerScan,
ulBytesRemain);

Signed-off-by: Laís Pessine do Carmo <laispc19@gmail.com>

---

Hi, I am new to Linux community and I am sending this patch to learn
about the kernel development.
Please, let me know if there is anything I can improve.
Thank you!
---
 drivers/staging/sm750fb/sm750_accel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 1035e91e7cd3..eed840b251da 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -383,7 +383,8 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
 
 		if (ulBytesRemain) {
-			memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
+			memcpy(ajRemain, pSrcbuf + ul4BytesPerScan,
+			       ulBytesRemain);
 			write_dpPort(accel, *(unsigned int *)ajRemain);
 		}
 
-- 
2.11.0

