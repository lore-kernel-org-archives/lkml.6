Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1995C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F10820871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuRqVoZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F10820871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeGFJBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:01:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38501 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbeGFJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:01:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id j17-v6so7897754pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 02:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPtnS3pR0e6k1wruvZ/TmyKB2yqnQlAi9FUL26a/INc=;
        b=LuRqVoZPEbRWIfqYU1MU6QCSF8B6Zg5N9a3RwlgIKRCOR+KVsOSSj3viQldv3hmGMf
         GMSkCkr+MrV5JCQcfIvsgI4DDC9ML5GkQb19ltWaOTB4AzfmKCzgjKRkNygsZH9jSriT
         liB+Wn1NRDc8xIbC14v03tg9J5Wgg0toGMNXaAl6UhXKNfgVETWdYs5mehhfD1NBgb/C
         ep2YF3ukJWurieDqljq39BX87TJXZYD9L7euZ87hiDciWQxJLS/+gLNXtGKoerax6Hdj
         KNsPLQo9vY1gxp+7TAKiN2aC57Tw3gHCMDp/pxVyDJLrfdn1MeIRlzTFToh5C0NGJGZm
         YbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KPtnS3pR0e6k1wruvZ/TmyKB2yqnQlAi9FUL26a/INc=;
        b=X5fkf5YFNyqZqqrgeZoBHv9F9z7YA/IWD/h4fL4W9FxQUN8ljXTTnI4RFqnOjaCdbj
         HBOK4/Z4WzdKUsXnLZftXZ1/uIeZfw6iAB7kxm+ngd6CKAWFKtTmgRPogz/dEtkiQ9x5
         4vCzKpFDG+/83o7SB6Vn/JaUr79K9A/hHA6HXD+sznDQIbLdo/BXbA6x5MO70gds3dpc
         e4ZCPW9rYmjRzG88TiU9qPe0OyOueHZx5ICVgkCsfgCxtziBtxytpgE5RWB1yOnHOmGJ
         dqZFs4j5uc+KMyVldthHv95/bbi9Iw3d18wfkIglKpdjKhFCdswg4M/Ae033LRih9jJq
         jAIg==
X-Gm-Message-State: APt69E3Bw2mnK4juQsEOcZJ3XXI0Dn9Bxa69rLZn2uMZI0sOuxC1V+q4
        2nBilzHU5TkJMf9Qxw0WKWM=
X-Google-Smtp-Source: AAOMgpehkcfeqbchcOBmDvMMovxPJ2BktsOoy3RbIzObSZLAU+KvZD+8RQxXtQQp7oWfHac06YzHZw==
X-Received: by 2002:a62:748:: with SMTP id b69-v6mr9805036pfd.177.1530867710772;
        Fri, 06 Jul 2018 02:01:50 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id e5-v6sm10837092pgs.59.2018.07.06.02.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 02:01:50 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Philip Derrin <philip@cog.systems>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemi Wang <kemi.wang@intel.com>,
        Petr Tesarik <ptesarik@suse.com>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Daniel Vacek <neelx@redhat.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jia He <hejianet@gmail.com>,
        Jia He <jia.he@hxt-semitech.com>
Subject: [RESEND PATCH v10 1/6] arm: arm64: introduce CONFIG_HAVE_MEMBLOCK_PFN_VALID
Date:   Fri,  6 Jul 2018 17:01:10 +0800
Message-Id: <1530867675-9018-2-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
References: <1530867675-9018-1-git-send-email-hejianet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_HAVE_MEMBLOCK_PFN_VALID a new config option so it can move
memblock_next_valid_pfn to generic code file. All the latter optimizations
are based on this config.

The memblock initialization time on arm/arm64 can benefit from this.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/Kconfig   | 4 ++++
 arch/arm64/Kconfig | 4 ++++
 mm/Kconfig         | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 843edfd..7ea2636 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1642,6 +1642,10 @@ config ARCH_SELECT_MEMORY_MODEL
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
+config HAVE_MEMBLOCK_PFN_VALID
+	def_bool y
+	depends on HAVE_ARCH_PFN_VALID
+
 config HAVE_GENERIC_GUP
 	def_bool y
 	depends on ARM_LPAE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090c..26d75f4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -778,6 +778,10 @@ config ARCH_SELECT_MEMORY_MODEL
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
+config HAVE_MEMBLOCK_PFN_VALID
+	def_bool y
+	depends on HAVE_ARCH_PFN_VALID
+
 config HW_PERF_EVENTS
 	def_bool y
 	depends on ARM_PMU
diff --git a/mm/Kconfig b/mm/Kconfig
index 94af022..28fcf54 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -137,6 +137,9 @@ config HAVE_MEMBLOCK_NODE_MAP
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool
 
+config HAVE_MEMBLOCK_PFN_VALID
+	bool
+
 config HAVE_GENERIC_GUP
 	bool
 
-- 
1.8.3.1

