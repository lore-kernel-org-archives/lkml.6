Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85651ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A10920C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpEkUYoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A10920C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbeGQMjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:39:01 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36253 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbeGQMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id m19-v6so358615pgv.3;
        Tue, 17 Jul 2018 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZpA6K+CHXs0h/hfU8hcGiB7lprfK/b3I20WZX9HufpY=;
        b=hpEkUYoXVIqwX/Twz8fhyPec7i1xQD8/UZj5Jt2s6VjsudoE0ZDes+ukOXWpO1nuyw
         DTE/YPcBEaWgO5iOYoLeq7DkiOXjpMsTPdFS9gQhVx9aPWHoRDWCxQNRTo+JpDNNCODU
         DxjdjKmnXn5yvh2MuTTibkJpur2lS9J3j9M4SiEpSs1TQPhEHGiIff314gqxloiOLK/3
         4U8muqK/ZxhDL4cXj4/88W1yaIlDj4pDqSDpXEz0DiRdhSAlSPZtCsr+t77wl9w5R6ja
         /JMnCj1uL2iloqapaMIu0zlXZbzbNPHFzMZBn//cVE8Ui4agwE9xveQ1RqlIdpT+ZY5A
         0Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZpA6K+CHXs0h/hfU8hcGiB7lprfK/b3I20WZX9HufpY=;
        b=n0FDjexMP4z318ZlVAjYwDe4a1CjLa3X9owGqL+S01uIHzPMWZqVo4+uHZmEJBYHj0
         lhWxJSWyQU1P1zgLhVXVRpyNS5WKF3cpjLJo39nNtkdRS+ya1wjtNu+2WCvjeghxS/E4
         qBql1UoOzOHhIv1UdIIaHgQ/zlhiAL8vHu4dgGGYzMDaXWQVZ/5eccVrXpDEy2wjJQPy
         MMrDWmFDEL+mlg3rTbUC+8SEDvRslctjbGnHVl74Lg4MJWr+VTJALspTXXaCeMyp0UwL
         spb48SSt7Y3PNLDau29AjrRSAImDFdJFTN8MurCzM3c5Uhc+6wONuOrsnbTlMNhBYsKH
         6KLg==
X-Gm-Message-State: AOUpUlG2d+6huJH4KW67KyN84YQWGGKJZfEO/3nDWp4d20OKGXqnNyrX
        edPXgVPmLRpTaq7NC5QPyv4=
X-Google-Smtp-Source: AAOMgpdgjPM3R9BYIR8wzv0UciVZ67t5ZXm9i0/9uaTOGWtd+MFlGvhFQf49Hzy4LEKAJcsuDiIQiQ==
X-Received: by 2002:a63:f953:: with SMTP id q19-v6mr1314826pgk.292.1531829200651;
        Tue, 17 Jul 2018 05:06:40 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id j75-v6sm3290327pfj.102.2018.07.17.05.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 05:06:39 -0700 (PDT)
From:   RAGHU Halharvi <raghuhack78@gmail.com>
To:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     RAGHU Halharvi <raghuhack78@gmail.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Subject: [PATCH] Bluetooth:hci_bcm:Check return value from devm_clk_get
Date:   Tue, 17 Jul 2018 17:36:35 +0530
Message-Id: <20180717120635.25259-1-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5b4ddae5.1c69fb81.61055.042e.GMRIR@mx.google.com>
References: <5b4ddae5.1c69fb81.61055.042e.GMRIR@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Check return value from devm_clk_get & return appropriate error.
---
 drivers/bluetooth/hci_bcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 441f5e1deb11..1295cc89d702 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -910,6 +910,8 @@ static int bcm_get_resources(struct bcm_device *dev)
 		return 0;
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
+	if (IS_ERR(dev->clk))
+		return PTR_ERR(dev->clk);
 
 	dev->device_wakeup = devm_gpiod_get_optional(dev->dev, "device-wakeup",
 						     GPIOD_OUT_LOW);
-- 
2.17.1

