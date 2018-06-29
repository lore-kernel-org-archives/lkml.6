Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CBEC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D0827A7F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmFb43JO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D0827A7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965541AbeF2SLj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:11:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37695 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935178AbeF2SK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:10:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so2958972wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PxKh/bdBDWB+bor/HB/Qrk4uF0YJJ5hVv+142yuwM5M=;
        b=QmFb43JOnwlNNi2g7ZKpNKaFVbIQ54dLRX49bMVhe3h31Q93Z5x+e+V3BoIAAqrY7w
         8DsyGGnAX8LfQ9I2ky4WcVdX3R9+xpemZj6y+E+ozx4/3FmpY12YMapr6L1gk8SLeWyK
         iTy6ZgBZXOkbWV59sbXDs86ExcoCXV9MZk9NTLinPgB4JM2XByilx5j5o0Y5S1o5DTW5
         N+07TpmcoVLl+s10fxdH54Z+9sY8MiUvjmDAG3DgQMZYOhoMuIUbi/kc3b/pLSlQUjG3
         JYWO042vNJN7QedCntNdRKHNJXNFBiN4PcSojPpggFaJeL3w3RQ10ZK0deT6y3gOONAa
         1PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PxKh/bdBDWB+bor/HB/Qrk4uF0YJJ5hVv+142yuwM5M=;
        b=UDSw9sjFpDF2iAj6FtKzRsDDIPtItJozzbRBWTmkDVp+fA57AgDRfnU0UrVo60RKSl
         ml0pWjRcQeUzYsFfr2S/V9Q8G7rJkIO1BDyQ1Ks+wbXepvPgApY3hNrMv2x2eLiaL2w0
         /cOF95Abx2rM/5CuzrJrJLakxAujRwykMXVO6jJz1otMEZ49BaCwQK5Ts9ozx3mh43G0
         nHVeMzX+g0CFqW55iuTRF6NMzgSJz8WRx/TE5sy9yb7XviPar5X9FX/HTXuJrUy1fJqF
         GdAzliovdxddmLEYzkwWIyBa3dtJ9wq+qRNScdoPLWGPQO0CH49lpedQLJ6n+V4/njZd
         5c9g==
X-Gm-Message-State: APt69E0kGkLiyXpoAfm1ZvmebiKNWuPj9NosUHMmHUFQ4WmqwNwDhCRw
        mzUPUQcYSzCtAtq5KlQB+Z8=
X-Google-Smtp-Source: AAOMgpdRabi4jh2tPdcs8UyiquwX6JIYFKxpPTGd0HiaIHufDaLvE2XWya3hqx+vgoB/PlMcDz6NCw==
X-Received: by 2002:a1c:8cd:: with SMTP id 196-v6mr2650931wmi.46.1530295857728;
        Fri, 29 Jun 2018 11:10:57 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id t10-v6sm11071491wrq.74.2018.06.29.11.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:10:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 2/3] staging: rtl8192u Remove redundant #include directive
Date:   Fri, 29 Jun 2018 19:10:06 +0100
Message-Id: <20180629181007.18071-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180629181007.18071-1-johnfwhitmore@gmail.com>
References: <20180629181007.18071-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file includes the file rtl819x_HT.h, which has already been included by
the previously included file ieee80211.h

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index a4fbc0435de5..3ce9ab6ab64f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -5,7 +5,7 @@
  * little changed. If any confusion caused, tell me. Created by WB. 2008.05.08
  */
 #include "ieee80211.h"
-#include "rtl819x_HT.h"
+
 u8 MCS_FILTER_ALL[16] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 u8 MCS_FILTER_1SS[16] = {0xff, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
-- 
2.17.1

