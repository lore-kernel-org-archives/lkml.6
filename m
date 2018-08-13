Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E5421776
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeR8b7Bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E5421776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbeHMX4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:56:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41022 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbeHMX4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:56:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so15414604wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 14:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9Fru04mQ9gE0He6W4Qg1uqiP2bCdRM/xy7AsxN17xl8=;
        b=WeR8b7Bqkyq2mqxVFe3sWMb1KUYKJGLvI9+UZSK9ZKQqgPXXz3mPzFYKX9hXf2A5ir
         FNiG8XePyBKLsZ78P9zWLaDvnAYpKifcIPshccMNaBPn8Grx2hrohN837V7C7cKAbUbd
         qNYJ54GBOUEu+QLMV679RXQEVk0q2t0Wdi+qw8GuJHReY3i53APE2YbCLK+iD2WkwFpA
         eoM6+RtWu1jySI7LarchXHRdUuxqtNoJgrP0wEAOBfT638F0hyct7yP6fbrxWixABlnm
         oMSulW6b9GCy6XxN/x2PoVX3pzIlI+h/3zu0EdixlEgJ19yJffvjlJH1LjGTjdgM84mR
         /lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Fru04mQ9gE0He6W4Qg1uqiP2bCdRM/xy7AsxN17xl8=;
        b=tCJXN0iARoQu2rYC7NCVy/2NdEJ7VgZYemeZNEQlt3fv+DUYN46jCRmx/eVnYaUeE0
         9bA+Nc9a2j6kyF+EZMzoI1nE/a7ljTdaBQA06j28YdBXiCX5iV76eqx7/DLkczGYr8cv
         7Eg/VjXA+HdaUn0rqjgDQVVcVjJVafVwQoXOHZW5w7ZxQv+Piaom5FQYCvMcFnDwMdd7
         aWrGOaAis2BiFbR5KLE8NrUPw9SkzNx+JsHTzfFS0Vrb3kq6FlcNrA0A9ZC/BTu4D+9o
         sjp6knTt67MbPW8IIQ09SHH6eNgmzGp/puCK3MRrJQ62Fzk9WuH4OvYPZ37KB7E/FyUm
         XAgw==
X-Gm-Message-State: AOUpUlEO7qT2GLcwf0YdJOxTu1Dpa0HxRmwgxki+T+H4E+1h77ja3GNO
        G0lHweKoOHjKFe+H6TQEcEQ=
X-Google-Smtp-Source: AA+uWPzwlcyYrJ9gLsYuuSy/yyw0ZoP/om+5hk68nqyd8kgeX/EyRKZXfaeB5AbZukTYaXXgSdmJOw==
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr11868885wrs.276.1534194762649;
        Mon, 13 Aug 2018 14:12:42 -0700 (PDT)
Received: from terrence.localdomain (cpc96818-rdng27-2-0-cust102.15-3.cable.virginm.net. [86.30.200.103])
        by smtp.gmail.com with ESMTPSA id n14-v6sm6620629wmc.14.2018.08.13.14.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 14:12:41 -0700 (PDT)
From:   Tom Todd <thomas.m.a.todd@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net
Cc:     thomas.m.a.todd@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtlwifi: efuse: fixed a line length coding style issue
Date:   Mon, 13 Aug 2018 22:11:21 +0100
Message-Id: <20180813211120.17015-1-thomas.m.a.todd@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a code style issue. Line length over 80 characters.

Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
---
 drivers/staging/rtlwifi/efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/efuse.c b/drivers/staging/rtlwifi/efuse.c
index 1dc71455f270..49ec9728fb04 100644
--- a/drivers/staging/rtlwifi/efuse.c
+++ b/drivers/staging/rtlwifi/efuse.c
@@ -245,7 +245,8 @@ void read_efuse(struct ieee80211_hw *hw, u16 _offset, u16 _size_byte, u8 *pbuf)
 	if (!efuse_word)
 		goto out;
 	for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
-		efuse_word[i] = kcalloc(efuse_max_section, sizeof(u16), GFP_ATOMIC);
+		efuse_word[i] =
+			kcalloc(efuse_max_section, sizeof(u16), GFP_ATOMIC);
 		if (!efuse_word[i])
 			goto done;
 	}
-- 
2.18.0

