Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C69C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD576205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blz9J7A2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfAQOh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:37:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44968 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfAQOh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:37:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so4520946pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=67KdRtf3gBQZSqEzeYBLHnkzf1Hr8Lnj8xOAI6w6D2U=;
        b=blz9J7A2wMXAFuN8wZeupd4BI7lp7TmufkG2SIPXFC+X5UGvYFuoBdkxZmwuXM6AVo
         NgHwe37xxMWMtQ0SUBwUQCFNd4s7qN5ZxUVTN7dHe+yknCVQphokPq+mPcVPGflkD2D6
         OOwJ6s0LglAHQYXTmUszTiSbSZPTVzb1yy/qyUroewFPo6f8YVvAKxJF7WLpzPJbwJsD
         6tNg8FzAamxyQ7xheKQEzOBtJgzjXl5kWmaV1P41P7JPhswhgNwKaXPglpANQibPGtrC
         4S6qiEaA0qMNnW/HF46zxV7HkVwKRwICUlHLOSvf4+f27SWRr+zTKE19rHTHFuprc0Il
         5m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=67KdRtf3gBQZSqEzeYBLHnkzf1Hr8Lnj8xOAI6w6D2U=;
        b=f0LsgxiXfXcxO9eWjS6IwLjd/Nw5zqO4yX2BmdVUpt+KH3tjLp2jXUHYJzlE4EfDEg
         Nsh3w6/iAB5gvcbSO3sIIZyFHWRj5ZfiZElOraSqLSVggg+cVNiUvWuKTtc+YzSImzHv
         +yeajtgtBOc54H7tO3AzSCUh57MbybQJpbWUbnbAjtrkjF0YMJNd/uK4m/DDmTZyzwJM
         cMXRbk36JNuJJFopP+eTCc+Lp6iGtrHgyX0PN+Xb7RjEDJLFlWv2F2yG+KCTyTnq488A
         5DrWkucxDaIwx+lmrhV14YmjLQvgIrhjzLrK/BcM+FMC1pek+h6m/TApdwdZT+EVJ1WM
         B4Hw==
X-Gm-Message-State: AJcUukeM55MNaCrQQBdygsGis/eqC0lQLnvVomr3Aah21pVABec90b43
        jZhGtIBC5XLvNCFHGzxgerQ=
X-Google-Smtp-Source: ALg8bN4F/kloviAoLjxyMQS8wAfpCWY/ItspHghPgGNpB30ZOdcUnUTjO5FGom9C4PKbc7VCHlrRng==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr13797903pge.29.1547735876478;
        Thu, 17 Jan 2019 06:37:56 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([2405:204:4402:39a3:451f:6d25:2f65:74d6])
        by smtp.gmail.com with ESMTPSA id g26sm3394598pfh.61.2019.01.17.06.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 06:37:55 -0800 (PST)
Date:   Thu, 17 Jan 2019 20:07:51 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     lukma@denx.de, hsweeten@visionengravers.com,
        alexander.sverdlin@gmail.com, linux@armlinux.org.uk
Cc:     jrdr.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] arch/arm/mach-ep93xx: Remove duplicate header
Message-ID: <20190117143751.GA3462@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mach/gpio-ep93xx.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/arm/mach-ep93xx/ts72xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index c6a533699b00..85b74ac943f0 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -26,7 +26,6 @@
 #include <mach/gpio-ep93xx.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/gpio-ep93xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
-- 
2.17.1

