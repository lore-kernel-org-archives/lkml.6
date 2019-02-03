Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E60C282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD502083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GAIElw43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfBCBp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 20:45:26 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:38823 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfBCBpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 20:45:25 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x131irhW003813;
        Sun, 3 Feb 2019 10:44:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x131irhW003813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549158294;
        bh=9hGI+v8Zvv5yhIuNvZZnk1DLKU8C/hGz/zfBUWBskD8=;
        h=From:To:Cc:Subject:Date:From;
        b=GAIElw432AJhn/5BDJLX9Rw64UU/xr6qJDB7DmdUnG8MhOtBl4WOPnEtamXWDaFWj
         09X1g6OGStGBAdrLhK/XADaxuXayXRb9s89oECA9ImV0IZyXm4CeK3eRQAeazaEyiP
         cB+PaMKfH3S5W5ZD9hsrlUg5ufRMNGsSonzsGt+q/FAYjZfMauRlcMGGoMb1yLPJkJ
         iuyDx3Z94brlclrmoAZXB5DFiJV0/cXQ43Bms/ZX4liY+YR+px0iwOdjWL2PVKlpsL
         nofZA7Xxw1Lkkt9N3jg/lJ7M9SrVfWGEFjNUXLPHnYmNLgrsoV/QJJrNxpy0zIKE2h
         AeokJuOJyP/IA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Rename include/{uapi => }/asm-generic/shmparam.h really
Date:   Sun,  3 Feb 2019 10:44:37 +0900
Message-Id: <1549158277-24558-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 36c0f7f0f899 ("arch: unexport asm/shmparam.h for all
architectures") is different from the patch I submitted.

My patch is this:
https://lore.kernel.org/lkml/1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com/T/#u

The file renaming part:

  rename include/{uapi => }/asm-generic/shmparam.h (100%)

was lost when it was picked up.

I think it was an accident because Andrew did not say anything.

Fixes: 36c0f7f0f899 ("arch: unexport asm/shmparam.h for all architectures")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

 include/{uapi => }/asm-generic/shmparam.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename include/{uapi => }/asm-generic/shmparam.h (100%)

diff --git a/include/uapi/asm-generic/shmparam.h b/include/asm-generic/shmparam.h
similarity index 100%
rename from include/uapi/asm-generic/shmparam.h
rename to include/asm-generic/shmparam.h
-- 
2.7.4

