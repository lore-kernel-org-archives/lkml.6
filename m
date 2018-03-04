Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbeCDCaQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 21:30:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:57201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752409AbeCDCaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 21:30:14 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 3/3] net: core: dst: Add kernel-doc for 'net' parameter
Date: Sun,  4 Mar 2018 03:29:53 +0100
Message-Id: <20180304022953.4508-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180304022953.4508-1-j.neuschaefer@gmx.net>
References: <20180304022953.4508-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ymtn87BSSHgLp7NedXUq1pd3aoC/rkoJ0l/WjZ4ZzyU5QVyQ38o
 B/LoidkOk/SHzg6YjsGKXsVL1qOkuJI1K8a+COJ3xzJNfRGjm/q16H3doJ+TFm4P+VytBps
 eV6wLwMmucnA6WBbDwthjdTZwcsMXy023oLRlzebEcOish6fKFS8lFgcHU4Zm8Acd3WtBsj
 9801hiXLDd1sRiBw+ze4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cygDGMWrtzw=:BhKicx7UIcunwOGZvLRCyJ
 NS0qUCe9SdirHlrY4c799sSo30CzweHxDumFFF5sysPebWPg3nFycIRSGBR+ejQW8fHm/NY0L
 VgbanXeb39klW+VFLRyH5d+TYBdaof6nrBfcfZBLZ5tQoL+EaJ4irLIvYwr96zsbr2HR0wpFp
 mhOQwDx0Zpth30QEHzwHfrH+oQFa1eNoJUR6WNnzLYIZ8h1V3AccPy6mM1et1h9P/6f0PIpn8
 vTHZlf8hNr3NHAWo0Sv431dHBxqvkaOGnxPqvZ+ZJmqPTKgYwc+HjZkbJBL5xvuYwRAqGwsl8
 mxrXYd8sm8/lmH+jTefBGeembhRvCyQauA+nR94B2zELFxXJ/RFX8pFwnwapbGTuWyNJP1nbt
 kRKLOfNylr54tJ2+0aG4sJXMMQE+j298jnVenGEtRBGqfjyjaSoHnSKjnGSJh1r1XQzY+kvNn
 wu9Ayrb6FAXimJSf87hUpVD/VMngg7CajPQT+plkwTVjmytHnR0qtA7UFnQDP9/SBz02q6M3c
 MbKlRARn0NHSKWgiF+nMZy9cd/8gftqxG+NjO/Hl8WmgPTlR9uNkqt2nt3hsSAg8KuJ39TcOF
 eg0/ogAjvw7JOo32NiSfvZu83JT4CHiF0nIWZ6JhFnH7ZS9G354l7Xk+c79Aa/1S2KjzEOgBr
 HapO4FUbm+UVpExxzgNbeAibdOYMqN+JA92ouRwvvXc8PsZBasLi4L68r4+Kin12XYkDtDVXi
 h+9shExOu1XynBKzjAfG+2jr/ZEpAK1DMfsw2CHiFcd7LC2AGeVOCTj1fAoLE1RsHLbnYsTsH
 IzKfOuyrRpQj+qRflhXYyvkwi9JKcJi5iDuiDCeAjrmBrDL58c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following kernel-doc warning:

./include/net/dst.h:366: warning: Function parameter or member 'net' not described in 'skb_tunnel_rx'

Fixes: ea23192e8e57 ("tunnels: harmonize cleanup done on skb on rx path")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 include/net/dst.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/dst.h b/include/net/dst.h
index c63d2c37f6e9..b3219cd8a5a1 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -356,6 +356,7 @@ static inline void __skb_tunnel_rx(struct sk_buff *skb, struct net_device *dev,
  *	skb_tunnel_rx - prepare skb for rx reinsert
  *	@skb: buffer
  *	@dev: tunnel device
+ *	@net: netns for packet i/o
  *
  *	After decapsulation, packet is going to re-enter (netif_rx()) our stack,
  *	so make some cleanups, and perform accounting.
-- 
2.16.1
