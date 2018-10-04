Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F1C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F212083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrybSpAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F212083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeJDXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:35:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53277 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:35:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so9681055wme.3;
        Thu, 04 Oct 2018 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P05siEmlZJdLv9lbBRxqmpdEf/LWQheaYzzXcNHz/T4=;
        b=QrybSpAIEZVtpurJRLovts6VJlZT78dU+/N5YTJX9QYtGxBW24vOg/5efM7QVPqa9o
         FDNTytUH6HV5YaKF2Zq+t5z/AMz64u1e752jsYvbsjm1+eCF+Fv+hRxbuEf4z/O/oNQW
         Bi8h7Ey+O949saMU3vR/2+rW8kBmftWRX40bPLQ3KaO5IE4+rn6b1GmxaaEcc4xlkLAO
         bnYM2yh9y8M0fqWtHp3d181z51oHLrzo29eYiCPg6Jz1wT03uYqVbJowqZ6UPYYkV+i0
         dBad9RmhxW05o9ryPH+3tYRvEGiMSS7TfpfJHQOYllGIHdciOBPGUDvycZ7FBaLy1EVv
         95OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P05siEmlZJdLv9lbBRxqmpdEf/LWQheaYzzXcNHz/T4=;
        b=i+87oguqaro+gnFRgynEiI8/Sc2TL4rgf16QIblaDAT+48/GP9ncmrdbOI9+6ohsEU
         8NWwg2rCvh1/iZKuD+uH0dbbDzad6v5E5FrXWlGTmj/Hczda4zKJ6YffdqSOLVqJrfrp
         j8Brvevb037phfZDzLiCzpPlTIc+KeONeJAl299SjITcutll7/bpAqAyNDnH93iuVjEm
         Q2dYAkaAWrgTj/w+hwsNXNWptUV+bAe8KHDsn71UZeCmDTRaaWdr0yIC8bQ7QDnCXmjJ
         ZYvdpEGROvggU3uOiabign7TQ2Zj5d0YiLTintYxb/SGLl4zqLaHNhw6SDkldhlhnMbW
         5jXQ==
X-Gm-Message-State: ABuFfogl4sTshNWh6QsM40lAA+bhGGHMi/Y6+yvEKYmZV625KRdf12KI
        ZW/07YRFLN6YcAKUF2muC04=
X-Google-Smtp-Source: ACcGV61BVhMk263DfjROebFXiNd9xckaYdrkWRokeOBeT/iBJiyT+zBi887ZztqHJOHnn1AFehSQRA==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197-v6mr5185799wme.82.1538671260099;
        Thu, 04 Oct 2018 09:41:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm2806953wmc.38.2018.10.04.09.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 09:40:59 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ariel Elior <Ariel.Elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dept-EngEverestLinuxL2@cavium.com,
        Tomer Tayar <Tomer.Tayar@cavium.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] qed: Avoid implicit enum conversion in qed_ooo_submit_tx_buffers
Date:   Thu,  4 Oct 2018 09:39:20 -0700
Message-Id: <20181004163919.13972-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004000912.22242-1-natechancellor@gmail.com>
References: <20181004000912.22242-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/ethernet/qlogic/qed/qed_ll2.c:799:32: warning: implicit
conversion from enumeration type 'enum core_tx_dest' to different
enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
                tx_pkt.tx_dest = p_ll2_conn->tx_dest;
                               ~ ~~~~~~~~~~~~^~~~~~~
1 warning generated.

Fix this by using a switch statement to convert between the enumerated
values since they are not 1 to 1, which matches how the rest of the
driver handles this conversion.

Link: https://github.com/ClangBuiltLinux/linux/issues/125
Suggested-by: Tomer Tayar <Tomer.Tayar@cavium.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Use an explicit switch statement to convert between the enumerated
  types like the rest of the driver, as suggested by Tomer.

 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index da13117a604a..aa633381aa47 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -796,7 +796,18 @@ qed_ooo_submit_tx_buffers(struct qed_hwfn *p_hwfn,
 		tx_pkt.vlan = p_buffer->vlan;
 		tx_pkt.bd_flags = bd_flags;
 		tx_pkt.l4_hdr_offset_w = l4_hdr_offset_w;
-		tx_pkt.tx_dest = p_ll2_conn->tx_dest;
+		switch (p_ll2_conn->tx_dest) {
+		case CORE_TX_DEST_NW:
+			tx_pkt.tx_dest = QED_LL2_TX_DEST_NW;
+			break;
+		case CORE_TX_DEST_LB:
+			tx_pkt.tx_dest = QED_LL2_TX_DEST_LB;
+			break;
+		case CORE_TX_DEST_DROP:
+		default:
+			tx_pkt.tx_dest = QED_LL2_TX_DEST_DROP;
+			break;
+		}
 		tx_pkt.first_frag = first_frag;
 		tx_pkt.first_frag_len = p_buffer->packet_length;
 		tx_pkt.cookie = p_buffer;
-- 
2.19.0

