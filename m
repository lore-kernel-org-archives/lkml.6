Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4EC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FC520855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 23:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P638SMxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FC520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeIKEny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 00:43:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44954 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeIKEny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 00:43:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so11243380pgp.11;
        Mon, 10 Sep 2018 16:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gUUXUF/wkyeavxOT3k5lUUczw/PDh7TOytJTN+xhUuc=;
        b=P638SMxUH/ePoMmGS+O11Dnmt0bemd1X6/7U2Q7czrxF6XUH37VWfxj5FZ1hhvpay8
         uEs1dV68TIpmhlRVuqGfUSz/VbgD1igADcxqwnIGTe3260i+oqFLMZfyXnj+d+OLwdOx
         RLNtaQZ5d6fRJSS0UDN3XdqrHaBBQsZOvd22+GqG1SJ8J8yhlVYn2VpmZ2jnsYsTo3ZV
         zbEQob/KJ7vrAlv0C98YMr5EFiR+F4BwUyZRy14VYT7na62Ivr8mmzKwHEQzs/afUIuI
         gbakxAspdwWqiuDCJqpbn0RUXgE//ZfoKUfMj6GWOfr5yrifWk629ph0KcpzvqfCUCNK
         wqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gUUXUF/wkyeavxOT3k5lUUczw/PDh7TOytJTN+xhUuc=;
        b=UzHEYOxOh3m2olqPjqPDG84LQs+7lW+yc6sOVuy7P5DimOrI4kqGq5LfJZeltHXmNJ
         55ySQNF703VccSTNuJMTkj6JyR6HLeKyMj3TJPpJK1VAXP6DKz3PhU14TwW3Ab3GqBIP
         1e8PtwcGZ/BVYJqsa+562MxTY6ScEBD3ZKoeB6KWPacvIe3GF6DtUHl5eKSb9/lqCYHq
         lhBsk4janZnr8Nfuq4wfGlsISO+zFxa2djNyDyE3qQWJS2F6TpKzn6vV+QnJVuR8E5Zk
         ++z4DacTqvTOOO9ezlE3ZlAdLHh0MDgIBNjZJDN08meTpbMMo3IwINhzQMjdxLhjPOGS
         EsiA==
X-Gm-Message-State: APzg51BZudQJjeb17E+/4AZh0kah9q1J80WjgFLL+2K22M4HJziYYMr1
        zNxJ2LPPPpBqKiZZhgTOYax+tC82
X-Google-Smtp-Source: ANB0VdZVPkrLyMMC9dELtixiBTfAKDxwwL4I7ellEM+42M4O4qXEjjQ5wqeSscId+urqUWrqI0OmQA==
X-Received: by 2002:a63:2d87:: with SMTP id t129-v6mr25390938pgt.128.1536623247524;
        Mon, 10 Sep 2018 16:47:27 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r1-v6sm31254192pfi.17.2018.09.10.16.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 16:47:26 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: b53: Only call b53_port_event() for SGMII ports
Date:   Mon, 10 Sep 2018 16:47:07 -0700
Message-Id: <20180910234707.566-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Built-in PHY ports are still being polled, avoid generating spurious
and duplicate events which the PHY library resolves through polling
anyways.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_srab.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index b0ed81876bae..321052732799 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -373,7 +373,8 @@ static irqreturn_t b53_srab_port_thread(int irq, void *dev_id)
 	struct b53_srab_port_priv *port = dev_id;
 	struct b53_device *dev = port->dev;
 
-	b53_port_event(dev->ds, port->num);
+	if (port->mode == PHY_INTERFACE_MODE_SGMII)
+		b53_port_event(dev->ds, port->num);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

