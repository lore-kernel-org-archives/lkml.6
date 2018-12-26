Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0596C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F86121726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="OzpGiYDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeLZBXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:23:01 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:46892 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeLZBW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:22:57 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 88E9FB04
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 01:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M3qWQRncc-ro for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 19:22:55 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 5FF57B05
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:22:55 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id w15so18477730ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 17:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AAHoTsSyNIe43BLaEwGnXajRWoTfyjipo1H+0l91hMk=;
        b=OzpGiYDxGTYe05By8QY4VsUBw8YTW87quAQ84CteyHxUP+2gQgPnUsDrwmjHxZ7sK/
         pKgF4Dtc32YeEUb5kkRdWKBMBrdKsXdiY0CsmopcH0KBI4T8DQjUmKaL6GumR6lc8f2j
         /l0ABrCcvg65UaB6hkn4OfvmkXtrHFy4lKB89/AgLzz6cxVTj+OChUre68H0oC9CBluP
         NOHTkYD100YQZZXjZF+XQax3OvTw/jDZLxBd0swXAzzW8bacjKzo5rCV6LlTBqphuPYt
         z012JGwXGJTMjyOZMrPPeKf/uX6vWarTHCSUV4IwJvUKujlBqXByQ/r6sWR0F73w3K3v
         hxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AAHoTsSyNIe43BLaEwGnXajRWoTfyjipo1H+0l91hMk=;
        b=RLXSymXHk/C2uo2jSN7o3lURDs/kF4kulWLjncH/XkcJw94WnoNuowhf7+brV/glfJ
         veYDzxF0LhmgSL3QBy670R7tSv21R6eR40BmyxR72LU4lCbaxwdfIdVWuDU6tZGEpDab
         n8zukRWFdtFo98cOKc/bRKYaD3iouJcsZvQ74dBFuwYOTFIWILs7/WO2ZpyvEYsZKmG1
         NMebJnT8sP2ZdbKZcurrNTlHPXoKMBpR6sP6sQIXhLoMyZUSFnBa6KQzK8gJ905QUovQ
         f6SuWpOPhYqYw2ttlrgMHAiLtqXaCKdhb1HCjPvm72EPsB4MluRJ1PoMYqg/sV9xZA9D
         ss9Q==
X-Gm-Message-State: AA+aEWa4ehFoLREYQ12/nHY3U6N9KTTwOtM5ELMZz09Hefbi38XvuA3n
        FP/lSO585CufdRs8Pi1Jqe4fhfJOQcHUYfZVUDdxJTZi5t8s3l7xeS+ThxoVS4EDr0G1VSkVSwg
        ECQOR6AXTZOTRnLei9Nvq+KUlAHDs
X-Received: by 2002:a02:284:: with SMTP id 126mr12114848jau.47.1545787374833;
        Tue, 25 Dec 2018 17:22:54 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UEsaqFoxYQKLg11KutOSESE4hYftJeOcyDjv53pju66WJPbHcLwG89Z8BM0dA1e5lj300UkQ==
X-Received: by 2002:a02:284:: with SMTP id 126mr12114833jau.47.1545787374602;
        Tue, 25 Dec 2018 17:22:54 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id t7sm14817847iom.27.2018.12.25.17.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 17:22:53 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: brcm80211: add a check for the status of usb_register
Date:   Tue, 25 Dec 2018 19:22:24 -0600
Message-Id: <20181226012227.70524-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_register() may fail, so let's check its status and issue an error
message if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index a4308c6e72d7..76cfaf6999c8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1550,6 +1550,10 @@ void brcmf_usb_exit(void)
 
 void brcmf_usb_register(void)
 {
+	int ret;
+
 	brcmf_dbg(USB, "Enter\n");
-	usb_register(&brcmf_usbdrvr);
+	ret = usb_register(&brcmf_usbdrvr);
+	if (ret)
+		brcmf_err("usb_register failed %d\n", ret);
 }
-- 
2.17.2 (Apple Git-113)

