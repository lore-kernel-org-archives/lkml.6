Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48m+j5QIlmbtlY8hx1LtAD8y40XgseJcQSo7ZjYVgGkuoyXRp9cn2JSRCnX4nJ05cRwU3/+
ARC-Seal: i=1; a=rsa-sha256; t=1523399190; cv=none;
        d=google.com; s=arc-20160816;
        b=eGYuzMTFQp2+ZBkULYX0Z3JSxG8/DglYA57KJkStDGWlgCYD2msj9g/PT/6Ao+QGpM
         6HtAZPfXpkkSq6mmifEjYa1U1Qpf60eZRsHsSUgczEQ5iYVWvkBw35op8oYKrWNS80IE
         RmWIEGG4/OIm5WdP+QScrnVmWwKQwmMTwPVj2L9iQA7EIL6QXl4KDjoVtE/M0XUZRhkp
         lbGEFzRx1LtSsRPSx9ll+tCDSqUdbcX/HZ8LWswfkFD5j1TiWLjwbxVpKZKq1rB4dvEz
         33fHyyoeuUp/xxaOgibyYr/fA0lGR7DQpAPL0yMEmJR1fTIlnx9Gi2Fwj8S9BV46XbQR
         Oxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4jj3+lS9fuvbQXz2INAO5NW3pio0DAxuguA0mHEe1EA=;
        b=uMw8h2r+i2DTPSrEQAnkwcIJGiNQaUZubaQ1leHPwEwKO14S86f2aWdibjn3l3QHUa
         cNHTmWhtu96SLCRmfl8WAznn8Vu7MMHIQxM3MxouhvKQh/LtBDSm4JKPTK2e7oNLxm5B
         aG5FXF0qp8LuGymeHu/jplR/fcoHbYqMw7khuQfIDY0KF7e7bI3k3Q2ql/3PgIYsLoII
         ZT8D3ovNpfzdyDltrvZ41t0krzrYnsFRfbPSI5vI/haWcSPmJP1wsjhsxx5VVT3mMzXz
         VK596kFFd1/Zx/yL+wqyiM6PJ2tUh7k45gwEnMCVRDO19TcwXrB97KrODSPweolsPYEb
         AAwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moni Shoua <monis@mellanox.com>,
	Maor Gottlieb <maorg@mellanox.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 019/168] net/mlx4_en: Change default QoS settings
Date: Wed, 11 Apr 2018 00:22:41 +0200
Message-Id: <20180410212801.028229454@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399830071735564?=
X-GMAIL-MSGID: =?utf-8?q?1597399830071735564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3336,6 +3336,13 @@ int mlx4_en_init_netdev(struct mlx4_en_d
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
@@ -479,6 +479,7 @@ struct mlx4_en_frag_info {
 #define MLX4_EN_BW_MIN 1
 #define MLX4_EN_BW_MAX 100 /* Utilize 100% of the line */
 
+#define MLX4_EN_TC_VENDOR 0
 #define MLX4_EN_TC_ETS 7
 
 enum dcb_pfc_type {
