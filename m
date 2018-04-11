Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3190956-1523476314-2-6920362518079284467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES encada, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476314; b=EAlM46k1cuPIH+27+8oxcoh3ZZiHl3A7r8wwulZB9jgq5GYDve
    iyM6bcIV71X/GqtgUVW1ir/JEzFrw/yySK91RCaJFtn4M/n79D1h+NyEDW9SJpW9
    omgdr3NnV+uOe3VF+M6InhGqO91CqNgDcOzc73/EarBDmmtVP1UCWOAqD0e+44lq
    a+EKWr2KBFvy/ToTE6G9BuAZvWX9ld3DM9Am3xngSNL8RZSmZTcS0TkCDm8ND6Rn
    tuyE78+aN+7y+gVcctyNP7+bek1KvrcSM2FRiKQxiU+NefThsO/NQUiamR0aRPpo
    9dU6e3sn5/DzpgFsJhyMzjgNNKcvE8nf056w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476314; bh=Ynn7vfZ0ooNi/al9TS4gPkHAzkHfLd
    V7DsHH1QcefSk=; b=lXDCfWqv3K5MTmaplbhkFhmqfSx2qtgZMeLYs5j2HGwBRD
    23KmgoKNy34cWAPvZJqgnlgjfOJHadfR8tv+PEAVwSVDgrJgg8guO1082HXOapV5
    cMNrqsoodvZGitpZZ5F5rkV40r1hCMQJf4mmF0JnrxwRGgwgkImhg8rXzwPSjyYM
    /UquXLss6XMwsp5CEFezk19whmTkQ7qR4vMqRGR0woVsZkZJ7Ov4z/HFPCKpiVfR
    9PWHDg+auQf1sXmQWAL3fX/uVqGlRo3L9RqWEHoGfIZ2uWaW32Zi2eLTimVcFOEh
    GDecKvDozyL3JE8hl8cxXPnieNvaSto5rSf1/Upw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOU/MvIW9qf6K675g28SczF5itzrlhCGD1SHAer+5s9sN5kZQDqbP8ZHtjOJ58qWxHg9gJjhIPDEzLL/JG+MHa2QxhbFepQCEts8bBMiy4L8aHC6hdH8
    NYyBnHmEMpFPzi7Y5EboKDHlAydu3oB9rXz090UZ7RLM094jdAOJIeF69tcOROSV2XEVSEmPTUdtdhIH42+8qrQU2BiuEbkr6OS1iAb7IhOhDo9nLrZzqiJQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=WP-OeG1ZIG9MrmokoloA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754331AbeDKS6P (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:58:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933250AbeDKS6O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:58:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 127/310] net/mlx4_en: Change default QoS settings
Date: Wed, 11 Apr 2018 20:34:26 +0200
Message-Id: <20180411183627.926912620@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moni Shoua <monis@mellanox.com>


[ Upstream commit a42b63c1ac1986f17f71bc91a6b0aaa14d4dae71 ]

Change the default mapping between TC and TCG as follows:

Prio     |             TC/TCG
         |      from             to
         |    (set by FW)      (set by SW)
---------+-----------------------------------
0        |      0/0              0/7
1        |      1/0              0/6
2        |      2/0              0/5
3        |      3/0              0/4
4        |      4/0              0/3
5        |      5/0              0/2
6        |      6/0              0/1
7        |      7/0              0/0

These new settings cause that a pause frame for any prio stops
traffic for all prios.

Fixes: 564c274c3df0 ("net/mlx4_en: DCB QoS support")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c |    5 +++++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c |    7 +++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h   |    1 +
 3 files changed, 13 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
@@ -310,6 +310,7 @@ static int mlx4_en_ets_validate(struct m
 		}
 
 		switch (ets->tc_tsa[i]) {
+		case IEEE_8021QAZ_TSA_VENDOR:
 		case IEEE_8021QAZ_TSA_STRICT:
 			break;
 		case IEEE_8021QAZ_TSA_ETS:
@@ -347,6 +348,10 @@ static int mlx4_en_config_port_scheduler
 	/* higher TC means higher priority => lower pg */
 	for (i = IEEE_8021QAZ_MAX_TCS - 1; i >= 0; i--) {
 		switch (ets->tc_tsa[i]) {
+		case IEEE_8021QAZ_TSA_VENDOR:
+			pg[i] = MLX4_EN_TC_VENDOR;
+			tc_tx_bw[i] = MLX4_EN_BW_MAX;
+			break;
 		case IEEE_8021QAZ_TSA_STRICT:
 			pg[i] = num_strict++;
 			tc_tx_bw[i] = MLX4_EN_BW_MAX;
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -3125,6 +3125,13 @@ int mlx4_en_init_netdev(struct mlx4_en_d
 	priv->msg_enable = MLX4_EN_MSG_LEVEL;
 #ifdef CONFIG_MLX4_EN_DCB
 	if (!mlx4_is_slave(priv->mdev->dev)) {
+		u8 prio;
+
+		for (prio = 0; prio < IEEE_8021QAZ_MAX_TCS; ++prio) {
+			priv->ets.prio_tc[prio] = prio;
+			priv->ets.tc_tsa[prio]  = IEEE_8021QAZ_TSA_VENDOR;
+		}
+
 		priv->dcbx_cap = DCB_CAP_DCBX_VER_CEE | DCB_CAP_DCBX_HOST |
 			DCB_CAP_DCBX_VER_IEEE;
 		priv->flags |= MLX4_EN_DCB_ENABLED;
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -472,6 +472,7 @@ struct mlx4_en_frag_info {
 #define MLX4_EN_BW_MIN 1
 #define MLX4_EN_BW_MAX 100 /* Utilize 100% of the line */
 
+#define MLX4_EN_TC_VENDOR 0
 #define MLX4_EN_TC_ETS 7
 
 enum dcb_pfc_type {
