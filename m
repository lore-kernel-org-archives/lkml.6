Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx4+L+cgebEWdxxvgIMmDiRMM+nLLj007+286G7e63Vt93UjbxILjdpPw2zhiXBFyFsq1Li1e
ARC-Seal: i=1; a=rsa-sha256; t=1522393799; cv=none;
        d=google.com; s=arc-20160816;
        b=rMsrogG5x8IiSp3j7Qq21LtIhbQb1S9KndJDT+IDFNeOaRiJU8mzQ4RAaac5KRE1zG
         IKZvthHjAR68AcxbrzD84ZYIBH4C/T7j1bnnI7v4DpuYfnO2KABAVR0b+al5zYvjKf+K
         XGRC4zbQ17EjkJdOlXhpx6NQxTuNVWjEd0dewarhVYXY2S03K9o43x61vel0RgXSitI+
         pgVJ/2GIUlvlCV3ZrxbYWEdEEH/IRkhzTPHfByV5u85tpvC3jj3kIIjCd/SqAuR+k22O
         gLCjoDb/D0w0LbtSQy7+vasqmHEhkWTAC0bGlQh57BaxL7vcs8arKaBUDEUZlQMU7DRF
         uk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=v73nl5Sk9z8ExCbT9mm52GVUE0cXb9NKSGbBELVmd7M=;
        b=OUNytzeHHEYb/Pl8gitDtGAGnTWxmA9oHfp7rmIJnDnK0oNZGkCUd7IZEpKRLlbVkV
         xokeJTiJGnBJq+VRk6+/OS7qiYoan6LqWNNez0lOSymMfyGns9O7jwUbRlHpVzg9gNfY
         6Ou3GcvQIWTSjGf4UwA6Gpit5JndYJ7Fd3gmPAxfW2DJmjo32EjEvVnQnWSn4P4QgTlP
         a8dqIWNO2sXggXle+L89e/DwH2d4Tm8m+m+sLB7IYoYRMm3w6nxbL/o+Ze4cbfSASebn
         3wl2rFN6ISRYqT+Bj19LmpLfeHboKrbDBn8GnH3eIOJTor2Z+FZlFI3rU+NEfL8UAs2u
         7PbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.194 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH 70/72] staging: ks7010: Rename ks_wlan_set_multicast_list()
Date: Fri, 30 Mar 2018 00:08:34 -0700
Message-Id: <20180330070842.25224-71-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:kWQ/TR11DwV4Nni3Op1X9lAY8daCZg8YSDjtMZuJIoEinI3Hg4T
 H5gz1VOLs09AA8jOl8rWaRdpxVNrludtPr/bQF/9hgckQakv9i22gqdXa++0hCBDQHPDxlf
 I/aESgnTrcoVZF2qJiBOlNsOPHkli9kuLwJ/qaBVACrBt8AjPav3FPvJ4ZIf7TKZtZO96JO
 C9wtQdUqMcYapv7XYgrLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ICaL69QgPno=:kVGOKZJmcfKsYLH3G+/FCW
 F+Fr8LE1jloomGUM3gJgwWhGUM8vnToER2XiEjw4wuQhy/zgptYGvW3AzlFU9rQvTCPNmUhyY
 EQR9XkMskuTMmk+OayPVlfA9Oq65DOuvAWc1Wu1RICmQjniPz6IdtEnelcoKNgisqpMprSX3q
 Rl1c+WSw7OGaRXb8UekOYxP5C7371RoI3im7479ZgGTRqajHE94HeP6clgGSTcE511bdgg9xm
 g6SBLf5wJWy3olfut+Cf5PEbD74MVzxRoDMfNVyLyhSyMe/u8H4WgO4lnGqofh/nZECE8rD/n
 nLko53DQwE+DExm0++U4vExFG76YISNxoO9FUcuSh7v16EZwBz5a5CWzM+GkK5bF91W22xo0L
 EmaC3OisXz3a6iLRUUwQwv0meYlAvaIbrORmSN9YIzx4DPfqrfCXcEeZHyGlAlrJLlfNsT3rp
 B0kqXLQVPTDsJm0WKXAg55YbcWBnXderkUqPcWbtvC4yzLROTHoFVJQ4tpd6GVCbpzs5iNdKb
 T4fa/1q+x5p61OMK23o4igW0Ta6KV9Plkhm0XGzALPYuIbsitzXXFejO4PkD1LL2eyHzB9uSr
 7Tq5fjpN/acfC1kuszaxEm2jfXo/uSpqCIJseTpbOmrvnQp5e+hbL6nigFEWsIDJb87fS7vwf
 3zrxJ5SbId8Cr7q725QKmnmfeOBB7nu+KzFuGCTqFUGSbv3PnwJlMOC6jvmow9F41E1wlw42P
 knG3sVNs3AbOsjnABiq7CutZo17k1mXBn9VM1w==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596345599842678462?=
X-GMAIL-MSGID: =?utf-8?q?1596345599842678462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All of the net_device_ops callbacks are named after their counterparts
in the kernel's 'struct net_device_ops', except
ks_wlan_set_multicast_list().  Rename it to ks_wlan_set_rx_mode() for
greater consistency.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
index 29dd07cdd69d..e98f6163e724 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -72,7 +72,7 @@ static const struct iw_handler_def ks_wlan_handler_def;
 static int ks_wlan_open(struct net_device *dev);
 static int ks_wlan_close(struct net_device *dev);
 static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void ks_wlan_set_multicast_list(struct net_device *dev);
+static void ks_wlan_set_rx_mode(struct net_device *dev);
 static int ks_wlan_set_mac_address(struct net_device *dev, void *addr);
 static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
 				int cmd);
@@ -2817,7 +2817,7 @@ void send_packet_complete(struct ks_wlan_private *priv, struct sk_buff *skb)
  * This routine is not state sensitive and need not be SMP locked.
  */
 static
-void ks_wlan_set_multicast_list(struct net_device *dev)
+void ks_wlan_set_rx_mode(struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -2861,7 +2861,7 @@ static const struct net_device_ops ks_wlan_netdev_ops = {
 	.ndo_open = ks_wlan_open,
 	.ndo_stop = ks_wlan_close,
 	.ndo_start_xmit = ks_wlan_start_xmit,
-	.ndo_set_rx_mode = ks_wlan_set_multicast_list,
+	.ndo_set_rx_mode = ks_wlan_set_rx_mode,
 	.ndo_set_mac_address = ks_wlan_set_mac_address,
 	.ndo_do_ioctl = ks_wlan_netdev_ioctl,
 	.ndo_tx_timeout = ks_wlan_tx_timeout,
-- 
2.16.3
