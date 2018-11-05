Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A90C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0872081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5BYBptQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0872081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbeKFIT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:19:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36716 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388034AbeKFIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:19:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so5183154plq.3;
        Mon, 05 Nov 2018 14:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rRXr2ehAZecUxevmphGf0OBMQL7jTK4DUFokuxn+GwY=;
        b=j5BYBptQkuEM6+OsRYBGazR6nXTiQUwM05QdW9d8nMpOY+BziHg6FvM1eIb5B6ggfQ
         Dhq8J92uiVin1TZKjRDm/FPtfyN1nVCCqmQiJ02jCWCrbBY1AuGqJpZkBQ9PgZHKYKsY
         SmK76O/PvwAyKC4t+6edxsMlZQJ2D58ivZ77CbVWon7L+mi9tyDZam30zs2705PQZzSm
         KnzHBLdWzPFziagtP7rWdyP8eSuSSMsLzLQLr0eqDi+ljhTgf7hqZvHGSTTCDJw+TI7V
         AhnF1OoDD5eExOyuHMlqKK94RyeT2rrGN4HCCRPF5yIUTn4/EB6+CkaraNtEM8P6Jrtm
         gdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rRXr2ehAZecUxevmphGf0OBMQL7jTK4DUFokuxn+GwY=;
        b=BfoX44GgwSK3zYnoRD66r9qa9IVe0ygNa0Xed3csKfDgylavswrAWlxam6dCRYYhAG
         dBGsmyVuO4S3NlFnCyzCfpHjl5Ekl7Noqg9xTPphXeb0CzaRQ8JJOqhnY3Ub/wv49WPQ
         yBGrWFYId3LyCkO86/VSP8GIesTZrhixdGsSgAXHQVYGmJCPuX7EfCI0EjRDCcfOY8a9
         3lbO8XMmh3EwFSAQ48irXUlEbqfcT1AfkPOtvXCjOQHKBR+4x/7PvdsY/gJYxVLlDNVC
         eEmwMczc9pkPcfYXorvcaQuLp47A2RAnzzh5wms3CDOKWf6NF9eeMhd3mceYdW5UDyBT
         kOew==
X-Gm-Message-State: AGRZ1gIpUBwN5YPTgHF0fRyefi0kBqkhSB3shNR5nmy+nDH4qCAHD7u5
        D4HmZ9n4B91tXHqeljR7fqARGy+K
X-Google-Smtp-Source: AJdET5eorykSmb1T1LSWwWGpsoKIKMnGJmcNMlcmE5EB8fW11PhYeIAy48bbWk2meiwiue+KPpDofA==
X-Received: by 2002:a17:902:8214:: with SMTP id x20-v6mr5193274pln.224.1541458674421;
        Mon, 05 Nov 2018 14:57:54 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q195sm12898479pgq.7.2018.11.05.14.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:57:53 -0800 (PST)
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
Subject: [PATCH v4 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
Date:   Mon,  5 Nov 2018 14:54:25 -0800
Message-Id: <20181105225431.24485-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes in v4:

- dropped initrd_below_start_ok assignment in ARM64, not necessary at
  all (Ard)
- replace #ifdef CONFIG_BLK_DEV_INITRD with if
  (IS_ENABLED(CONFIG_BLK_DEV_INITRD) for consistency with other parts
  of arm64_memblock_init() (Rob)

Changes in v3:

- use C conditionals in drivers/of/fdt.c
- added check on phys_initrd_size in arch/arm64/mm/init.c to determine
  whether initrd_start must be populated
- fixed a build warning with ARC that was just missing an (unsigned
  long) cast

Changes in v2:

- get rid of ARCH_HAS_PHYS_INITRD and instead define
  phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c

- make __early_init_dt_declare_initrd() account for ARM64 specific
  behavior with __va() when having CONFIG_DEBUG_VM enabled

- consolidate early_initrd() command line parsing into
  init/do_mounts_initrd.c

Because phys_initrd_start/phys_initrd_size are now compiled in
ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
we need to be a bit careful about the uses throughout architecture
specific code.

Previous discussions/submissions list here:

v3:
https://www.spinics.net/lists/arm-kernel/msg683566.html
v2:
https://lkml.org/lkml/2018/10/25/4

Florian Fainelli (6):
  nds32: Remove phys_initrd_start and phys_initrd_size
  arch: Make phys_initrd_start and phys_initrd_size global variables
  of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
  arm64: Utilize phys_initrd_start/phys_initrd_size
  of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
  arch: Move initrd= parsing into do_mounts_initrd.c

 arch/arc/mm/init.c              | 25 +++++-------------------
 arch/arm/mm/init.c              | 28 ++-------------------------
 arch/arm64/include/asm/memory.h |  8 --------
 arch/arm64/mm/init.c            | 34 ++++++---------------------------
 arch/nds32/mm/init.c            |  2 --
 arch/unicore32/mm/init.c        | 24 +++++------------------
 drivers/of/fdt.c                | 17 ++++++++++++-----
 include/linux/initrd.h          |  3 +++
 init/do_mounts_initrd.c         | 20 +++++++++++++++++++
 9 files changed, 53 insertions(+), 108 deletions(-)

-- 
2.17.1

