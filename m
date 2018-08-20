Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EA32172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTGf/TP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EA32172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeHTTdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:33:39 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 543F02172F;
        Mon, 20 Aug 2018 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781843;
        bh=+nj5MyjV2am5ZmDD+EaGEZawyKEBTG7mYEGgwsb2ABI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTGf/TP5QoCC8K5Baw/N3w/U70Ash52bYJQjknoQhGiWB/xlgU8a8VALoKS5hWGvi
         6uAHeGSSmrBNm/tyJoDUPlfxz+6XtmHxQFuFuz/Wmn+Z/iqO+SNHx7IEzB/K5HZVQt
         hvniQooMBjTErXWucjgYGdYGN+XcNO2AHYCRAzI0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Jan Beulich <JBeulich@suse.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 21/21] tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf bench mem memcpy'
Date:   Mon, 20 Aug 2018 13:16:02 -0300
Message-Id: <20180820161602.6830-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To bring in the change made in this cset:

Fixes: a7bea8308933 ("x86/asm/64: Use 32-bit XOR to zero registers")

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  LD       /tmp/build/perf/bench/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-sad22dudoz71qr3tsnlqtkia@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 298ef1479240..3b24dc05251c 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -256,7 +256,7 @@ ENTRY(__memcpy_mcsafe)
 
 	/* Copy successful. Return zero */
 .L_done_memcpy_trap:
-	xorq %rax, %rax
+	xorl %eax, %eax
 	ret
 ENDPROC(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
-- 
2.14.4

