Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B318C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B6120896
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjBPH++s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B6120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeFPGAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 02:00:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42749 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeFPGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 02:00:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so6390113pll.9;
        Fri, 15 Jun 2018 23:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=DcTl2LAkAapkURUeFColDwq+XjdkR0p4lE+F516z/pA=;
        b=ZjBPH++sxbUyyd4Ku9qzpSw+ft+Kq+YctRG1f2wt5rgiEmD7/bq2gYQClnyrxg6xBI
         fYHll1WEpbKyGIvj/Usx4XlojNLM2lGzy6LmIIE8yh+BTpc8phIkmkXXBf1lYGbBnjLA
         J3Z60Sox2rEdYtD2j7m3GF05jK/CpeGo+HBfRg4bTNHsO9aPs1Jfp9uH/l3DAzj3yl3k
         i498bj9P/3QlmsuSt0vh2J/BtdxAWzqn/FeX+GRd4lTgQo/krxpciX5+S21aK0fldElG
         pKvnwm25RlvSRxA+nkrwJxNBhCQMpRP0ry73iQWC+ZGcVkXeMLhn+g5MxbbL1C3nVUWf
         wvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=DcTl2LAkAapkURUeFColDwq+XjdkR0p4lE+F516z/pA=;
        b=ofW4MZD6/Yf1N+az0N4q0ue0QzcyFwAQuGPZibvTeBNn9venWTwpCsDpKKs9QZbR+F
         OGHbUnz12gNnRZoYVTkwUHCfTr1oMkSbmZ+1cto+6RqAPhrJxGX8vUcNMIRExN0rYoXC
         VlQNcxGn3Hpgv+KzTcrvqhO8oSelX0pd2iHjyycS42z28KxRguMHkS1+hZDByKq5QZWe
         /BI6/Q+ur8K0K66t+tyoqM532WMcH/JN5StBw2feGcPCgpCC13cxjVFATFuLfNzqXss+
         NgG3MbX/72l0EctDS9BMzYiF2JS4tMlF5Z6x028FPtOJG97iQAI2nLwnWXBiRZeGmJAn
         EWXw==
X-Gm-Message-State: APt69E0AVxSs9+Q56xlPVfxOSIPrjjOvIqJaNo7JiVFt665yVxqFSXFl
        U42l7PXa3V+wmOnlGj/18Xo=
X-Google-Smtp-Source: ADUXVKIAP0oSsp8XfUY+MOQ8rY8XyQbJOFOkXW95Hg1cCMX0Li+7PRXgD1ypIsnhsweHSeDfuq3jSQ==
X-Received: by 2002:a17:902:b217:: with SMTP id t23-v6mr5372065plr.312.1529128832269;
        Fri, 15 Jun 2018 23:00:32 -0700 (PDT)
Received: from os-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id l11-v6sm11299698pff.50.2018.06.15.23.00.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 23:00:31 -0700 (PDT)
From:   Hyunil Kim <thtlwlsmsgkfla@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     davem@davemloft.net, colin.king@canonical.com,
        johannes.berg@intel.com, Linyu.Yuan@alcatel-sbell.com.cn,
        keescook@chromium.org, tvboxspy@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: fix line over 80 characters
Date:   Sat, 16 Jun 2018 15:00:31 +0900
Message-ID: <1909265.MoDodiKBI3@os-virtualbox>
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
 drivers/staging/rtl8192u/r8192U_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 74c5865..2111e01 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2044,7 +2044,10 @@ static bool GetNmodeSupportBySecCfg8192(struct net_device *dev)
 		return false;
 	} else if ((wpa_ie_len != 0)) {
 		/* parse pairwise key type */
-		if (((ieee->wpa_ie[0] == 0xdd) && (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) || ((ieee->wpa_ie[0] == 0x30) && (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
+		if (((ieee->wpa_ie[0] == 0xdd) &&
+		    (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) ||
+		    ((ieee->wpa_ie[0] == 0x30) &&
+		    (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
 			return true;
 		else
 			return false;
-- 
2.7.4


