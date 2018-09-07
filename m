Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E79C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E7B2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="h2xxGVZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E7B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbeIGKla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:41:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41505 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbeIGKla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:41:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so13660386wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=yRl6O8mdS6Rtdeo6LPSg3ZAaXExdHmlA49U0m5uKiyU=;
        b=h2xxGVZuThGzxvhn30t9E17Bl962UYpfWkFWJz4vetHUISJE6uvB8+y0wEhI3HB5UO
         9WMJLh9W3iMOae6rvqaY7BvVif/u86Rb6XzX4RL27hgw5p6XBnCkJ+yjJgCTgDjuCPii
         we4F7bSF/SG5yeCf1orCrPXriI1txviMTOPlTAM7dlkR5uecN2S6zQaHOj5dTz5ZLO7Y
         F50WSxsn32Ww/dhpQFeIuQ++Ycd7I/yneol0u9bt0DhsEart8GeJa/l2PlAbrXtvtQw9
         wanjYF52k1xUPr4/ix4VqGmy0fNwqqhw1bdDfoP1vOJlxOCsq/Fkl3MWHujY/fWiHPbn
         IO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=yRl6O8mdS6Rtdeo6LPSg3ZAaXExdHmlA49U0m5uKiyU=;
        b=gn5MVdN8U9zMoABpFNewC9JiRDmv5w/O3tsgGa8ZIQKLscnkZZmoMC2dcM5paD15hs
         gSxkWtx/NENUxRYJsCTJgQ77kTfg6EhXf7cIHQakdz+xjDRzhrJDfZXA7TnABKoiLbmL
         jySbJfaHEV71g4qAutwcIl6rygcdLqE5HrY9IWmnyMh3alGhWA2PSklUYgtS2Mu4NBLy
         f/5dFMgDY6U/ibPXZ6Z8Zniq/SEl95CpHMMgHnQb51JCQ9Jk92wwtbtO9DqVRMQ+Ety2
         1KHjQcWMnPjFoOdXf162DpMZlzn9XxTssprF8hFzKgtM+9mQzRtEr+bUYw+XW8NY7gZL
         rlbg==
X-Gm-Message-State: APzg51DsEDqoVzPcFP4abddDsDTKZ4j4j5vfEOb9bAmob4ST56u5eThU
        XkPGeXePd8now6IgXSBt738vJ76I0e9TyA==
X-Google-Smtp-Source: ANB0VdbMWG6D2cz+R8KB6dO++p8BDjFCc3Nd/4DVpRMbr9KG4azVhjC0jIzgJ0UqxWyjyYL0P++96A==
X-Received: by 2002:adf:e8c1:: with SMTP id k1-v6mr4669911wrn.43.1536300130073;
        Thu, 06 Sep 2018 23:02:10 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id h82-v6sm5775603wme.11.2018.09.06.23.02.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 23:02:09 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiko Schocher <hs@denx.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        u-boot@lists.denx.de, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] i2c: xiic: Record xilinx i2c with Zynq fragment
Date:   Fri,  7 Sep 2018 08:02:05 +0200
Message-Id: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include xilinx soft i2c controller to Zynq fragment to make clear who is
responsible for it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Normally we are handling all these drivers via one fragment to make sure
that there is only one central contact. Another reason is that people are
changing and their responsibility is moving time to time.

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..d870cb57c887 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2311,6 +2311,7 @@ F:	drivers/clocksource/cadence_ttc_timer.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 F:	drivers/edac/synopsys_edac.c
+F:	drivers/i2c/busses/i2c-xiic.c
 
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
-- 
1.9.1

