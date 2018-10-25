Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BABECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A0520833
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSqdgKnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A0520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbeJYIsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:48:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38902 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:48:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so1605481pfi.5;
        Wed, 24 Oct 2018 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TnLiTvyrwuhtwG3TOy++vC5FnC5iGa59HG0m+UGfT8Q=;
        b=CSqdgKnnJVKe31uueE5LDdCyyGrIHIlrq3RQPqrC2N8Z1ad0+s0j1zCFmOrohmWnHg
         BZQTyQTm08P5+OEO/d+pVqlXolZa1zC6ycytTYBX676jp8/J2Q7eYIEmlHmMvIydxVEW
         8btmeCmxtuDOVxINRxPn7qpwPGmBed6wGLLy1kaFV7oZWsAS//wy2DGySn/91GjuvJ5v
         kMIsJa/0hIOKiIrFGiHwaLS0T5hiuwqQGpVjcs+sMCU8/zJvNO2TKV9bMjqbPlt7vK9h
         /K/I//567/XpsZjEVwOnYCsk8Kkmi4P1HQ7N6NVvZEIRuhdVdSleFBFBmZGYb0oI/nQZ
         YUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TnLiTvyrwuhtwG3TOy++vC5FnC5iGa59HG0m+UGfT8Q=;
        b=GrNoPG1M1gmzaaOHJw5jv11RbZWXi03FwozkDOWLsfOtq1f4qbH41kuWSz/HsOKRI0
         J/14neMBMuMelDY95ehiqImfNzlzgBdNNFBg+gGO09wQCsJ3FaRicLgNQw+sviafaENJ
         xaikv/dNM469nv4lSycewzroFSkC/GBdvuDrb7mCnK/1MCmWA0HiCxrwJbCAOwwwgdI+
         0p6qFb7gqgSWac/GboHqnD4LkPT4r79NJupunHsembFIh+NS8WrrY7F0zVztK4Ib4NwM
         KkZxte0AU5hUDSNC83BEo9GzsMqBScoWruVQiK2Bei7CnSDWSHMzwFyxFecZp5HKSFMn
         N8zw==
X-Gm-Message-State: AGRZ1gK7CI2GokJifwN2CTcpxg41ebYr1sHH7vpGfBbh2z3e0Qou8IlA
        CDbOeg2z7uvTwpOX6Ue7xMSxT82WEoA=
X-Google-Smtp-Source: AJdET5eWK8/v5Co0f6NaeAnzdwvHxpVgrxyCU3y9Gs9CNe8LiqsDW9T8YK9LKHYsj7r7FtEvqjHU3w==
X-Received: by 2002:a62:1693:: with SMTP id 141-v6mr4828258pfw.183.1540426671377;
        Wed, 24 Oct 2018 17:17:51 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z87-v6sm11615707pfl.58.2018.10.24.17.17.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:17:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), arnd@arndb.de
Subject: [PATCH v3 0/3] of/fdt: Absorb ARM64's __early_init_dt_declare_initrd()
Date:   Wed, 24 Oct 2018 17:17:39 -0700
Message-Id: <20181025001742.6510-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Based on Rob's suggestion, this is a follow-up to the patch series
posted here previously that aims at cutting the ARM64 rebuild
time/number of objects. Rob indicated that he was adamant to just having
drivers/of/fdt.c contain the ARM64 specific behavior, so this patch
series does exactly that.

https://www.spinics.net/lists/devicetree/msg255512.html

Florian Fainelli (3):
  of/fdt: Absorb ARM64's __early_init_dt_declare_initrd()
  arm64: Remove custom __early_init_dt_declare_initrd implenentation
  of/fdt: Remove definition check for __early_init_dt_declare_initrd

 arch/arm64/include/asm/memory.h | 8 --------
 drivers/of/fdt.c                | 7 +++++--
 2 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.17.1

