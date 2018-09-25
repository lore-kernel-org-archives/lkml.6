Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14781C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D0A2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=sehro.org header.i=@sehro.org header.b="POUSTK5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D0A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sehro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeIYWBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:01:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38260 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbeIYWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:01:31 -0400
Received: by mail-it1-f196.google.com with SMTP id p129-v6so15902316ite.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sehro.org; s=dotorg;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sbxkMpjchUlRGs3zqPIV0ZJBQawFnNjB4O0ZY37hDkE=;
        b=POUSTK5cy97P6bFUObD7z/n/J9SqOb6hK9dg3XQfGX6pSD6sJD2NUhYbk8QF7Bt3Un
         5+fSepz/3XwIEzwlNmmXIfqHuMeUQQzB4fltgmZ09EwUs+QukefqBo784J2JMfhltLfZ
         n5W84Q+2YIzNHYVohR5NzgQGGIbf8gwqodlMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sbxkMpjchUlRGs3zqPIV0ZJBQawFnNjB4O0ZY37hDkE=;
        b=OmoCq3MVi/deFXdldTW+MFjNlPUxMkf3irs4jBgeQwiY2DVz3wHYyamaV6rtcaq2H6
         1iPwsLU2GP8QGBf6QoC/bCabXhmw6kQS1n+Z8CpHMPI6XXqTXodpkd5L6cQGNXMu1HEc
         iMgbm/RNPuYR7vN5/zGx4MFK/iD6DDtD/0jJBokF5rp87cuVGHbvozqIDxpocwsA/rpx
         m+z8KZij5w/27sOh/eBf3H7Pn1782IGtuYiuz2KvcEQxWUxR6QauzUQn5aRUEf3skjZO
         UTfaGD2YSIRla2ynPoRlccC7xGRtU4CmfEtifa0R1Haa7Kk7x8zMGPybLy5enF4GEeRP
         XgMg==
X-Gm-Message-State: ABuFfoikITNR1nHktP6ScysqAL6KXPOewi1boVQeX6e4skm4hj1OuhBH
        NJ9LW+EiNTXDuv/KeaZj05Wt3Q==
X-Google-Smtp-Source: ACcGV63J+kfYITWQGR9L1sQMFNDjFl7AIwMAJ428gzvd0buENNwXiy3cOUskSpt5Vkue68VXUwP2yw==
X-Received: by 2002:a24:141:: with SMTP id 62-v6mr1308232itk.97.1537890803785;
        Tue, 25 Sep 2018 08:53:23 -0700 (PDT)
Received: from goro.horizons.sehro.org ([2601:280:4400:56c:731e:1a85:7df8:2d5b])
        by smtp.gmail.com with ESMTPSA id i2-v6sm847206ioh.80.2018.09.25.08.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 08:53:22 -0700 (PDT)
From:   sehro rautenkranz <sehro@sehro.org>
Cc:     sehro@sehro.org, Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: dgnc: Fix Kconfig help header and text
Date:   Tue, 25 Sep 2018 09:53:09 -0600
Message-Id: <20180925155309.15861-1-sehro@sehro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <d5bb4ab0-42f6-3fd1-006d-670a355e8702@infradead.org>
References: <d5bb4ab0-42f6-3fd1-006d-670a355e8702@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace Kconfig help header and text to match other modules. Issue found
my checkpatch.

Spacing adjusted to match Documentation/process/coding-style.rst. Issue
reported by rdunlap@infradead.org.

Signed-off-by: sehro rautenkranz <sehro@sehro.org>
---
 drivers/staging/dgnc/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/dgnc/Kconfig b/drivers/staging/dgnc/Kconfig
index c845b357b53d..7361d6cd73d4 100644
--- a/drivers/staging/dgnc/Kconfig
+++ b/drivers/staging/dgnc/Kconfig
@@ -3,8 +3,8 @@ config DGNC
        default n
        depends on TTY && PCI
        help
-            Say Y here to enable support for the Digi International Neo and
-            Classic PCI based product line.
+                 Say Y here to enable support for the Digi International Neo and
+                 Classic PCI based product line.
 
-            To compile this driver as a module, say M here: the module will be
-            called dgnc
+                 To compile this driver as a module, say M here: the module will be
+                 called dgnc
-- 
2.19.0

