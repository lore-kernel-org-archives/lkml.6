Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2B8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B238208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUM+UDov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B238208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbeHAXqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:46:00 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:51308 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbeHAXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:46:00 -0400
Received: by mail-it0-f74.google.com with SMTP id q5-v6so262990ith.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PugyUTtDXQCncDeN0drKTnY1GVeCtEkYFFLKHFhjyOQ=;
        b=wUM+UDovNAEgKQ53BOpSTFiWEk1winLvh2Q1JN2+8a+9xG5La2Z6wAc1b4cDodZfZr
         1oitR1PwvXXIBhQYqGnISvGWMBG4fjg5tB52G3DYpdM6D3qzrw/TGTcdJkXqZ06MYEJQ
         dh1r2gA/iQAL8a78T8U2w0e6EtOikEojwfDcpmsI8OeaEQ0GG3/ciQ+fLPNbI9k6a0KI
         N9t/J7TizNNeGvE6zOeyPZzRCPmhB245q84aSkWO/Lk6qK/9oL8NvwsDH5rxMIL9BNOD
         GwN6dUifOR0xo9PZJru6W4BY9Ovot/qrEinglG//xnjZF0+fAibWah2KD4LN9QD13pRF
         3sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PugyUTtDXQCncDeN0drKTnY1GVeCtEkYFFLKHFhjyOQ=;
        b=tsp4vnZ4IQnehvWXlMSu8R5LLT5wYrSSZQvogm0GIvA0a+bQ1H8qyfN16GCOwWEkcS
         turBNvan+KbguOdJ2a/P1KdLZ2MPTLS0DlEzueM3hB8dAUCwrGDRBSMKwglyxEyaRBf1
         GV/B1UhTkUFU896RsmvSC3TIvKNhsveV9ZGbIBhKjpIfsmXHAhtNkhhC2tF/BATS0WX/
         IQrDqNVJKVbtGwD536hSVi1pXdNmQaIcfi9oafneDS28czu/hYQQOGNeyJ0/u94LTIKg
         1IzuwTIYnH/33dvnY+zGN6ZvQc5rClst+7LcSmRY0AyNl0hqpXBqdE3o+JttJjqrOh8G
         lpvw==
X-Gm-Message-State: AOUpUlFIX4dNzl8yt3XoDtYbQs3Yj3aZn4x9Impc4CHfNQIDi1fzBVeQ
        RuaQ41nlLKlJdPApSyqptQtpvYMhLA5mI3XkuJ4=
X-Google-Smtp-Source: AAOMgpdvdN3BYs+OH1Pyl0fhePGZpdiNVB8Vba/ecTVJcdJOGmlNAkL4FfpS6EBeYPP3PzoNe9rX611RDPESbIru4pk=
X-Received: by 2002:a24:5fc8:: with SMTP id r191-v6mr73655itb.38.1533160687304;
 Wed, 01 Aug 2018 14:58:07 -0700 (PDT)
Date:   Wed,  1 Aug 2018 14:57:59 -0700
Message-Id: <20180801215759.103758-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] inet/connection_sock: prefer _THIS_IP_ to current_text_addr
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     davem@davemloft.net
Cc:     natechancellor@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to reduce the code duplication between _THIS_IP_
and current_text_addr(), let's consolidate callers of
current_text_addr() to use _THIS_IP_.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/net/inet_connection_sock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 0a6c9e0f2b5a..f2a87e85c07b 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/timer.h>
 #include <linux/poll.h>
+#include <linux/kernel.h>
 
 #include <net/inet_sock.h>
 #include <net/request_sock.h>
@@ -224,7 +225,7 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 
 	if (when > max_when) {
 		pr_debug("reset_xmit_timer: sk=%p %d when=0x%lx, caller=%p\n",
-			 sk, what, when, current_text_addr());
+			 sk, what, when, (void *)_THIS_IP_);
 		when = max_when;
 	}
 
-- 
2.18.0.597.ga71716f1ad-goog

