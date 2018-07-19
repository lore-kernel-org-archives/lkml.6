Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C34ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2822084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="oOSh0bMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2822084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGSW2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:28:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42765 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbeGSW2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:28:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4-v6so8156071edp.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=j9/NgnJurYhC8x1tbKIpTDEsFlweodzOak91LVYg41k=;
        b=oOSh0bMMky4d/3crJFIpZpHLljJ0P46SYQ+3dcTYkmOumiRnd+mG7O9K9rB0vr6PIu
         Jax6SjlwdO8V89l5mevdpywdv2eNFvbyeKoi3Sukbth3HMO/Ygkg4VXUJlsxuZAqYb13
         aqHOBRlvmmBPuY8cmiBOxlo8xWMH0x+1klJv0lKLMSwtEPhi4NCKSU8XQw2GhJCMw1uP
         3tSFTDTZzhyFsd8AvykYV7qQQuTC/Wl4GEU3Aa1ZXJqxS6tFuedpkNqWUsNkwzQLwDyg
         V76a1QdWzF30etvvzYkU1NdEktNX0Nby05leb3l28ux65GOenYQEq3C6JMx65sje6rv2
         N39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j9/NgnJurYhC8x1tbKIpTDEsFlweodzOak91LVYg41k=;
        b=MaVx0FQxXrsYOxVLdXnUA9SoY2wuVS+1s2myHGqlBFxSizRzkNVD4UcZt+fA9m1QyU
         YaSkaA9/ICAuWdvsJSKU2xldjBq5tFJkp+jkS8bRup4kFQJBKF6EutM4Nxn1CHtGdOEB
         r7XbCcYJSZxp5N89JdoGdbkymjGwHzikNixAyB/cSdUyYvDaCWJRVthD35UYL5ZKo2ze
         Vz97W6MqS0AbvNmEPeGaxvLNpJEPkRSFMsqsNSW8x3V4+mlLQVH512j9guRuFnKYY8Dk
         216/vp1Begh05E4+Q+ze15KobL7o2bc9odDhd8eZw45hiQ/nIJR5t51odUHix8Xz/k0L
         QmHQ==
X-Gm-Message-State: AOUpUlG9f2wf3Z/UmRq6MoSTL4kJ3w48AiNQGxnNZ/gTmxwtnyP3jlAQ
        pNUjLKf+Uq2Oi9+amPX8R/xwFGZoCgLIheI/BzQ=
X-Google-Smtp-Source: AAOMgpfuzAtCUdpZpr2/WnR7EC7Jgl5lycHEyvvIesHxp+bEWAKzH06rtSARxfL05zWWzDg5jpDSwQ==
X-Received: by 2002:aa7:db09:: with SMTP id t9-v6mr12219130eds.277.1532036611481;
        Thu, 19 Jul 2018 14:43:31 -0700 (PDT)
Received: from localhost.localdomain ([109.255.141.80])
        by smtp.gmail.com with ESMTPSA id o34-v6sm364867edd.58.2018.07.19.14.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 14:43:30 -0700 (PDT)
From:   Mark Railton <mark@markrailton.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Mark Railton <mark@markrailton.com>
Subject: [PATCH] Staging: pi433: rf69: fixed a multi line comment issue
Date:   Thu, 19 Jul 2018 22:43:18 +0100
Message-Id: <20180719214318.388-1-mark@markrailton.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Mark Railton <mark@markrailton.com>
---
 drivers/staging/pi433/rf69.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 90280e9b006d..14826fb505dd 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -618,7 +618,8 @@ bool rf69_get_flag(struct spi_device *spi, enum flag flag)
 	case fifo_full:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_FULL);
 /*	case fifo_not_empty:
- *		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY); */
+ *		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY);
+ */
 	case fifo_empty:
 		return !(rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY);
 	case fifo_level_below_threshold:
-- 
2.17.1

