Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F73DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1488320858
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjcwOYvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1488320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeKQLyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 06:54:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50973 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQLyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 06:54:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so300377wmw.0;
        Fri, 16 Nov 2018 17:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyBZJLdqz+s57CxqOu2+0YoBrEqUs1DOmRBCmfoOLuE=;
        b=LjcwOYvR1YDvpJh1JYSgyl1MZ+ut94jvBgkddrwF8eZaq9aIQwObAqasssVXPNI2mR
         ygHmtce7x1FYsKbZipX6tPgd48T0ktbNvh9D6h0AG7JKBsqhxwMd7+u2p7lPcaxYy7We
         ymeD81cDuo1mSV5ihJdNhC0maBL93aQVMF2gwoOvuhW9mbStTfAvBVH1FvgdGGZNXcmz
         3XxjOyvJBWNr/+8dO5OubyX4w52LusU07bcam1IqmUbedguZWRyNUxWSyVgao9F+QWVU
         jpYI5WUjIq+bMvxj9sJRvw2d6FdLV8URWmLWAzwfFqTLfJOIs7L/53nOE5j1MyYXDpXw
         bAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyBZJLdqz+s57CxqOu2+0YoBrEqUs1DOmRBCmfoOLuE=;
        b=nBhqUYQTk5gc818Jeq+BN4x09iQfxCmUwO8kMUMlOvWxmcAsyyHLeaS2fujCIDdHKl
         n4FcKEZ4Qy/o92lSPzS3iXRuZ1c7KTSlhNLTt/gSnWzNaLFFNE9F5myHLkQsjk0NiyKS
         /z5JtJHsKHNjv2DobrBSg2ahhIzrDA8haIt3hA33KNxVEepCcWCbcGMFH1P0Q9JgX5x0
         vj/DX6aQRCBe1t5rgvO0gHDiqM+qSlCFROEIUsvhZSD2QEEbcD5x+JWa3Bk8+LEKia66
         vdVlbkHRmR4XOI9+auUmtz1ga77xTn1Buw4cnV4Oz5QLlWhghcoEa5JG6W3KSf11HrD9
         GS+g==
X-Gm-Message-State: AGRZ1gIWtp6BciavFGz3K/u+4jMSvwZwhPCL6dvpE5u6EENtgjzOjg/n
        xht6S1deTZyQ16hfICNxntg=
X-Google-Smtp-Source: AJdET5fOrD2x/P6BxqNQJQzg3511ss8iFArD9nvcUN7IPvUPynXWSW4ItJmvT+uu6qx/Kcw+pNv8+A==
X-Received: by 2002:a1c:8a11:: with SMTP id m17-v6mr330690wmd.15.1542418802080;
        Fri, 16 Nov 2018 17:40:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t5sm6817727wmd.15.2018.11.16.17.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 17:40:01 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH net-next v3] geneve: Initialize addr6 with memset
Date:   Fri, 16 Nov 2018 18:36:27 -0700
Message-Id: <20181117013626.4808-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113061146.12182-1-natechancellor@gmail.com>
References: <20181113061146.12182-1-natechancellor@gmail.com>
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

Rather than trying to appease the various compilers that support the
kernel, use memset, which is unambiguous.

Fixes: a07966447f39 ("geneve: ICMP error lookup handler")
Suggested-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Just remove the zero instead of adding more braces as it seems to
  match the rest of the kernel (as suggested by Joe Perches).

v2 -> v3:

* Use memset as suggested by David Miller.

 drivers/net/geneve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7c53e06b31c3..58bbba8582b0 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -425,7 +425,9 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	if (geneve_get_sk_family(gs) == AF_INET6) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
-		struct in6_addr addr6 = { 0 };
+		struct in6_addr addr6;
+
+		memset(&addr6, 0, sizeof(struct in6_addr));
 
 		if (!gs->collect_md) {
 			vni = geneve_hdr(skb)->vni;
-- 
2.19.1

