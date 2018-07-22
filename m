Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B71C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C2E20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C76ibJZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C2E20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbeGVXJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45421 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbeGVXJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id t13-v6so6604888wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qY/BF3lZPoImhLfpXLNdORUIGwHAzkbvuSiehvOE7gg=;
        b=C76ibJZ6SoIY4Jwh9X8qppzfUz0oTgdKd9u7B0ZaZZQs+ltiDy/mBAada10CDsZdwM
         IBbMyQDLALc7VYe5qcCCSPKAEZt0HtWUnC+CYu3w4+hDnqcmSsSkOx7CGjrxUAom1UQ7
         CZXmiTTE4s8IfbkQ+cczebk5hSIxNDXNngjbz3hFWIT8wCk6e/LXUAIGhX1znZf0eoeG
         ZhXqX2vwgSbUChJHdBfWuvTBNeANljCUv+NNmht5wZXJFu1I14hSzh77fIQv4GGVkvt3
         vzLwzMaV5vAbJY+TxfJbCrmm0Gf75IOcwN4rvrb4MgoXIFFT/KwtbP88ZJFdGRdw7kq+
         064Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qY/BF3lZPoImhLfpXLNdORUIGwHAzkbvuSiehvOE7gg=;
        b=edSwDKwZIJhY+mAijGVS8+4HeAxmG4UM2NR+YoTyUu+7vBrLwNgGakW1mUp+cLlWsJ
         MQIlR7q442LXOcCZ/+I891/rbBK+RMmpKNr3uiykg1sEHPmZiNF1DPQwV7YWZC3fbGxm
         WmrFGiKdc9zxnXdBE8G7Zs/gsXIi15QqzuxB3D4Sg9GGNd2gVlY3AQBxq1DpBnba0QCs
         ZktEOo23do6JAb0sEpCk5q+QRlrF8KSl+8hMovS6EjKcYX/gZzfGOGbVW1dXR2i/k0Tj
         BbkO6L1xJFHCxtKPe6mUM9FR0KxkJxxmCtA+MKMDuekGIosfMTsP0ALGZTi92lPktWh7
         xPGA==
X-Gm-Message-State: AOUpUlGz/s6B+DLzy7aU+qmkskPJFCif4bNCKLoYAVZF//fQ2zQcPU9e
        nOoqAa+dz/49ikaxl4Ij1JZcBJ2hDTM=
X-Google-Smtp-Source: AAOMgpdAga/ZdEAH3zrJ5JfcIPzs2ojKpF101ZPVcQSTH4Eq/fxReCNmDNiTDkf3k+/mZ+j3n+sG6Q==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr7071214wrw.209.1532297451713;
        Sun, 22 Jul 2018 15:10:51 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:10:50 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/20] staging:rtl8192u: Remove unused page 9 definitions - Style
Date:   Sun, 22 Jul 2018 23:10:18 +0100
Message-Id: <20180722221035.14453-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused definitions from page 9 section.

These definitions will fail the checkpatch CamelCase test, to save renaming
these unused definitions they have simply been removed. This is a coding
style change which should not impact runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index b8e5fc003a5a..e0c99a953afd 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -41,9 +41,6 @@
 
 /* page 9 */
 #define rFPGA1_RFMOD				0x900  /* RF mode & OFDM TxSC */
-#define rFPGA1_TxBlock				0x904
-#define rFPGA1_DebugSelect			0x908
-#define rFPGA1_TxInfo				0x90c
 
 /* page a */
 #define rCCK0_System				0xa00
-- 
2.18.0

