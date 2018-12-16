Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84529C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD8206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 15:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eDv9TxRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbeLPPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 10:05:17 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:53299 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 10:05:16 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBGF4hLs015268;
        Mon, 17 Dec 2018 00:04:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBGF4hLs015268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544972684;
        bh=MA2Jjh7xK/VA5C7P2Ase8nz3E8v8zThDpaq5G92NU/I=;
        h=From:To:Cc:Subject:Date:From;
        b=eDv9TxRfP3f3YMZVKyBhfCTKWqH/1ScVCmmJfX+gAqIrNham8+fCqOtthajF6YSKx
         Wv4qnwc2890CMsIH0998FiYCXjcyFZK0J/DD7yMzG5TvDOLpCZMdAZYegXYGM/ErSh
         NYB4MplaOcmzKw27LelRC1No6ovt+O6GaRFPCmz3Scl6zU6fWebjapiCT4k+IBBKU/
         LhJo1tnAv1T80ZLIolSyaqQRmBqROLVioVvDJdn4T9OWku0jicVCbQfVqt//ZJuKfO
         WaqZlO/UBsoQRn/ljrviouzXImcgxJkw5wJWxdrGCk10Bl+MNssCzRZtPgdjxz8il9
         T2PeiWu3NeR+w==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: promote bpf_perf_event.h to mandatory UAPI header
Date:   Mon, 17 Dec 2018 00:04:40 +0900
Message-Id: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c895f6f703ad ("bpf: correct broken uapi for
BPF_PROG_TYPE_PERF_EVENT program type"), all architectures
(except um) are required to have bpf_perf_event.h in uapi/asm.

Add it to mandatory-y so "make headers_install" can check it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/asm-generic/Kbuild.asm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/Kbuild.asm b/include/uapi/asm-generic/Kbuild.asm
index 2138144..355c4ac 100644
--- a/include/uapi/asm-generic/Kbuild.asm
+++ b/include/uapi/asm-generic/Kbuild.asm
@@ -3,6 +3,7 @@
 #
 mandatory-y += auxvec.h
 mandatory-y += bitsperlong.h
+mandatory-y += bpf_perf_event.h
 mandatory-y += byteorder.h
 mandatory-y += errno.h
 mandatory-y += fcntl.h
-- 
2.7.4

