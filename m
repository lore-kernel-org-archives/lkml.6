Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC823C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877B521471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVgLBgPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877B521471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJQCM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:12:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45025 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJQCM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:12:27 -0400
Received: by mail-lf1-f66.google.com with SMTP id m18-v6so17732625lfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssuygcYMLn1Q3WIghGGutlJDCYEv/K27yRAinbSWkn0=;
        b=SVgLBgPNL/Sitz1phBzvx86rsDjysgDcl4zkZoW8vR7l04xha37TWN57++dA+Z7tbG
         8a62jDyS2L1Cmn1YBDyC8OBpIl6Sy83zj1YANM8LCJN9L7KJE56gjxwSuXKVXYISoQq7
         HoWglV34ppwNd8C53EhQe0LRiHB1zASMCaoqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssuygcYMLn1Q3WIghGGutlJDCYEv/K27yRAinbSWkn0=;
        b=OEimGybECwEXHmf+WAWD2Ju3AoN2sSTbcALEEMEfyQ0z/eJshFSGBttb0l2444zOn6
         Na0nhji0VNVPqQJoJtmuV0dYCcaA7hRvBfnZ4eLDfxzXW3R5rpTKbeDWZ6ZFItmpvRvf
         hojM/NRDVnpDHVzgPyyPwViav2L2QRHoaqI/GrOumEk/eu1mxcak4Rh78qLWmwqQf9jG
         6qEXDsZpl74TPJKiufx2PWfDlHfKCko9DKkv0adv7+FlcoHRDcPolJwhEB8zQlbeeqTh
         eVA+ULD10bXtlpraY8B27lUP2FxDr0jaA5dTxYj8t5z+P5mI4oXGCdH9lamZcV6nUbWv
         ZGKg==
X-Gm-Message-State: ABuFfohgO8LF32e9Nwk4I+3JGaupKF5rveDhK9vm8fcWUAn+WHyfB3fm
        SRlixEnKg04KaD3X9FbrNKrIHg==
X-Google-Smtp-Source: ACcGV63xvagoTNoSMklmn+Vbqu7O/3oz7HBsg8rMijkZXCRqDemPgsGVYfIMKZf9bwZda16jnK+bAQ==
X-Received: by 2002:a19:d3c4:: with SMTP id k187-v6mr13953987lfg.101.1539714044045;
        Tue, 16 Oct 2018 11:20:44 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id i27-v6sm3207844lfc.22.2018.10.16.11.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:20:43 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 4/4] net: ethernet: ti: cpsw: fix vlan configuration while down/up
Date:   Tue, 16 Oct 2018 21:20:35 +0300
Message-Id: <20181016182035.18234-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vlan configuration is not restored after interface donw/up sequence
(if dual-emac - both interfaces). Tested on am572x EVM.

Steps to check:
~# ip link add link eth1 name eth1.100 type vlan id 100
~# ifconfig eth0 down
~# ifconfig eth1 down

This is TI sdk tool, dumping all ALE entries, see they are present
~# switch-config -d
~# ifconfig eth1 up
See entry for vid 100 is absent
~# switch-config -d

Try to remove vid and observe warning:
~# ip link del eth1.100
[  739.526757] net eth1: removing vlanid 100 from vlan filter
[  739.533322] failed to kill vid 0081/100 for device eth1

This patch fixes it, restoring only vlan ALE entries and all other
unicast/multicast entries are restored by system calling rx_mode ndo.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 5967484619d4..0b28a90b62bb 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -565,6 +565,9 @@ static const struct cpsw_stats cpsw_gstrings_ch_stats[] = {
 				(func)(slave++, ##arg);			\
 	} while (0)
 
+static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
+				    __be16 proto, u16 vid);
+
 static inline int cpsw_get_slave_port(u32 slave_num)
 {
 	return slave_num + 1;
@@ -1955,9 +1958,23 @@ static void cpsw_mqprio_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
 	slave_write(slave, tx_prio_map, tx_prio_rg);
 }
 
+static int cpsw_restore_vlans(struct net_device *vdev, int vid, void *arg)
+{
+	struct cpsw_priv *priv = arg;
+
+	if (!vdev)
+		return 0;
+
+	cpsw_ndo_vlan_rx_add_vid(priv->ndev, 0, vid);
+	return 0;
+}
+
 /* restore resources after port reset */
 static void cpsw_restore(struct cpsw_priv *priv)
 {
+	/* restore vlan configurations */
+	vlan_for_each(priv->ndev, cpsw_restore_vlans, priv);
+
 	/* restore MQPRIO offload */
 	for_each_slave(priv, cpsw_mqprio_resume, priv);
 
-- 
2.17.1

