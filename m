Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA649ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75696208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcr5juyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75696208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbeIXXjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:39:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38390 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbeIXXji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:39:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id z186-v6so17463175lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=spUdjBQRuwk8DWj3ogVgva32aOcEkFHZyflFpBuWXnk=;
        b=Bcr5juyYLFPgtc9o4/wcJIEgoMdEtL2XSQoBEzJ2h7y34brFbhFnLpcmVUvPxyrq11
         ZrO4qWyeRVy6ayo2oPW7dM6Po8/tKN9+wOGYZKn7mAO2p9KiBbMFCquEO72oMCinPIge
         1+w3AHoCY3nlTiYj+30JDhlTYKPPX/NgzfGmC4SZQHV9zfMhv46vANtmR8zOIsrcDU4r
         ZQ735Js1Jh2U6NVsmPmrBfDvH9K6vCw8VvkYMFQCozz/Vr+dduxifnMcTmuZnc2+HZiH
         Vvxx7WhRVh6brV/p5F6XD2kgv70ixf/NujMycjvAHxFN4VFclnXaPp7sZcdgJ2oxhXEA
         rnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=spUdjBQRuwk8DWj3ogVgva32aOcEkFHZyflFpBuWXnk=;
        b=Z7bIKBqEqwT+6fV7Khq+GD/fifnzBKK5+/MkIUpJAXusZfeCg3Btd8Od3V479NpBG/
         z49PHvBmbg4YPmBxq8tYEiqzrloFfpin7JxniyTQu/dWf9g70IkxnR3P0p9RbFiFJtam
         pwWEI60dY65ZgN6QrxQkmp4W5jzyUt+4CAWodL6RnQWp+jDHfvmAwRCcVNNiS4WGaTD+
         OJsD3oUlnvrAs+WvVOcbHS31MFwyWMqBmLJ2TmIW6SQIngGRZDMimTsVBM8cr2PshIP9
         fcDOacKis6sLXQnuFau8H3Qgzc64/H1W1LtYQpW8OVoTwdguzJO1jlPwcozjvDS4Qdnq
         KJ5w==
X-Gm-Message-State: APzg51A03Xw2/YvxkYdiDLztGcbj0yRrGWduJO2iQOcmT8LauVHpecJt
        kqr9tBcGGWTuc9m5Djr0Jmw=
X-Google-Smtp-Source: ANB0VdZcvZ0IVwtBrd2rv4HkXgEAyNCI6SbmaUJj8LgRkon/hoeuu6XlYS09yXZuL5GXre8d+kbINg==
X-Received: by 2002:a19:cb09:: with SMTP id b9-v6mr6753650lfg.117.1537810582749;
        Mon, 24 Sep 2018 10:36:22 -0700 (PDT)
Received: from localhost.localdomain (185.59.110.199.maxnet.net.pl. [185.59.110.199])
        by smtp.gmail.com with ESMTPSA id g16-v6sm3878956lfj.15.2018.09.24.10.36.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:36:22 -0700 (PDT)
From:   Arkadiusz Lis <areklis909@gmail.com>
Cc:     Arkadiusz Lis <areklis909@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: remove unnecessary nullpointer checks
Date:   Mon, 24 Sep 2018 19:34:22 +0200
Message-Id: <20180924173425.12162-1-areklis909@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes nullpointer checks which are redundant. container_of
returns structure containing entity which we know for sure is not null,
so the whole structure can not be null.

Signed-off-by: Arkadiusz Lis <areklis909@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3e51476a7045..0e8d3f232fe9 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -2513,7 +2513,7 @@ static int nbu2ss_ep_enable(
 	}
 
 	ep = container_of(_ep, struct nbu2ss_ep, ep);
-	if ((!ep) || (!ep->udc)) {
+	if ((!ep->udc)) {
 		pr_err(" *** %s, ep == NULL !!\n", __func__);
 		return -EINVAL;
 	}
@@ -2570,7 +2570,7 @@ static int nbu2ss_ep_disable(struct usb_ep *_ep)
 	}
 
 	ep = container_of(_ep, struct nbu2ss_ep, ep);
-	if ((!ep) || (!ep->udc)) {
+	if (!ep->udc) {
 		pr_err("udc: *** %s, ep == NULL !!\n", __func__);
 		return -EINVAL;
 	}
@@ -2743,10 +2743,6 @@ static int nbu2ss_ep_dequeue(
 	}
 
 	ep = container_of(_ep, struct nbu2ss_ep, ep);
-	if (!ep) {
-		pr_err("%s, ep == NULL !!\n", __func__);
-		return -EINVAL;
-	}
 
 	udc = ep->udc;
 	if (!udc)
@@ -2787,10 +2783,6 @@ static int nbu2ss_ep_set_halt(struct usb_ep *_ep, int value)
 	}
 
 	ep = container_of(_ep, struct nbu2ss_ep, ep);
-	if (!ep) {
-		pr_err("%s, bad ep\n", __func__);
-		return -EINVAL;
-	}
 
 	udc = ep->udc;
 	if (!udc) {
@@ -2839,10 +2831,6 @@ static int nbu2ss_ep_fifo_status(struct usb_ep *_ep)
 	}
 
 	ep = container_of(_ep, struct nbu2ss_ep, ep);
-	if (!ep) {
-		pr_err("%s, bad ep\n", __func__);
-		return -EINVAL;
-	}
 
 	udc = ep->udc;
 	if (!udc) {
@@ -2885,10 +2873,6 @@ static void  nbu2ss_ep_fifo_flush(struct usb_ep *_ep)
 	}
 
 	ep = container_of(_ep, struct nbu2ss_ep, ep);
-	if (!ep) {
-		pr_err("udc: %s, bad ep\n", __func__);
-		return;
-	}
 
 	udc = ep->udc;
 	if (!udc) {
@@ -2959,10 +2943,6 @@ static int nbu2ss_gad_wakeup(struct usb_gadget *pgadget)
 	}
 
 	udc = container_of(pgadget, struct nbu2ss_udc, gadget);
-	if (!udc) {
-		dev_err(&pgadget->dev, "%s, udc == NULL\n", __func__);
-		return -EINVAL;
-	}
 
 	data = gpio_get_value(VBUS_VALUE);
 	if (data == 0) {
-- 
2.17.1

