Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A43AC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF90120897
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dugeo-com.20150623.gappssmtp.com header.i=@dugeo-com.20150623.gappssmtp.com header.b="TFY8yO6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF90120897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dug.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeG1IWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:22:34 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:41690 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeG1IWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:22:34 -0400
Received: by mail-pl0-f45.google.com with SMTP id w8-v6so3229338ply.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 23:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dugeo-com.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=dudzcry+KvQIRoofLEVC7OwJU8e0Oy8UNC2vmR39l7c=;
        b=TFY8yO6V9DccbtGgIPA3vLnYXsXYmIYqa5Gt+79BzWxVZlmnqXnXG3/uHAy4N6ioxT
         BZLIsy1LqDI8u64Or51tF+gDizBm29B0ZShE/ZmrHognS/m1wiHckCmHg/ghZ3dRDfQ4
         EJSW9rJli4gX0MYxeI1+lEzNG/del4SH/iDI85evVBkrYgUwJ/2pIYh2KvAqKKb2vzNw
         yOhhPBQE+SVZ6L+YO5RSRKTvYDSELmDlaaUQLXE7QOwNvJ+3nvunnGDS9JZm+OJOUt3s
         XplAkVSGYkoFqWWMpjdjFtK0XEvANXXDsEe8ljn/oMM89dsqUm+KkBMM1gyTQpFISVqP
         d5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=dudzcry+KvQIRoofLEVC7OwJU8e0Oy8UNC2vmR39l7c=;
        b=cgI6+qt+9exRTWPnZVtxhee9CMCeH+cgrQb2Kqbs0IrXbEUFlJM5KRuOk3fRBarRLq
         oNPeYWBJW4/vUi+ChD4RBkM1RVt+SgZOM2qUpvy0zNwkgakDZ1PDTsIckvh/JLSOvhVC
         fPoWXnSvC/nt4nVO5ocIDJ0rjEMfKFBQQroczPC9KUuHzn02pQQEtKdxmRlZ1QPxMifx
         cW8Ed0wMU86pG+Mo1231hHirRNzVCwlKuxVj17XtccOLAWx26//CuVpNpTiE0X399Y2Z
         bXQs+mFipm1/GM8773hZ4N9YItl89+LYQmUa9bccbwHH6Mz4gHvpNfFgH9Zs4zrjdwrE
         +8tg==
X-Gm-Message-State: AOUpUlHKqaCBYNZVr131eynCouCDjdrHLtb/UXCGMeifOJckT17Ph693
        A7SQSBx6s+gNVMp9oJ9daOkhfPcn6y4=
X-Google-Smtp-Source: AAOMgpcYMmpW/JUbhH1wzUgaSmgJeF5zSALw5h/WxdCoUQJuCeqg2TY2Ll/fiCZzEe2jlLliG0gaZw==
X-Received: by 2002:a17:902:7793:: with SMTP id o19-v6mr8942408pll.306.1532761028424;
        Fri, 27 Jul 2018 23:57:08 -0700 (PDT)
Received: from bud178.dugeo.com ([116.212.202.58])
        by smtp.gmail.com with ESMTPSA id 203-v6sm9641242pgb.14.2018.07.27.23.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 23:57:07 -0700 (PDT)
From:   Jacek Tomaka <jacekt@dug.com>
X-Google-Original-From: Jacek Tomaka <jacek.tomaka@poczta.fm>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jacek Tomaka <jacekt@dugeo.com>
Subject: [PATCH] perf/x86/intel: Add support for MISPREDICT bit on Knights Landing cpus
Date:   Sat, 28 Jul 2018 14:56:41 +0800
Message-Id: <20180728065641.26595-1-jacek.tomaka@poczta.fm>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Tomaka <jacekt@dugeo.com>

Knights Landing supports half baked LBR_FORMAT_TIME format. The addresses are linear but it does have MISPREDICT bit but nothing else.
Unfortunately IA32_PERF_CAPABILITIES[5:0] will report LBR_FORMAT_LIP. This change teaches LBR about this Knights Landing quirk.
---
 arch/x86/events/intel/lbr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index cf372b9055..0f73e60315 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1230,4 +1230,10 @@ void intel_pmu_lbr_init_knl(void)
 
 	x86_pmu.lbr_sel_mask = LBR_SEL_MASK;
 	x86_pmu.lbr_sel_map  = snb_lbr_sel_map;
+
+	/* Knights Landing supports half baked LBR format. The addresses are linear but it does have MISPREDICT bit.
+	 * Unfortunately IA32_PERF_CAPABILITIES[5:0] will report LBR_FORMAT_LIP.
+	 */
+	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
+		lbr_desc[LBR_FORMAT_LIP] |= LBR_EIP_FLAGS;
 }
-- 
2.17.0

