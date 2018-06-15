Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76881C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19350204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOymSDEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19350204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756498AbeFOS5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:57:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39040 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756403AbeFOS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:57:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so5519951wmc.4;
        Fri, 15 Jun 2018 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HPiuAyY8BUq7JQaGGiHctswWEw9cFWxnwR6v1pIFffE=;
        b=iOymSDEaWmhX15I+BTmIuZ0Mpfc4EnmL0PhT0Tlum/s0DPbrhomN27EtrM41ve1PPD
         LZdTKf8EMYT1LdzrqppESH+HOpP4KedJf2ZIPV/aTIeJnM1J05UocDCXzEegSASWqA0y
         3IpS352zwgb6OdzGrSyHeZ9NC/iI6ITh1ikHZnr9132sX+jhTyKPKOpF6JC+rNF8VTLu
         YeVauAlY1VbyeW3xSvR81S84umgLNFlK/4c93U2Uq98mgzttRHvaN3YJhcDz89heAirn
         xte8VRq08uon9pkLhrOBfC4pD/0nphqsRJJoZxX6AzGIsyjLMyphKF0HN/3F1KugKNKb
         kKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=HPiuAyY8BUq7JQaGGiHctswWEw9cFWxnwR6v1pIFffE=;
        b=e0TxfXLizfnzmDLU5OukV2CKeS25NKJSmNLG1TYd7rabahZikHYSaAlUf/mDfUmGY6
         EHkAXN2ug3UvlKTLkUuMrdAicjsUJ9xYyDC9Xml6BJdrrrx3J1F6+g3z+TiGGMXwq9O3
         WmfORy3zHJuxF9Ux/CaegIsjVOh70n7oYoj6/YlG2uuFsGPrxSNQLKa/mkQst78GFB2n
         WYqud4EcZW0h25UfLhIBnntyEVexH3aZzQ9sFbBODfdsK3og0BmQnkLV6hs8wPBHoQzS
         ciMDOTLXnSnY9wLWLhTp3UDumaF+Fw/KBf52L8k9ArmW67B76ZV9NAkD/VMEYHnFeT08
         8PHg==
X-Gm-Message-State: APt69E0YCOd3TgDRFhK+yrYp8skxTEpzwyn6pRSLr9CW9gwP1gqTzXg8
        EnacMGYjJfVTWPLa/4u2Rvg=
X-Google-Smtp-Source: ADUXVKJqCLRJooYxd5+xEWES0K84iHibQOlCsKCuLV8k18SyKSKmSaYsWSga/MTfoTQlIGE8NYebeQ==
X-Received: by 2002:a1c:6c09:: with SMTP id h9-v6mr2223729wmc.138.1529089051036;
        Fri, 15 Jun 2018 11:57:31 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id x24-v6sm1719367wmc.2.2018.06.15.11.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:57:30 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 071CD10C033B; Fri, 15 Jun 2018 20:57:29 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends"
Date:   Fri, 15 Jun 2018 20:56:45 +0200
Message-Id: <20180615185645.8921-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 88078d98d1bb085d72af8437707279e203524fa5.

It causes regressions for people using chips driven by the sungem
driver. Suspicion is that the skb->csum value isn't being adjusted
properly.

Symptoms as seen on G4+sungem are:

[   34.023281] eth0: hw csum failure
[   34.023438] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #2
[   34.023618] Call Trace:
[   34.023707] [dffedbd0] [c069ddac] __skb_checksum_complete+0xf0/0x108 (unreliable)
[   34.023948] [dffedbf0] [c0777a70] tcp_v4_rcv+0x604/0xe00
[   34.024118] [dffedc70] [c0731624] ip_local_deliver_finish+0xa8/0x3c4
[   34.024315] [dffedcb0] [c0732430] ip_local_deliver+0xf0/0x154
[   34.024493] [dffedcf0] [c07328dc] ip_rcv+0x448/0x774
[   34.024653] [dffedd50] [c06aeae0] __netif_receive_skb_core+0x5e8/0x1184
[   34.024857] [dffedde0] [c06bba20] napi_gro_receive+0x160/0x22c
[   34.025044] [dffede10] [e14b2590] gem_poll+0x7fc/0x1ac0 [sungem]
[   34.025228] [dffedee0] [c06bacf0] net_rx_action+0x34c/0x618
[   34.025402] [dffedf60] [c07fd27c] __do_softirq+0x16c/0x5f0
[   34.025575] [dffedfd0] [c0064c7c] irq_exit+0x110/0x1a8
[   34.025738] [dffedff0] [c0016170] call_do_irq+0x24/0x3c
[   34.025903] [c0cf7e80] [c0009a84] do_IRQ+0x98/0x1a0
[   34.026055] [c0cf7eb0] [c001b474] ret_from_except+0x0/0x14
[   34.026225] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
                   LR = arch_cpu_idle+0x30/0x78
[   34.026510] [c0cf7f70] [c0cf6000] 0xc0cf6000 (unreliable)
[   34.026682] [c0cf7f80] [c00a3868] do_idle+0xc4/0x158
[   34.026835] [c0cf7fb0] [c00a3ab0] cpu_startup_entry+0x20/0x28
[   34.027013] [c0cf7fc0] [c0998820] start_kernel+0x47c/0x490
[   34.027181] [c0cf7ff0] [00003444] 0x3444

See commit 7ce5a27f2ef8 ("Revert "net: Handle CHECKSUM_COMPLETE more
adequately in pskb_trim_rcsum()."") for previous reference.

Link: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-June/174444.html
Reported-by: Meelis Roos <mroos@linux.ee>
Fixes: 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends")
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Cc: Eric Dumazet <edumazet@google.com>
---
 include/linux/skbuff.h |  5 +++--
 net/core/skbuff.c      | 14 --------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c86885954994..cbc753a3e41c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3134,7 +3134,6 @@ static inline void *skb_push_rcsum(struct sk_buff *skb, unsigned int len)
 	return skb->data;
 }
 
-int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len);
 /**
  *	pskb_trim_rcsum - trim received skb and update checksum
  *	@skb: buffer to trim
@@ -3148,7 +3147,9 @@ static inline int pskb_trim_rcsum(struct sk_buff *skb, unsigned int len)
 {
 	if (likely(len >= skb->len))
 		return 0;
-	return pskb_trim_rcsum_slow(skb, len);
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		skb->ip_summed = CHECKSUM_NONE;
+	return __pskb_trim(skb, len);
 }
 
 static inline int __skb_trim_rcsum(struct sk_buff *skb, unsigned int len)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c642304f178c..360293d1baf3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1840,20 +1840,6 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len)
 }
 EXPORT_SYMBOL(___pskb_trim);
 
-/* Note : use pskb_trim_rcsum() instead of calling this directly
- */
-int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
-{
-	if (skb->ip_summed == CHECKSUM_COMPLETE) {
-		int delta = skb->len - len;
-
-		skb->csum = csum_sub(skb->csum,
-				     skb_checksum(skb, len, delta, 0));
-	}
-	return __pskb_trim(skb, len);
-}
-EXPORT_SYMBOL(pskb_trim_rcsum_slow);
-
 /**
  *	__pskb_pull_tail - advance tail of skb header
  *	@skb: buffer to reallocate
-- 
2.11.0

