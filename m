Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEDEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AF2217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7mND0Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfACSp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:45:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52536 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfACSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:45:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so30097564wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITHs4YFYCIBJqlnIEDmL4pdf24tyFGf+yxfC0Fh4pdM=;
        b=h7mND0Ja2CKX3WEOQZZNYqd9Wl32B4mOeHcoyNptcwaUsD1PDVzEu47VrmDVJUf5I/
         WypbBGhjGDrsNseH3LE81ezH6HRM+2k+CLcnghlohirns+/D5S+RzY88W5ncYB/QXGE4
         FbSucETcPMTEFkrY8hH7Ezrp+JFajaHzL+fEpNCZVUcWhEeCvstyL4ZBK2jmpnv3KX//
         zhlc96slJeXGPvl+PDvcNgEKSIZ3PYuexVQtTtCSTtMcJRwOKvVuipGRsELAuHweHeIM
         5kGT8cfnOeSShUJDPY4ZZYwnvDDgcJHkq2gdObP0PmXMvHEIam2ksYVYLTM8kno/zPM2
         fQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITHs4YFYCIBJqlnIEDmL4pdf24tyFGf+yxfC0Fh4pdM=;
        b=UDW0y4V/1L7AguknnIuJR6IO6NVQJEm0KSw0DNiHRHmCKaWE1xzK2voyROwLXwlCSk
         3KYiRZ2i8EdOpGTzO6X8nap5Yst/RKEDLT96K7CRKSk54AzzTjk4+4JaoaZ3F2dmEjLa
         fbcwg4/Y7KHTbqu8g1YrLw9/4I4dOFYq5g5dfHQsA77jETpYzrVgdP4YBck0Vk08wheo
         Cr/KXouj88i88E9NR3HDkJLmoVVAEKf/W0s5P3825CIQBU3oIxVvcd3IjVOFS77fffnj
         s/EmVlLx7USgQu7g/2yCG1OxKKhHsueSLEJ9H8m2MgBk65vWh6xVre9gk8KBlVgsQAYY
         5cOA==
X-Gm-Message-State: AJcUuke1osZQ3PJ32QVKakPYRXP6Lk+zuKgfZyodRqvpEWhpYwqqVHah
        CmoKyvyRPYHl9xgBnNu0MbwtTw==
X-Google-Smtp-Source: ALg8bN6PfR1Ylu4w+0u4VmomLr/zJW+6Qt2xgzQ9hKBfW94sc2lkLW4VnkWuDt9Lz7DbH3yYH4+Q1w==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr37572044wmj.138.1546541125030;
        Thu, 03 Jan 2019 10:45:25 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id t12sm52236944wrr.65.2019.01.03.10.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 10:45:23 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 0/3] kasan: tag-based mode fixes
Date:   Thu,  3 Jan 2019 19:45:18 +0100
Message-Id: <cover.1546540962.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
- Fixed krealloc tag assigning without changing kasan_kmalloc hook and
  added more comments to the assign_tag function while at it.
- Moved ARCH_SLAB_MINALIGN definition to arch/arm64/include/asm/cache.h.

Changes in v2:
- Added "kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY"
  patch.
- Added "kasan: fix krealloc handling for tag-based mode" patch.

Andrey Konovalov (3):
  kasan, arm64: use ARCH_SLAB_MINALIGN instead of manual aligning
  kasan: make tag based mode work with CONFIG_HARDENED_USERCOPY
  kasan: fix krealloc handling for tag-based mode

 arch/arm64/include/asm/cache.h |  6 ++++
 mm/kasan/common.c              | 65 ++++++++++++++++++++++------------
 mm/slub.c                      |  2 ++
 3 files changed, 51 insertions(+), 22 deletions(-)

-- 
2.20.1.415.g653613c723-goog

