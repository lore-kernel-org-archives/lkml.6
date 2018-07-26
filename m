Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2938C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D409204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Q7wIVXbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D409204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbeGZDsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:48:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35753 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbeGZDq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so339165edr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rgUumo0LqnvJS+B98GBegKvI5G0lgAubDkmVdRBxjUc=;
        b=Q7wIVXbGV3UV4flvJgGsbbmfmAZ+DLmXAf0ZL4tQU1Ll2wtF5KBx0hHN3nrAmDJRk3
         nczR0OdefG6F7voJMYg9nLjZd4kD/VmeqT4+v6eguD4r7WoEX23aiGyPOVRtyGToFwh4
         McKi1THf75WKa/cGnMWf2Qr8Xhzl0J8LJhs3UI/O9D4I8ZCiZzXm9eGYL3gMj3VtkIBP
         cTBkAhTdpxNJk2UTz0hAc4Ulf37Ozkl0JyOJpMEiXIsi0/pA9WXzBNIKwMMy+J7TMLu4
         ElpJ6SPpTkBWezi4nnuZxrjOu5xNSc2QpUIT3R2GFv06zTGJNO0zn24qgdU7jHCe6XXJ
         hD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rgUumo0LqnvJS+B98GBegKvI5G0lgAubDkmVdRBxjUc=;
        b=rSa0fakoxEF/McOZAh5eTfasOBTnKOaafj7yPplSr9hmAA7C80ebbSegDWBzvvbY0p
         w6fM6u+czn4zIxHoTwACTrTAljv8qZgI2q1pujbH3BsF3cphU0loLBL4deQHOd1a3H3h
         L+/USm+vwUqHmw9xPBgY4iHJJJ3RwQOg47mkzO6/uTnZpF+RkLbFecU0tlruE1LKjjxr
         IN/ioQsC4dGvQzhcpE1P9q9uBBiqN+uPxL/U5hS2zU+nU7TvLnvefyC41OdIgp9khes7
         GdQr6DUchRdu80OGLVsYeIh6bP1bhhAK46DW8R5gOfUNn4S1oU11v1TPfHyGgTzNRiEA
         qevg==
X-Gm-Message-State: AOUpUlHNiC7wirCuyeow4L1S32aQ/rlBHO50PlV9l0PKGz/+xQqNi33q
        GWI/bVvfjhH67dS9WDoXEXUoxNDt0rU=
X-Google-Smtp-Source: AAOMgpf+/78vpYY34Mmxlu+9r6HVh9jV1vaVJVAALPWdVnvpIJaLu6KCXS6REQ4+xO2f9yXPPWf/1A==
X-Received: by 2002:a50:dccf:: with SMTP id v15-v6mr501363edk.196.1532572312398;
        Wed, 25 Jul 2018 19:31:52 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:51 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 05/18] net/xfrm: Parse userspi_info{,_packed} depending on syscall
Date:   Thu, 26 Jul 2018 03:31:31 +0100
Message-Id: <20180726023144.31066-6-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct xfrm_userspi_info differs in size between 64-bit/32-bit UAPI
because of (possible) padding of xfrm_usersa_info:

          32-bit                                   64-bit
----------------------------------------------------------------------
sizeof(xfrm_userspi_info) = 228     |  sizeof(xfrm_userspi_info) = 232
xfrm_userspi_info::info = 0         |  xfrm_userspi_info::info = 0
xfrm_userspi_info::min = 220        |  xfrm_userspi_info::min = 224
xfrm_userspi_info::max = 224        |  xfrm_userspi_info::max = 228

xfrm_alloc_userspi() can handle both UAPI by checking the type of
send() syscall used by userspace with XFRM_MSG_ALLOCSPI.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index b382cdd3bef6..bf2ca93edaf5 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -61,6 +61,12 @@ struct xfrm_userpolicy_info_packed {
 	__u8				share;
 } __packed;
 
+struct xfrm_userspi_info_packed {
+	struct xfrm_usersa_info_packed	info;
+	__u32				min;
+	__u32				max;
+} __packed;
+
 static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type)
 {
 	struct nlattr *rt = attrs[type];
@@ -1279,11 +1285,21 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	xfrm_address_t *daddr;
 	int family;
 	int err;
-	u32 mark;
+	u32 mark, spi_min, spi_max;
 	struct xfrm_mark m;
 
 	p = nlmsg_data(nlh);
-	err = verify_spi_info(p->info.id.proto, p->min, p->max);
+	if (in_compat_syscall()) {
+		struct xfrm_userspi_info_packed *_p = nlmsg_data(nlh);
+
+		spi_min = _p->min;
+		spi_max = _p->max;
+	} else {
+		spi_min = p->min;
+		spi_max = p->max;
+	}
+
+	err = verify_spi_info(p->info.id.proto, spi_min, spi_max);
 	if (err)
 		goto out_noput;
 
@@ -1310,7 +1326,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (x == NULL)
 		goto out_noput;
 
-	err = xfrm_alloc_spi(x, p->min, p->max);
+	err = xfrm_alloc_spi(x, spi_min, spi_max);
 	if (err)
 		goto out;
 
-- 
2.13.6

