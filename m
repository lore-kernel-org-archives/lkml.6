Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE40C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB72320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="K5I7KxLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfBVUch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:32:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfBVUch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:32:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id y15so1931046qki.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvvzSc4t3o2R7pWzEPHRmrdi9rCvNLjs4c+WRCjXEjk=;
        b=K5I7KxLbqnE4yuHfARvYND3aunWyNYwasdaRypPqIr385aRTMXK1C/ZCCXCM3bvdzy
         binp6R+CHO5mbsL5tU/KKR64lwwLer2djStLZN9i5gsqqt3imxWoXxxR9Svex2fIHMs9
         V6pHznAvm1yBZx6iSe7rUPBRFiVuA+uXfR2Vj/v097QwvO5XXtcHhTj4pP8gDn7rR0AF
         dfiH7yK0RG8670+4NM/vIln+XS9pfYRkhgf7QHxb/OLkeLH88cDnCJYnB64S9DD1iUOD
         oi/3xsjloBXMLFGMWQJ7EqcILqWOZGY9T2z6si1dReBOaCzA6kc6frJ3gx4QV79w//pT
         xLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvvzSc4t3o2R7pWzEPHRmrdi9rCvNLjs4c+WRCjXEjk=;
        b=o9o5U5/NDFd1VApRxe6UVOdcHPcpfusIs5cBx7PiVWwTsxmSE3SP8719Lr6KdHy3Hl
         /W9wfWsiK3rjEtWVQPaqciV9Nah4GH85tIKPQwHdshXsVuAMH47mqIgvk5jO+lfNCoeP
         C1kSBZOgRC9TW91HKEe/9s4OSTgWEHqEz4Qge7KD6gFKb8So48KXX6SO6uhV1LdKCizH
         8yujXXwKZEaCzhty3uVU4HMvXB5Q59z3Z1qk6qJQHpcPHlok5+oE9kGFPcVMHZqCTcEF
         U7MQwou7c6yTRMBghiSZL2IHd/JMLvgjJgTxJR0ZCo5H9R78+oUkNMAJpKvYwQhpFhUE
         ZQlA==
X-Gm-Message-State: AHQUAublGmHR0tXdOsxKHZYAj3jrR6WXQMq8N0Q9tEonW6jO9qU5d8nF
        +1PyYzdvnR2OUZ9dDHoFyAyzaA==
X-Google-Smtp-Source: AHgI3IbJfkIthHg6+Jg3H0vK4CuDLmwe12wJzP1xpgA1w8GvMa6O/no7rPh/SZ0ugQQyrQMqil5DBA==
X-Received: by 2002:ae9:c119:: with SMTP id z25mr4353813qki.222.1550867556032;
        Fri, 22 Feb 2019 12:32:36 -0800 (PST)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v26sm1449149qtk.22.2019.02.22.12.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:32:35 -0800 (PST)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [PATCH 3/4] iio:adc:ad7923: Put macro argument between ()'s
Date:   Fri, 22 Feb 2019 17:31:58 -0300
Message-Id: <20190222203159.15116-4-barbara.fernandes@usp.br>
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

Put macro argument between parenthesis in order to avoid precedence
issues. Solves the following checkpath.pl's messages:

CHECK: Macro argument 'mode' may be better as '(mode)' to avoid
precedence issues
CHECK: Macro argument 'channel' may be better as '(channel)' to
avoid precedence issues
CHECK: Macro argument reuse 'sequence' - possible side-effects?
CHECK: Macro argument 'sequence' may be better as '(sequence)' to
avoid precedence issues
CHECK: Macro argument 'val' may be better as '(val)' to avoid
precedence issues
CHECK: Macro argument 'dec' may be better as '(dec)' to avoid precedence
issues
CHECK: Macro argument 'bits' may be better as '(bits)' to avoid
precedence issues

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
---
 drivers/iio/adc/ad7923.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index b39ea834cdd6..dbece44e26e4 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -40,16 +40,16 @@
 
 #define AD7923_MAX_CHAN		4
 
-#define AD7923_PM_MODE_WRITE(mode)	(mode << 4)	/* write mode */
-#define AD7923_CHANNEL_WRITE(channel)	(channel << 6)	/* write channel */
-#define AD7923_SEQUENCE_WRITE(sequence)	(((sequence & 1) << 3) \
-					+ ((sequence & 2) << 9))
+#define AD7923_PM_MODE_WRITE(mode)	((mode) << 4)	 /* write mode */
+#define AD7923_CHANNEL_WRITE(channel)	((channel) << 6) /* write channel */
+#define AD7923_SEQUENCE_WRITE(sequence)	((((sequence) & 1) << 3) \
+					+ (((sequence) & 2) << 9))
 						/* write sequence fonction */
 /* left shift for CR : bit 11 transmit in first */
 #define AD7923_SHIFT_REGISTER	4
 
 /* val = value, dec = left shift, bits = number of bits of the mask */
-#define EXTRACT(val, dec, bits)		((val >> dec) & ((1 << bits) - 1))
+#define EXTRACT(val, dec, bits)		(((val) >> (dec)) & ((1 << (bits)) - 1))
 
 struct ad7923_state {
 	struct spi_device		*spi;
-- 
2.17.1

