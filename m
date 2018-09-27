Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE74216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6XhF5MV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE74216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeI1Brk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:47:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42078 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeI1Brk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:47:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id i4-v6so2052746pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3GCyOHWIpD7IB326Tq5Whn5QBKsp9/pOp1wUxjWkEUs=;
        b=r6XhF5MVSU0FAwczVIaqCFdapvujaZdJw7BrJu9edAIefeadvnyVj6srdZDksMQgvF
         ft7KypMi3DLc1qZmGdluou12U6XcJEQ4gfymRmsbv+47kiXh96J9hwu4RcvCR+p4TLCj
         hJJBC0Z3i12DIZCxmCkWWqgXplYMIv2dboy4tV3G7toXcP5GRdlfrDgzsWp6oHuGI88E
         GKMlXgDdcWXhFE73rcBXpMPwVqGLkosiNleiUStN5D5ABjUZTi9ZiDbAoadBbvjFa4Pz
         GxSj8OuQOaNiUrspsLPMnR93O95/SuwVV+H0ncLDyxjNc6XErlWrxn0pW1KGupFWpBq5
         /UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3GCyOHWIpD7IB326Tq5Whn5QBKsp9/pOp1wUxjWkEUs=;
        b=gJbxOKKeIDOP5itBtkbOBnDkJuh6IaOLzoNh+FcX4tba2ZRPgXWSZVzi3P6emr7UMA
         mOdyavobEr8AUgP4d+PUkdecF2O/LIGMB4+XXrvqn88JZZZmZPzIF91ccvkGNx0UOpVf
         pQeFP4Qwhp8gGZ/LYB0k8d9cuR71gW7i5lAGlLteR7+ElavphPLeShkflcRmXKg5KkJU
         yhT2Vi0i7yK6voXofzqPdSNVmpPcY2y8uetR/FdGizSdSw2/iXsxqMY7gXeI6UxmqEIz
         9T8NmXNXlZ1irFkIJSYFxT4/o+yIQ0A2SEdk2LMC0kWSze2s2OYD1JNyWiOPF1tE5MgJ
         hS6A==
X-Gm-Message-State: ABuFfoi2TsMKTlbKWTkb8cYpmzKKNMR1BCfIebjkPOYEru6a3l17O1UT
        5ew5fVePdue51fJZs73WYv4=
X-Google-Smtp-Source: ACcGV610+dRgUHWYiSEcMHYUT2FfAldTgNTp2pGveA/msUeHg34DweRmkqelSCyiBUe0Gka+pHVBSg==
X-Received: by 2002:a63:91:: with SMTP id 139-v6mr2430628pga.389.1538076471845;
        Thu, 27 Sep 2018 12:27:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q2-v6sm8531502pfc.17.2018.09.27.12.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:27:50 -0700 (PDT)
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
Subject: [PATCH 0/3] ARM/PSCI: Fix THUMB2_KERNEL entry points
Date:   Thu, 27 Sep 2018 12:27:08 -0700
Message-Id: <20180927192711.26455-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While playing with THUMB2_KERNEL on ARCH_BRCMSTB, several issues came up
which are addressed by these 3 patches.

The THUMB() assembler macro is a no-op unless CONFIG_THUMB2_KERNEL so
using it unconditionally for CONFIG_ARM should not cause a problem
AFAICT.

Those patches can all be independently picked up by their respective
maintainers and don't depent on one another.

Thank you!

Florian Fainelli (3):
  firmware/psci: Fix cpu_resume entry points with THUMB2_KERNEL
  ARM: psci: Fix secondary core boot with THUMB2_KERNEL
  soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL

 arch/arm/kernel/psci_smp.c          |  4 ++--
 drivers/firmware/psci.c             | 18 +++++++++++++++---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.17.1

