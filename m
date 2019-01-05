Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23840C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D748621871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1Kkj59+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAEFJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:09:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44468 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEFJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:09:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so19216904pfh.11;
        Fri, 04 Jan 2019 21:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MNMzRwNChS0yPDlWA2Dlmnwr40HNg0+jMjhl1JKiHgY=;
        b=f1Kkj59+ln9J3nnrnqDXLOv+nIHmnhOvjscxdvptJpwNzuosYtcF1SPdJ1CjiQHzZP
         oKcd9xjJRtsfDmfLHRekkheRITg3E0l3OaBoFLrcvqER06frNRcp04xUia7VsmR3tB51
         T+8jZdN2Vu+HpLCD+N/nsynS5EC5KoQA7M7b31cR88Y3JB6eqYpSqWxjvKKilMzpTftI
         EuQpES2BQvLjh7KS6W3Q+dpnos70vcEMZUOy+CbOTNvzUmxnZOBWqjbSG6pS/RYNvg6u
         v/Cn1Cx15e4xfWT/N0KjoqNUZaf9HUiSmtUbmK9OViMAmuaRWPQF/woilVe0QrVjn2mB
         c4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MNMzRwNChS0yPDlWA2Dlmnwr40HNg0+jMjhl1JKiHgY=;
        b=hAseVH7jAJx48VVBn+7omzgcFYtGKv96tMNZ/IqlmdOndJ02aAuLBRxMLV95FZbyL3
         ugbRowxbw8bUNGzkhxJrkAvD5gcZA7LLyik5GxsMm8hWNvEOpT/8dLIzqwIdVobwcd5p
         CLkn65PhtwPqmM93HCiNJDXpWcATMLxdWWhuCis9UTDD1BV8mstBSpnvmPsM0LRXiFlZ
         ogbhX7XULMWf/SsEPt9rdkEVpDHCcW8/g3uwiDIaxvl44SM9u5Z+N7c8jKmLsHf2xoQQ
         i5+nj6fcxNRwqJtUxt5yuQKiQWMw0o5x3loIo17b+8hM9k6Vgfj4Cq20wS/cpXwQf+tL
         jkwA==
X-Gm-Message-State: AJcUukdwNQ4qhyplK4I2Yh9UHgd6an8oj+5L0l8WZTSsl65dU+K1jIVz
        C7dMdtSRwwq+lCR4ax3jItkQQyub
X-Google-Smtp-Source: ALg8bN40RhT3ULq0Y9oDhTYS8FDRUSP+rbNeBKpWvQ1pNG1VajMUFqyKlNuZo1/pnz4nKbg6K3mtPg==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr3856226pgr.13.1546664953278;
        Fri, 04 Jan 2019 21:09:13 -0800 (PST)
Received: from hp-pavilion-15-notebook-pc-brajeswar ([47.11.225.208])
        by smtp.gmail.com with ESMTPSA id m11sm77147259pgh.51.2019.01.04.21.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 21:09:12 -0800 (PST)
Date:   Sat, 5 Jan 2019 10:39:07 +0530
From:   Brajeswar Ghosh <brajeswar.linux@gmail.com>
To:     dmitry.torokhov@gmail.com, matthias.bgg@gmail.com,
        lee.jones@linaro.org, chen.zhong@mediatek.com
Cc:     jrdr.linux@gmail.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] keyboard/mtk-pmic-keys.c: Remove duplicate header
Message-ID: <20190105050907.GA2525@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/kernel.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1749fc..5027ebb7b4e8 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -19,7 +19,6 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
-- 
2.17.1

