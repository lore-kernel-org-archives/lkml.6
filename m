Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E684EC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFF4208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 00:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSrzAUa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFF4208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbeHABzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 21:55:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44546 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732830AbeHABzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 21:55:44 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so7877062pls.11;
        Tue, 31 Jul 2018 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+R7tgThq9EkuX2iFlGQsp9jqSonqc45a2/W3MXyyNQQ=;
        b=qSrzAUa/bgG3vwxaOa4ohUPipt4q45QTZrinpglzpf2UWaNy1PXsbXffk9gXCdoT1E
         NtoHq8fbMlN8y2OauvMzkB4cSt/dfO7H55AhUYT1LqkV71iWTabqLAmPnlylAS1mnR3N
         WlUHvS38i14wACF7CETb2eNQXgF4p18ZeYPaK8+5xCps22wdALa8P4IVLimeIccTsr4H
         FwheuLnjqyVpUN/9nWKT5OIzVkWG9D3kWHQaTE77tyPyqPcplomEUhHuvdcXu8r0rGwG
         D/4c3NO28j5OGn/319IRc07nthoNzqM+gy4/RyiEoP2uQkO460S6HPFAtSH9uNcF5kGe
         EpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+R7tgThq9EkuX2iFlGQsp9jqSonqc45a2/W3MXyyNQQ=;
        b=L+kAXa1HyWLTrO7Xpk2m0P7nWlMtXOMEl+7PV7QbrNgTLvQlFsUj/3ZuBzpfeCz3W3
         aLK1CWYQTDjZLn6vBcKTiLz1V68PaIre8dpB8ND5KzRgSFFHJSRZbX3AeEQCDQH7ka7m
         B7UQjJoOncM21s29gSk2s2VGzP29yo3PI7e4uMXTRsS65JcSVdxyFNp2/pmOUqX8xwWg
         HWi6iPiwJ9xyw/EMjaDpAzM6pQFsnfESU+IjNNO6h4C6YOy0+h46bZ4H5YcgiUGhWBI4
         VtF2UTCSIuUK9za67KhY+PFGN85Uv9wwrL74UnjomkV0DnN+PF70FtX8O4wUJ11D0+6R
         U0OA==
X-Gm-Message-State: AOUpUlG319tr3ywp5lMZ17ql+a6j81ZHVgb5PdWjL53F6b6EGhNg1zi/
        TaOGYNBKoFGv/93EeXUiiSRce7VR
X-Google-Smtp-Source: AAOMgpejo4v98W97XoV8q8Jimbja5iMsd/A7KhpoiPjBQhVfdyEutwc7/5/u76UGfrfVkzxg83W7ow==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1-v6mr22674418plp.20.1533082376230;
        Tue, 31 Jul 2018 17:12:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i20-v6sm25015504pfj.82.2018.07.31.17.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 17:12:55 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: Do not suspend/resume closed slave_dev
Date:   Tue, 31 Jul 2018 17:12:52 -0700
Message-Id: <20180801001253.16312-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a DSA slave network device was previously disabled, there is no need
to suspend or resume it.

Fixes: 2446254915a7 ("net: dsa: allow switch drivers to implement suspend/resume hooks")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/slave.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 1e3b6a6d8a40..732369c80644 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1248,6 +1248,9 @@ int dsa_slave_suspend(struct net_device *slave_dev)
 {
 	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
 
+	if (!netif_running(slave_dev))
+		return 0;
+
 	netif_device_detach(slave_dev);
 
 	rtnl_lock();
@@ -1261,6 +1264,9 @@ int dsa_slave_resume(struct net_device *slave_dev)
 {
 	struct dsa_port *dp = dsa_slave_to_port(slave_dev);
 
+	if (!netif_running(slave_dev))
+		return 0;
+
 	netif_device_attach(slave_dev);
 
 	rtnl_lock();
-- 
2.14.1

