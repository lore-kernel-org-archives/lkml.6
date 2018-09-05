Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D932FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2872077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2872077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeIFE0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:26:12 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45716 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeIFE0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:26:12 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so17082429oie.12;
        Wed, 05 Sep 2018 16:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nkJMkWyySy74YTvFhf6qJOX7nnDeyKVtkRXZ7YOmtxg=;
        b=Y4YdpG/KaK33dZ4awvxtur+wR3uwU0sno/IelohNMyHz+T+F3egRPkEi42dUyvFdyc
         iCF1t8/TqPCWF85kbORGGkN37f7TzvLQYGP8STBLMUVH/kpAU5bpWn5tKOsdhTo1o17F
         3sYM0ccgRGV01n12D/f7PyMqQJacf+MbGdHUa1BA0BJ1nxZhzdvX9rOJ4HD7tVjbcHjd
         igG21b0w4dX5mPoF05obWAvH49AWW97PkpJXRMMxNuHLktHMeYHAdg4gGn9G+1oZXGW4
         PJMJd2ZVt2gXWe+lXyVti3PhPWIjyFKoDQ+5z1tJlsixznfsEM/usDQF3mUIxQZx/Juj
         kPrA==
X-Gm-Message-State: APzg51B/e+T5/UIBjQ/+ls/ih3oL5MCQeHrcdiPkC1u2OYEs5AILm1B9
        mNwPmM6DsLHE59FJbT6YKo5uEH8=
X-Google-Smtp-Source: ANB0VdZHXQLfAoh+b2lVl0qV6b6ikNdv9FIHnKW2pMaIxYVtw5qVIB4LkCU/VDF7K3I9pKTuGyZBWg==
X-Received: by 2002:aca:d44a:: with SMTP id l71-v6mr110613oig.199.1536191619549;
        Wed, 05 Sep 2018 16:53:39 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Simek <monstr@monstr.eu>
Subject: [PATCH v2 9/9] microblaze: enable building all dtbs
Date:   Wed,  5 Sep 2018 18:53:27 -0500
Message-Id: <20180905235327.5996-10-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for microblaze. As microblaze only has one dts
file, always enable it.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack so I can take the whole series via the DT tree.

v2:
 - new patch

 arch/microblaze/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index fe9af267f598..c7324e74f9ef 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 #

+dtb-y := system.dtb
+
 ifneq ($(DTB),)
 obj-y += linked_dtb.o

--
2.17.1
