Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0189C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFBC2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axUj+uzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFBC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeIAQlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:41:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55487 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeIAQlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:41:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so7470445wmc.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=CUbYWZvDL2IVkpa0avEwQKJ+2TIVWgTwPpqqMop2ZTQ=;
        b=axUj+uzWqKlS8aRu3V5ZYgTy+3wJYaCRWZ3mETd96NeHAI/1PsgpNG3fpxTYARq/IJ
         jZrgsD13ijHhGJQ5KLnz8lhGK+iG6+C8Td7WTZ5AX5utEZlxFsio/oqb0AIux/5D74Vy
         ePjgvhrjTJH8q4EkG8SKW1269ME0YJASv2pyNvkTpOvkM5OsBFULY1lL7/JgxMBQI9Rj
         JkA0MoB3uAdCcjm9IGYs/boR3OioCTQN3O9ixLQiw4vp+2vbB7wCkhvitzoIrsb30gAR
         4E1hR5OUIrdEjKPh3xDOe+70HWZxTfc690G/bGWW8jZlrYjXh5zq7nfaDV/OLa3CCPsD
         dr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUbYWZvDL2IVkpa0avEwQKJ+2TIVWgTwPpqqMop2ZTQ=;
        b=HPV3sp/QR3FyAt80JZk/HyoVYemoG2GZUinBA9myw6k/Qjhm5JQhSvtO3e2IcxR3kW
         WNvvleXCMFe0URkISo82qifhj06Z7jxA9EWJ3h/4nlTIwMaEc3O05gG/ayarpyR0TUf+
         lkU2z6eOZDBD3oWz53NsYYVfsyY7EWx3eZXh2YqS0QCdcENDkw5ZPrVvn+pbu2TX2tFB
         tRk0b9JO5BKT4iRd2I3rrCoRDFJfQhYsG4zo8nVlIUHesO73GI9zOJ7K1CfR3DEiiwJ8
         vyf4ZJShJ8KxaNT45AmX/vGdVTAIpLmUhYvrVDcG3hwG4I42cZdglTBQWVmF//dFELsI
         kkgQ==
X-Gm-Message-State: APzg51Dih1ijz9G7l8e2gy5jtpMFjg8MEDcYEmnCchKz6UwLMQhHPPSj
        8Iu+Xsz5/bTWxnPrwjl97y8=
X-Google-Smtp-Source: ANB0VdbEsiJFpjppivqTbYxYHlADhXPADIZSuO3mDk4uEykz0g3dYG0F8nJ4mdDpaBWrPftXuGpKpw==
X-Received: by 2002:a1c:8587:: with SMTP id h129-v6mr626521wmd.105.1535804953537;
        Sat, 01 Sep 2018 05:29:13 -0700 (PDT)
Received: from terrence.localdomain (cpc96818-rdng27-2-0-cust102.15-3.cable.virginm.net. [86.30.200.103])
        by smtp.gmail.com with ESMTPSA id k13-v6sm7901418wrq.7.2018.09.01.05.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:29:12 -0700 (PDT)
From:   Tom Todd <thomas.m.a.todd@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Tom Todd <thomas.m.a.todd@gmail.com>
Subject: [PATCH v2] Staging: rtlwifi: efuse: Fixed a line length code styling issue.
Date:   Sat,  1 Sep 2018 13:28:06 +0100
Message-Id: <20180901122805.32147-1-thomas.m.a.todd@gmail.com>
X-Mailer: git-send-email 2.18.0
Reply-To: 20180827175108.GD27089@kroah.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a code styling issue.

Signed-off-by: Tom Todd <thomas.m.a.todd@gmail.com>
---
 drivers/staging/rtlwifi/efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/efuse.c b/drivers/staging/rtlwifi/efuse.c
index 1dc71455f270..abb0f720cf21 100644
--- a/drivers/staging/rtlwifi/efuse.c
+++ b/drivers/staging/rtlwifi/efuse.c
@@ -245,7 +245,8 @@ void read_efuse(struct ieee80211_hw *hw, u16 _offset, u16 _size_byte, u8 *pbuf)
 	if (!efuse_word)
 		goto out;
 	for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
-		efuse_word[i] = kcalloc(efuse_max_section, sizeof(u16), GFP_ATOMIC);
+		efuse_word[i] = kcalloc(efuse_max_section, sizeof(u16),
+					GFP_ATOMIC);
 		if (!efuse_word[i])
 			goto done;
 	}
-- 
2.18.0

