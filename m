Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AFBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB31E20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaTEyc5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB31E20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbeHVL6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 07:58:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37174 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeHVL6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 07:58:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id c6-v6so575063pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmpTcC6Aq0w1M4g1dYZFyQAjFaM0/Ckoz/A5bJDuHpE=;
        b=eaTEyc5WamY4JeSXnZiwxGf2AnSDqX0GWBzcyZUrQkaD202WyQQKn27cmR7k/Yj/Mf
         L7EIkP7eA2wXmgdi/GLnme5IaiChUwPsMQUNLIKBhKaud3gNY8OSn8JTz0WkDNDSIjP0
         03+2Qff2LN9Js4j+L1PBfxpWYodeg5runZXu10nNkCOhmgybmiY90L9nFctlnM5N2fIq
         +t+RK2yAd3A8AGXbGMQRrBNUDdr7bzZc07ipwQv+FQv/oIf2fE7UTy6/HX4igxWWozHU
         SWtqhj0bXSLSrnM8i8+KFVBxnIWVjmy3Q9G2oCZA5GnRZ/erl4FtuaG+Ils6jihofYyb
         6mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmpTcC6Aq0w1M4g1dYZFyQAjFaM0/Ckoz/A5bJDuHpE=;
        b=gjk6qei5fzyTMYfm8cZxaFdF8JYYoa198b/4nJIPPBuay3xGMkrSab2qtAeNOcdcA1
         253lndGovLDkYphgdt51xN+eU+KJpUvbaeeZdl1wymO/BNBgEk8TdssaxeKh5Ov1jm+J
         pzKbl6yc0ZgilP0tVkxA/TaBwE4ZowjxxsBwnHH/rwL1HPw5zyx32pxLWc4/LYn1U5Ig
         Pfb6Wa+exlpKxFJWEFN/wH7tT9S4AQSA53QXcS0s1pzjvJogt/gOVyUn+Voy5yMs3DiR
         yEDULINrH+Ot0deaczzf6U+msTrZ4EAmsbOVRwBNxkFZtuPNj13L9tmQt926ZJSQLpID
         cRIA==
X-Gm-Message-State: AOUpUlGBKcZKNBuGPF4qOQe67eq9L6ZCBeNUtgh7nI5WBddg8FwpBs+q
        iBddo+H1Prd0VVz+lSPGgNM=
X-Google-Smtp-Source: AA+uWPx0OzpN7J+HMsoEF9o0zCB7a9J3cU+qEk32NUKelktlfnFUQwPcLWj1PghsT0aeBuqS8/iOQQ==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr22391108plz.49.1534926901755;
        Wed, 22 Aug 2018 01:35:01 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id l79-v6sm1907630pfb.111.2018.08.22.01.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 01:35:01 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:04:55 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v4 1/4] staging: mt7621-mmc: Fix debug macro N_MSG
Message-ID: <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1534923403.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the debug macro N_MSG. Replaces printk with
dev_<level> without __func__ or __LINE__ or current->comm and
current->pid. Removes the do {} while(0) loop for the single
statement macro. Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 2f2c56b73987..c56fb896617a 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -104,13 +104,10 @@ do { \
 
 #define N_MSG(evt, fmt, args...)
 /*
-do {    \
-    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
-        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
-    } \
-} while(0)
-*/
+ *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
+ *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
+ *}
+ */
 
 #define ERR_MSG(fmt, args...) \
 do { \
-- 
2.17.1

