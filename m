Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9CC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF56C20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="VHQlxExO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBVUcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:32:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40488 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVUcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:32:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so4021086qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kw6AUIg4Ejwdusxaso+DCJFNAKWhgIjCRtvWWiMb+yg=;
        b=VHQlxExO7J8BmmpDL1RchzVfDQ0q+Hkk9BkcuF2CzdURTzmxQsi1IWux5ePeQZEfrv
         bi4b4oS6ag0inLRgiGJOsl8Gc8qaW+8DuT44nkFytA8x2nhXgSfdHWTyvWEiRiqrhDA5
         1WI3GYz6CYHmNNuwVapiDFoZtGPAWfD2jMXKYHIYWWh9x0f6K0RZN0zHGgcg9M61MOlY
         x1vNx+b1phjpvslWvDwgUIRcwtA8L7NshL4cNbp5FU+kJmQqLqW9S+2PMBvkFQuUrTpb
         bV8nvKriVF4BiUkA3cSlNv1P9x8JOnWqtxL/rlEKmSW8axz8tHn0Fo0CKuQmUSWIPNAA
         ld2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kw6AUIg4Ejwdusxaso+DCJFNAKWhgIjCRtvWWiMb+yg=;
        b=Yc4xkxV6biK1fabMqtvUl6iLvFRsHSPVeyuTCSSHsZicepRC/K2k+r5nBKuTgCqNA3
         90YAZrifV7v6dp4cK+DHmbF6w1yTtzt1r6kigtwNbtKxHwgTGagznPYNEvjE/D27LdEN
         J5T5DX3IPMyubuji29SaGSKIjj/eNt90jwE7CaBKf01W8o1vBuLuBqvhqIZikhgPd63Y
         UdxiYs/nCECGPzoA61ekwJutE7kz9an1nNG35GACQ1LMswGpOAq1/2cndrZk8BOOhMem
         ce+PJBiFYdQug16UP5HnX81m96hiejZu2olqIoBvr+QME5qbG6CAT7Cb7uXj/xNbtKPG
         fZGA==
X-Gm-Message-State: AHQUAubUYGZyj98JjmoZuL6Ba6UAtL50WJFDJe6nWSjIvMGhjHiEU4e3
        6xfV0BpAhMKA0cL4NPTtl/ga3w==
X-Google-Smtp-Source: AHgI3IawQWj/G3jwOl3NvvNLrncK/FPR5vFIis0K7ZRv9VYT0RlFmBvcRL9YAUl7KCpVJ8xEEmWzIw==
X-Received: by 2002:ac8:fb0:: with SMTP id b45mr4791487qtk.146.1550867549709;
        Fri, 22 Feb 2019 12:32:29 -0800 (PST)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v26sm1449149qtk.22.2019.02.22.12.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:32:29 -0800 (PST)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [PATCH 2/4] iio:adc:ad7923: Use BIT macro instead of bitshift
Date:   Fri, 22 Feb 2019 17:31:57 -0300
Message-Id: <20190222203159.15116-3-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222203159.15116-1-barbara.fernandes@usp.br>
References: <20190222203159.15116-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace use of the operation '<<' by the BIT macro. Solves checkpath.pl's
message:

CHECK: Prefer using the BIT macro

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
---
 drivers/iio/adc/ad7923.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index ebae7522710a..b39ea834cdd6 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -24,9 +24,9 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define AD7923_WRITE_CR		(1 << 11)	/* write control register */
-#define AD7923_RANGE		(1 << 1)	/* range to REFin */
-#define AD7923_CODING		(1 << 0)	/* coding is straight binary */
+#define AD7923_WRITE_CR		BIT(11)		/* write control register */
+#define AD7923_RANGE		BIT(1)		/* range to REFin */
+#define AD7923_CODING		BIT(0)		/* coding is straight binary */
 #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
 #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
 #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
-- 
2.17.1

