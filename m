Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA7C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B135E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/oBjRvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B135E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeHaCkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44342 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id q127-v6so8553800ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Suqu+8mzeGsAyTM4WyabTxpxqa18yKHcczrxQ30lt0=;
        b=F/oBjRvAqeUY12kAagc0L2MRBD0fGaTRW+42m7uaP/WR2VEiPaqDUGFUByA7s7ugI/
         itFAYYaUjBs/Pc7IIzpPCpokT9a3wto1mV3OyxkdRJ1VEM2fWID+67dZ/3dIoQJWPMwS
         qNgRKgTzbm3wZ5KUezdPpw573uwsnmckQFqw84XnEkBogQynsv6yIltqYxGJmWGa17tK
         vt94mfrf/RcQrrNrM8TRjzjAHhEGV33/Qq/a3JDyfzyn0XwWNjBphtZtXKa880qb1nbh
         j5vZi6MGvmdr2JEK4vFZ+pmJiqWIEDPNAid+/nz+5nHG76aabAvb9EMMdbzTqp3fSwS3
         bbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Suqu+8mzeGsAyTM4WyabTxpxqa18yKHcczrxQ30lt0=;
        b=TfDd6mWWL0jEgJR0w2zO672aBSqv+IebxqBLWjl+kSxdIh/Zj29EcnI5X9r81MIQNf
         r2yoI42+0wd4GmC7znrMPBKkJ27QJsiZdHy+pieBGqfaiBmiSebCkKRYVZrLpwERg+el
         j8xrYNkqKuJS49KLHjCLTVANX2rbvQQ1IjtMsRW542G5pm+79pQ5IT1/ytentQXrwiCA
         PhZPE5oyycpE+eF9KTHKPEz3RvibHMDmQvlcj7LCJSkfiljB1NaFMAFabVuQo/GH3mqM
         zDKUrzqb4YUSs1ecZSkRavda1LXj6aTsrwrNHcge2fuzZ8RN8szGW1mkPx3hLIiCEkJY
         m9Ew==
X-Gm-Message-State: APzg51Aa4AYNg9CDLqsgg8olPfj2SyQyWAqNF/qYq/yKOiNrQHCHUEGc
        bZ4axOoRiD99mGwgLDCbXLNEr0GAqCc=
X-Google-Smtp-Source: ANB0VdY98fImYPA3Q3VRmT8TMs2vxQ6Q5nKHC3k6YufRuCt0eKIuKTZhRvEfzjfKcWb9Cl3pL+PSuQ==
X-Received: by 2002:a2e:4951:: with SMTP id b17-v6mr9012852ljd.31.1535668536108;
        Thu, 30 Aug 2018 15:35:36 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:35 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 10/23] wireless: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:16 +0300
Message-Id: <20180830223429.30051-11-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON_ONCE() already contains an unlikely(), and the logical or of two of
them is still unlikely(), so it's not necessary to wrap them into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/carl9170/tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 0cb5b58925dc..8c75651ede6c 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -246,8 +246,8 @@ static void carl9170_release_dev_space(struct ar9170 *ar, struct sk_buff *skb)
 	 *    of available memory blocks, so the number can
 	 *    never execeed the mem_blocks count.
 	 */
-	if (unlikely(WARN_ON_ONCE(cookie == 0) ||
-	    WARN_ON_ONCE(cookie > ar->fw.mem_blocks)))
+	if (WARN_ON_ONCE(cookie == 0) ||
+	    WARN_ON_ONCE(cookie > ar->fw.mem_blocks))
 		return;
 
 	atomic_add(DIV_ROUND_UP(skb->len, ar->fw.mem_block_size),
-- 
2.17.1

