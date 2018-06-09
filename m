Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5qvdBaVrG1uYMwAAmS7hNA
	; Sat, 09 Jun 2018 06:06:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7BEFA607E7; Sat,  9 Jun 2018 06:06:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+Q1brBE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 063E960290;
	Sat,  9 Jun 2018 06:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 063E960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeFIGF5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:05:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32989 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeFIGF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:05:56 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so9435017plp.0;
        Fri, 08 Jun 2018 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=m+lTtu5pCyGVqhSoKBSwj77hf+J2TDR1gJ5l7A/CQEw=;
        b=n+Q1brBEo8Wf7vgyNK5BkK264ybPAdO8PMnnUyYAqRM82TRzh2TjYghbfkJMkNTIOG
         PlADMJmrlj70hpZmBwXYLpL/TgNeKcTua/ustWHUYkLoKtsINTMqcvXvKi67Mu/dznT7
         NQfWSybSwUrSgUg3+u0EgdQOwp/KFFLWoVgmYP++QqitNIHbiwMgpsB18TOywu76rp8a
         OiH0K9jJqkUU4nPuslCo2SQv3H7JJwZyDidVNILqcmPXq5ivE6RBaRl0nrZgnGgJe1ne
         ndlS8okllGjWxE++ObvTxYZVjN0QR/mFZEWyaduX4YbioSp688pSsQ/EVCquumIh6Kbt
         6dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=m+lTtu5pCyGVqhSoKBSwj77hf+J2TDR1gJ5l7A/CQEw=;
        b=X/4+U0QrZmhyF8uUpEmzNLGSugPnL1kY3XeJdbgCKmYc6nd7T5IAUoy1HmWgxhVpro
         wqi3e5KiOwPgQS5GUb0eititebbHW6joTTfHrVPocnAHGDXBnc+P9eaMkSeHmxmraU5L
         WruKMzfrPeO3XnWO9DClRHdczagzAA1yIhkMM1kD6a+6ufsHC3rMd/p53qa8QMKhl0TR
         Gsuf468Mvgok2sHT2mYQzeyezr8CSijZgJWEu8Y2G1EU3PBt9xDKTn/eCvwAKtNCIqgE
         HAGxn2zQgGvn+bWFwQOBu43yb7Dpisyb9XbK8IFYpg4/39r3/dPhYFqVo6roaJdoVhWL
         VFAg==
X-Gm-Message-State: APt69E00utDM4AiX6qNdCfElOecCMfu4bBFewswsXBKtJ/WFfaPgnGWC
        DEok5rSRZo3MAR/EpPvIMu0=
X-Google-Smtp-Source: ADUXVKINRRWBGDDmIfRbxFzKKfxVoRF+uJTfmDxx7mExhD6CCTOV+W7SJYJhzMvIa6kMgis27ADWBg==
X-Received: by 2002:a17:902:900a:: with SMTP id a10-v6mr9598160plp.41.1528524355605;
        Fri, 08 Jun 2018 23:05:55 -0700 (PDT)
Received: from os-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id 131-v6sm104075239pfa.128.2018.06.08.23.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 23:05:54 -0700 (PDT)
From: thtlwlsmsgkfla@gmail.com
To: gregkh@linuxfoundation.org
Cc: davem@davemloft.net, colin.king@canonical.com,
        johannes.berg@intel.com, Linyu.Yuan@alcatel-sbell.com.cn,
        keescook@chromium.org, tvboxspy@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8192e: remove brace for single statement
Date: Sat, 09 Jun 2018 15:05:56 +0900
Message-ID: <1986308.HpuS17FQ0J@os-virtualbox>
User-Agent: KMail/5.1.3 (Linux/4.13.0-36-generic; KDE/5.18.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* fix checkpatch.pl warning:
  WARNING: braces { are not necessary for single statement blocks

Signed-off-by: Hyunil Kim <thtlwlsmsgkfla@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 919231f..d172e87 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1355,9 +1355,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 		rtllib_WMM_Info(ieee, &tag);
 	}
 
-	if (wps_ie_len && ieee->wps_ie) {
+	if (wps_ie_len && ieee->wps_ie)
 		skb_put_data(skb, ieee->wps_ie, wps_ie_len);
-	}
 
 	if (turbo_info_len) {
 		tag = skb_put(skb, turbo_info_len);
-- 
2.7.4
