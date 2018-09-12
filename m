Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05DBC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808EF2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPDi63po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808EF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeILUj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:39:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44073 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeILUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:39:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so1184490pff.11;
        Wed, 12 Sep 2018 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zS55LZcFGGPa3btPMbTeGKJbich8oSVruTfBHsyknYg=;
        b=fPDi63poEyjY4j9RbfKjbDvIwp9Cl0ZGChl8E8CMQXYG4lC+BnCcua5K957iqwy/cG
         VmeDPDHZNvZTuLmi64ktu73znQl6at49Rlt0TbLSMwfP7gG7Ktcdi+02eOJtb3jt6pam
         RtgTr55X+EScsPEd5SCAO5wPaDROYyfb1UCLdoR7JvHlI/H44T0HU+Te6gGjRPGrb3+q
         qeMShYSYUi3lETBjfq32oLzB28Lp1fXnymIeUV+FcoHBVUjgFZ2PJknI3QkCnEuB+pRB
         7K/+WHkKPtu7SmB2DtHU/iwHt5X3ncS8rAUV6FybkovOxKd+wUH+S3QeyGd3Ga3XUWaq
         nk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zS55LZcFGGPa3btPMbTeGKJbich8oSVruTfBHsyknYg=;
        b=eAxFCBdKjiRz//yiCgrGkXAE2NflwYb4M1/sX3TM0tuB/cFNp4UBhHU5uOy2XjGMSo
         A9p2HkdX1VvW/JlIFY903GQmGdMAMB57byS88P0+znZNUklOEF2VX037UE7Sf3gX1abB
         AZqSQVtiRMKieSMn8mlJp3fMQ+gZzVXdutOOC22fdAKvugXTASwPu3ZeI/twC9UPhl+z
         UVWHvqho6016VB3Kuf4F0qZL6eKALjF+oYJdRBPzPn2Iw+FkUWvV6TEp+o2UI9jjs5ne
         bdg2lPU1SW5P2YlNQXI+PZ3DVul6OuvpwogSCRT+Gl4uMP7CO7zWseAmm6tE0eA7ym8Y
         hsEw==
X-Gm-Message-State: APzg51B7tr246EEYxQMo8dTlFNmgdeNltuHblMTkvaJZBapn70WNVF7J
        K75nHVSu3zhyRSQ4a1RtUlQ=
X-Google-Smtp-Source: ANB0VdZ2NIcjBdvUPFhy6Oe8J4LigUAfRQM4h4bCnvDvzFUVM+xQn2C0Jjtoy9GG0f526yk83GB5Zw==
X-Received: by 2002:a62:1b41:: with SMTP id b62-v6mr3088945pfb.172.1536766492925;
        Wed, 12 Sep 2018 08:34:52 -0700 (PDT)
Received: from localhost.localdomain ([103.224.155.47])
        by smtp.googlemail.com with ESMTPSA id h69-v6sm4376396pfh.13.2018.09.12.08.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:34:52 -0700 (PDT)
From:   Jagdish Tirumala <t.jag587@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        yamada.masahiro@socionext.com
Cc:     linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagdish Tirumala <t.jag587@gmail.com>
Subject: [PATCH] WATCHDOG: uniphier_wdt.c: Fixed error do not initialise statics to 0
Date:   Wed, 12 Sep 2018 08:33:54 -0700
Message-Id: <20180912153354.4658-1-t.jag587@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed error do not initialise statics to 0
in file drivers/watchdog/uniphier_wdt.c

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/watchdog/uniphier_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
index e20a7a459d69..2c62ad7250fb 100644
--- a/drivers/watchdog/uniphier_wdt.c
+++ b/drivers/watchdog/uniphier_wdt.c
@@ -41,7 +41,7 @@
 #define WDT_PERIOD_MIN			1
 #define WDT_PERIOD_MAX			128
 
-static unsigned int timeout = 0;
+static unsigned int timeout;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
 struct uniphier_wdt_dev {
-- 
2.17.1

