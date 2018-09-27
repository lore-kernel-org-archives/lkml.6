Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E014C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA5D216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMwBU7+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA5D216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeI1Brr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:47:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41286 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbeI1Brq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:47:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so2585552pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BGoSejrBEFtVHbBL0BYK36ryiXzv88p81h8++1Dth7E=;
        b=OMwBU7+uS3Q2jD69NvKxs8pumvEgjNDPHQCG8WCX+bIPXcTQqJZKKb39B7vzSYvKTn
         wktA+XUkcCiqrbfQuUNMblzYwRHAYLFTHRe8Q+IQqkSiDCdB2YOuiA++pMUF8hfbHP1Q
         yQiF+qOwTKUDoIBzbzy8FYfDHQFGfy+TjJJbmY7PvxrbHSZC5YAp8esngwgO5bjodkru
         2VkKRIR7Q75PnswDoTnvMVk5TnZE6sE4V1PSxPrcQ3iWNr53S+hifmLnUHvuxg3JdHGF
         oBISpmGYs+mUoZV/FjJzpb0IihE19hD2jaTGR7O2tOpodhxCqGCw3n3o8EYjQV0MylUb
         KgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BGoSejrBEFtVHbBL0BYK36ryiXzv88p81h8++1Dth7E=;
        b=Uvt+1fhxyjUK2Uyu2aXBQpzUu1z56SOhK9f0z27XtdowBFESmwYsYFnAn0hYbPv/l/
         QuHDNxXXMGzQjbGtf4bLXAJ1GLVSBuRc6b1jZRfs2WRCaK++8tUF1SYNRAYi/kfi8zZY
         K8Db9Fe/iXnaVA397ggu6ihe8iMze3ANQg5/y09ywlwJgRPCAuHdtdVWR3HPG3OqeWxp
         YVDeXJ38mdg8wlUSHJ9W4l/9EM/+0O5qpkxwMrxL/4sOwPZxnz1ANNo0XXmUQuThUH7u
         50z92ZiCG9BG1w60p07pNigg6nF9OpOKtng0lAReF97AnXEgXCRU1wyvLqmD84lOnDir
         E9pQ==
X-Gm-Message-State: ABuFfog+luyb/oJjLIpzxZBjR6UxtQrqyKGPwfbO/L3jp9SI9EYRGImg
        miVLJN/+rzgoBX3a9esppKg=
X-Google-Smtp-Source: ACcGV62L/rFYWIyyL2JeyRobD/AQ0X8ikN3rzpbMH/hdmqdWxh5LoxpPBBTeVj/pWEEzF5AQ9nqRnA==
X-Received: by 2002:a63:5558:: with SMTP id f24-v6mr11791116pgm.37.1538076477816;
        Thu, 27 Sep 2018 12:27:57 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q2-v6sm8531502pfc.17.2018.09.27.12.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:27:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Rob Herring <robh@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL
Date:   Thu, 27 Sep 2018 12:27:11 -0700
Message-Id: <20180927192711.26455-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is built with CONFIG_THUMB2_KERNEL we would set the
kernel's resume entry point to be a function that is already built as
Thumb-2 code while the boot agent doing the resume is in ARM mode, so
this does not work. There is a header label defined: cpu_resume_arm
which we can use to do the switching for us.

Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index a5577dd5eb08..8ee06347447c 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -404,7 +404,7 @@ noinline int brcmstb_pm_s3_finish(void)
 {
 	struct brcmstb_s3_params *params = ctrl.s3_params;
 	dma_addr_t params_pa = ctrl.s3_params_pa;
-	phys_addr_t reentry = virt_to_phys(&cpu_resume);
+	phys_addr_t reentry = virt_to_phys(&cpu_resume_arm);
 	enum bsp_initiate_command cmd;
 	u32 flags;
 
-- 
2.17.1

