Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04FD2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCRjmGvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04FD2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeKAE2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:28:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43602 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeKAE2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:28:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id h4-v6so8082555pfi.10;
        Wed, 31 Oct 2018 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AtQivvj6hJ1qy9E/5uGhpUB8LlJCIsHqyEiYftwE/sA=;
        b=RCRjmGvEbqjdI9OzBdo0gQXu8wg9X6HwAW3XgkU7ez22isXbB5ufYHZ+1GfVHV1eba
         gXay8rKdsjLxqW5NuaC+V7hfQzg2HjqLXmpe8SvdS5FErR/MkZRSXq8GcCP6OTdKJ/Kl
         712HBpnoOqSZmW7ZQ5IbTKmC8lPJAuTZcDPkfVoy2LgWREGA9yz28ofIFd/SlEJmtf8p
         dV4s9jyB4FFFwns2J8T7GgXeBuxN7HzuO/XTNhDd+Gfp0Ns2/SNj2zNhf9sXyR1kuHNg
         6+ZG40EK7aN0o/9QM9Kup15i3/UprgIz8hMjQiT28SW/XZBnlmI61Nze5WtMzSYpgrtp
         gL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AtQivvj6hJ1qy9E/5uGhpUB8LlJCIsHqyEiYftwE/sA=;
        b=uggRndLXy5/jMUzDwFeHxKA2zTjkNuqwpf16lVjLaTH12W54xjMny0m/O4nFW7iP+M
         RaK+vsrTeG5/WaW7TIa+bWlQOimDKCGCglv92PWB8oUv1jc00ko3yK0si1FEe++3fHIC
         +kp1Zhg5Z8zp+TzasUIINwVW/NlmidM+T+fY+clzN1Dz3t8m6+XEQUSZjwB/YtwfLopv
         nD33JMFH7YKa00QG2GprXPeNuooTK2iTh9mpLMscEf0LkEaA478Z8c2b6bP/sxMnk2dv
         31+RRaumk7SJunufhpPC2BW+ubFezltsmDjb0T2Ozq5gYOtRY0XNExRjbAoyTuVZrxrb
         afJg==
X-Gm-Message-State: AGRZ1gIbeZVjJufFt50kj1XrJJ5tko/LDp756SdMvE6NVKRHwTmqhXVw
        mZxSOUIqqaAxZvJCB+kLl5T+BGZy
X-Google-Smtp-Source: AJdET5f7X7eCWJYEA+AGipie+aFbOeddYHCxOJMNJ2STdldTVRWDvnNSpIGLBnGD2MyZb2iOJffekw==
X-Received: by 2002:a63:5664:: with SMTP id g36mr4308655pgm.313.1541014149773;
        Wed, 31 Oct 2018 12:29:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z26-v6sm28926456pfh.77.2018.10.31.12.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:29:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), rppt@linux.ibm.com, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: [PATCH v3 1/6] nds32: Remove phys_initrd_start and phys_initrd_size
Date:   Wed, 31 Oct 2018 12:28:38 -0700
Message-Id: <20181031192843.13230-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031192843.13230-1-f.fainelli@gmail.com>
References: <20181031192843.13230-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will conflict with a subsequent change making phys_initrd_start and
phys_initrd_size global variables. nds32 does not make use of those nor
provides a suitable declarations so just get rid of them.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/nds32/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/nds32/mm/init.c b/arch/nds32/mm/init.c
index c713d2ad55dc..32f55a24ccbb 100644
--- a/arch/nds32/mm/init.c
+++ b/arch/nds32/mm/init.c
@@ -22,8 +22,6 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 DEFINE_SPINLOCK(anon_alias_lock);
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-extern unsigned long phys_initrd_start;
-extern unsigned long phys_initrd_size;
 
 /*
  * empty_zero_page is a special page that is used for
-- 
2.17.1

