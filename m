Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0C3C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FF320C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caNa4+3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FF320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeJAVYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:24:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37327 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJAVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:24:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so43446pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oOFCHFfEspr9rKEWYY6f1+MZDCDLwqhsJoxZ/YFAkMo=;
        b=caNa4+3YRdjWmyFyusRVSjXgFA8xfrz+bw9ywTCBEU3JAmM537R5pJ3AWcj4u49Ooi
         0KqX1gB+sI1mzuMJfmLCB52OIXQky/tp3B3HkPPzuuHTso2s7YvgYMTuxWHgBwOyxFOn
         nHhcEb5nfd9MNJNnrjmZOpLJP2wSVJ6+n7cQwNrrDucr99RtwwPotPNO7HblioS4LxdV
         Nk0p1ofMQvuypEXqjZAlsV+Kvnm9TUujAEDGj2b6HPNgPXWTxrB8GeUIMAWg9MRdf5Wx
         SUhaglfOoG3GVuZklrYj+uKbJzTxvI77Yr2EYCh7UWnxkiPU7sNAPwxyPKLX6A/4NSOR
         cYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oOFCHFfEspr9rKEWYY6f1+MZDCDLwqhsJoxZ/YFAkMo=;
        b=t4dqRhcLo703ktKbFjUgWgVeWPtp3anMcmi1TznLWOKFROR8B0/hR7eymfMO0JKHiE
         rHjA9rRk/K0cv40O5QjuGNGGNTsG/OmdhnlFMG6QDKz1ERl6D0slgLCptWUuLbj95+Sz
         exdM3hGgvlAWe9yFcf0Xb2SditF3XI727AgP2MmOae/SX6jRfjIbh1QxFGSczmXSxpLL
         Autre0Z2QSs9l3hu/9Bb8F/nTdn7tId2abym8Y/jNb1OuihWCwPhpgxkQl29v3mbKt8u
         TRWyZNSEoQ212RmjOefSF9E7lT8sVk80Xx7cY83t5YgZQ6VKV47Kk99QwRL6sVPvI7TP
         wKdw==
X-Gm-Message-State: ABuFfoj4NRNJ68BUs8BgTCY91QK7KJVlcuIOfiYPINipmeo4cpUlonZC
        a120/sui/2I42p7Im+jyZ4OtwWDkCoabNA==
X-Google-Smtp-Source: ACcGV626AZDHxb21KMjIpmejgyBnajWUzlWg+6iozqMf6ipIBfUkPdAHI8hvVI6pRo7PrIZ+qqbbiw==
X-Received: by 2002:a17:902:b08e:: with SMTP id p14-v6mr12284360plr.241.1538405173662;
        Mon, 01 Oct 2018 07:46:13 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id p18-v6sm7409219pgi.5.2018.10.01.07.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 07:46:13 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:16:05 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 2/3] staging: mt7621-mmc: Remove single statement macro
 msdc_irq_restore()
Message-ID: <b04630c76e0a7ed05b65decda5b42db741c65f0b.1538402548.git.nishadkamdar@gmail.com>
References: <cover.1538402548.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538402548.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the macro msdc_irq_restore() and replaces its
usage with call to the function called in the macro definition.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index c88b82488464..29e75804db67 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -144,11 +144,6 @@ static void msdc_clr_fifo(struct msdc_host *host)
 		sdr_clr_bits(host->base + MSDC_INTEN, val);	\
 	} while (0)
 
-#define msdc_irq_restore(val) \
-	do {					\
-		sdr_set_bits(host->base + MSDC_INTEN, val);	\
-	} while (0)
-
 /* clock source for host: global */
 #if defined(CONFIG_SOC_MT7620)
 static u32 hclks[] = {48000000}; /* +/- by chhung */
@@ -299,7 +294,7 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int hz)
 	host->mclk = hz;
 	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks); // need?
 
-	msdc_irq_restore(flags);
+	sdr_set_bits(host->base + MSDC_INTEN, flags);
 }
 
 /* Fix me. when need to abort */
-- 
2.17.1

