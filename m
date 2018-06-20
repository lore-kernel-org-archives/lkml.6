Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B216CC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E4120874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUXACcRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E4120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbeFTTAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:00:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50506 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753989AbeFTTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:00:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so1207771wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UC5dXIGt593eVM6AX+ICADj2mmyQXD7nyucwhBOKZ/E=;
        b=uUXACcRJEoQvaRhUlwH2qg4BEGme4hTyCfQlPe7VROBth/XbZYxFl6hHOUwDpcMcrI
         uGdwheMv+RNg8+14tTxEHQvPGoNVbQiVZ/SYSf03IJiSxk6sawwwU1lgbD57c0bUZUG1
         f2U1sbZaZm/QYPHwllRIYRVAvG+X/9kWN3HO4uxAQTYkbQgcCXB6+Y34NgfXchjIOtlY
         UW8Wpj1rJggzWM0rQ8Qnl7/gKU/7pIqhEl+fY9Jb4hvk3jS4xLyPOIcWvBP/z/vETzPR
         JkSlQHoTv99dDEUMzAbxRU8MlGLQbXo86q/T0vZEl3AXwOh8/Qq7lc5U9QsOpn63/VCN
         9Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UC5dXIGt593eVM6AX+ICADj2mmyQXD7nyucwhBOKZ/E=;
        b=DZP7Zq40SWj3dmf8P6bnzBEUdw5SdXxE+GApsNfCwCdgl6jz4OyHjK1p2CX56eo6d7
         9Mm7kBQdGBZH/WErqmNdr7/pUdlVodqOGzW3h8i2E0rbRI5tY74u5QcCWZUJc8rjT4k2
         +k9LfcJrzPHSzm70oui4VPLWp0/Gzbth9pfICPfon4mlLxZcbD+ouysWtP4+3T2LTrnP
         4gMS14NjZb838fvILM3Mh2v+zaLkc4WpY0c2XRFJGzLO4+SoBJUsvHDrH/tuxyaUkyrR
         WwbFNCYOjfGzZ/tsgu08Kvj8BNrAixY4kpwRttvY/qvWNiPSAnXW+EgFZkr7ZaJildYp
         oUtA==
X-Gm-Message-State: APt69E2UTaqHPDXDRpsnZVOLZ02LHNFrfk11mJjM2kvuPzjQhtTiNneq
        CdklVdYlit1H1glJ2dU4fSbAxd/i
X-Google-Smtp-Source: ADUXVKJ8cor+UfCtns2gpHoSXeGouPsIyUtrklbrX5pUVuUG6uu6t0w9Q6aWc1AzeLIPmYDttOidAQ==
X-Received: by 2002:a1c:b80a:: with SMTP id i10-v6mr2830672wmf.123.1529521242833;
        Wed, 20 Jun 2018 12:00:42 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id 72-v6sm3659924wrb.22.2018.06.20.12.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:00:41 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 189AB10C03DB; Wed, 20 Jun 2018 21:00:40 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc/32: Remove left over function prototypes
Date:   Wed, 20 Jun 2018 21:00:37 +0200
Message-Id: <20180620190038.3250-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180408194821.19682-1-malat@debian.org>
References: <20180408194821.19682-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 4aea909eeba3 ("powerpc: Add missing prototypes in setup_32.c")
prototypes for

- ppc_setup_l2cr
- ppc_setup_l3cr
- ppc_init

were added but at the same time in commit d15a261d876d ("powerpc/32: Make
some functions static") those same functions were made static. Fix
conflicting changes by removing the prototypes and leave the function as
static. Fix the following warnings, treated as errors with W=1:

  arch/powerpc/kernel/setup_32.c:127:19: error: static declaration of ‘ppc_setup_l2cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:140:19: error: static declaration of ‘ppc_setup_l3cr’ follows non-static declaration
  arch/powerpc/kernel/setup_32.c:186:19: error: static declaration of ‘ppc_init’ follows non-static declaration

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: correct subject line to be less confusing
v2: Previous version contained the reverted patch, correct that.

 arch/powerpc/kernel/setup.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 35ca309848d7..829ed66f0a40 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -19,9 +19,6 @@ void irqstack_early_init(void);
 void setup_power_save(void);
 unsigned long __init early_init(unsigned long dt_ptr);
 void __init machine_init(u64 dt_ptr);
-int __init ppc_setup_l2cr(char *str);
-int __init ppc_setup_l3cr(char *str);
-int __init ppc_init(void);
 #else
 static inline void setup_power_save(void) { };
 #endif
-- 
2.11.0

