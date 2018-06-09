Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ytf5DKBuG1smUAAAmS7hNA
	; Sat, 09 Jun 2018 06:07:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AA3FC607E7; Sat,  9 Jun 2018 06:07:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVGmu0yY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2B459606FA;
	Sat,  9 Jun 2018 06:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B459606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeFIGHw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:07:52 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33861 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeFIGHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:07:50 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so9444760plq.1;
        Fri, 08 Jun 2018 23:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bexOj58cbjxIeWYQA/ZB4CDXFUx2xdbcBiKYQ5RdlvU=;
        b=XVGmu0yYiTsWog1NTA4N5gHMxpRs86OE73i15phwe4rpV2PaM39Gw0k/YGhyJr/ict
         tHAgkrp9uim0USbNQGckjoSsRs2tIpQ22lHAf3CBuTKL4g5Z5c0D1JHGLVnbo29UH8SV
         9WfM8VJuVIJM8I0L0PH3P8/t/snjj7CxRoL9vOfLLxmi4iHRIKcW+p5trcvKxirUTNpP
         jxt3MD+Kk4WCPgFUi9R6fhaezsepVPqDv5vNe4WUVWAwIHfmwHdtTSFVeTEv949WWD4q
         iMenrEG+F9Ikc/C3Jbv/vpd0MYqYnlgixF3KALRnT5mRFESV8pZdLJTsm3DEvpQDIGmD
         nK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=bexOj58cbjxIeWYQA/ZB4CDXFUx2xdbcBiKYQ5RdlvU=;
        b=DrujTFOe7R6lz2y4aFKdrbkRf2V2zAOPIxuicv9ZSjt3BBFx3FcTebX4ODZKzhmckS
         hpKMyHL0lMzDp8H7ZB45jEurdLfbzFOrSz5Nc23300kJD0ytUCeddIfZNOL13Hd2innH
         tQh9n96RevThDvQwf9vXvDC7/vdLPzOdqImpIg7Kh/2yhBdKFrUnjMFD0reWDT5PjPmE
         iY8Jlpb5f3B2pS9sMXUJPtiou9p7L6efu4x+82/cO5zFwnsdCRRNyula7a7k4rUimlWu
         NavZqPWsdSAigxVIejs44QLs+TTpT5h/s3+zEA/tIf5NFNL1knupeZ0npXIejWdMPL79
         rrAA==
X-Gm-Message-State: APt69E2N94QvQMhH9JRv39875I+g0mYF03u5tnEab+52oorOm+Sa+uGc
        7TGcIKHeU/ShUSTXA0VuDNk=
X-Google-Smtp-Source: ADUXVKLTUAxk227MI2enB2CYz8h0yDkL7v/Wi17O4U86fLOzHS63vref/tCycpqKuznrDTMSHeEgqQ==
X-Received: by 2002:a17:902:4101:: with SMTP id e1-v6mr9583788pld.205.1528524470253;
        Fri, 08 Jun 2018 23:07:50 -0700 (PDT)
Received: from os-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id i71-v6sm23332860pgd.22.2018.06.08.23.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 23:07:49 -0700 (PDT)
From: thtlwlsmsgkfla@gmail.com
To: gregkh@linuxfoundation.org
Cc: davem@davemloft.net, colin.king@canonical.com,
        johannes.berg@intel.com, Linyu.Yuan@alcatel-sbell.com.cn,
        keescook@chromium.org, tvboxspy@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] staging: rtl8192e: fix line over 80 characters
Date: Sat, 09 Jun 2018 15:07:51 +0900
Message-ID: <1667235.oI4jP7xdTe@os-virtualbox>
User-Agent: KMail/5.1.3 (Linux/4.13.0-36-generic; KDE/5.18.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*fix checkpatch.pl warnings:
 WARNING: line over 80 characters

Signed-off-by: Hyunil Kim <thtlwlsmsgkfla@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index d172e87..3c5def2 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2596,7 +2596,8 @@ static void rtllib_start_ibss_wq(void *data)
 
 	if (ieee->current_network.ssid_len == 0) {
 		strcpy(ieee->current_network.ssid, RTLLIB_DEFAULT_TX_ESSID);
-		ieee->current_network.ssid_len = strlen(RTLLIB_DEFAULT_TX_ESSID);
+		ieee->current_network.ssid_len =
+			strlen(RTLLIB_DEFAULT_TX_ESSID);
 		ieee->ssid_set = 1;
 	}
 
-- 
2.7.4
