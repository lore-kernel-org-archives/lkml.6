Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BBFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075CF21479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcMIVvUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075CF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJSA2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:28:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44408 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJSA2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:28:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so14414931pgu.11;
        Thu, 18 Oct 2018 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FKV7PguVhGaaFT83abrxfobePyuJ/ZBdvJ6x8a5cqo=;
        b=OcMIVvUF0GMfsZrF86d8yWroo+jUju7bdcmKhW2WHFItvRzBbiDUbAc22FlA/fZvU6
         UACA3b3wIs9U/54RNw+OW2DfKwfqP4IiycD25C4e0kCuu9ZK2vLHGKLOUgKGYF4r2Z8n
         /7E7+Gp35Y0rdLvyVZKdq71WZVggR/2xYaZq675XRmSlBTS3N3B0Kn8qqhygDDLqp4Yz
         eqQkQHKVvrYCCxiAPH1lMDp8fLbgEEkFDZIN5tZviQovcS6HW41SoHaVhYY38N5iFxgD
         AMTE8O2Q0TAatjfK5Rfv3cyRtL5cGfm+RDJ/Dl7wf9Juz6hCUcuM9AkCLs1e8LUuevhO
         teuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3FKV7PguVhGaaFT83abrxfobePyuJ/ZBdvJ6x8a5cqo=;
        b=DqIuq+uOQB+CvqbHLlJDd2/Ym6vOYHsJMdsVm5Or1BckZn8qNXPW1Ys6eJs1859RKN
         Gj7SlJ3nE2MMWMmYEDkrE0y8QG7SlFdMXIcuU5W8vo38nekJnzsM5fuUJPqygMMxbsvp
         dhN2zWD/28BacKN2ZyAdbsMSuq0GkvzCm0J/9aNPYHe73D3i7j2AlpzqMBOE1SUCqBbu
         mN1M/7/k7HlWDznWYq9MrGDApYK4cekRaJooprj+wkykCD/V7+LfCVpqy9WqyTJW6vxU
         hSdsHJcxfpyWfF2rPNZT+Q6pj/wsYlOQVXsJRidxTtdZFFXKCvM09T0zfnw75Cfb3Qzp
         8Afg==
X-Gm-Message-State: ABuFfoggHcoFiF138wHFm/5iU3NkhxzJGVUrQ9cghtto7O3zUE1plyfE
        aVScM+5qtPBw7pXRcWQmvgg=
X-Google-Smtp-Source: ACcGV60fGQ3vI6QAckWY02jxNLZN0sfT01xEM3j1WUqCQxDk1bHd8eMxfH/HYDQ2rjNo3i4tbr2klw==
X-Received: by 2002:a65:44c6:: with SMTP id g6-v6mr28329113pgs.350.1539879979903;
        Thu, 18 Oct 2018 09:26:19 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id 5-v6sm27813420pgt.83.2018.10.18.09.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 09:26:19 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, linux@armlinux.org.uk,
        akpm@linux-foundation.org
Cc:     rostedt@goodmis.org, x86@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH 3/4] ARM: mm: fix build error in fix_to_virt with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
Date:   Thu, 18 Oct 2018 16:25:47 +0000
Message-Id: <20181018162548.6399-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018162548.6399-1-changbin.du@gmail.com>
References: <20181018162548.6399-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

With '-Og' optimization level, GCC would not optimize a count for a loop
as a constant value. But BUILD_BUG_ON() only accept compile-time constant
values. Let's use __fix_to_virt() to avoid the error.

arch/arm/mm/mmu.o: In function `fix_to_virt':
/home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
Makefile:1051: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Signed-off-by: Changbin Du <changbin.du@intel.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e46a6a446cdd..c08d74e76714 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
 		pte_t *pte;
 		struct map_desc map;
 
-		map.virtual = fix_to_virt(i);
+		map.virtual = __fix_to_virt(i);
 		pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);
 
 		/* Only i/o device mappings are supported ATM */
-- 
2.17.1

