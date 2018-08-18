Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA22C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C952188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsYQOWWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C952188F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeHROus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:50:48 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37782 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:50:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id c6-v6so42045pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=CGBLGbfUCclMVvGwgkarS7gxvGVBAKn/n0nAJeDL2ZQ=;
        b=ZsYQOWWJmF1Q3MHDr7irL3ma27RYJxHlfBLOL/SPPNbMgl3BksnzEt3+3FDyVx+dk6
         YUL0vf98EZLBr1sakKbcCRDMlgh4EAJFDmqvYt9jKpoixw8LiGLOByFXWKa5vLD6NFLB
         U/Ntatz17F8RLdo7DnPoZC7bbCCZd485e+qWPQiaDe+0VJ5b/cyWR3Q7CgNrm+DN09Pd
         fSM8yy6pXHZYYluURP5yUyKkSYYvoSGNh4tTm3THRhoLOF2XLuNoumY4HMPylId84iSN
         H8Ib01uNFO4brRhaUmxKoAMzR5s3nu1moEznw0sssOztaFVO0CpzZxBelsp61eRaoUUs
         kjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=CGBLGbfUCclMVvGwgkarS7gxvGVBAKn/n0nAJeDL2ZQ=;
        b=Wr8Eg7fwv5F2YBZVelPaZuAAWxZcLyKZhzU7NPvhI5WRJPBn3ow5FEKGuYCDocykOa
         d6R4rlhsg5RaazfHFh+W83aWh/gdyG0UvFb0wYUsTzsOiwm7LHe5HuSCOqHXX8T5dEK/
         5QYZnTgb21zvx0zu5XdMZd5lMLwqNGKfM7A15dqnKihesCr3tqLTUHEOlWB0NSp39p69
         hcQx+kqLIGYVZSmY5eCQZypTEatLFS/THkI23rL7t3tXUktcPSqlrEKVLigFy2k4yhi2
         s1CSOBDOD1Gh5momlWHqGEFooZwzKmMWsjFJ2TMxgZSQ9+nfNmlFV7VplcgxwNnPYV7F
         72DA==
X-Gm-Message-State: AOUpUlEGLsheJ/EFdRT6Vwc4QGInYN3UYGzyZhha8ZuOE3bPGAv/mKEq
        Haj8BYkd3S9yeIkffJ+vfnA=
X-Google-Smtp-Source: AA+uWPwo8FryTdq1XEJDVfJ0IGp0sSbvE01ftn8HOvgRY3Ssw+ooklGbyPbNUsXkt1eOl3rmAitm5A==
X-Received: by 2002:a17:902:e005:: with SMTP id ca5-v6mr37124140plb.224.1534592604102;
        Sat, 18 Aug 2018 04:43:24 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id i28-v6sm6750272pfk.108.2018.08.18.04.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 04:43:23 -0700 (PDT)
Date:   Sat, 18 Aug 2018 17:13:17 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, John Crispin <blogic@openwrt.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: mt7621-mmc: Fix debug macros in dbg.h
Message-ID: <20180818114313.GA6608@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed four debug macros by replacing printk with dev_<level>
without __func__ or __LINE__ or current->comm and current->pid.
Further removed the do {} while(0) loop for single statement
macro. Issues found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
  - Replace printk with dev_<level>.
  - Remove __func__, __LINE__, current->comm, current->pid from arguments.
  - Remove the do {} while(0) loop from these macros.
  - Modify commit message to include other changes.
---
 drivers/staging/mt7621-mmc/dbg.h | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 2f2c56b73987..e8091db3c1d6 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -104,19 +104,13 @@ do { \
 
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
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
-} while (0);
+dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)
 
 #if 1
 //defined CONFIG_MTK_MMC_CD_POLL
@@ -124,17 +118,11 @@ do { \
 #define IRQ_MSG(fmt, args...)
 #else
 #define INIT_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
-	       host->id,  ##args, __FUNCTION__, __LINE__, current->comm, current->pid); \
-} while (0);
+dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)
 
 /* PID in ISR in not corrent */
 #define IRQ_MSG(fmt, args...) \
-do { \
-	printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d>\n",	\
-	       host->id,  ##args, __FUNCTION__, __LINE__);	\
-} while (0);
+dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args)
 #endif
 
 void msdc_debug_proc_init(void);
-- 
2.17.1

