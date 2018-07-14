Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B17ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1611208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9SkAG8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1611208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeGNIzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 04:55:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45712 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeGNIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 04:55:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9-v6so5443756pgp.12;
        Sat, 14 Jul 2018 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DvRb1rIWLnSOUlEWxvv62Cz+83ZDoIyaEK8j/+Yn7Vs=;
        b=p9SkAG8PcM7OhuuR2yfHXrgCIBjWje+HHeoEl0wWAztydYHosFSS5GG5ph6HuB1EiE
         ivZWQAg5M7Og5DoZJCTVc5xvn/LyDxhP7vQ1aXTn0cDNlS4R9enAspElLwXY6+AVR+/c
         kphxV7Ks/mYq2UErvsuVPiqBbWCiK8gOF8Z2+0xCTrIWc9J/IcshKn+VX7ZXCP1durs9
         CtyZoJniO0mvebmMjdDsdf6wb4YNMeYDjYA1p9XnHYr+qWaaLjK6i5yn+stKZUk+CzmT
         E5i6daLmHqrIiKsFwQt2+TN9r2YB7tl1nLW+prL3S+XAEr2Lx4mEn4BwMnjNudEqo1qK
         EmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DvRb1rIWLnSOUlEWxvv62Cz+83ZDoIyaEK8j/+Yn7Vs=;
        b=d7bpirPghAW5FvbZ+Iy7cpxTgkgzMKWJScXdmJpk/jCbUGbJTptiP0pnsoaxoWdJ9h
         oXFEoSFRjVIvPmXVjEt1NdMQFHyOP+owF/EySoat2S0UFJ435iL6IvFXVrwgkumzhsjb
         sMmWi4wydp13PUg0VS3za69zdxfv8qAPVSvLFCXypAw96oTIQl7TWdVG3pnFW2OdjJOL
         hOXjRS6nbP+IfdOTYnJ3ZcUom0GOnAuXD/bibKo4bSFQmjTKsaalLgVqWdkX//jLCvGs
         O/UqunicvG1XPpUoz6FYd+H0HgANDk0sS3BK2wEnNXk1HdqgKzFIINJdSch3Fuxo0/A/
         RcXA==
X-Gm-Message-State: AOUpUlETfuPDSM/2owSkmRGLOLsn/aS1cJFwaJGLaOJnkTHR1oKnKxQN
        O4kFpu6TJ/vV8leISIulXeV24olT
X-Google-Smtp-Source: AAOMgpe/3p9o5i8EU9xvDFnjFbUByAk/n0Y30C8/qoNicONkOTTuHcWdmqeaSGv1zu1zuhfhJsEgIA==
X-Received: by 2002:a65:60d2:: with SMTP id r18-v6mr8953717pgv.306.1531557411192;
        Sat, 14 Jul 2018 01:36:51 -0700 (PDT)
Received: from bogon.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id p66-v6sm39188874pfd.65.2018.07.14.01.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 01:36:50 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaoyafang@didichuxing.com, Yafang Shao <laoar.shao@gmail.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next] tcp: remove redundant rcv_nxt update
Date:   Sat, 14 Jul 2018 16:36:29 +0800
Message-Id: <1531557390-12592-1-git-send-email-laoar.shao@gmail.com>
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
Signed-off-by: Eric Dumazet <edumazet@google.com>
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

