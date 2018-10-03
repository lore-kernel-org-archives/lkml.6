Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0520BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAFC21477
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aai1vzck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEAFC21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJDDeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:34:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36082 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbeJDDeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:34:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so2904988wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KU+PutpPWxNPDyVbl8FWSdHVswWvbcCxIo7jiT8ahGM=;
        b=Aai1vzcki7+ICKAIQ242spL1I9C5LLyU+W9LZcAdZCYCxY9AxtaQsv24427LhDNwFS
         v/exFP2fxpCHImZSxYiZZqpM9spO4vywFV++0BpujzmhjNGvXLLRAWixRUCXyAgp01Yq
         lLC1dsfE5TsOCbU28evy/D2fy+rBK/445c1pBynBrEPohCVUl011kRe/lU+1vja5V8Er
         sEFNd2PW6z2Jyq+DhHvtP6ux0HDFFFuajfZDyaMqJVOhaqit1HdM15ILNjw6f+RWGfZm
         OZSXVjcQzuez7Sjyw5nxWFGmHyOKdsiBQU1kTSeRh+NNj22MghoSJnHScL/jE11rzFG3
         Xhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KU+PutpPWxNPDyVbl8FWSdHVswWvbcCxIo7jiT8ahGM=;
        b=hUpsedrcVF0Zs8JSI1XIlDBMscpAtB6bAwMVrLKFi0dNyR3Ab8/kuqOWFzuWRTvDiG
         YqUUzrZa+vFlIGMMuFPEAMpbO2JkV/HMBCt6gO/wyJxq4TZ3wLA3jsj6hYZi39PkeqO3
         XDo+IYOP8Bt+Wqe2GzG0L/sYXCxriFx8NP14AOzJ9MP6qzUARafRyRCTCwYuRUN2cIeL
         K5QAQZlmxU73Kviv3JNttNkEG22YLgsyZmfMbb86Tb6atSzMxiM2TOXPim0n8baUBBsU
         TxKMyaEd8+OGr3X4Rqha1+lJBic0kmLcIZ8FZuN2L7EioUDq4/db/LfViVQihVECG3EV
         u+GA==
X-Gm-Message-State: ABuFfoiw8rZGVHXthfq9ioybKg41ryVLfCl/VKYB4rvnwAU9/b5HJnFT
        cZ79mZEeNrHa6jHC/gWV8jw=
X-Google-Smtp-Source: ACcGV63SYNn5ZuJnLy3JnAvSs2PZs1QwJaFGmyBW1C8hyp3Y2jZnCu1/8kG4ff7VyCoTV+4uYB8kvw==
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr2285172wmd.90.1538599447702;
        Wed, 03 Oct 2018 13:44:07 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd55.dynamic.kabel-deutschland.de. [31.18.253.85])
        by smtp.gmail.com with ESMTPSA id h18-v6sm2242235wrb.82.2018.10.03.13.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 13:44:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: rtl8188eu: rewrite if tests - style
Date:   Wed,  3 Oct 2018 22:43:59 +0200
Message-Id: <20181003204359.30676-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003204359.30676-1-straube.linux@gmail.com>
References: <20181003204359.30676-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite if tests to clear a 'line over 80 characters' and
'Comparisons should place the constant on the right side of the test'
checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index f03ac89736de..c6945164ee34 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -3957,7 +3957,7 @@ static void init_channel_list(struct adapter *padapter,
 			if (!has_channel(channel_set, chanset_size, ch))
 				continue;
 
-			if ((0 == padapter->registrypriv.ht_enable) && (8 == o->inc))
+			if (!padapter->registrypriv.ht_enable && o->inc == 8)
 				continue;
 
 			if ((0 == (padapter->registrypriv.cbw40_enable & BIT(1))) &&
-- 
2.19.0

