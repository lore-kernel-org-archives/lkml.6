Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE462FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5920873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dugeo-com.20150623.gappssmtp.com header.i=@dugeo-com.20150623.gappssmtp.com header.b="XQk5Acn7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD5920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dugeo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeG3QDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:03:39 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43241 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbeG3QDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:03:38 -0400
Received: by mail-pf1-f181.google.com with SMTP id j26-v6so4610674pfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dugeo-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=JWwN8suPm5zubfM9g+3+yJJ7cZkayLlzKQEkaJHlqs8=;
        b=XQk5Acn7USBenABNlMe18Vk9EhiypDdAbtIeBRya4EnM04yv5FgHO7y+32pu+iLdP2
         V6fFKGhdL30wNTiHhuhJjUpY6MXYKPSwsW+zF4H3ixsg8s+/s+Hz4RUpTweVLOnM1ZTy
         Z5qCcE8aIOu6QIr3290864XSLk7dX23Z25tC+E76WkMI/OJ1T+rdG/zxuzUGgccjcIww
         GKPGgQESJbn4ol/+bG5vC4J6bobkA8IrdIGaKtl+SupOk7zAz8tYY061VsqgTyJHFvmu
         hdP3DYZnvUr6C1EN/fBbaPQrXzPBiH/BeE3JDlGFpo+/3TOGqiXwuV/oIb1/rrQlaJD2
         W+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JWwN8suPm5zubfM9g+3+yJJ7cZkayLlzKQEkaJHlqs8=;
        b=GZNQmuIzt+kZ3colEA1XQMS2oSK6GLnbTTwDL/vDiVGRJOOLW+TV2c3w/1nfNXlT1A
         6G5as57sS6gaEyEZpZ7c9rJgMjqhd3k4TuQbgd2rAQMFNo9Vr8FELhkd3FyW0qWz/9pZ
         kjmbFtftdl4zpMZm1JZ3VloHkCDKRvk3Gg7ICyYtWlCF+z0btFw3zOX4it/xPUa0nn3W
         /On3a4zi86pGGhN8xXdOFE2XSQScP+TGHJnXEJBqbYMOBbu55xvvu66xco7sLIGfgbKl
         7B5HUxN2+0W8CRiOVjGIX+b+GoPqQR4KjApuflvwLynAYbFH3ci2ZFgAuaFL9cSXHoRR
         2Zvw==
X-Gm-Message-State: AOUpUlEZiaGPYrgV1/N2T6ipXEvK022u9JLohlG45YO4otdTZCdz2gQ4
        BIb5TtakDEeqHfYLflp2+12VXQ==
X-Google-Smtp-Source: AAOMgpdmmofBsbM81Qt431N1ifhZwY8R8mNB+6dPjUJSGzWfp6tK4rIKqAya2ym110AikeJvMCGHZw==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr18120745pfo.160.1532960902934;
        Mon, 30 Jul 2018 07:28:22 -0700 (PDT)
Received: from bud178.dugeo.com ([116.212.202.58])
        by smtp.gmail.com with ESMTPSA id s3-v6sm31836371pfg.2.2018.07.30.07.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:28:21 -0700 (PDT)
From:   Jacek Tomaka <jacekt@dugeo.com>
To:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de
Cc:     Jacek Tomaka <jacek.tomaka@poczta.fm>
Subject: [PATCH v2] perf/x86/intel: Add support for MISPREDICT bit on Knights Landing cpus
Date:   Mon, 30 Jul 2018 22:28:13 +0800
Message-Id: <20180730142813.13451-1-jacekt@dugeo.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Tomaka <jacek.tomaka@poczta.fm>

Problem: perf did not show branch predicted/mispredicted bit in brstack.

Output of perf -F brstack for profile collected

Before: 
0x4fdbcd/0x4fdc03/-/-/-/0
0x45f4c1/0x4fdba0/-/-/-/0
0x45f544/0x45f4bb/-/-/-/0
0x45f555/0x45f53c/-/-/-/0
0x7f66901cc24b/0x45f555/-/-/-/0
0x7f66901cc22e/0x7f66901cc23d/-/-/-/0
0x7f66901cc1ff/0x7f66901cc20f/-/-/-/0
0x7f66901cc1e8/0x7f66901cc1fc/-/-/-/0

After: 
0x4fdbcd/0x4fdc03/P/-/-/0
0x45f4c1/0x4fdba0/P/-/-/0
0x45f544/0x45f4bb/P/-/-/0
0x45f555/0x45f53c/P/-/-/0
0x7f66901cc24b/0x45f555/P/-/-/0
0x7f66901cc22e/0x7f66901cc23d/P/-/-/0 
0x7f66901cc1ff/0x7f66901cc20f/P/-/-/0
0x7f66901cc1e8/0x7f66901cc1fc/P/-/-/0

Cause: 
As mentioned in Software Development Manual vol 3, 17.4.8.1,
IA32_PERF_CAPABILITIES[5:0] indicates the format of the address that is
stored in the LBR stack. Knights Landing reports 1 (LBR_FORMAT_LIP) as
its format. Despite that, registers containing FROM address of the branch,
do have MISPREDICT bit but because of the format indicated in
IA32_PERF_CAPABILITIES[5:0], LBR did not read MISPREDICT bit.

Solution: 
Teach LBR about above Knights Landing quirk and make it read MISPREDICT bit.
---
 arch/x86/events/intel/lbr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cf372b9055..043aa09f3a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -19,7 +19,7 @@ enum {
 	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_TIME,
 };
 
-static const enum {
+static enum {
 	LBR_EIP_FLAGS		= 1,
 	LBR_TSX			= 2,
 } lbr_desc[LBR_FORMAT_MAX_KNOWN + 1] = {
@@ -1230,4 +1230,8 @@ void intel_pmu_lbr_init_knl(void)
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
+
+	/* Knights Landing does have MISPREDICT bit */
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
+		lbr_desc[LBR_FORMAT_LIP] |= LBR_EIP_FLAGS;
 }
-- 
2.17.0

