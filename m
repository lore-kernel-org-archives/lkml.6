Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE488C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E6E2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXFkFkp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E6E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeHaCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37396 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeHaCkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so8571275ljk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p8eJzuiYqNGQh5l3aulpaEC6rDHC9wpiJW8RJMd55aE=;
        b=mXFkFkp5ArNiGa+217b4G1Ms+pyusmYsmvWzODRcxoz8FOkGohp/QSiXApZSw7cjyh
         y5fo8ytvohfSvnLskRLbmZ+m7ENhqKYVofRPmjURX6TCPfQtRPwjLuw8J9np+WcMrx/z
         e87XhMH9stmJ13/Hhu7YnNWpVI1lFyy/5Fs3zfbFJWRImuM9EXCaPcmoUBDIN2Bvd7LB
         2R14GrhIZndTEHxkvW/uuwTXzopJOdSf/Y+AlbkHAPPsMGnh+1ITIe7jLr7/IVc3rqO/
         OYGfOuspO4zmmMAyIyPs+LKj/XsbeFaCzyxZPhr2/ut5Ybw/eEOV4dPz7fGX+0qXPKcR
         SBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p8eJzuiYqNGQh5l3aulpaEC6rDHC9wpiJW8RJMd55aE=;
        b=qe/Jm03rf9lMaT+IvTwlI8b3mCULB09PJslX8k5HMk9mgV7K7iUKhvRPHR7FOIg0+n
         rfG5pu1p+TUUPrkMsAa1kym1zj9MUhyhS6PGdeXekS3aL7GbI9X9eZJqoV4Kxr+s4lQq
         ik05JTZ3Fin03BSYPGzFYYTy601ty8PmPRJIGoD1njPvlG89L5higQgDdq60wIkQ0aMg
         nOFTGjZw2nTvFyXa0x5F+jveGydI4/+BccK4tWNgRmjvHHTc2tLsUtb5ZZKbGX+zJmLg
         nyiQYYWUaoOMxilUmwvnT841zY9Gac4aA6sTVr8ahngvSQJt1lhsnOhYPRkIsJuONnGH
         6EoQ==
X-Gm-Message-State: APzg51CANIPq56T0ygrZkULLybVmAKhDMkDVI8lcizyhaiCC4qB8sXCj
        vTY9ZslzRLpi0JgJs13KV2Uz9g9rKac=
X-Google-Smtp-Source: ANB0VdZd/Sp7ibzhQo0gyQuWJIR+yhmlldfIBnN++TCnHmxTIdxEXA/yoVP8kiDYrNsmQuLyGDa9hw==
X-Received: by 2002:a2e:2e02:: with SMTP id u2-v6mr8911086lju.77.1535668537776;
        Thu, 30 Aug 2018 15:35:37 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:37 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Michal Kazior <michal.kazior@tieto.com>
Subject: [PATCH 11/23] wireless: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:17 +0300
Message-Id: <20180830223429.30051-12-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON_ONCE() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Michal Kazior <michal.kazior@tieto.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 4d1cd90d6d27..1455007f3eb8 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1176,11 +1176,11 @@ static void ath10k_htt_rx_h_undecap_raw(struct ath10k *ar,
 	 */
 
 	/* This probably shouldn't happen but warn just in case */
-	if (unlikely(WARN_ON_ONCE(!is_first)))
+	if (WARN_ON_ONCE(!is_first))
 		return;
 
 	/* This probably shouldn't happen but warn just in case */
-	if (unlikely(WARN_ON_ONCE(!(is_first && is_last))))
+	if (WARN_ON_ONCE(!(is_first && is_last)))
 		return;
 
 	skb_trim(msdu, msdu->len - FCS_LEN);
-- 
2.17.1

