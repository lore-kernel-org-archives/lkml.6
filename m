Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FC821547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0T0fVjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FC821547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeIUG4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:56:12 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45080 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeIUG4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:56:12 -0400
Received: by mail-yb1-f195.google.com with SMTP id d9-v6so4757172ybr.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 18:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vVqP0ZWyf01ZJq/LrATf0sGns5mN1Fx+TbfLIQLpbB4=;
        b=X0T0fVjgqz83GOjjV3YixCZVhl48S/FHWNetLDzUFgTHfxUOriPlA4aYW00ufi39kw
         EUVEI99L3EslTMqhNBJcorSa6PfpDnAqpgnLKjeLtTccU5spPamGfbQcl5QPvDH0QjRu
         SL5ANGNufuqnruz8AoQ7bU0AxWv3bR0LXPvsH8g7xtuMHp4gD2JHUb3bFVpxjXri8aWT
         Lksas93fD59LwgO7josi/3YPPlsnuKVeqXlqUCaM2KPcHTOFxyHlU64FLxVPJyacvp9B
         57g8lRPloOxiTS5xOz5bf4oTkvTWaoE5xoB/J8VBIgAkq2OFIDnDKr3AE6qacUmANt9P
         sdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vVqP0ZWyf01ZJq/LrATf0sGns5mN1Fx+TbfLIQLpbB4=;
        b=t2vAuGpOwt/uDr5A1PugYzZG20cGasXU6nFHv3gd9ms0w8Jb09/u9WGznPQ7hLVq/V
         G4qJpiLIvCkylldVidv8P4/tjJ2JBECBWJqybpF1ansjHnSxqCebpqZIotNVHUaWO0il
         VH+F4GYW0ZwqTJkaSwWWI9zXiGD1novG4n4Mgso31yQuzDmSz0tddmpj+bq2IZ/JOpx8
         e3ytitBzV4yj6FM+oLxAGQC7cEW1CJhia//pbZA366oQGW1eBSqXKgHzgb38Rw+S4CSC
         HkuosGmcLW+0WyzYYmzaxkI3sJ27WZ2BbGdgTBd/GyCV4hik6ppFKvbJ2wGd5yjG4QTg
         sBtQ==
X-Gm-Message-State: APzg51A00D0+vs9hNK98BU1DOVpVDQRWhIaOtDFGo0tsL+VFoahTwG1F
        qbPPCkUO0Ft/QyY423nTgI79px4=
X-Google-Smtp-Source: ANB0VdbGuWjyLmcHd3VhXqJDKmd93iuYk7CUmRKaWNVSDSbw9SU27d4AhFy0q+830SIqsK1V6arx5w==
X-Received: by 2002:a25:b906:: with SMTP id x6-v6mr19722055ybj.309.1537492195784;
        Thu, 20 Sep 2018 18:09:55 -0700 (PDT)
Received: from gabell.redhat.com ([2601:18f:600:d880:b4e9:4651:58aa:d5a3])
        by smtp.gmail.com with ESMTPSA id v126-v6sm5270594ywe.45.2018.09.20.18.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 18:09:54 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/x86/intel/uncore: Use boot_cpu_data.logical_proc_id as the pkg id
Date:   Thu, 20 Sep 2018 21:07:46 -0400
Message-Id: <20180921010746.32118-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Physical package id 0 is not always exists. We should use
boot_cpu_data.logical_proc_id directly as the pkg id here.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 51d7c11..edaadac 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
-	int pkg = topology_phys_to_logical_pkg(0);
+	int pkg = boot_cpu_data.logical_proc_id;
 
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
-- 
2.19.0

