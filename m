Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF929C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39820989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="aC2+2W1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeKTXD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:03:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37441 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeKTXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:03:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so2044733wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7XSaCY6+J0zrTmy4G5qtm5Iz3fUqOSQX4R3o25fdbA=;
        b=aC2+2W1GOIisODBa2U5kUaVp//NoI4DPs3YxKl29kd1Ub0Rakd4UZEraqUEDo3Rm3W
         iowycjS1FbBvJdWCmTxxEtg3/oEbuQhy8CRXKWpPU5H1T0Fe657Ht76jJJf/soY3xdEJ
         V5qo+IsvM53TzSX6sPhBEOdkYekfo57T/bbANxcTD9O6w2gi6v8eGE2FuAqjz8cwdWW7
         noMEognHCkQ0GCyeMfXZq2hozRsttKqPXLeKFkSmJMhEUogP/h6awSAx2uBsCvL6syIS
         9MDSZKwHRajczQDS1p0EnQsS6XZL5P5PHsbdiGPpwT4utveTtKGK17ppLRchhlE+AxT6
         LIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7XSaCY6+J0zrTmy4G5qtm5Iz3fUqOSQX4R3o25fdbA=;
        b=sdEF6cIz0U6tyryjyYMHh48uvYJ+cUJLJNIzAexQk2BUzS1SaWigXPkykUYCOxbJ5U
         +NaYjb85fpRZFYzndHYh14E3k+5KPWL5qTKkjhwuM2OJImMliEl8dYuswwC0VNZ3529J
         rnB19+l26FVkWm9wSZPT8OZzNjCI3MI5p/s/EavJV+A6JillDhsGt8xBJ7nXjCQp6GAJ
         CbZ/ZbI4xxeI+inIB+YqbDV1/EJrytum5P+LfowkxOiesPTuyMcwNmdeb1zwKJqOicbj
         Q8RSLRp/VIH7jrlxp5uX9c1aaIEGqVFrDMyFsXiQDLijzZ8B+Y1AxwvBcuo24uWFpj3q
         owWw==
X-Gm-Message-State: AGRZ1gLa2jULXViH4gs60DI4tN7x4HkLRq/tG5slDDES6eZoV1QkkxyG
        uceTte9MKVfyyCvgedtXRMs5pA==
X-Google-Smtp-Source: AFSGD/WihXhBviq3RCiAl6c7hdZgR8P654DApjrDAXqLFbWvKFJdf3OVi2JjpOSbYI9aCs1RfilxPg==
X-Received: by 2002:a1c:81c6:: with SMTP id c189mr1947920wmd.86.1542717270618;
        Tue, 20 Nov 2018 04:34:30 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id v189-v6sm33482685wmd.40.2018.11.20.04.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:34:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 3/5] ARM: davinci: dm355: set the GPIO base to 0
Date:   Tue, 20 Nov 2018 13:31:23 +0100
Message-Id: <20181120123125.24938-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120123125.24938-1-brgl@bgdev.pl>
References: <20181120123125.24938-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the GPIO support on DaVinci boards
in legacy mode by allowing gpiolib to set the GPIO base automatically.

DaVinci board files use the legacy GPIO API with hard-coded GPIO line
numbers. Use the new fields in struct davinci_gpio_platform_data to
manually set the GPIO base to 0.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm355.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9f7d38d12c88..73f2f70ce729 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -554,6 +554,8 @@ static struct resource dm355_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm355_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 104,
 };
 
-- 
2.19.1

