Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD1EC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A681E208CE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 09:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPmWmRJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A681E208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbeGHJ1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 05:27:32 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44759 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbeGHJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 05:27:30 -0400
Received: by mail-lf0-f65.google.com with SMTP id g6-v6so2255974lfb.11;
        Sun, 08 Jul 2018 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBNwoI4dzlCxBcbq7mC/UNf7PXpHALVkMhx/R1XSP2Q=;
        b=KPmWmRJjqVRdNS9e7Yh0AdKPR8ZuNiLejrmRVd/60mEbQ/VtCIvIahNf/SQcGOSYKH
         pT5DVjBl0xB3VU7yWjcuk7wPu5Y5H2CZ8tp1pa4dtugNG5UfZT6LoFIJd22LY7OrMiGs
         FoBGdvO9PLMX5J5h5s5kgmY1roQI7ojDL0LhYWqAWcnjM8NZdHRWwlzzCdkISNjTqvqk
         PuUK/e4WW9Dw+qrNkeS7h95CZweTaEJpWjTJ/xBW5otQ6QXwzL9BBixYSJ6A6p3QVPzP
         tAqWqQge8NKkKzBmSTyRNvbmPsXtzy4Hs3WeyVh7CdOc0+6y5vJ4piQ1yw3sqcv1MXSx
         mZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBNwoI4dzlCxBcbq7mC/UNf7PXpHALVkMhx/R1XSP2Q=;
        b=KGOGrC3khMFg9eGf2iHTQxmunT9RLEK1IA2Y9l2A6G3vt8XEbufNNFosTOwSgU0zjJ
         xOF6PNwYC3uGaLO8mx+pbDFEb4JMDWttWSmAseBQBIw4SeMXj5hki7sXBTuiBld1bxRX
         9gmuxRzr8bXZDL3g9vx6vxqw/2U7un770NE4dKEAwpaX5zcdvXB64XNk3icZlcqO2JvO
         3RcklvgN1U6M7n9uz+5CFb+Dky1ROTjLao1LipMpGUnFvlIKB/rzQeio7mhj25IgoL8i
         L0GW0voayos01m/Z0pDDvEyNggaX+dh7MeDLckTLip9bAsvoEobODUEx+RMlKpcmZQ65
         10Yw==
X-Gm-Message-State: APt69E0imNBFVOkW/A1PA110F0oqOOhPsDn8EQosrIE0DoHxXBu9YqtQ
        t2TTo2C5CawBtIM50wfJmOw=
X-Google-Smtp-Source: AAOMgpd7XNOgma7PMjP4tfuL/0s7Jp11LadkmeQGK20i3/AQ7A/kPWO96blhniTd4fBShWUhuLAhDQ==
X-Received: by 2002:a19:cc0f:: with SMTP id c15-v6mr11227389lfg.145.1531042049271;
        Sun, 08 Jul 2018 02:27:29 -0700 (PDT)
Received: from radek-K75VJ.NAT.warszawa.vectranet.pl (093105176145.dynamic-ra-01.vectranet.pl. [93.105.176.145])
        by smtp.googlemail.com with ESMTPSA id g2-v6sm2204904lfb.52.2018.07.08.02.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 02:27:28 -0700 (PDT)
From:   humbabek <humbabek@gmail.com>
Cc:     humbabek <humbabek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Maloney <maloney@google.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] move smp_rmb() after load of status
Date:   Sun,  8 Jul 2018 11:27:15 +0200
Message-Id: <20180708092718.17605-1-humbabek@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <5e5dfd01-bad6-55b0-cfd1-75f7ec769e89@gmail.com>
References: <5e5dfd01-bad6-55b0-cfd1-75f7ec769e89@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: humbabek <humbabek@gmail.com>
---
 net/packet/af_packet.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 57634bc3da74..91830ef07c48 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -394,25 +394,30 @@ static void __packet_set_status(struct packet_sock *po, void *frame, int status)
 static int __packet_get_status(struct packet_sock *po, void *frame)
 {
 	union tpacket_uhdr h;
-
-	smp_rmb();
+	int status;
 
 	h.raw = frame;
 	switch (po->tp_version) {
 	case TPACKET_V1:
 		flush_dcache_page(pgv_to_page(&h.h1->tp_status));
-		return h.h1->tp_status;
+		status = h.h1->tp_status;
+		break;
 	case TPACKET_V2:
 		flush_dcache_page(pgv_to_page(&h.h2->tp_status));
-		return h.h2->tp_status;
+		status = h.h2->tp_status;
+		break;
 	case TPACKET_V3:
 		flush_dcache_page(pgv_to_page(&h.h3->tp_status));
-		return h.h3->tp_status;
+		status = h.h3->tp_status;
+		break;
 	default:
 		WARN(1, "TPACKET version not supported.\n");
 		BUG();
-		return 0;
+		status = 0;
+		break;
 	}
+	smp_rmb();
+	return status;
 }
 
 static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec *ts,
-- 
2.17.1

Sorry for a lack of information- it is the first my patch. 

The opposie smp_wmb() is in: https://elixir.bootlin.com/linux/v4.15/source/net/packet/af_packet.c#L415

On my eye smp_rmb() should be moved *after* actual read of status to be ensured that no read after __packet_get_status() happens before actual read of status.

Note, that tpacket_snd() polls a ring [https://elixir.bootlin.com/linux/v4.15/source/net/packet/af_packet.c#L2677], possibly waiting for a published packet (by published I mean a packet with a TP_STATUS_SEND_REQUEST status).

It is important to have a guarantee that no load was reordered before we know the status, isn't it?

Please note that it is possible that I am wrong, so please take this into account. However, if I am wrong please let me know. 

From the other side, what is the point to place smp_rmb() before read of status? 

