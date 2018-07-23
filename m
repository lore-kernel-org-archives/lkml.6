Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588DA20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfvTgENW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588DA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbeGWVyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:54:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42899 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388343AbeGWVyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:54:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so1987218wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qFKr/GO0XlTPcsnRZEXpB3YCLADYWLrwskBRPakEWrk=;
        b=DfvTgENWfdhxRZdlmGm3NQCszIbH9rHuUKVDjovx/iVN3J5AhHf8AHgk8qmsh3Pgwr
         aDfV/bNNm9vnmJAMEF+c6jVDni+SjvZgmyzKbmZXJdS0Mj2BUGkvIfRyLle+/s2cQyp3
         G5V/OpP6vz4wffIzUrU+P2pPjByOQMGUPn3dvRYQcVrm4Xj4tcpNYSxRGJyYPP2ddzUB
         YqxxmZ6I2ICg4GTA4C9xroBfJ1KwOFduz0RKLj1B35/ZtVVsmUgI4wRFd0mr2SEw3P8V
         biR6sy1HvFf56XjSTyji6FE31Rmam2cy73FjJDNYy88zMOmkdKvV6u+3SgOpYuUl5sj9
         rEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qFKr/GO0XlTPcsnRZEXpB3YCLADYWLrwskBRPakEWrk=;
        b=J355ToGNqnIvqpjydFl9Iy2vHBvvquptit/UJS97At8DfOShODlzDH1Q8c9sY07QhS
         XbYxCYKZvynBrzaNYzfjfIeeaxx32Pnx7vAFaL1xC+DDHNRFxwALx0Hxz6n4hIEjQklN
         4ophlUdp9PgpQdzF3Vo92BGqJ3W/7XwUeUXGco0z1wgq+TdzqOuAInU5AdwxVxD6bWIk
         /LkLgvD/t+BaD7ct16phFJAbkXWilc2JDGlPLCDML1Fk+0iUfOIE7BBf/wIousQsWlnl
         dGBiWxRrGuBsReBq+/6uba07IbX90Tp1E4uVPX4UsXkoyRqy+qNte8Hq03/axbOG5o4H
         iLTw==
X-Gm-Message-State: AOUpUlGBmlBiHfldT9wD+XLz4A861+MTLoguKfGHDlYMOHzPm7Fbo6fX
        DOv17ai4pKk6+tbeNp/Kt3OcPWv2
X-Google-Smtp-Source: AAOMgpc+CM6ySn3B46Fk1lWUi+esdClHnU4cvMdx8vaMZZ9G37jJTqkwkmp86tJx24bgLd5Ofldejg==
X-Received: by 2002:adf:a64d:: with SMTP id k71-v6mr9470138wrc.78.1532379065492;
        Mon, 23 Jul 2018 13:51:05 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:51:04 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 14/15] staging:rtl8192u: Remove unused AC_UAPSD definitions - Style
Date:   Mon, 23 Jul 2018 21:50:30 +0100
Message-Id: <20180723205031.19816-15-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the definitions associated with AC_UAPSD. These definitions are
not used in code so have simply been removed. This is a coding style
change and should have no impact on runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 878c467e7b89..471874dd8cb5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -112,21 +112,6 @@ typedef union _TSPEC_BODY {
 	} f;	// Field
 } TSPEC_BODY, *PTSPEC_BODY;
 
-typedef	u8		AC_UAPSD, *PAC_UAPSD;
-
-#define	GET_VO_UAPSD(_apsd) ((_apsd) & BIT(0))
-#define	SET_VO_UAPSD(_apsd) ((_apsd) |= BIT(0))
-
-#define	GET_VI_UAPSD(_apsd) ((_apsd) & BIT(1))
-#define	SET_VI_UAPSD(_apsd) ((_apsd) |= BIT(1))
-
-#define	GET_BK_UAPSD(_apsd) ((_apsd) & BIT(2))
-#define	SET_BK_UAPSD(_apsd) ((_apsd) |= BIT(2))
-
-#define	GET_BE_UAPSD(_apsd) ((_apsd) & BIT(3))
-#define	SET_BE_UAPSD(_apsd) ((_apsd) |= BIT(3))
-
-
 //typedef struct _TCLASS{
 // TODO
 //} TCLASS, *PTCLASS;
-- 
2.18.0

