Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2A2C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D9D206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQq08hTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D9D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeI2Fpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:45:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36670 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2Fpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:45:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id n23-v6so3641169wmc.1;
        Fri, 28 Sep 2018 16:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7EjcO8AOqi6wmrlm1Wfclavax7VPrDQSsrxmfbBlQM4=;
        b=VQq08hTNz9D1I2y2uKcuIOdXti6LnGuCqF319oJTs5LyDBAa2SG3bLbEwj23aBoqsY
         QL2efI+MdzCSUmjSH8CsYxQzh1ubmkyKdOX0JmgWFG6Zw8atOUjDIqBgVOfIX6t4rERj
         XjKlC8xM0iACIIugay8SqOkU0+IWazIxeXw4V7kEFddtjFN/2hRj293Ss/fuqfsILC2W
         zaf7mnOcibqEpvI3WkydmQcoYSVTd2LGgAtf4PrgvXYB7a052zSIO5gQ9AT4/IJYBlD0
         1yb1p+qbhCCHc+6N17H/JmQebfhcct8nh7HKnGYwa9SXjwiqR5SZHytNm+TYJyA7hgxD
         rfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7EjcO8AOqi6wmrlm1Wfclavax7VPrDQSsrxmfbBlQM4=;
        b=DEsn+Vuik+T0EiHiq9VhG8DPfV7H1eInknWD9GHqKDnULNHTstsOtWJyVx4Q0Obk1O
         5oUlHPxjThmcLT91khXdg3R3Kwayhfq9V/AgK7djxBU1DFUZ3W9F8eA+l3EobDNOzUln
         vegSp8hK4AWvDRnAeNp3ue7twQ56Do+sFpntRUE8SXAjv0tdt5EcSu2JaPhoypGhSA/A
         feqBVWOeAFKP3LaaQP6+n1PMJhxjmSUlL30PGqp71r5/n5khcbGgVuTz3nF4ei8kxBSn
         jysCC+mA2XsDs8Tp19CQu2X4pTmS9aGluXVXo2P6EaSN1eC5pORPEv0jAjconv4I4NeQ
         vf8w==
X-Gm-Message-State: ABuFfoj2+6OBYClF1RZWmS0ISefph3/bX8aIDuAda1LV20Hko03EKvXZ
        +nSEPrLkkYPbniPPNThwVQ5T2FWN
X-Google-Smtp-Source: ACcGV63XAKq6n9nar3nclIwQfJecn37KLHcgeuCjccwcwACHP9zeLw+FvqvpYucwdJeSOgbMbO5r1w==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr3036890wme.125.1538176779409;
        Fri, 28 Sep 2018 16:19:39 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 11-v6sm8590730wrb.95.2018.09.28.16.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:19:38 -0700 (PDT)
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
Subject: [PATCH net v2 7/7] smsc95xx: Check for Wake-on-LAN modes
Date:   Fri, 28 Sep 2018 16:18:56 -0700
Message-Id: <20180928231856.3587-8-f.fainelli@gmail.com>
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

Fixes: e0e474a83c18 ("smsc95xx: add wol magic packet support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/usb/smsc95xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 06b4d290784d..262e7a3c23cb 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -774,6 +774,9 @@ static int smsc95xx_ethtool_set_wol(struct net_device *net,
 	struct smsc95xx_priv *pdata = (struct smsc95xx_priv *)(dev->data[0]);
 	int ret;
 
+	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
+		return -EINVAL;
+
 	pdata->wolopts = wolinfo->wolopts & SUPPORTED_WAKE;
 
 	ret = device_set_wakeup_enable(&dev->udev->dev, pdata->wolopts);
-- 
2.17.1

