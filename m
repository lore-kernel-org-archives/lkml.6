Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7ACC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9407D20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivMDXyln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9407D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbeKBAsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:48:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38101 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:48:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id p7-v6so9136870plk.5;
        Thu, 01 Nov 2018 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6znPA5uNEbsLp8GZPzykYrcBihaGyA6Tm5WRG2JXOsk=;
        b=ivMDXylneeqV6mo1KQGkmYZR2MUxwcXZI+QNYqSZw8LO13KCcRvtfY/+qChjSUzPYX
         ixFjoZ+pHpkiDEBQfycoipTbpZmbelfJyh7qtv6jl8VOJhVN3oUcmCrxuckSZ9v2TtVH
         NRYaFb95xzp6k7iFSARRSDK+7A0ohT7V48KkCFfWIZV8lq23sU8H6bM6us55oEClb66R
         IjN9U9RuQKlhInKjrRVPZ5JhkjUb/RPCzqTalbAHRgg5D+yRLUjFENMKcnNCE3aur3Pt
         HIk7GFqUhOpap9zOcrt1Z+14gsHgKk3RpHKeJtKqRHWXaX5iz/uKne6Amg7ZhX0DvtBH
         ObrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6znPA5uNEbsLp8GZPzykYrcBihaGyA6Tm5WRG2JXOsk=;
        b=QYbPQA+yRcdZQe7Swa7RDreuEsd+4Ze+jBZeYEEbI5MXLBKr4/8y/URCfkslUaYpw9
         C3Q3SoPX3sl3wg7lfOZq7rn1HpPHppI8lDXBlM0yNUJ2pFHO/6w89nvC/1gagWOUmKOB
         zDOgMF0e3BqiTCneUKktyRFIneqwT4TQg6iqesGrzJiG7Efz/KpMye+7JOvxbSOadMUZ
         y4GfpZ2ZBC5MvTCA4zVjeG8IHhjxw9P2IYQpnhwbuk4fL3AK+KnwyTFkkz4KvktA8qk8
         N6jUABrkClm8AqvV8zdcLW54tIGAqBoRbX09s+ryCnT/FwvvvpNRUoB0nhvvHnhlljPC
         ckqQ==
X-Gm-Message-State: AGRZ1gIYEaUwOYQzeDOsKfRK6+Vzz1+RIdyeVGHni86nG9ORLDj0vfF2
        ywGpAWTDZIloKtXe/v/uANUFn5qf1ic=
X-Google-Smtp-Source: AJdET5edoMdTlyP1//1rmT6w+1wcV10l6hW6xh+P7S6ayQb/hUrpgoTkrr7lsZpRYpQW90UbH1xvsg==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr8235005plb.76.1541087074380;
        Thu, 01 Nov 2018 08:44:34 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 62sm7104194pgc.61.2018.11.01.08.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:44:33 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sean.wang@mediatek.com, linus.walleij@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] pinctrl: mt7622: fix small typo
Date:   Thu,  1 Nov 2018 11:44:27 -0400
Message-Id: <20181101154427.23110-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 6f931b85701b..9b00c5e6ba8e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -977,7 +977,7 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
 		return -EINVAL;
 	}
 
-	/* Caculated bits as the overall offset the pin is located at */
+	/* Calculated bits as the overall offset the pin is located at */
 	bits = c->s_bit + (pin - c->s_pin) * (c->x_bits);
 
 	/* Fill pfd from bits and 32-bit register applied is assumed */
-- 
2.17.0

