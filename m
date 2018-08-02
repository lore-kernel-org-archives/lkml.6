Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F4CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD8C20C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnJrNNSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD8C20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbeHBKdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:33:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40867 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:33:09 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so702223plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 01:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUnuDDueTgiCgEkUdn+VaGhRVxHZEPmAdaM8/YbeFIw=;
        b=BnJrNNSE8gK7I6mUgDyLCZXWxPavTT35IaF619TkDDsgjoQ/OJz6O8agKxTolmZqIM
         UY+eUbj7bOLSzEUr7WOS47xlIafxIGE1BOxkYVOTnpCWYF3D7dfRJUcSzDB73ZUkvjKJ
         AT7JPkQMrXmt99aLmb+jttjq7NBAHyGP+9huMnjZH1ziCCniE9kZpsxQyYMTe/1ZwWjW
         d79t6vSjTNiRWCShaZQbAGrziHvooGrDPfKpkg3xsdMqokPQylV5QQaudy8jeibcUu1O
         W+56dv4tNCJeNxFpCDdr8R01EnCtmPoI1IxCuQYttKCiEVOGI+IC9kA9RrUDlHlor5KC
         wy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUnuDDueTgiCgEkUdn+VaGhRVxHZEPmAdaM8/YbeFIw=;
        b=TgwQkUwRsFAp2CcJqRj/rkkB5ebfxPfavVAsEKGO5VDQKfaEbBQvIXxJkm+zP6W0Dc
         /8l/N0m64xmhY0ciDkGLQMB7QP9Mo+mH0p20oWnZCt4kxGcctBsuVfWrhc2vepiOGtCP
         qCpYiw9uslYR/j2CHn0inFF3hdcMCsqtmLXISi/Zox/FgIEQqpqMmbBhH3+caXKpyw8p
         8ZPk4mchhylc98kAsgzPtEOoB04oSdkayR8FTEAF20F3+BKd9eOTNUOAF6SEALUxXjaq
         gM71+ubz7WSS7hq1I1TyZp88rdkYMuyOcwxZY/hm5WjHTVHvnX2D8/7hLKu48FvGl+k8
         ylrA==
X-Gm-Message-State: AOUpUlHG9S1tyAYDzlFgCxu8tj81BQYofuzj/loQHB8xwvpuXiCcGI65
        bjlTgt1WIslBm/smi53Xfm0=
X-Google-Smtp-Source: AAOMgpd867C5Gn48gIYIWSfWrPp2D9Rrpy1ehrt0d8mffbK4EJxLtXhxrxKlYAhoSHs7kKA42s3KrA==
X-Received: by 2002:a17:902:780d:: with SMTP id p13-v6mr1526788pll.119.1533199381846;
        Thu, 02 Aug 2018 01:43:01 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2128397pfl.156.2018.08.02.01.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:43:01 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Todd Poynor <toddpoynor@google.com>,
        Marty Faltesek <mfaltesek@google.com>
Subject: [PATCH 1/8] staging: gasket: apex: enable power save mode by default
Date:   Thu,  2 Aug 2018 01:42:38 -0700
Message-Id: <20180802084245.239689-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180802084245.239689-1-toddpoynor@gmail.com>
References: <20180802084245.239689-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Set default value of allow_power_save parameter to enable power save
mode, which is expected to be the state usually desired.

Signed-off-by: Marty Faltesek <mfaltesek@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index dfbff47b46086..7fd0dd609d037 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -233,7 +233,7 @@ static struct gasket_interrupt_desc apex_interrupts[] = {
 
 
 /* Allows device to enter power save upon driver close(). */
-static int allow_power_save;
+static int allow_power_save = 1;
 
 /* Allows SW based clock gating. */
 static int allow_sw_clock_gating;
-- 
2.18.0.597.ga71716f1ad-goog

