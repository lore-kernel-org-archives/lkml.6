Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF133C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FA220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1pAtYPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FA220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030440AbeFSSpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:45:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38658 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030279AbeFSSpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:45:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so685683wrs.5;
        Tue, 19 Jun 2018 11:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xM/FEjRUhsJ5gEK69suhNEAatHbmVqDcKOKpz4jHt0k=;
        b=U1pAtYPBlVNyfuDx7T1QNcu16xHj8iVp7yxxTv5bcIeNdALwbF7XQr1ubjvw3Qgkjl
         7ptPPY/D1YaN+W+N5JqTcSrZjN0Jq5sIw4mn0IxuYIG2tKu00NAvHR0+wd+xE9GPKJs4
         At0Zpvi+O17Ovr8mev+Q+/JpB5QgJ28ESY0h4iLXUAATVvOuedr9fz5Gkr2cmPgbbOdF
         gzEfQLjqkNfP2gu4zC88K/3NrqNFFD86xjmhOFlU9YifxCvM+bF14kCyZGf4YqdTdiN9
         2G4wRFV8XzpahLJcHAFNwIHUAG8JwAaC5Dz5wLBB5Wdr7H1SzQsGOtHifNREzJcqC8h2
         tLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xM/FEjRUhsJ5gEK69suhNEAatHbmVqDcKOKpz4jHt0k=;
        b=hdGId4YKyAoQUN7OtZSr8ACXRcGQdUez14Yk1ixnVNvIAQydtp2pW80et3jIiI1JiK
         1cTKaWsyaB7IiE6JworGrU1yMik1XYv646CRdZTCjfdBqWUVSApbrBtSz3TJQpXONi8f
         7fV6AssVyRUXC+EblBHJPmjs6PgTw9wQVrS7bhGiFt9IwmLzbqDswP4I7SszqEuZ3fKi
         zzI5zHD2rmE5gYb5Gc4cyL6LhIpyEpPIyIpPwLgWXoP8X7TS2VeKNIUjJNU2jAPwZsAM
         iaE46vd8+1tpGOuEKqzseCK+1z7gMKL9B3aa5fOkxjhkJPMmQ/VG9svoMwp1WBLtT+Cq
         8swg==
X-Gm-Message-State: APt69E3zq1jKyjbWV1qQgB80bVRU0XmPpABN/9C5SBWUIyx+sINwp7+G
        0AqyBRQqCIje8peZeh4JXioH+Oto
X-Google-Smtp-Source: ADUXVKJQTQym5PgeUWR9DLydkr6xbE3p7/tBRZKVyCU8RVU4X3mwt45bIcQ4uDq/a8pGT/e5RqYJxg==
X-Received: by 2002:adf:8747:: with SMTP id 7-v6mr14015788wrz.117.1529433907423;
        Tue, 19 Jun 2018 11:45:07 -0700 (PDT)
Received: from L80496.priv.atos.fr (abo-39-222-68.trs.modulonet.fr. [85.68.222.39])
        by smtp.gmail.com with ESMTPSA id u108-v6sm716669wrc.40.2018.06.19.11.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 11:45:06 -0700 (PDT)
From:   Thibaut Robert <thibaut.robert@gmail.com>
To:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Thibaut Robert <thibaut.robert@gmail.com>
Subject: [PATCH v2] staging: wilc1000: Use common structs to parse ip packets
Date:   Tue, 19 Jun 2018 20:44:19 +0200
Message-Id: <20180619184419.10304-1-thibaut.robert@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604105549.04031722@ajaysk-VirtualBox>
References: <20180604105549.04031722@ajaysk-VirtualBox>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use structs ethhdr, iphdr and tcphdr instead of manual parsing in
tcp_process.
This commit fix handling of ip packets containing options.
It also fixes the following sparse warning:

drivers/staging/wilc1000//wilc_wlan.c:201:19: warning: cast to restricted __be16

Signed-off-by: Thibaut Robert <thibaut.robert@gmail.com>
---
 drivers/staging/wilc1000/wilc_wlan.c | 43 ++++++++++------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc1000/wilc_wlan.c
index 55755d7fbb30..85af36595e69 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/if_ether.h>
+#include <linux/ip.h>
 #include "wilc_wfi_netdevice.h"
 #include "wilc_wlan_cfg.h"
 
@@ -150,9 +152,8 @@ static inline int add_tcp_pending_ack(u32 ack, u32 session_index,
 
 static inline void tcp_process(struct net_device *dev, struct txq_entry_t *tqe)
 {
-	u8 *eth_hdr_ptr;
-	u8 *buffer = tqe->buffer;
-	unsigned short h_proto;
+	void *buffer = tqe->buffer;
+	const struct ethhdr *eth_hdr_ptr = buffer;
 	int i;
 	unsigned long flags;
 	struct wilc_vif *vif;
@@ -163,37 +164,23 @@ static inline void tcp_process(struct net_device *dev, struct txq_entry_t *tqe)
 
 	spin_lock_irqsave(&wilc->txq_spinlock, flags);
 
-	eth_hdr_ptr = &buffer[0];
-	h_proto = ntohs(*((unsigned short *)&eth_hdr_ptr[12]));
-	if (h_proto == ETH_P_IP) {
-		u8 *ip_hdr_ptr;
-		u8 protocol;
+	if (eth_hdr_ptr->h_proto == htons(ETH_P_IP)) {
+		const struct iphdr *ip_hdr_ptr = buffer + ETH_HLEN;
 
-		ip_hdr_ptr = &buffer[ETHERNET_HDR_LEN];
-		protocol = ip_hdr_ptr[9];
-
-		if (protocol == 0x06) {
-			u8 *tcp_hdr_ptr;
+		if (ip_hdr_ptr->protocol == IPPROTO_TCP) {
+			const struct tcphdr *tcp_hdr_ptr;
 			u32 IHL, total_length, data_offset;
 
-			tcp_hdr_ptr = &ip_hdr_ptr[IP_HDR_LEN];
-			IHL = (ip_hdr_ptr[0] & 0xf) << 2;
-			total_length = ((u32)ip_hdr_ptr[2] << 8) +
-					(u32)ip_hdr_ptr[3];
-			data_offset = ((u32)tcp_hdr_ptr[12] & 0xf0) >> 2;
+			IHL = ip_hdr_ptr->ihl << 2;
+			tcp_hdr_ptr = buffer + ETH_HLEN + IHL;
+			total_length = ntohs(ip_hdr_ptr->tot_len);
+
+			data_offset = tcp_hdr_ptr->doff << 2;
 			if (total_length == (IHL + data_offset)) {
 				u32 seq_no, ack_no;
 
-				seq_no = ((u32)tcp_hdr_ptr[4] << 24) +
-					 ((u32)tcp_hdr_ptr[5] << 16) +
-					 ((u32)tcp_hdr_ptr[6] << 8) +
-					 (u32)tcp_hdr_ptr[7];
-
-				ack_no = ((u32)tcp_hdr_ptr[8] << 24) +
-					 ((u32)tcp_hdr_ptr[9] << 16) +
-					 ((u32)tcp_hdr_ptr[10] << 8) +
-					 (u32)tcp_hdr_ptr[11];
-
+				seq_no = ntohl(tcp_hdr_ptr->seq);
+				ack_no = ntohl(tcp_hdr_ptr->ack_seq);
 				for (i = 0; i < tcp_session; i++) {
 					u32 j = ack_session_info[i].seq_num;
 
-- 
2.17.1

