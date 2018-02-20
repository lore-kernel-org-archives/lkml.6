Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBTN2u (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:28:50 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39894 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeBTN2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:28:48 -0500
X-Google-Smtp-Source: AH8x225UPQsmiwRccpebHDVOWRIdJJJ8GIXujr1oNAM70rOwuZV1upx9sCNfWMiw+1+KIEbDxqeOVA==
From: Yafang Shao <laoar.shao@gmail.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: remove the hardcode in the definition of TCPF Macro
Date: Tue, 20 Feb 2018 21:28:31 +0800
Message-Id: <1519133311-22068-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCPF_ macro depends on the definition of TCP_ macro.
So it is better to define them with TCP_ marco.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/net/tcp_states.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_states.h b/include/net/tcp_states.h
index 50e78a7..2875e16 100644
--- a/include/net/tcp_states.h
+++ b/include/net/tcp_states.h
@@ -32,21 +32,21 @@ enum {

 #define TCP_STATE_MASK	0xF

-#define TCP_ACTION_FIN	(1 << 7)
+#define TCP_ACTION_FIN	(1 << TCP_CLOSE)

 enum {
-	TCPF_ESTABLISHED = (1 << 1),
-	TCPF_SYN_SENT	 = (1 << 2),
-	TCPF_SYN_RECV	 = (1 << 3),
-	TCPF_FIN_WAIT1	 = (1 << 4),
-	TCPF_FIN_WAIT2	 = (1 << 5),
-	TCPF_TIME_WAIT	 = (1 << 6),
-	TCPF_CLOSE	 = (1 << 7),
-	TCPF_CLOSE_WAIT	 = (1 << 8),
-	TCPF_LAST_ACK	 = (1 << 9),
-	TCPF_LISTEN	 = (1 << 10),
-	TCPF_CLOSING	 = (1 << 11),
-	TCPF_NEW_SYN_RECV = (1 << 12),
+	TCPF_ESTABLISHED = (1 << TCP_ESTABLISHED),
+	TCPF_SYN_SENT	 = (1 << TCP_SYN_SENT),
+	TCPF_SYN_RECV	 = (1 << TCP_SYN_RECV),
+	TCPF_FIN_WAIT1	 = (1 << TCP_FIN_WAIT1),
+	TCPF_FIN_WAIT2	 = (1 << TCP_FIN_WAIT2),
+	TCPF_TIME_WAIT	 = (1 << TCP_TIME_WAIT),
+	TCPF_CLOSE	 = (1 << TCP_CLOSE),
+	TCPF_CLOSE_WAIT	 = (1 << TCP_CLOSE_WAIT),
+	TCPF_LAST_ACK	 = (1 << TCP_LAST_ACK),
+	TCPF_LISTEN	 = (1 << TCP_LISTEN),
+	TCPF_CLOSING	 = (1 << TCP_CLOSING),
+	TCPF_NEW_SYN_RECV = (1 << TCP_NEW_SYN_RECV),
 };

 #endif	/* _LINUX_TCP_STATES_H */
--
1.8.3.1
