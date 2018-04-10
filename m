Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48FY5m6VxfhOm1eChik4PbpZHzTvsBOpJrlJZ/InBI76baa6RUH93km2G1IWfwe1LdBtyW4
ARC-Seal: i=1; a=rsa-sha256; t=1523399657; cv=none;
        d=google.com; s=arc-20160816;
        b=tnWCTIyX51f5sSUPG6/bJKFbSyE3PIeKPon+mYq/9mBLxErIYMqtCVDIJy+5WAsRda
         4Xg5c4iK6mAh3777UaFhUz2Z/FnyhujqRrDRpUpzp7QLcrG8zd1PDGLnlnaxhYyJCtsd
         UBODUsbaFP86+eWomHfK0+cu9fKdMr3tvzZTgT4xWei3xvksoK6DGRa9iR5jIf8TM4BT
         VDhhRQQDYUuvEH/iePZUKxvP6r5qOdMobr+DMhi4pxRvaI5LIW3KA5dmUV+uSb56IILJ
         7ci6DX3GjcMCffN9QonpAgFUrS24A6KRSs5E+jQpu82DykGnB91vtK1IoQgJYDta70F0
         h1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MCV5HYzqLP5pQqnf5KbaEL+0OqRRHiKkBvrfhfjPh6k=;
        b=p0kGaLWMTbnCOv1vsL1zKSxVVnF2/Vvsqk0s7lqr+CqV/9wsV7R62hQQRw9uLNEMie
         BlCWz2Fc4gD4r90KeNBkoTJfKPKufbb/jlkHj/ynEOKIdDDlGWNLX8Jn4oY+X3mxgsC0
         CK3vCTpHcYjf6RzbDIEZAy8aSopYvjDdw6WiAACfyZukNDdXIHnx2CN2u4FkL3bA7O3v
         EwRHJiF2HvS6PORKUJKu7oFi5o+BzSCkCXJ31kiXoGe5msv7wDAf0IKUKdubhMwPWLCR
         Qo7t63qX4zSOUdaPoqhzZDY8M+uq2PXbY1DN8Vlrwhw705i8pYYqLpbJYb9qWOLPOpGn
         cbtQ==
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
Subject: [PATCH 4.14 017/138] net/mlx4_en: Change default QoS settings
Date: Wed, 11 Apr 2018 00:23:27 +0200
Message-Id: <20180410212904.100608745@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399830071735564?=
X-GMAIL-MSGID: =?utf-8?q?1597400319496115379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3335,6 +3335,13 @@ int mlx4_en_init_netdev(struct mlx4_en_d
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
@@ -476,6 +476,7 @@ struct mlx4_en_frag_info {
 #define MLX4_EN_BW_MIN 1
 #define MLX4_EN_BW_MAX 100 /* Utilize 100% of the line */
 
+#define MLX4_EN_TC_VENDOR 0
 #define MLX4_EN_TC_ETS 7
 
 enum dcb_pfc_type {
