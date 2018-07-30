Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94313C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47092208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oebYP6Xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47092208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbeG3W1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbeG3W1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:27:37 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D3D208A1;
        Mon, 30 Jul 2018 20:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532983851;
        bh=QxggjiL2DVs6FjPf1s1rwSrySng1V+jxmrXQxrdP290=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oebYP6XxR2ks1NYmOd8js62XOeWDRWArJCNtsrGDywRWxtN2KUt116VquTy/gpEnO
         vQYQ+tpjmK40xKu4JhV0rnM1j+St9gaZHrRSImmx9SRzNzZrNYo9nLA65oUUQW572O
         27GzlYBHtEJdovI1xENc6IGAtgpNgSXKY+bf4ge8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Breno Leitao <leitao@debian.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/5] tools headers powerpc: Update asm/unistd.h copy to pick new
Date:   Mon, 30 Jul 2018 17:50:28 -0300
Message-Id: <20180730205031.12853-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The new 'io_pgetevents' syscall was wired up in PowerPC in the following
cset:

  b2f82565f2ca ("powerpc: Wire up io_pgetevents")

Update tools/arch/powerpc/ copy of the asm/unistd.h file so that 'perf
trace' on PowerPC gets it in its syscall table.

This elliminated the following perf build warning:

  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/n/tip-9uvu7tz4ud3bxxfyxwryuz47@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index ac5ba55066dd..985534d0b448 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -399,5 +399,6 @@
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
+#define __NR_io_pgetevents	388
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.14.4

