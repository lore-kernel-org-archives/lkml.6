Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE74C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3991A22460
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmdhb0rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991A22460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeGGCmf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:42:35 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44102 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeGGClg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:41:36 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so3623954pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zkn9dFnQlHslnUrsRQayj6aOWnyIAcLJ8Ykx53qHclg=;
        b=mmdhb0rpFkgZjB4XRtnFsdKciiesV7wJpDPMOk28oouvW8fHwLeyGjsaby8MkIvEsh
         UMJKgcGCED/4HIoBdxbVXLn0bx+oKZqYz2h/ZiHP1CUQ7JGXcWSu0vMsxPF7TNjAj0bP
         /nBQTGTGHh31LJxB5KdvBEzxPfML5vhc9j5Wldys9k6rWs27F6fE+QywZ/WPeSpHcwoy
         5qO7sLgRn42GwoJUAQNHrm09qax9F+fuSLVubVSUhO003AeKiJf//o8UOxNx2UqvMyDm
         6zFJsJgqX6JGKuox50fQbYTlA2t6coJITgMWfcjqiOqCuHhXBU1x0DxoMks423Kqy7m6
         7IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zkn9dFnQlHslnUrsRQayj6aOWnyIAcLJ8Ykx53qHclg=;
        b=mgwJcfm9YGl9/mvhvmOPZ7u+lcuqTZh0UzBfVrajZN4FcDKMLV8PMOU8qNo99dAcui
         bTWOob9OyamR2neLWokIV3YvnCqWKlR4lAzh2/OusddDtn8PEHeFGXHIiwmHN8Z03jhU
         SwWq9wbqKHcWAEcn78wtbo2/hlQTdPmCbkRKHEcnnN+JP1NPQCk/J6StjWl5YcZk0iqC
         qnVkE7VT12uHvghOhNbn5uGfKmkMRnvjm6IX8qv5rQYLZNtR62ZyhZ6WIxXiGnWrTt3P
         sC9zacAwlPwwuX5/EBc1v+qSZ4/YxPEDVGxwO6PoUWkeN+FoZhD/CfuABKc6febtL7Ph
         lNjg==
X-Gm-Message-State: APt69E2upS+cDyxPRsiHeCsK+6O5g/QNEqpDQu2/YpE6Q4FheJGuB5zN
        ssA55sJ2AgWZZ3MDy5s8taw=
X-Google-Smtp-Source: AAOMgpcNwGAnLycKRSkOaiDrhKPB6ya3kt1mhX3+8gJ7GCnWHs1uVdl44wCQAEYkbGOTe4WBOaheqw==
X-Received: by 2002:a17:902:a505:: with SMTP id s5-v6mr12516922plq.66.1530931295934;
        Fri, 06 Jul 2018 19:41:35 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17-v6sm18897276pfj.95.2018.07.06.19.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 19:41:35 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 2/6] mfd: rave-sp: Fix incorrectly specified checksum type
Date:   Fri,  6 Jul 2018 19:41:04 -0700
Message-Id: <20180707024108.32373-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707024108.32373-1-andrew.smirnov@gmail.com>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RAVE SP firmware covered by "legacy" variant uses 16-bit CCITT
checksum algorithm. Change the code to correctly reflect that.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index dfa4f5f1c376..a90ec4986b22 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -697,7 +697,7 @@ static const struct rave_sp_checksum rave_sp_checksum_ccitt = {
 };
 
 static const struct rave_sp_variant rave_sp_legacy = {
-	.checksum = &rave_sp_checksum_8b2c,
+	.checksum = &rave_sp_checksum_ccitt,
 	.cmd = {
 		.translate = rave_sp_default_cmd_translate,
 	},
-- 
2.17.1

