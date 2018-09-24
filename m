Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE699C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF2D2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxHohLml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF2D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeIYDqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:46:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46792 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIYDqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:46:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so9343616wrr.13;
        Mon, 24 Sep 2018 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3/eo3kVoyM1nrOqL0GrHbHasLyt8hucsm7HikPto6c=;
        b=fxHohLmla585TazWglsH84bVWj2sUZwSIv2nQjziUuVjbnQ49XNKXjQ673AFgy16Jf
         /50beAYqIzgjBvq0iHZ3Q59irHLsYXZwDlxfCjrVbM9R9YClsN8dydCXG7wWis8aKyca
         06olvEfYtmCBStg6cxbmYUHwdJqob7CrtN6XZBqaHcY/7qSjMteQpNw8srbq+eQYBHVB
         bzrdEtQ4ORg27z6O47Ejgy2ZOJ4nuzkoMR1QGvjLbpYN40a8uTaEKLpShKGcqs+0nQVN
         VCXQWQWhflr1l/2aARLo45gAwPpJDvlSy9zsbvM8iRVmmJpnKV9zISNt+7GjmS9SL4Bq
         3rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3/eo3kVoyM1nrOqL0GrHbHasLyt8hucsm7HikPto6c=;
        b=EZpZR/7MaOqeleIBZYD440nh9XljIWlFSKBtnZCRGXoZGxMLqe0jNRMr51SPmiNiug
         4Y6vXqGIWVNaeISTBrweL+KYYTceVYzNWNOu2caIX86zM7J4VR112otrUlzEeh3XC7E+
         JckDtqRac3dPp5tavCAOEINlKGut40SlmRYvQYZF8bOuQaY/MfgelLLYipjXsLTjSquJ
         49m//yg0JckvKXNHZnPXXoy0VeKCX0avThxS67pAXZmqcjaYubb00iI6+jRblm3mRJfZ
         PV7Zk+yn8DlLn5p5WG53aFndvNDRgaEJrWsyCmYvEUVZ3vzb8vtF+lCbaxEDLeLX8kzH
         /F+A==
X-Gm-Message-State: ABuFfohrCEMbY0Qj5NzmyhBPVq2LbLpNnede99W6mVElVFtYZ8Dn2yAU
        +raiZYJOQuUQWd2MwmQKdR8=
X-Google-Smtp-Source: ACcGV62hD2NMANzLOt8p8UoSdiJYHF86SkEjjrW8Oy2KMREr6Elv6+f9V6KIRTf2LRN7BVZFBAyhEQ==
X-Received: by 2002:a5d:6209:: with SMTP id y9-v6mr493915wru.179.1537825340211;
        Mon, 24 Sep 2018 14:42:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y128-v6sm141125wmy.26.2018.09.24.14.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:42:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>, everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt
Date:   Mon, 24 Sep 2018 14:42:12 -0700
Message-Id: <20180924214212.22522-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_iwarp.c:1713:25: warning: implicit
conversion from enumeration type 'enum tcp_ip_version' to different
enumeration type 'enum qed_tcp_ip_version' [-Wenum-conversion]
                cm_info->ip_version = TCP_IPV4;
                                    ~ ^~~~~~~~
drivers/net/ethernet/qlogic/qed/qed_iwarp.c:1733:25: warning: implicit
conversion from enumeration type 'enum tcp_ip_version' to different
enumeration type 'enum qed_tcp_ip_version' [-Wenum-conversion]
                cm_info->ip_version = TCP_IPV6;
                                    ~ ^~~~~~~~
2 warnings generated.

Use the appropriate values from the expected type, qed_tcp_ip_version:

TCP_IPV4 = QED_TCP_IPV4 = 0
TCP_IPV6 = QED_TCP_IPV6 = 1

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index 17f3dfa2cc94..e860bdf0f752 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1710,7 +1710,7 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 
 		cm_info->local_ip[0] = ntohl(iph->daddr);
 		cm_info->remote_ip[0] = ntohl(iph->saddr);
-		cm_info->ip_version = TCP_IPV4;
+		cm_info->ip_version = QED_TCP_IPV4;
 
 		ip_hlen = (iph->ihl) * sizeof(u32);
 		*payload_len = ntohs(iph->tot_len) - ip_hlen;
@@ -1730,7 +1730,7 @@ qed_iwarp_parse_rx_pkt(struct qed_hwfn *p_hwfn,
 			cm_info->remote_ip[i] =
 			    ntohl(ip6h->saddr.in6_u.u6_addr32[i]);
 		}
-		cm_info->ip_version = TCP_IPV6;
+		cm_info->ip_version = QED_TCP_IPV6;
 
 		ip_hlen = sizeof(*ip6h);
 		*payload_len = ntohs(ip6h->payload_len);
-- 
2.19.0

