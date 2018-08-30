Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516DEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F022082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F022082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeH3XJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:09:02 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46782 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeH3XJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:09:02 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so17328571oie.13;
        Thu, 30 Aug 2018 12:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uSvE4BURxRuYiZXLX8XgwcZ6P2cYrvLpXItJM32mbrc=;
        b=qe2cYchbFfN3sN33sQ5Z/imMtdrdlit8sZtd2lHPDRmJYgT/TbmAArYuy5l5lPqhlm
         Pvfu/3ISnY4PPp+zNKdPpFO5oMgK6RcmkiJVMv6OI4NO2znLMMIikk8zGUlqUZLPF/5I
         G27lFNOTu9EoKY1Pv3UyVVJZDy2jKA76ht4ujGiJ2llcMut04Lrbnu/MSY/Xo1PBcXkB
         qsbBY2c2m+/f8CFvZtn7afZwB4BRFdFI8Cip3Dc3rBSh1yyYPJ8dsbazFl9xH4j4K+6e
         QHmknHIbPVvY1MutA6dTz4DKA01G7wDLGbVt7ICm/0ZJKCr0u2J7hv511B1mk5Cql8Lp
         Xjig==
X-Gm-Message-State: APzg51AAqVgZ0CGlPG+oDOQzVQMxvrI6G4db46dVABC51sCAQWoCzwhN
        vFVJ9uGeJP0XUO2/W2/qeg==
X-Google-Smtp-Source: ANB0VdZrhp1Y56jojMNBEh1wXfmyYGQDGUoHPrniLnEdc2E6DRberlHrdDYuIb5vT4feKtUsXgqb6Q==
X-Received: by 2002:aca:bd46:: with SMTP id n67-v6mr4143869oif.56.1535655924551;
        Thu, 30 Aug 2018 12:05:24 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 22-v6sm4200423oix.58.2018.08.30.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:05:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 0/3] of: root #{size,address}-cells clean-ups
Date:   Thu, 30 Aug 2018 14:05:20 -0500
Message-Id: <20180830190523.31474-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small restructuring and clean-up of handling root node
#size-cells and #address-cells (or lack of). As only Sparc needs a 
different default value and only for #address-cells, we can handle that 
locally and remove one more dependency on asm/prom.h.

Rob

Rob Herring (3):
  of/fdt: Scan the root node properties earlier
  of/fdt: avoid re-parsing '#{address,size}-cells' in
    of_fdt_limit_memory
  of: make default address and size cells sizes private

 arch/sparc/include/asm/prom.h |  3 ---
 drivers/of/fdt.c              | 30 +++++-------------------------
 drivers/of/of_private.h       |  8 ++++++++
 include/linux/of.h            |  6 ------
 4 files changed, 13 insertions(+), 34 deletions(-)

-- 
2.17.1

