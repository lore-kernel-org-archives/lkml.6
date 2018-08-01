Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FFEC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0864320841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZgK2JlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0864320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbeHAU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:58:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33813 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeHAU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:58:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so21175677wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=geuYfsgy3+rfRtB7WY1+nY5Ib8dZROBnTH2tR/Ds3qo=;
        b=dZgK2JlJNH57EN11ZVTEuDAjcNdWnETlNnCP/si/fan3Dprdv2rn7h0+ns6hD05nAT
         1wIBgVGq/stILyX1Ee78jNN4yC8HXThm8soy4PnW6O6f0ck+d2JDz8u6B2OHWKVQTGW6
         aTQ8iBogORMOJ1mn3wqvY1IpIHkmWMooQTpcCIfC8bgWDSkjVyWIV6NcgNBDTr9/1XDr
         xeWpQWKq5nCkr1MHbmcTwq4xvEyGJnvk3bXHcrh4wLZl8b47tQ25r1zH8lVynicY0eRr
         T26cX4cHEmd5ABP7rC+sarWqFSbSrrpQRqpN5NURzL5sEFE2SccByLDlnZ7Uqap4CHwa
         a6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=geuYfsgy3+rfRtB7WY1+nY5Ib8dZROBnTH2tR/Ds3qo=;
        b=VtH9PClDqxvRSyU+lwuFaLKulUy2Ulxz4zi35cCcWAd9KmchCQUYD9hncY5YC2EdKw
         HYJmSO5ScfbQw5RjgIemNT12LerIlcywg3efqfA7629aY0PjZ3fbG4dX7N+DGJELo3ie
         g6uJm9blbdl17srMEcLWgD2Gn6dlQlDz+D8q4Sgi1xSY/xZYeiY2WS+KtNyceZ9f0GNX
         Bx/eZ49jqfRan9falqg6/AuLe3HoBaOZV0VipFdVT8ipCVfofJE4qIoEH/6/4iZePoQJ
         aQnwn7NL9/fm302/KwDP3gkNUm219FBb49GPJL/x8gKZy9r14a1OxqBCaL2Y3R2zzACG
         8tdg==
X-Gm-Message-State: AOUpUlHYznhnudcB6XHhQSpSQFZJaeJ/GOu7xmklya3R2144h6MDpnD8
        VMtAoA1BlmgKD3K0I6vVhGU=
X-Google-Smtp-Source: AAOMgpeX7mg5WttviMYIb/yfmV3JqV/KPeL9jyMF/+5/iUUB+CyLkFhetO3aDY7lDe1p8B4aydkYdw==
X-Received: by 2002:a5d:55c8:: with SMTP id i8-v6mr24658332wrw.38.1533150665380;
        Wed, 01 Aug 2018 12:11:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id a12-v6sm15879808wru.61.2018.08.01.12.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 12:11:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: use is_multicast_ether_addr
Date:   Wed,  1 Aug 2018 21:10:50 +0200
Message-Id: <20180801191050.1734-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom IS_MCAST.
The variable for the result of IS_MCAST was only used in the
if conditional. So remove the extra variable and move the call
to is_multicast_ether_addr into the conditional.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 80f55937e3be..eca06f05c0c4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -2022,9 +2022,9 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	struct sta_info *psta = NULL;
 	struct ht_priv	*phtpriv;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
-	s32 bmcst = IS_MCAST(pattrib->ra);
 
-	if (bmcst || (padapter->mlmepriv.LinkDetectInfo.NumTxOkInPeriod < 100))
+	if (is_multicast_ether_addr(pattrib->ra) ||
+	    padapter->mlmepriv.LinkDetectInfo.NumTxOkInPeriod < 100)
 		return;
 
 	priority = pattrib->priority;
-- 
2.18.0

