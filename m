Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA5AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3744820817
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMhW5Zeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3744820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeKMQJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:09:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54979 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKMQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:09:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so10676739wma.4;
        Mon, 12 Nov 2018 22:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCkiFZumujImEkQOt55JYaHPYWBqsU/ptQR5bVovdDI=;
        b=XMhW5Zeo9j63fLi6f/qWVRhY6yO9McL4lUZWNG8HyFxC0wkKcQTeke4xjfTaOS4AoG
         qBWrsdnTjd4AXSA3ZR63CaJNACNfhdf0y1US3WJf3biwl8t+VRRxl4wJCOJjUEIABfGu
         gKYNffVa3EhNoH92HbZm8kk4KALSnTW2dQFIbt27ADgupvfOaG7KeNqI4pVFgrvOUSQW
         0GaXdpsbOwKzBFn6mk/InInAanAl7314SgFpI96uQAGfPT16IQWcznFIdzrOdsJYD/rR
         a5rxtFfdUmdsBFajS/67oDnSJmD81r7hj4o3Tm7Dawg7D05EAkcjibeTQRmsFB0I3ERK
         e0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCkiFZumujImEkQOt55JYaHPYWBqsU/ptQR5bVovdDI=;
        b=Xpr4bv8k3gG7YfZwZCPg59DU4VKefWsandS9cy/YkamD5oyxXLepcF8AQxl6K600jQ
         JZfU4r6Ef5D13dXR3E+y5GzXhKGAtvNTGREyCwX5WPWOe2nZbI4evGqOKsUSDk5hliKf
         53EHAjereMuP5lPi3VbSXIwFEgKBGvPZ2I8lWRnxAheKwuo0VMHmsy+LIlGd9IX/AjlC
         /94SVh11W0LEeHYCdHw1aflAWWhZbrVgwlgK18FoJaOc9swg0XvgZ1NIYwWS6VbwHIKo
         7h/oo85oIbkPBRvsLayUy3Sxb3oQAle1tI4GplYTg3AA1Vhgis7K8663ShscUVtseh+I
         odEA==
X-Gm-Message-State: AGRZ1gKLzWBX+Lfhqj9HAeuFlxEGwwcePAnSERyA98UhvHALmsw0Yspb
        U6jAssO6X47w5JFBuSQoEHQ=
X-Google-Smtp-Source: AJdET5cQRSk170HBio1JaMo2yVpGcOaLcz6sjxiPSHzPbgDjrmYzmnaOg8K56Bk8MGymODpcBPoM5g==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr2075278wmb.145.1542089566870;
        Mon, 12 Nov 2018 22:12:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r3-v6sm13867440wmd.25.2018.11.12.22.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 22:12:46 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH net-next v2] geneve: Use empty braces for addr6 initializer
Date:   Mon, 12 Nov 2018 23:11:47 -0700
Message-Id: <20181113061146.12182-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112221248.11477-1-natechancellor@gmail.com>
References: <20181112221248.11477-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/geneve.c:428:29: error: suggest braces around initialization
of subobject [-Werror,-Wmissing-braces]
                struct in6_addr addr6 = { 0 };
                                          ^
                                          {}

Most initializations of structs in the kernel seem to use this format.

Fixes: a07966447f39 ("geneve: ICMP error lookup handler")
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Just remove the zero instead of adding more braces as it seems to
  match the rest of the kernel (as suggested by Joe Perches).

 drivers/net/geneve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7c53e06b31c3..f09e58b7b01e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -425,7 +425,7 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	if (geneve_get_sk_family(gs) == AF_INET6) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
-		struct in6_addr addr6 = { 0 };
+		struct in6_addr addr6 = { };
 
 		if (!gs->collect_md) {
 			vni = geneve_hdr(skb)->vni;
-- 
2.19.1

