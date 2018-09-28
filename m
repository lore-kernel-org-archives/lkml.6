Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E0BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDDF2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pcnr75rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDDF2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbeI2Fpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51693 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2Fpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so3656059wmi.1;
        Fri, 28 Sep 2018 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Piwc98Rhl39Hpiu2GJne8FYMrIF9jD8b1cwLP656bic=;
        b=Pcnr75rbfu9HIrsQjIdfBEU0vz34OCgUeX23DJPcTiLGUSiRJVoZc9lz9qGkjIiOcC
         wUYjRi69QbfRWo/LL1L96+WJ4BikKAqz3TTVF19v6OIzEsKwA3gsuv2waroe90NEOxk1
         p+pmy0cWVilRS29EChc2DzNASvA6zWRxD3oCkja5yMCZzDSdhfM2IlQJ7oL7G32jnH2c
         BWyWWzjmt0R1xWtNYLcMHZOhzICEEc3qSdXBXQ0ssVQtTrGrt16IQJhSzR/LoyoXT656
         CPUnsCjv4pgJxrnrf6TvGBLQrKHrIMqEDIFmjhwBVfrDPUIF2xoR2R8gOLgcEiLR3fQX
         PjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Piwc98Rhl39Hpiu2GJne8FYMrIF9jD8b1cwLP656bic=;
        b=OPglw/my4fPZEFQJi3Kao8l5uBjWJS1o50c6XTXKENw97PeRWGLTC2839ftEy2sh7q
         EbcMLqRHWH+PCXKd0xGGe7rzkLvibSD1ao79V8SiH0gMS/XkhncdsV9BrK0ERzJmA4k4
         8DNRD3GpIdhc2lEgaHMOm+bXAb/9p7qXjlLfm+YKcRekGlwt80unNK8V3bayOl9z/B/W
         uZv9hTYz+RyUhaxcJhUSnZDjw1+hjwV0vdggSSC7tWhWzp1qclKNT5ZQLuhOTUJ3ddVn
         hbjEdbcIItMTrzlYVUPIzjhjbsa9+z943ssNVplQG/U2/kQfjSDJiHnuWLPZFaiWf9JZ
         PGoA==
X-Gm-Message-State: ABuFfohqHaxc6dgz1N5Zvr7TN50tvY8PG+nma/l9NxP+Dk8nr1RFyht+
        8YxV/LosAPp5ml+o8e0Wep5icgNm
X-Google-Smtp-Source: ACcGV626wKqCBnh03Bs22JMEHG+vOVREBV/JLZnFnvKyUfAbCiUERuUFsaSAuGsdXen2JbOulXbDPw==
X-Received: by 2002:a1c:d712:: with SMTP id o18-v6mr3307394wmg.54.1538176771071;
        Fri, 28 Sep 2018 16:19:31 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Steve Glendinning <steve.glendinning@shawell.net>,
        Kees Cook <keescook@chromium.org>,
        Alexander Kurz <akurz@blala.de>,
        Hayes Wang <hayeswang@realtek.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Grant Grundler <grundler@chromium.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Wang <ran.wang_1@nxp.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 5/7] r8152: Check for supported Wake-on-LAN Modes
Date:   Fri, 28 Sep 2018 16:18:54 -0700
Message-Id: <20180928231856.3587-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180928231856.3587-1-f.fainelli@gmail.com>
References: <20180928231856.3587-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not check for Wake-on-LAN modes specified by an user,
but will conditionally set the device as wake-up enabled or not based on
that, which could be a very confusing user experience.

Fixes: 21ff2e8976b1 ("r8152: support WOL")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 2cd71bdb6484..f1b5201cc320 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4506,6 +4506,9 @@ static int rtl8152_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	if (!rtl_can_wakeup(tp))
 		return -EOPNOTSUPP;
 
+	if (wol->wolopts & ~WAKE_ANY)
+		return -EINVAL;
+
 	ret = usb_autopm_get_interface(tp->intf);
 	if (ret < 0)
 		goto out_set_wol;
-- 
2.17.1

