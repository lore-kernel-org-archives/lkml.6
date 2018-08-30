Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF4AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE4120645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RphcGtFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE4120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeH3NU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:20:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33187 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeH3NU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:20:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id i134-v6so1321856wmf.0;
        Thu, 30 Aug 2018 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NRTqjAbhYUwP2iZpdfOJHL9AhRjMfoNc7gnmHdHJqms=;
        b=RphcGtFXrjHMOuHpHKxikuPt2j29hI6gwXp4e7mMx7u5V6r9MSeEcf9rQCpCRUBnLV
         zh2an6R19/2yASEpDEpd2ll3U47dEZ0Q/8a86QXOWz48Xl7b5xxJYr64S2DA0drV7dO6
         elJe4Hm8Dfbo9CtmkaX8WHGKcdsSDmzl/afC/q/EiNQsFKu0NSBSTqXC3qztGu25Nr++
         Lw9vBe1gM2I5tqG1L5jCTSIzUYBvAIzWEy4Pz6roDz6Bop9sfI0OaaRcV4wDm/jd7ZZU
         d3PO2nbCnQtlVasGD5k0yWgTeOKIBHtbEB5KQOiwJyIflexrwSMla3NM59EWs1U/KVVr
         OyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NRTqjAbhYUwP2iZpdfOJHL9AhRjMfoNc7gnmHdHJqms=;
        b=sJSb8tVuCVXOwBHKcflXlwFjG6Yjtwu5Tx3EXerGzxgDOaYbhJ06LS8f6z8FClq9vu
         CltY2BtwnATl/ZpigYElXzlGHHIjP71uo+PlMDSRq/yNSS449sNQAwfU7yk1trrNexlT
         rPp1itqC6Fig9AF85Df739F5zrLTaXWmGsIekOK/I8zkKn+BpSV7d6HGCArhdZ1mk5i+
         9H/EQMYKl1qEiLxGm86dDvxoJkALAp14Q7ShL9oMhyQzmYIAqxDZVGUWu5hUHKVl4wdc
         eekJOd7zgbOkL8RTS6bQ/AAh1u05c/UJbDZrnhEsgAl1qjnCF8Rzxi6qIxNkP4NZAN0+
         XneA==
X-Gm-Message-State: APzg51Bdx4XB5TDfcdqwgneiY/6y+XbrcRgeaRwxRnwK46i/flEzHT4J
        BSBO+toh1ZiI31ryNnG6fAEo14W+
X-Google-Smtp-Source: ANB0Vdb53BLcLX9aKB7E8AUW4m4/DOPA73mw5V0cTQ2c/hL4cSfQ85QzQVbKbuB4CFpjRTQTrijV9A==
X-Received: by 2002:a1c:8291:: with SMTP id e139-v6mr1270411wmd.39.1535620756680;
        Thu, 30 Aug 2018 02:19:16 -0700 (PDT)
Received: from alpaca.bmw-carit.intra ([145.253.130.2])
        by smtp.gmail.com with ESMTPSA id v5-v6sm5748157wru.60.2018.08.30.02.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 02:19:15 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] kconfig: remove a spurious self-assignment
Date:   Thu, 30 Aug 2018 11:18:42 +0200
Message-Id: <1535620722-14689-1-git-send-email-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The self assignment was probably introduced by an automated code
refactoring in
commit 694c49a7c01c ("kconfig: drop localization support").

The issue was identified by a self-assign warning when running
make menuconfig with clang.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 scripts/kconfig/mconf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 83b5836..143c05f 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -490,7 +490,6 @@ static void build_conf(struct menu *menu)
 			switch (prop->type) {
 			case P_MENU:
 				child_count++;
-				prompt = prompt;
 				if (single_menu_mode) {
 					item_make("%s%*c%s",
 						  menu->data ? "-->" : "++>",
-- 
2.7.4

