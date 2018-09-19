Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193EEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8CA2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/x3vXO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8CA2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeITCT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:19:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39853 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732282AbeITCT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:19:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so7131579wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Mju0ae1j+P+lk4hYohx4SY9JA+2bDS+keUrZFnlzo0=;
        b=B/x3vXO7PCwYXoQF9Nw32rQdwE1tVOis3iOjjd8SyspzWuMRvtKDVSNFNhDYQYWp0T
         H1oI7sD7NbonNGEj17FpyuyuP7I9zcsPZhsi5Z2lro8+4iTl3YmZNJrZhjO7a6E2SVdt
         HqQuzYU+EqV4FfQ07pS9Ip3z95N95KuplEbRb4u1zoZs9XCvExyHr+gVSqtwkBktjcSu
         XbeaHvVTfbpyn9hhGn5iMDofHFg9W/mT2NBIm1CALxGTYHi1xhyKGemmi6UrtKdOBvRl
         22TLk3j8oesdVC3+pNfv93ylaIJ7koi3SYGYGMHY8bkOJT6x3J+BFMbP3LrdUodz2V+L
         f4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Mju0ae1j+P+lk4hYohx4SY9JA+2bDS+keUrZFnlzo0=;
        b=gom4b9Lq/USgZINz0Y/TTNfkLmrUMeK0JVJtL+ulJGXchRPyp+0qWFvEUKvC7rp+dn
         Xhu1GRpnhuI67EhkmrGiF3AU4c+Mda4/9hcucivfNVtdntWR+oR4zjNpz7Xx/d8fovuN
         5wZEnuxW/gT0Djz2xWNxNVs3p+uAQztDj1gJek40HXgctdq1bU8AIDSj5W2KtapvSoZx
         Nz65LTLMD+OcDym5oj45MBsTWH2E202YbbgCpSJoxxZHD7cyIZrHBopp5mcgJA+TAz7q
         5riu14krBF+qtSLpUxa++5jf/YN3OhMCtM+09oD91BrWkFY0zSEWfzjHRV222GDANwPg
         Tu4w==
X-Gm-Message-State: APzg51CyUS25v5K7lXZdVKlvIR0Wfl7XLTEBLpK/BNHsIAWDZ7i1vO0l
        RoQdPmWkZ+QqCyQKSsMv6hNtB7xR
X-Google-Smtp-Source: ANB0VdbakZhIVdGys55XQ5lL4h9l7HEWDlqF+O0GTSIq0nO5Anq3uKPpPuNKHJqqGuqfWVIFqeVGdA==
X-Received: by 2002:a5d:69d1:: with SMTP id s17-v6mr30894543wrw.77.1537389618172;
        Wed, 19 Sep 2018 13:40:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id b10-v6sm18013637wrr.88.2018.09.19.13.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:40:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8188eu: rename parameter of Hal_GetChnlGroup88E()
Date:   Wed, 19 Sep 2018 22:40:00 +0200
Message-Id: <20180919204001.2358-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919204001.2358-1-straube.linux@gmail.com>
References: <20180919204001.2358-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function parameter of Hal_GetChnlGroup88E() to avoid CamelCase.
pGroup -> group

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 72266caa2d7c..5fc346a285c2 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -378,20 +378,20 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 	}
 }
 
-static void Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
+static void Hal_GetChnlGroup88E(u8 chnl, u8 *group)
 {
 	if (chnl < 3)			/*  Channel 1-2 */
-		*pGroup = 0;
+		*group = 0;
 	else if (chnl < 6)		/*  Channel 3-5 */
-		*pGroup = 1;
+		*group = 1;
 	else if (chnl < 9)		/*  Channel 6-8 */
-		*pGroup = 2;
+		*group = 2;
 	else if (chnl < 12)		/*  Channel 9-11 */
-		*pGroup = 3;
+		*group = 3;
 	else if (chnl < 14)		/*  Channel 12-13 */
-		*pGroup = 4;
+		*group = 4;
 	else if (chnl == 14)		/*  Channel 14 */
-		*pGroup = 5;
+		*group = 5;
 }
 
 void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
-- 
2.19.0

