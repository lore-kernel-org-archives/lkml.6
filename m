Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF47C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C068B223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="elfy2KSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C068B223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeHJPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:17:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42834 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbeHJPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:17:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id f1-v6so7068411ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/BAzsY3ygWwvCiEZ/10Pn/Lg/p2uPBAkEn1J4zXy7s=;
        b=elfy2KSglYDEJJxxOi/LXkMdCR5gy14vWgFCPrrD2WTXhDnvaUc1VJDFb0m6LYIODJ
         i63AlPUo3meeXB7hhfstAUfH6LFR25BNdJFVHeMzqBwAzFyY6bjS+cZEAOIwi7gvyQRV
         g0ZtlAxvALSeX2oqVwEh8x+KLpn64hiVpXNUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/BAzsY3ygWwvCiEZ/10Pn/Lg/p2uPBAkEn1J4zXy7s=;
        b=aG2F8lxSNZc9mMv0SpJn+V+1TcW4VONQM2S9bNyp3NCzxbq4sUHSyTC4UsGoqfSFgG
         tdST/LKPrfrQOxkrnqnaBoJxFy3bulioPDz4zQ/kCtcQz2v/+LFqHD6Bi/hvsHy6ueIv
         kp2EvMcvgax0AVQZfpL1bubPfaJICgjUtZaYlCLWyIKBMG2Odo0Ns160rCdJYCt/t7i3
         7NhJ7Wi5J3HrR8j23NMOWXLyscyiCk6QWwvUA1ensfJgniTO0YbAX5ph+T9RxP6ghSoK
         wH5OFprQkwLf7sZBEJ2UWLs14ytRvqlTM8ZBNUp1IRDXiyV3q1FZwKDb+NlCG4nC0aXv
         FgMg==
X-Gm-Message-State: AOUpUlHbYYzY64aZcRLQnp6myuGGibve8jEqlbH7fP06ZVPputjNAWTs
        vwwXEauR3eWlmtcauhLZh92x1w==
X-Google-Smtp-Source: AA+uWPy4nUa6KyEGWUGvlrXze3jkwirmAPKsARS+ANvFwdwU8ME/1u3CLQEyZN/QiS5US2giVg7GVQ==
X-Received: by 2002:a2e:498:: with SMTP id a24-v6mr4875106ljf.27.1533905242306;
        Fri, 10 Aug 2018 05:47:22 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 84-v6sm1626382lje.48.2018.08.10.05.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 05:47:21 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 2/2] net: ethernet: ti: cpsw: fix runtime_pm while add/kill vlan
Date:   Fri, 10 Aug 2018 15:47:09 +0300
Message-Id: <20180810124709.25089-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
References: <20180810124709.25089-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's exclusive with normal behaviour but if try to set vlan to one of
the reserved values is made, the cpsw runtime pm is broken.

Fixes: commit a6c5d14f5136
("drivers: net: cpsw: ndev: fix accessing to suspended device")

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 9edac671f276..3e34cb8ac1d3 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2086,14 +2086,16 @@ static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
 		int i;
 
 		for (i = 0; i < cpsw->data.slaves; i++) {
-			if (vid == cpsw->slaves[i].port_vlan)
-				return -EINVAL;
+			if (vid == cpsw->slaves[i].port_vlan) {
+				ret = -EINVAL;
+				goto err;
+			}
 		}
 	}
 
 	dev_info(priv->dev, "Adding vlanid %d to vlan filter\n", vid);
 	ret = cpsw_add_vlan_ale_entry(priv, vid);
-
+err:
 	pm_runtime_put(cpsw->dev);
 	return ret;
 }
@@ -2119,7 +2121,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 
 		for (i = 0; i < cpsw->data.slaves; i++) {
 			if (vid == cpsw->slaves[i].port_vlan)
-				return -EINVAL;
+				goto err;
 		}
 	}
 
@@ -2129,6 +2131,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 				  HOST_PORT_NUM, ALE_VLAN, vid);
 	ret |= cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
 				  0, ALE_VLAN, vid);
+err:
 	pm_runtime_put(cpsw->dev);
 	return ret;
 }
-- 
2.17.1

