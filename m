Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xGHiCZMEHlvNOAAAmS7hNA
	; Mon, 11 Jun 2018 05:11:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F3ABF607BB; Mon, 11 Jun 2018 05:11:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pD6XMqio"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 729E060385;
	Mon, 11 Jun 2018 05:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 729E060385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeFKFLm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:11:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46239 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeFKFLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:11:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so9576072pff.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 22:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nK7e3LsJjbklCPMdNkK3KrlpRnpej5I9jztZjB0AjIM=;
        b=pD6XMqioE7SIbYZizBlP+XZRrQFxbBHWLeN5WxBPT+pYrNRly9bC1vEvZwnRQWA00j
         rSHy2tW5WyCTx3rQ6krajOcFre5vs11ft0IjLUM7BIIH4vmeTeb+/UMzXZSStgku5TxV
         +IYlw8cuUz3yorVfRyHBt6/RqnKH6TWtR7e6IKcQiHAHs0cG3yZPObEHPTgwUVP+8iuK
         dDo2KAlUC90jgB6fxvGYTYYNboN/yJxxibcu6fVpFqo0eTEgw5GbgMOjhjBjNBedD3WS
         tMmSskQPIuF6qifpKxkY7mUAIx4xkmkwGxoahnAQkMvPb6r0qD/CEC7BEAWRS+w3fqYZ
         TcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nK7e3LsJjbklCPMdNkK3KrlpRnpej5I9jztZjB0AjIM=;
        b=a640bcarubX/QIVjjjpWzdt/grNqCcjd1PsODwOf1qiTMzYNg2OvTdQHsb1ahz5n0Y
         G48GAruF3nT/nD2jpRO8ZXLPkOImqtliaO1n7Q+XbynLTbGcUaLwc1gTyB1qNn/d3rRd
         vkNgofwLQCPOIBUZHGwfXxAgiP30r4V7zfDNcFL9NJ39fdAMuHSr07olT87lXsY0pmKZ
         5vhL8q0Ga3MfNhBpoyL4TDMZf5bm05RVlrKEwM2FMoii+JoSlcfcwVh1IZTCdrNeYCP2
         q9EfqXsGi9rWcRYEFEoWBFLvkugaxKWaruQPBilWKTehfDWuA53vJSL9/DDUx/G6+iWU
         vCUg==
X-Gm-Message-State: APt69E2EJqdfsJidEYsm7eQ275gh4eOBCYKxMplpgnejVIeIc8Zo43lR
        QZPysK+taXbK6oeQGdDDgxo=
X-Google-Smtp-Source: ADUXVKKwzG5cVixkX/x4+hnHxq7Bgpi8NkDxIfI2OlIKumxK9I2DkI37nl87so019UdO84fyrrJolQ==
X-Received: by 2002:a65:404d:: with SMTP id h13-v6mr13562887pgp.62.1528693900986;
        Sun, 10 Jun 2018 22:11:40 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id x124-v6sm32699970pgb.53.2018.06.10.22.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 22:11:40 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: add error handling for nlmsg_put
Date: Mon, 11 Jun 2018 13:09:24 +0800
Message-Id: <1528693766-31570-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nlmsg_put fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling nlmsg_put.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/staging/gdm724x/netlink_k.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
index abe2425..4623140 100644
--- a/drivers/staging/gdm724x/netlink_k.c
+++ b/drivers/staging/gdm724x/netlink_k.c
@@ -119,6 +119,9 @@ int netlink_send(struct sock *sock, int group, u16 type, void *msg, int len)
 	seq++;
 
 	nlh = nlmsg_put(skb, 0, seq, type, len, 0);
+	if (!nlh)
+		return -EMSGSIZE;
+
 	memcpy(NLMSG_DATA(nlh), msg, len);
 	NETLINK_CB(skb).portid = 0;
 	NETLINK_CB(skb).dst_group = 0;
-- 
2.7.4
