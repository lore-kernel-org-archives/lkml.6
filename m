Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBA0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04032082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEZfuzVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04032082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJDXbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:31:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44473 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbeJDXbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:31:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id r9-v6so3496314pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYBDn/KT3xdhLUzEiALjmYwJpmU0XeamIlHQgugLRj4=;
        b=hEZfuzVaOvedfQtr9ExBcl+MwsCGUsReERt5w69LLIwRtV5DHd7YtCS53O7Y6qoUr/
         uxILygk9wgsGrTujldRFr0bbyUDT/bw/BvqV7wJOAneJUl/bUVM4M+VbBdFtpifyTeGE
         6iqeURaVa25rxL2OsDXP/avgv83s85z2o0zqitUubnHmOw+RDoaoryKxwSIiB/VSEeOB
         m+NqrAinN/2V0mhVe8DhmX/j005zLuoQRo+F+VYLlU1WD67RWANK/oqlac3HUxJASEuZ
         860VCtNkFLUPj9msRb+qA5jCCujn0iBPdpWVQk17BLn8Zvyi/k5EHA0p32brYfHmESKb
         uaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYBDn/KT3xdhLUzEiALjmYwJpmU0XeamIlHQgugLRj4=;
        b=TROc1dtJuNhGLuyOY18XGfsmdDLrLJHfQ/ncUHNUOR5HFEo/O5DlMdJMyZrELpLc62
         7MnXKo9n+crcH8phjF5JcLP1nQVDsJvfFc0ra+VBIFiW6iwaYGNWiZPepdAGxMibFepG
         Yn1FkuF7OHvgF0avTg/LxHqyDv5CuqVzSrxW/nVNTapBrQ1+vOTYlm3WETlLHILrB5Wq
         EQQVa2NS4IbVyzvCpkXvdKv5jqmnG0Z7BcruVVJVjMHVDp1KyrCvW8tv7TF5KL1ETnBX
         ohUkKTp5Ke5MQTgNB2Og1Ux9ycMrAJogG74VrQGBl7PRDmGIR3UiUFvdv391fhJiQoxc
         ePeQ==
X-Gm-Message-State: ABuFfogEAQQPlFfSOWtJZUp3odT6pVbqdhFt1WGYx0/Ovi+FVsLRwM1a
        wIY/QaNukEMXVtYDEr7t3dM=
X-Google-Smtp-Source: ACcGV61/gg7/FtqLrVLgVh9JlbhSMZuwdDx5ggjz9zVSJiKBHOmawjDNuuYyGwCmP3k/5WMJrcSaPA==
X-Received: by 2002:a65:4d03:: with SMTP id i3-v6mr6466989pgt.239.1538671052878;
        Thu, 04 Oct 2018 09:37:32 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id j5-v6sm5309201pgm.79.2018.10.04.09.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 09:37:32 -0700 (PDT)
Date:   Thu, 4 Oct 2018 22:07:26 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 3/3] staging: mt7621-mmc: Remove #if 0 blocks in dbg.h
Message-ID: <8d069e464e83a0376e0ae412823c8e7fd478967b.1538670306.git.nishadkamdar@gmail.com>
References: <cover.1538670306.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538670306.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if 0 code blocks and usages of
functions defined in the #if 0 blocks in dbg.h.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 4ab9f10dccc2..89acf590ed11 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -91,23 +91,8 @@ enum msdc_dbg {
 
 extern unsigned int sd_debug_zone[4];
 #define TAG "msdc"
-#if 0 /* +++ chhung */
-#define BUG_ON(x) \
-do { \
-	if (x) { \
-		printk("[BUG] %s LINE:%d FILE:%s\n", #x, __LINE__, __FILE__); \
-		while (1)						\
-			;						\
-	} \
-} while (0)
-#endif /* end of +++ */
-
 void msdc_debug_proc_init(void);
 
-#if 0 /* --- chhung */
-void msdc_init_gpt(void);
-extern void GPT_GetCounter64(UINT32 *cntL32, UINT32 *cntH32);
-#endif /* end of --- */
 u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32);
 void msdc_performance(u32 opcode, u32 sizes, u32 bRx, u32 ticks);
 
-- 
2.17.1

