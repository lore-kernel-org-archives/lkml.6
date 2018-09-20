Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D831C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EBD2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqgneG4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EBD2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbeIUCb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:31:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39361 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeIUCb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:31:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14-v6so10721937wrw.6;
        Thu, 20 Sep 2018 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wg3egDLkTXuLTmRbPM21TNn5lPaqSV8GqOsjDMyEWo=;
        b=DqgneG4Bn0XouVsEzbYhv+noJJFW3n49NIz3oYhw+KdaHY3iGz+Z3x/f3/Fzjadm3S
         6qDb4fD/soil0xUMcFiBWklbiovuepqnoL3z5DBqkllN7P6cp6e1lRT9o4ieZVmARHC5
         QRoZMsFC9FO6JQgJ1Z5lO52n5g2T2oIE34sC2ZMk21SMeCAXyqSiJi8Bzq3YOP3FArqq
         G6Tf1ycUzIB10ntWNORuOA6kUFhmKvUz580mC2lAENBVogcN/48ALRrWPl5QCSucagcE
         TBWTaDOr8bjNTPYSU0bJR5gWykrdqoJk7Fb/zmzfedWf4r0kiXX0zenZ8hZCZkeeg4OU
         xSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7wg3egDLkTXuLTmRbPM21TNn5lPaqSV8GqOsjDMyEWo=;
        b=r4QgUUkn0eZvDuwPKrRHO161JPLH7wvLnskfg5exwiZ9/RWKjzL/BdgfnQZdDsqs8J
         RPaDhVSHL+8vuXVQsTFK8yRcuW0QDqFoJxeUI1IIe0q5rsG0F3Ubk/Ecag+yohYOM34Z
         /2R6C4LLs5gSyRhOmOqzXcZX6wwQtSHWdcZN3b5DK0CBjzgQZjbvIMnL2uR+9VVkL1sX
         BBMlpgbeY3R0rc+h9y6UIMcGuikU3e0uk3T0L92mRUSxHADbPdgNpuEtyaMiQOGulGkN
         Aggk0OAdeaR0CPvcZW1B7YsxX4lRYZUd+RSMVZjePN6Pqm7HfjqtUGKMaIbLfhWaQlO2
         e3Yg==
X-Gm-Message-State: APzg51CXenK0GUAa6ReYHVNvIRb7ZRGIdL6G3PnWI45viHJkGx+fCQkU
        C1N//zBxO0pWrG5TuOnmdE8=
X-Google-Smtp-Source: ANB0VdYRLJU61nx8AFgskEYM2aUZF89e4BbRyCq6KWtYg0v1uoR4QsM9/FNYuDQZGkNwwuIeN+y6Zw==
X-Received: by 2002:a5d:6a0e:: with SMTP id m14-v6mr35696191wru.192.1537476368127;
        Thu, 20 Sep 2018 13:46:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id h206-v6sm3845903wmf.25.2018.09.20.13.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:46:07 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] wireless: ipw2x00: Remove unnecessary parentheses
Date:   Thu, 20 Sep 2018 13:45:49 -0700
Message-Id: <20180920204548.2405-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/net/wireless/intel/ipw2x00/ipw2200.c:5655:28: warning: equality
comparison with extraneous parentheses [-Wparentheses-equality]
                if ((priv->ieee->iw_mode == IW_MODE_ADHOC)) {
                     ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
drivers/net/wireless/intel/ipw2x00/ipw2200.c:5655:28: note: remove
extraneous parentheses around the comparison to silence this warning
                if ((priv->ieee->iw_mode == IW_MODE_ADHOC)) {
                    ~                    ^               ~
drivers/net/wireless/intel/ipw2x00/ipw2200.c:5655:28: note: use '=' to
turn this equality comparison into an assignment
                if ((priv->ieee->iw_mode == IW_MODE_ADHOC)) {
                                         ^~
                                         =
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/134
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 9644e7b93645..bbdca13c5a9f 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -5652,7 +5652,7 @@ static void ipw_merge_adhoc_network(struct work_struct *work)
 		}
 
 		mutex_lock(&priv->mutex);
-		if ((priv->ieee->iw_mode == IW_MODE_ADHOC)) {
+		if (priv->ieee->iw_mode == IW_MODE_ADHOC) {
 			IPW_DEBUG_MERGE("remove network %*pE\n",
 					priv->essid_len, priv->essid);
 			ipw_remove_current_network(priv);
-- 
2.19.0

