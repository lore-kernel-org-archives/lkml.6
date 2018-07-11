Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E453C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B872A20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4DmPa5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B872A20B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbeGKNVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:21:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46674 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbeGKNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:21:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so18398688pfl.13;
        Wed, 11 Jul 2018 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CX8Xwm1kKRiPW+XkpSi328+658QKGFtpL73d+Bz0VXc=;
        b=r4DmPa5U0+ny4AIwXGewmFFYRvKN/79P5/uUImPY8fuOqtPl34sSWG9BWFzCQ5zA9V
         yAiZySmH7Pr6TneVQ7YJSJDsRLRU9fkRzupNLEBeQ38RMrgKTsJFUTIbOPmDdleeJzbC
         AIgMB6mtbPOHiidWihOeNHSVr1hrVV6jHmKvu0az7TEErxU8qiYlafoCmCtpG/d+tnVO
         azA8Z6d1YzZNV7XL6Wl1q8B2mHFSfZ0vej2DtVtYgzoNBmGncoo/xSLucQqJZxkHmokW
         7+1JNxcUhe88ktaQEg+8X7kiwpFyih9A23zoQBJZTNUn6ngwdDP1b/ZrE8rW4IJle7Vq
         EDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CX8Xwm1kKRiPW+XkpSi328+658QKGFtpL73d+Bz0VXc=;
        b=MjQa/QSzmixnUCWL/xIkgaG/IVKnQYCGjy2UwcKOhL5t9MUQwQUoEptJWjAPf8pQDZ
         7VyiK4zdES742N+QyeTi3OgsKqf8RAN86Kcq6D2iqPXUjv6qnJhXh3oaoOgdE4fpeQ7z
         coPsvks5LZOzoomwwrCr0s4oFDowsfP4e9u84gB4DFmVR9b0aedbpkdg/6uSBknb0zzI
         H2R0Fa6gXGfzd2j1Kah37yDFm8BHpza87AwyRvo/m8yizhdyeFMKU7HHO0Sz3Ib3IG+V
         PzjwyhqTOtvBp5p3MBZu1k9eYRV53KFd+lIfLs2HtNB+c27pFxiUS4e27D6MIGJFGCKx
         eTFw==
X-Gm-Message-State: APt69E2tipT0W982iarbXpkOSSS9qdSaWi2YBiiXK/Svdul/DHmG3QJt
        Nsym3roRYUmH/V7d7xyjWwkMo96w
X-Google-Smtp-Source: AAOMgpcKK0HAAJ1lJaXJkATT+sknc7TKlOObQUdPhM9+ZhcTTwIMoDzUivFhJEB+0aRDfUP5E04xcg==
X-Received: by 2002:a63:842:: with SMTP id 63-v6mr27324614pgi.406.1531315039459;
        Wed, 11 Jul 2018 06:17:19 -0700 (PDT)
Received: from bogon.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id r87-v6sm50285737pfb.1.2018.07.11.06.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:17:18 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net, edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaoyafang@didichuxing.com, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next 1/2] tcp: remove redundant rcv_nxt update
Date:   Wed, 11 Jul 2018 09:16:58 -0400
Message-Id: <1531315019-3553-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcp_rcv_nxt_update() is already executed in tcp_data_queue().
This line is redundant.

See bellow,
	tcp_queue_rcv
		tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
	tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq); <<<< redundant

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 814ea43..3a54faf 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4695,7 +4695,6 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 		}
 
 		eaten = tcp_queue_rcv(sk, skb, 0, &fragstolen);
-		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
 		if (skb->len)
 			tcp_event_data_recv(sk, skb);
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
-- 
1.8.3.1

