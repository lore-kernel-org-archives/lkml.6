Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB80ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878D4208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeLIAlzZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878D4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbeIUPOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:14:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36697 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:14:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id j192-v6so2473652wmj.1;
        Fri, 21 Sep 2018 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ao3pmJxQsgWpuj+FkY3KcBUAtFX0U9m0rbGeglbE9s=;
        b=DeLIAlzZQDBfpoXMx4SykqGyDM3L0OFBpelFcPr5YVUgOeUcqGpIO7JW/f5t7j6TN3
         24Gamj+fKoOkfjXsC8/sRG4PImOfaJZ5jMwRGhlOzor22I/Rr5SzLfaqQLx/ggcmFqT7
         LkNlJ6L/lRH5Nnfue+vVhtB6PDezA59S70+Kv7Jn/kcdmPq1CMWuyyVFrtn+ul5afETk
         D5+rvDAc52o8fZ1LGXynNLjn6orUk1uqHFth3wFRXzLkN8IegTk1L94+yqdGQWL5fUm3
         jmbkUifLyhVbJ5f5RTVF/8LtYvn+GaSnzCDaAnY/1u1eBNPMJ134R7pDo4qS7IrU+qQE
         asww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ao3pmJxQsgWpuj+FkY3KcBUAtFX0U9m0rbGeglbE9s=;
        b=tBD9oEfn99xuUWiQlzk3qKLGIWFp2QEHCFq2UNYMMyWz5SOV5k8S6GSiEiLsxHCv02
         T4i/cQp6Os/zTMOmpsUiWJl+mS9NqBKGdmmrAtcNjSEOx1z5j9sdQrXjjmjNlOrvqn/y
         CeaH+80jYZKQzq73nQh6FTWATf6qzjcDPSf3hqZrpw+BIpAVjHqGbRQcFpyqq1e2ziJz
         P88gJhlbn6FDcq/XlUGAYOCoWnrEJ+rZf+CIMWyu4FBFaDEwPjQMpfax5sOn1m3cKh4v
         B2x+IZMh/MYv8gi+vRmHlje+Pm8CfBeq2rSjzVN+RXgilYMQrbq+TadAnucZp2buarjK
         2GhQ==
X-Gm-Message-State: APzg51ALhVuCfA0uQqoFbi4LUihoHhNnpyaU3aEfKYnOcKzpCUu1JOXN
        O7yuvQRzH691MIAx4kohvh0=
X-Google-Smtp-Source: ANB0VdZWEr/ARB7X23HEzXKKuJAog7CHIK5gTHEBvtqvnSV1G51m6FXLhogQXEi4pP0EcOeL4Z7ILQ==
X-Received: by 2002:a1c:b157:: with SMTP id a84-v6mr5784366wmf.18.1537521989677;
        Fri, 21 Sep 2018 02:26:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f12-v6sm5332767wrj.55.2018.09.21.02.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 02:26:28 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ath5k: Remove unused BUG_ON
Date:   Fri, 21 Sep 2018 02:25:48 -0700
Message-Id: <20180921092547.28414-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that the address of a pointer will always evaluated as true
in a boolean context:

drivers/net/wireless/ath/ath5k/debug.c:1031:14: warning: address of
array 'ah->sbands' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        BUG_ON(!ah->sbands);
               ~~~~~^~~~~~
./include/asm-generic/bug.h:61:45: note: expanded from macro 'BUG_ON'
#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
                                            ^~~~~~~~~
./include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
# define unlikely(x)    __builtin_expect(!!(x), 0)
                                            ^
1 warning generated.

Given that this condition is always false because of the logical not,
just remove it to fix the warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/142
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/wireless/ath/ath5k/debug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index e01faf641288..94f70047d3fc 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -1028,8 +1028,6 @@ ath5k_debug_dump_bands(struct ath5k_hw *ah)
 	if (likely(!(ah->debug.level & ATH5K_DEBUG_DUMPBANDS)))
 		return;
 
-	BUG_ON(!ah->sbands);
-
 	for (b = 0; b < NUM_NL80211_BANDS; b++) {
 		struct ieee80211_supported_band *band = &ah->sbands[b];
 		char bname[6];
-- 
2.19.0

