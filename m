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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE568ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572842154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGiikT43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572842154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbeIVBXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 21:23:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33781 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391160AbeIVBXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 21:23:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id n8-v6so2775349edo.0;
        Fri, 21 Sep 2018 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrPwB5WK6Ja+Zrc0WKMAwtEMtqbjprwaDXYCO1vI8XE=;
        b=HGiikT43fDU+Z39LU+rk3/TxywjlnnYCMT5Uc9YZQEyz84jyq4/uLcnY8J+uTKZ83Z
         2q0nMjmWIsIbtNosP5tX7AuC7qVhRbbqTPD+fsVN2ngTFE3KCL5ZF5+BXLfi1FDLYP8l
         RG7/l5Vm4h8/PjtcPOJxt2swa4Oa4N20ewKm/SQTDQGzwhN8GSSVCKr+20dbj+NAf4+1
         zEhEZIcFq+7Mv2nwMcSdkqNE1HougEQPirJjmU6u3M2qmgysDsmP+yfZyOKY2s3+WiqI
         L60WRbCO30pSS0bW0ILz7oPSdYcKoPZL8U0TILL9XTGag+GE1448X9ygiOcXMcQMVefQ
         CYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrPwB5WK6Ja+Zrc0WKMAwtEMtqbjprwaDXYCO1vI8XE=;
        b=rLfqvzUUed3iuzuf8zLZ18qyqx9urw5ujjuZk6+ZN38JqkgdQtboFTeTr9zGYSeIpA
         MC/N4XWqqMvQ8lpAgMXUmqe6P9PN7WyA1tQL9vcNQvL45E4Z/eSX4Q2iwCQWcPaUpsH+
         3nY17GImjcrtys4H9zaWgoSaWfNqaQskEzqIhgJxqG3hpL/7uljOxR9ZS9d0/YGoYcvV
         fXmstVJ2lNTYQ/Nrc51Fj70VfrySXvgfvbr8yxSc2pSzxf1nVO3bOfZ43CXuBc91wyTt
         3HiNbHDSjsAAA+eP8GQ3u8WmXYzckHciIs6B+df+Wz7xsrJV8IE8UY3RHUzre930LFus
         ROIQ==
X-Gm-Message-State: APzg51BmsJ5co8icKtjqg7+K3seYZVVDN7TduKsmVQwDL6FbnyuUP/lE
        UsBr3Sb/634plnnlfyFoNrI=
X-Google-Smtp-Source: ANB0VdZCPz5o0UJt724oiodS2t5QuRFsRS9SFPIr9b3dI4YEef6BlEPsGWus/gtbzZCfCjG1rnNANQ==
X-Received: by 2002:a50:b2c6:: with SMTP id p64-v6mr7393691edd.293.1537558412140;
        Fri, 21 Sep 2018 12:33:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z56-v6sm5366812edz.54.2018.09.21.12.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 12:33:31 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] ath5k: Remove unused BUG_ON
Date:   Fri, 21 Sep 2018 12:32:36 -0700
Message-Id: <20180921193235.1723-1-natechancellor@gmail.com>
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
just remove it.

Link: https://github.com/ClangBuiltLinux/linux/issues/130
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix incorrect link

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

