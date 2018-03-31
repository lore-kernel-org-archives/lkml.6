Return-Path: <quytelda@tamalin.org>
X-Google-Smtp-Source: AIpwx48k8WztA5v4CNzcljBoWWjFBQLVQRsNUsMh1XZUp8C4UnTxCdzReniD4jyCiM7CWAcEh8+r
ARC-Seal: i=1; a=rsa-sha256; t=1522476625; cv=none;
        d=google.com; s=arc-20160816;
        b=F3sjTOLbDeLJePRbh8KT0vNl6m5qXUlbji79iF5IPw39+lOiFoyYDjp5elGIR7Wt68
         dB0aSBAfz9g9uR3uPWjTmvW4PE3KcGM+1PmAl1QG/R7JG8aOjFyixcMIy4fU5GUk6NG0
         LFSKyG9Z8Z6ZWpUWOY25QPR1XKlTjVD0g42LDhpdrYMnijOudh5YuAzT1CGtpxvctYhQ
         z7EboGr6KXZFq33Q0b8Qu+v5DWqdEPNFly1uD4+U6Gd8uOSc5P0FtthHB+xJwiJuLH1k
         1HgYLZTO+/U5IphGDDqoL9nrUaajH9644PtyjDmif1Q1rmEIYLpEeqwSoM6g0QtVNTh6
         xwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PQvkBxqDh5yki8yCbZgzHHVD4ZH36ZfXBCKJdqTcrvc=;
        b=PhOoegWV9bWbOTht9fw1HXfRdrtw+4Dk/RR83ZsrhHexrQVRkLS3805m4uNs9CJKTR
         MDMmVzwpvl7m6IVQ5ZAFuJNuxoMC4h9HUA9SLBDwZyTyFE5cb1idqmyZ72aiWAHx6wvd
         TaBsBtZQBm6lh+wzTx2jY1qbKW/Ig5vdAC9lBCmMiBqS8keEA2Gh1YAw9hSEAg8f1bnC
         s73eKNHv7/rMjQf8svdqbtobV/hHPYcMpDslz9PIwkKA6vEDoj2wlhXGKrCLJX+h1J/D
         D9QUqN5S/BfMJ62i1C2nBIQcBZTRWqBsdWMcPSVWvc7oeh9JrNMctD0xCVZ2EZ+kUqlM
         Yycg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 74.208.4.196 is neither permitted nor denied by best guess record for domain of quytelda@tamalin.org) smtp.mailfrom=quytelda@tamalin.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Cc: driverdev-devel@linuxdriverproject.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Quytelda Kahja <quytelda@tamalin.org>
Subject: [PATCH v2 70/75] staging: ks7010: Rename ks_wlan_set_multicast_list()
Date: Fri, 30 Mar 2018 23:08:50 -0700
Message-Id: <20180331060855.9452-70-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:ny6WEe669w1rcFSmw40nvY4bpBKdP1oL/cg7vA8j++dI+vU0+0i
 F7Sqc04pcLTyZ5olua8LO6YNibJ/+gleYgthP72rWbYu9PKyv9BEGF9VYBr5KXaA6nuN7DV
 mg3tKYTezvZ//RmGl+rZVpJf5SMLqH2TY4rpP1IDMnBzjindwAWq1cdfiwEOvAYNjvhXpG7
 scf486iKSRXXKzmkQGGhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X3zZIrqQsvs=:ogyejCENCZTnUHSnePGiE1
 k6CBz9MQKE6jcarnZteWoK0HO0ek7mbKckCb988jt9d76gq1dpoQZ3ejVy15ZF+WI5uCQrWzn
 cUQzcfTlImzLQ765MLl6aAGOkis8h3Li5bVLRV2a4ce+q7Ps5w4sq49MMnVLbBhd82Vn7nUCB
 UCJPLFRiuDe1r+Krb/Dnu54niOrtb8q3AB1IFTz+PQQjY9lIhN+pCw6NmY/DrnTv1WGvj4xF+
 OV2QIZZm8dUFkK4EzF3MD1G8gZI+2NLgmqpY6UA0M1flOVQBZLKIi/5bU0SOv7PusC931Nzep
 OAt7HBffR6kHzXo2sscQAVsTcUwAJ21vQLYzumQdnJ/2cgb2zKDoyXLQ6zIevN9xXOt9vyIVq
 HKYx3CXfbUOH3HKdqA0yGe1teLbTVWo/QI6/pJQ0X4wx0SzgxNlHaiGl1J/Z5k9xHLM+fz1Mj
 fRwajP0Gd3nn/0L/riI7DwzWz5tfUES2D9kT2vYkFwTtSHTZJxB17NRiiCyeEwmIh+LzrIJik
 ie8Swo6pYJjBCbOGUD1SBadUv0aLD8PT9niGeCuZdgQfAh6pufAB8Zg+22Fp63xm3QzISqW5H
 2tfl6IMEODikR1pnRGl6OXnFWr5wVM9lN7N69P5xzH/TXNUyM+IPkK5qxi1LzKpGnIQEV5uiS
 +e7i6a8EUvTo6iz5eA/Sp4rRJqP3GeZgIK+aHmPqVWNezog1HYgyEMkwYxB3RWuoAE7rKkLia
 cOESOwb6/avjVvySXKwceDl/iadXreOTdbibZA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432449923732709?=
X-GMAIL-MSGID: =?utf-8?q?1596432449923732709?=
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
index 35c615433687..5c5569000fce 100644
--- a/drivers/staging/ks7010/ks_wlan_net.c
+++ b/drivers/staging/ks7010/ks_wlan_net.c
@@ -73,7 +73,7 @@ static int ks_wlan_open(struct net_device *dev);
 static void ks_wlan_tx_timeout(struct net_device *dev);
 static int ks_wlan_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static int ks_wlan_close(struct net_device *dev);
-static void ks_wlan_set_multicast_list(struct net_device *dev);
+static void ks_wlan_set_rx_mode(struct net_device *dev);
 static struct net_device_stats *ks_wlan_get_stats(struct net_device *dev);
 static int ks_wlan_set_mac_address(struct net_device *dev, void *addr);
 static int ks_wlan_netdev_ioctl(struct net_device *dev, struct ifreq *rq,
@@ -2816,7 +2816,7 @@ void send_packet_complete(struct ks_wlan_private *priv, struct sk_buff *skb)
  * This routine is not state sensitive and need not be SMP locked.
  */
 static
-void ks_wlan_set_multicast_list(struct net_device *dev)
+void ks_wlan_set_rx_mode(struct net_device *dev)
 {
 	struct ks_wlan_private *priv = netdev_priv(dev);
 
@@ -2864,7 +2864,7 @@ static const struct net_device_ops ks_wlan_netdev_ops = {
 	.ndo_set_mac_address = ks_wlan_set_mac_address,
 	.ndo_get_stats = ks_wlan_get_stats,
 	.ndo_tx_timeout = ks_wlan_tx_timeout,
-	.ndo_set_rx_mode = ks_wlan_set_multicast_list,
+	.ndo_set_rx_mode = ks_wlan_set_rx_mode,
 };
 
 int ks_wlan_net_start(struct net_device *dev)
-- 
2.16.3
