Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B11ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFE52084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="AR68WDd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFE52084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeGTXBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:01:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbeGTXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:01:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so7906894pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=aHUKqxSNTAflsjSWWuhnAgKuyCboelcgZNLTqVgs9qc=;
        b=AR68WDd3jtfN+Z4pi8cQ1BQnmxp1ZhuEZPXURIe3BTr9vpvOS8VRecoBpOkLjbYfw2
         4n5/ElDuDAD5cauBBflTYg3xkQKOzGT/ec1zasTJepBJKmFBKa0rOKIZT16oKFbQP2a7
         GCq76U9bdgVShWWJi1Qb+x03jp1PiMY2EEZ+XqSxMNa3fxiWYfr3QBPZ9yaced6IhPHQ
         Uixn5l/qaVyjr+8pO9JPkFs5ho9YcaO4+yc66nCkZ7UV1CocxPHRp/LnJcrMssSqLG5F
         T8XygIT/9RaihlcKm9ifFqisq7RqE+Hj6z76ElxYCP4BRL+N7qh4yw0jtlMwHVYynhBb
         6gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=aHUKqxSNTAflsjSWWuhnAgKuyCboelcgZNLTqVgs9qc=;
        b=TIvvxUufYfjcIq3sGF4eIu3YcRIwxubpRJs8prNi/z6o4JhF0G+qjErafz8uIlwxUz
         RzQWufQXAvBTHvo0PMjI/j9UHYtp5A0U2SZIrTlFvNhMUx7rcJWFCGS7uJ9JzrohAuGP
         zVIrbEP4rRlY5Y03czUFB8t+D27wPPWTFoTvi6V+FzsavwI1OdLBa34UZIq2DY525IPo
         cwVbE8MW1QrKbMiIambbzCp8xh+3yRyRZ50rmaYoyv0SdkQzQkvvxwuZNfpdaPG6Mr9h
         05XTjn4eytp2V0xZM9C8pEnZLel9h1xA/iI4YKf2n3zk6kWUzH5tlhmLhAkprNpFahVX
         ZJhQ==
X-Gm-Message-State: AOUpUlHmgud6swpQSYGb5xebD1OmO1dqq+3JAPeh995cZ3Iz38xiJMm3
        qG72DELVSZpSGhq9Lt1hQ3gQxg==
X-Google-Smtp-Source: AAOMgpdB5MfMaITZ/ilO1AcyAIpb0JJTn+1At+X20wQYkR1iQfZtusxJrlK5pW16QXpRJmYdfvDZKw==
X-Received: by 2002:a63:788b:: with SMTP id t133-v6mr3576897pgc.329.1532124688389;
        Fri, 20 Jul 2018 15:11:28 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r64-v6sm6154742pfk.157.2018.07.20.15.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 15:11:28 -0700 (PDT)
Date:   Fri, 20 Jul 2018 15:11:26 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] uio: add SPDX license tag
Message-ID: <20180720151126.5e62a2ec@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace short statement in comment with proper SPDX
license tag.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/uio/uio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 5d421d7e8904..f63967c8e95a 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/uio/uio.c
  *
@@ -9,8 +10,6 @@
  * Userspace IO
  *
  * Base Functions
- *
- * Licensed under the GPLv2 only.
  */
 
 #include <linux/module.h>
-- 
2.18.0

