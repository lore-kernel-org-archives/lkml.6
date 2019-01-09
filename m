Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C15C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70546206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UdoRaU5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfAIVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:52:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38247 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfAIVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:52:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so10114590qtl.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jeotiuDVoAXBD8bBhdnEFNFA+yIhydpgnnuKWR3Opek=;
        b=UdoRaU5maG9XAVYpx/3i8tXhBjy8/XNEIdWTEhzNxL4YG6nLivUjzKN+M48wXeFqn3
         pNCN2BMR4zKiFNJ27tUzD+DjkIYdHztbsfTsxB9TXxIuxncDlXFDYjq3n9RU/dy8xfck
         xyMKhdnbdU3cMyiie5QQmhYzNNceXI1J+nRoNyXXQHevRUH68Ul4L1FWLRlo3hgxVbo3
         c2ZRxJxT2uzWsesG1wGdTdHrVIp2masoUnDZM6YLgbAvPVQud7r5u1dNDz4la3GkdIRx
         gWf19J7zZpkVKJxTnHRV0DZaE0BkcCHAs5QUQSFS4dtEJawktU1Q5hPXBqW7JktwPS04
         dsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jeotiuDVoAXBD8bBhdnEFNFA+yIhydpgnnuKWR3Opek=;
        b=KAWpXbb/R6liDRQKpKmSb6qloMl1FoXY8ZRQSNsqO5LS06c9QjVFKeYxTK6rlB/ACX
         kNT7+QQskAfhdsfnL2WxhFOWtbVbcVvjZARLy3dqFlMH2+Nm4D1aG9JWnid9T0JrDoPm
         aGNyrDWs0iTTVErHQCjS4MczwbssRR5kxg1SDCcOwtU5d7hPNBUB4txMqU31pGW3fs+f
         fkpPHi728ZRCUHRvOhz1v9klPV2qY3PZx98mCfoyDGjV8Cd7rgRSG9MJSVxvFmJxPVDu
         DtB9fBhTE1CPS/8TmSLQ8QMclxDvZG9JVLIcZQqzbsiafI8u2CgULgYpJN8G5X2aXf8u
         yIvw==
X-Gm-Message-State: AJcUukciuEwTT3GsgTglEaKNcZE51fU8coEPfXjUb/Vk+OlKmGQSBu9l
        ZrNP+FLO/YcmRVrUis6on6Ujdg==
X-Google-Smtp-Source: ALg8bN6B5ViLzzSzrmwRZOWL2XY9G8lfKwbBxnNO7yj++3yTeCeUnb2jJz9UaTqAzu8pR2akY8dTXA==
X-Received: by 2002:ad4:410c:: with SMTP id i12mr7344672qvp.219.1547070744788;
        Wed, 09 Jan 2019 13:52:24 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id w15sm42593452qta.16.2019.01.09.13.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 13:52:24 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] x86_64: increase stack size for KASAN_EXTRA
Date:   Wed,  9 Jan 2019 16:52:09 -0500
Message-Id: <20190109215209.2903-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20181228020639.80425-1-cai@lca.pw>
References: <20181228020639.80425-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel is configured with KASAN_EXTRA, the stack size is
increasted significantly due to enable this option will set
"-fstack-reuse" to "none" in GCC [1]. As the results, it could trigger
stack overrun quite often with 32k stack size compiled using GCC 8. For
example, this reproducer

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/\
syscalls/madvise/madvise06.c

could trigger a "corrupted stack end detected inside scheduler" very
reliably with CONFIG_SCHED_STACK_END_CHECK enabled.

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks. Some noticiable ones
are,

size
7648 shrink_page_list
3584 xfs_rmap_convert
3312 migrate_page_move_mapping
3312 dev_ethtool
3200 migrate_misplaced_transhuge_page
3168 copy_process

There are other 49 functions are over 2k in size while compiling kernel
with "-Wframe-larger-than=" even with a related minimal config on this
machine. Hence, it is too much work to change Makefiles for each object
to compile without "-fsanitize-address-use-after-scope" individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Although there is a patch in GCC 9 to help the situation, GCC 9 probably
won't be released in a few months and then it probably take another
6-month to 1-year for all major distros to include it as a default.
Hence, the stack usage with KASAN_EXTRA can be revisited again in 2020
when GCC 9 is everywhere. Until then, this patch will help users avoid
stack overrun.

This has already been fixed for arm64 for the same reason via
6e8830674ea (arm64: kasan: Increase stack size for KASAN_EXTRA).

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/x86/include/asm/page_64_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 8f657286d599..0ce558a8150d 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,7 +7,11 @@
 #endif
 
 #ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_STACK_ORDER 2
+#else
 #define KASAN_STACK_ORDER 1
+#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif
-- 
2.17.2 (Apple Git-113)

