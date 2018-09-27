Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8391C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD3F216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BreOZlqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD3F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeI1Brz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:47:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44350 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeI1Bro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:47:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so2573052pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wuh9PQJuORDhEW1Qd/Bh2TINja23GTiwyoguU2JzXEg=;
        b=BreOZlqXIoivOHZ2ib1XqFRve8Dd/ktNmN5tHceWLVx4Wa7/qZl1KKFkcqIbEeg4XZ
         yKKaVfAoAPaRiQdLH0z/pnHCIuOMVfqbpvfBD8rp9Ag/AIIUZ/0Gx2i+2FR89jXIGmXD
         NE9YFKr4ff9IOkFLjKRBeJ7KpbxkYYywtpcJRnDpST9c1eU6JmiEKrj9jIh0+mrPn9Sl
         /bxLDEDW73BMEAgNYL44wEzymDSO9LRntwBJ2drabw7HexF8FOd0jy8FROmKwc6DpJ1y
         jAwgoDOJ2uswfFCNCtC+pqs7bqAmqs+l8W/iI/auEuc613YOed2StO7TpkO+Q6KrDW1g
         Y6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wuh9PQJuORDhEW1Qd/Bh2TINja23GTiwyoguU2JzXEg=;
        b=ItE5oBaooPNMCkT3JKLrrgpmkk7mt+mdbcw3Dm6xRMseabF8q/0TF3Ldr399T8WwX+
         9I6ZgDLT2/9gyZwUqzCttsV/vT9Y7Fj2XluFqSv/HlKodDP+qRbPh2lzfdyVuf8dtBHy
         oWNv+tc8AE5PZJL+M9t3QP4Agd5eHon5zEKlglOeaq9kU7Tg2vTILKi32vWQuIWE61zf
         6Xk4FzW+vh3rOfACs6ncf12ddtlTE4qpufDfC08k/bmWiy/dk5CvhnB/uOAm1+oBlex0
         cDA2UQiKRrlS/mttuIDVQtZdJb5onFpSlY5waEhmVuC8maP9m3RpMY97kklI3WDvwAdc
         sBaQ==
X-Gm-Message-State: ABuFfojFGcdP2DuTuRloiWyRFPsI4HNKwHKiowugZpN/wRrJAxgKErSo
        RG6QLutE68Tcu8PCeiCKv+k=
X-Google-Smtp-Source: ACcGV633b8E5X0PZQju3F1eHG9FSpBW5Bizb8t+FcNwsVHoPWMXcjQxBMhmuo/yWmsqE9gHYb9rR4w==
X-Received: by 2002:a63:d70c:: with SMTP id d12-v6mr6709685pgg.110.1538076475816;
        Thu, 27 Sep 2018 12:27:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q2-v6sm8531502pfc.17.2018.09.27.12.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:27:54 -0700 (PDT)
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
Subject: [PATCH 2/3] ARM: psci: Fix secondary core boot with THUMB2_KERNEL
Date:   Thu, 27 Sep 2018 12:27:10 -0700
Message-Id: <20180927192711.26455-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When THUMB2_KERNEL is enabled, we would be setting the secondary core's
entry point to secondary_startup() which is already Thumb2 code, utilize
secondary_startup_arm() which takes care of doing the mode switching for
us.

Fixes: 05774088391c ("arm: introduce psci_smp_ops")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/kernel/psci_smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index cb3fcaeb2233..547a11b065d2 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -47,13 +47,13 @@
  *
  */
 
-extern void secondary_startup(void);
+extern void secondary_startup_arm(void);
 
 static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (psci_ops.cpu_on)
 		return psci_ops.cpu_on(cpu_logical_map(cpu),
-					virt_to_idmap(&secondary_startup));
+					virt_to_idmap(&secondary_startup_arm));
 	return -ENODEV;
 }
 
-- 
2.17.1

