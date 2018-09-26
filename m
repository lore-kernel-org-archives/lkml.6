Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209DBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD00F2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyThfYns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD00F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeI0BcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35951 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeI0BcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:32:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id f4-v6so2900866edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RGHHOgsd6CUtXUBKj1DgktbgVfzqWBc1nMKYiEjJjz8=;
        b=qyThfYnsO/Yh/ztPacA+AIvt1olJ3Et7Pji8ZrT2Ms0ONICsU8NQsZ79eWGYaICSmU
         PdsrdWC0zcxyItN0MLtZKtpftqX2Zk7EJAWJaQabC08+f8hR76998by9aFzLfMz+ydjd
         nnBOnsVNvC+VKoH8MAZa19SB9oAUYFamf9xD5pYC80Wum+Qg01gX7oQTvxhsgSsOVrFO
         goPUKASeicEI8jLwH5KlflmoaWY5Hzoi01zeOcquRlC8DwR7KGVl0Q0yZyWw/p9lBcgL
         p5WNDV/96WwlXq8sdqMQnfoOLMN9bk5/PCctU6LsXfIzqnnv3NTMdHkUh096dG8UZMqr
         izkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RGHHOgsd6CUtXUBKj1DgktbgVfzqWBc1nMKYiEjJjz8=;
        b=aRGVRPwojqK6pHnnLabLcwId1zP0Wu2UtlWpL5bsbHLFOq8NBf0sY7fNFWSbySpVjE
         lSuylpchiyDPoYEtg+y/t4LdlbFq0JyOznvWECJb9yTo2YwavYxGRYaOp9LrqAXSZ/ws
         Ik3x9YimR2HXjVGlXpLbntMtb2ipJ0ZLmEp8nO3gQ8r4CFZ2XX2Ws0iBICuz6UmVG0LI
         1rbY2AdLqCiLEKHAWO7361vPkKYFkS2mwjcvEu9dvh+fdwAVe4rfZ4i2jIlXmvMLXiRd
         GVI7aYFsu4qg1zQBgqGU1c3826hHuHWT8mj2CP8vtPRQU7vge/vcRyFgLOkl4prgTgrq
         q0QQ==
X-Gm-Message-State: ABuFfohWpA6ANClUTgzQQ5TP6+wU2AiUoqz0aXRVt/p8WFIAO9ekDQQQ
        fX1dixpSp1UH9C2iPANm8iCroxe9
X-Google-Smtp-Source: ACcGV62ou+htq1nE08RDM4iBHdA9tPrz5FQFM48xy3UNK6Tl4IAImuPpc7flU11lAAD66Udcq87fRg==
X-Received: by 2002:aa7:d698:: with SMTP id d24-v6mr12215743edr.209.1537989460947;
        Wed, 26 Sep 2018 12:17:40 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:40 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 13/13] staging:rtl8192u: Remove potential memory leak
Date:   Wed, 26 Sep 2018 20:17:04 +0100
Message-Id: <20180926191704.16322-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add call to ieee80211_networks_free() to avoid potential memory
leak if allocation of pHTInfo fails.

If the third allocation fails only the first successful allocation
is freed, not the second.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 90a097f2cd4e..aada077ced0f 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -159,6 +159,11 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	ieee->pHTInfo = kzalloc(sizeof(RT_HIGH_THROUGHPUT), GFP_KERNEL);
 	if (ieee->pHTInfo == NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for HTInfo\n");
+
+		/* By this point in code ieee80211_networks_allocate() has been
+		 * successfully called so the memory allocated should be freed
+		 */
+		ieee80211_networks_free(ieee);
 		goto failed;
 	}
 	HTUpdateDefaultSetting(ieee);
-- 
2.18.0

