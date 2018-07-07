Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF34C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CF422474
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omKFrHov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CF422474
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933059AbeGGClq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:41:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42656 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932965AbeGGClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:41:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id v9-v6so9775643pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TISJ/chmccN9jFmXP/Rfkvnr6C4im3bax2dsTi4N0cM=;
        b=omKFrHov1mq5e5PbY8cvd6wrEDL7PMv7DXA23BN7GnWYZiSHOOl6MIRe4IzrKQsw/U
         OMApxe985NVu94BckBovCxYUP6I+XnFezVA/qYkT97hvPn5k4V045dSAFo+Dl3tTFMuT
         ljxKeXzPthCvovXRIXa9H0wL5GLukFXwbFlrdOgIo9I/K5TepvMsiCgDlri6wcl/iKo3
         WGS8v0ebtVtbJ7x7pBWVdP15N0Xq3Mz0wFNhag1jiyKXXjaRzZBF1Y0fVIi9mm/RNe3c
         2qP9N18V2zhFHo29G8SQ9q2VY83yPhoSiV1FDsE6njEOxZI05n0XcaUT/SUNE6iPVfyt
         zZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TISJ/chmccN9jFmXP/Rfkvnr6C4im3bax2dsTi4N0cM=;
        b=Jna/8pipaYtB1SZzTBBldvLRKbq9B7GvKryV89f4Yzzo/Xc60T28LNzjp+jLUId0qW
         qLIjBmSXrQH02x2k3fNe/Spp4sezmo+Hp7xWUE8e77M2DGwdPMjCsX1cjLe1Reacr7ip
         Tov4aT8147KRKVr7TFKvDqlTplar0YdE5zl8R5aWFaHutyz3bKZX5hjJSq25KDQesg0R
         wZxrPVAKAk08vNCPhx6FUAhgdBKYlsTVTEHB8DrEg5G+5vz/vNNUMWOECFT+qaRXV+s8
         vlP0G7iuzAmPpFWCXh0F64WROlTh0u+OrRw2IzDYu6NCsLJRJYCqJS/SCtJkdzK4CKGY
         eWXA==
X-Gm-Message-State: APt69E0jeRASjob8xYP+hiKboBAxgmbVuu/+2oWHbI7Ali0XZBeu8OLF
        K6aHfxL8z9dDC7MZuwNhDoY=
X-Google-Smtp-Source: AAOMgpdmpVOxL8fk8HPQJ9KAQYzlcP/25V6Abgibh5k8HnjNuwYVzlPeTH+MVF7DcoiB323rAcAFnQ==
X-Received: by 2002:a62:c0c4:: with SMTP id g65-v6mr12671531pfk.72.1530931300174;
        Fri, 06 Jul 2018 19:41:40 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17-v6sm18897276pfj.95.2018.07.06.19.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 19:41:39 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 5/6] mfd: rave-sp: Add legacy watchdog ping command translation
Date:   Fri,  6 Jul 2018 19:41:07 -0700
Message-Id: <20180707024108.32373-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707024108.32373-1-andrew.smirnov@gmail.com>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed to make rave-sp-wdt driver to properly ping the
watchdog on "legacy" firmware.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index a999fa721b03..eee62ba6874d 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -631,6 +631,8 @@ static int rave_sp_default_cmd_translate(enum rave_sp_command command)
 		return 0x14;
 	case RAVE_SP_CMD_SW_WDT:
 		return 0x1C;
+	case RAVE_SP_CMD_PET_WDT:
+		return 0x1D;
 	case RAVE_SP_CMD_RESET:
 		return 0x1E;
 	case RAVE_SP_CMD_RESET_REASON:
-- 
2.17.1

