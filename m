Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA02C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF51208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s44hdlkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF51208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeGHKjy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:39:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37384 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbeGHKj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:39:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id v22-v6so11639039edq.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qd67YTnuy123s3hPxG7yhZD/IV4ZufecAKMIUqLhpIg=;
        b=s44hdlkOu38KKCv+0zleVLZdw94fICq3cy78c6jHpJzDwGmHg5BcZsDt2wRlVNzPHk
         TDx0gSm21XfnFGwYf/q9KPjYQw/b2tiVBpPiFZAX1i75810eN6P2kJ7Me19TjtifZldB
         musa4mBGIXpYSDLV5GjtFK/uZRQK/g4U77OvBSyRzFEPwavZRB4QHkeULUmhhHRZA4HG
         /CPs9jpSOBJq8DCblg599BtuTwKO3mGTG3t1lAIrIN/2nFiUGRYHe/Yol6IvHCXT/FVw
         /mxyX+aAR5WJVrWEXPax1EGZXjml4sNpwlrWfDpF8SvuFMLrTM+Jrqn7QAa4tYSOSGaI
         D2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qd67YTnuy123s3hPxG7yhZD/IV4ZufecAKMIUqLhpIg=;
        b=ic+I+WWxdExI/3OR1531Y4mZQpicg7ijZHHztkOaGR9V6tIRM8wBG0jg69Q1U9bMO1
         6NmgfNB+DX0FNwNertBFyhoYgn8w+2Hpu0bSKjg4ZDanYiTD0uw25pH+T/cLiLktYtqp
         SXn1D1Z0cJFoj82zC542WqvIgNwRRaQPcao+n8xDICMQsbf2MP6Fk0wDuK4MisTIWbNs
         h4EkWONp1ry3IECN864FUHTezfxEhdYlV6ifUuYG2xOl7xhNl2LseMdTdqg6IE5c+swV
         yegugxREtvERQ1P2sbmGyhLUElunTRdivvnG3qITGN9WFtWqvlwOecP62AeqDi8Wd3YR
         Satg==
X-Gm-Message-State: APt69E385v2Faycgw2/Wxpj93QSoAc3zhld/FQv6VIzOA2izfpt8P17Y
        Xt3+4seSM0CaCOJH/u9AHmc=
X-Google-Smtp-Source: AAOMgpelesvMrGR27/qe4MKMYLkQb731ywRtIXBmQZrRMoDk1waDJjp9GUyeIEU3qgaynoCifl5lOA==
X-Received: by 2002:a50:be49:: with SMTP id b9-v6mr17339197edi.46.1531046366320;
        Sun, 08 Jul 2018 03:39:26 -0700 (PDT)
Received: from arch.localdomain (x4db1e3f8.dyn.telefonica.de. [77.177.227.248])
        by smtp.gmail.com with ESMTPSA id p59-v6sm6295886edp.54.2018.07.08.03.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 03:39:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: rtl8723bs: remove braces from single if statement
Date:   Sun,  8 Jul 2018 12:38:55 +0200
Message-Id: <20180708103855.12473-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708103855.12473-1-straube.linux@gmail.com>
References: <20180708103855.12473-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove braces from single if statement to follow kernel coding style.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index a4f9e2b90b08..3f1c7bb0eb9f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -149,9 +149,8 @@ u8 *rtw_get_ie(u8 *pbuf, sint index, sint *len, sint limit)
 	sint tmp, i;
 	u8 *p;
 
-	if (limit < 1) {
+	if (limit < 1)
 		return NULL;
-	}
 
 	p = pbuf;
 	i = 0;
-- 
2.18.0

