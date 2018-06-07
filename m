Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cP3HCAZzGVvdVAAAmS7hNA
	; Thu, 07 Jun 2018 19:38:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AE1196074D; Thu,  7 Jun 2018 19:38:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qVS8Qxup"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DD94D601D2;
	Thu,  7 Jun 2018 19:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD94D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeFGTiV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:38:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38583 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeFGTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:38:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so8359868wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CiSIiqV4WQ+QOpQO21lmsZ3iZl+daa6ujnjnGsFTJqg=;
        b=qVS8QxupwD9v8Hz682BYIhc6Q+AJG7/O2X6lBdRdx6LHBxrXwjZkHNLrkByK5+59EX
         +yujTGDjialsadDQ8d6rAPVb28RzsWxqWBaozmhwqj3hdp18p79+6alyd6Q6UkUYCK/w
         6OpCmQZ8XL40l+hAY2tF/AcnVv7AxpHvVyDGdt6JZRhwRGZLh0Ip+Lyi6WhBP0Ix5VGi
         Ah3iZyDinlu7z9grZAgLk5yQtoErG5gXepG0etdNKHxs8NYKydsq6KEL9aeuEhQ5qH2e
         lWB3fezwVfP+RrJEE7aYTEO2C+QfOLOxHTv2DfOVTaIOnnEQ+ECjMNBxt+R/J4EeoSnk
         a2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CiSIiqV4WQ+QOpQO21lmsZ3iZl+daa6ujnjnGsFTJqg=;
        b=gXQ77CFHq8k5XoMcqwm172iQ+9Fcd7wobTtoL8hk5zEoVQrfEYaSq+VNWnOqg3P7rO
         ITwUV7pZOYpMxrtmFgSotmNKiymTy5TSK0UaZxiwcM6fcI/5vA3KGu+ni6TFshwuw1Qh
         nJ7W6zgbxlsc6lgZXSRIWxvMoP5ZA9xgKBeY9wZj/ZRiL/6rKf/nMzObY82Z6OhZF/uc
         +aTxXmQvtoHGUe3CTAAUBumtFPUMO733hMBdtNVxu3rm5ddyjdjOjTFkfIY8p9iEAzKe
         h0pw4kAZukwgb5Jdq+Sgrqq0x9rEQrCd87jANP13wbNOHZn6P1nzKVVB9zTL5/Zu5Me9
         M8vw==
X-Gm-Message-State: APt69E0JAfwhDxplzw1vWCPVc50SToXo+IU4nnHwkWGWVR/oBnTkf0f7
        AlEU3jnHMi2Ty7MnrrHi4orMUw==
X-Google-Smtp-Source: ADUXVKJ/X7JPng9dLiP3cY6WR3Vas3Lhvt4I8NY+MxIN5fkLRwkGzjYWQaNZJGxcevJXhUE++9yW1w==
X-Received: by 2002:a1c:da4e:: with SMTP id r75-v6mr2486312wmg.64.1528400297974;
        Thu, 07 Jun 2018 12:38:17 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id o138-v6sm3253342wmg.10.2018.06.07.12.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 12:38:16 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: davem@davemloft.net, fw@strlen.de, kadlec@blackhole.kfki.hu,
        pablo@netfilter.org
Cc: coreteam@netfilter.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] netfilter: remove include/net/netfilter/nft_dup.h
Date: Thu,  7 Jun 2018 19:38:09 +0000
Message-Id: <1528400289-28004-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/net/netfilter/nft_dup.h was introduced in d877f07112f1 ("netfilter: nf_tables: add nft_dup expression")
but was never user since this date.

Furthermore, the only struct in this file is unused elsewhere.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/net/netfilter/nft_dup.h | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 include/net/netfilter/nft_dup.h

diff --git a/include/net/netfilter/nft_dup.h b/include/net/netfilter/nft_dup.h
deleted file mode 100644
index 4d9d512984b2..000000000000
--- a/include/net/netfilter/nft_dup.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _NFT_DUP_H_
-#define _NFT_DUP_H_
-
-struct nft_dup_inet {
-	enum nft_registers	sreg_addr:8;
-	enum nft_registers	sreg_dev:8;
-};
-
-#endif /* _NFT_DUP_H_ */
-- 
2.16.4
