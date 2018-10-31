Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86132C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C8D2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 11:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEUqxvGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C8D2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeJaUcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 16:32:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34849 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeJaUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 16:32:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id q12-v6so11502707wmq.0;
        Wed, 31 Oct 2018 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7q2TKxxiWapLWVKXSGuedW0PN1sYUXA/8jiW0DUXB+8=;
        b=qEUqxvGk0uMxNWukiq9gE+z/3E12de7J5hp38PLSWV/raDShgHsDrWuRVo6BYJHIeV
         Tjl6z1VdEYCfljhHagzSahcF9KXWsHpVpoorb/8TvxHCSOy4WaNh5aTEfbQI+H8vYmk8
         +R5e36hhbAiupXHSX1WMwz/4GpKX7WFPFxg7Y4Jl1d+VkeqpuLmyjq55hnnuOFgeotZ4
         B9maixUhMADgaA4PjDN6vhU7ZW42s6lD5JFVPuLB3c57cT+Fj9CEjHxYTHOVHX9sfFeK
         siRlBT/ziHDwGR4hY8Fau1GIyADM6ehaMWk2cEox7sNxKwk+xupPD9S/C4iYLkOExyNS
         PkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7q2TKxxiWapLWVKXSGuedW0PN1sYUXA/8jiW0DUXB+8=;
        b=X9JFxlqsd0iRYb4hAlY/jh1Afw8dP7u70EjKIkC60lj4rkyW6tgi716cYMlCFgEpbD
         pyfbS5kSuCUaYRKPrdmASwzC8JYj2TH7d0lkyLovX/iyn/ryc2TWA0uid1+Qjxzg4Uy4
         OBJ0IerCe1lQLguaZ+p4ZbDI4ZNQtLNd0w8OaA/lgIIBvDbWDDoXks1dUyS7CTLxLnuu
         s3J0TlQhw/UCqMm2TDzWoayJcSYtMJWosuDFbEjxSWSGEZrbhzBHh+5Plc7Bh0FZ14Td
         I2UPRsRKt3kP1e7SfNn1HGUXa2FrbATDMUdHjmZH4ENHFu2LOtVbnTTxofaoKUVtTnUY
         X/bw==
X-Gm-Message-State: AGRZ1gIlqGXZkRqHWWeDlv5Wyw6yAshO8ftrerbv1TG/A5R+w/SQgabq
        k+xfvpwNUFsLSbcElvyIiHgXyt1d
X-Google-Smtp-Source: AJdET5dRr49qAbbVApJJ5mx54RuK9mbeU3bgJvuauwNOb57HZpCoIsC6JWnI+O55NKEHVJD66mojlw==
X-Received: by 2002:a1c:1d12:: with SMTP id d18-v6mr1977436wmd.31.1540985710631;
        Wed, 31 Oct 2018 04:35:10 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id y76-v6sm18918393wmd.37.2018.10.31.04.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 04:35:09 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id AA8741142338; Wed, 31 Oct 2018 12:35:07 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     davem@davemloft.net
Cc:     Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?net:=20move=20=E2=80=98=5F=5Fzerocopy=5Fsg=5Ffr?= =?UTF-8?q?om=5Fiter=E2=80=99=20prototype=20to=20header=20file=20<linux/sk?= =?UTF-8?q?buff.h>?=
Date:   Wed, 31 Oct 2018 12:34:59 +0100
Message-Id: <20181031113500.3763-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it clear the function is part of the API. Also this will
remove a warning triggered at W=1:

  net/core/datagram.c:581:5: warning: no previous prototype for ‘__zerocopy_sg_from_iter’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/skbuff.h | 2 ++
 net/core/skbuff.c      | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0ba687454267..cca7c0a3c176 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3311,6 +3311,8 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
+int __zerocopy_sg_from_iter(struct sock *sk, struct sk_buff *skb,
+			    struct iov_iter *from, size_t length);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 void __skb_free_datagram_locked(struct sock *sk, struct sk_buff *skb, int len);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 946de0e24c87..7eb7e0e104d4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1102,9 +1102,6 @@ void sock_zerocopy_put_abort(struct ubuf_info *uarg)
 }
 EXPORT_SYMBOL_GPL(sock_zerocopy_put_abort);
 
-extern int __zerocopy_sg_from_iter(struct sock *sk, struct sk_buff *skb,
-				   struct iov_iter *from, size_t length);
-
 int skb_zerocopy_iter_stream(struct sock *sk, struct sk_buff *skb,
 			     struct msghdr *msg, int len,
 			     struct ubuf_info *uarg)
-- 
2.11.0

