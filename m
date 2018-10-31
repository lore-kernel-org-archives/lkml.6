Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A19DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74D42081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXhPKLVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74D42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeJaVPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:15:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeJaVPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:15:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so14278438wmd.4;
        Wed, 31 Oct 2018 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=yDsGAkoCwEYRdTY/gcvr/sb0ECj9UAZrQTLqLk352DA=;
        b=IXhPKLVuC/IIndrXpXSPRXbFo6x8uv9XFWucI6bvOPOeQwWEX5yK6nXOKxH39BD4kR
         /DZNASm6ux1EHOiE3tTWELRIQ9QP75bBlqBgw5aW3g7Ahu9iWngqclASSarqV4oAXLGa
         EtcVIZp//gh12LpZZkVF/POPujQ7hg+AVqRke6OIEx1gF8emo1T7Tfgz79ofDRVeTYX+
         qQU7JMBlHYkaElXRkKfPuY8fKJpicWBNQkxlqMAB4+dC73esi9ukjvolwFiHf4SJY+Wb
         SkUdhuq2LI+KuAB3ZRCRB0jHHDh2e/EEff1b05zbh9LyxkfywTD3b8hE3N/ez4cqceqT
         sWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=yDsGAkoCwEYRdTY/gcvr/sb0ECj9UAZrQTLqLk352DA=;
        b=M/JAvyaE6YDXIyloDqfpcprzVZqt9w4QiB7TqckFVDVVkoqzvkpeky2+5FaSO+c88d
         tL+1ZFcUinUbQ3oI1nXJ04FO2M/RsKMol3l5iA4vDSzvW0lg44cl+xEK8BPW3a1/R/Q8
         pxRDVMT2/mCtkwry8WOzhKpQC+hwYzFzHyE1PMj8/VpSAjKpuWxCxrPbiAzdL2QmuleN
         Sm26wJo2vHINEbqU8h7BkGdmlH6Hersr7txuuIuzIh7bjneBlQz0OT35kY3fhMeD8NAm
         crbpiia35n5VtkO2IzCVfs7En0/tWeTxXp+7vCEyoAg3DIH8J+7RhLCeyBsRhdwOnPXS
         LjPg==
X-Gm-Message-State: AGRZ1gL01n6rffJCJS3sS4JMlZARFWk4aAnyEXqPwlIALecIsG4Dzj7j
        +i0mHP8zeWU/fYEmysUr1KI=
X-Google-Smtp-Source: AJdET5ddBORJd9MYXQTYzUvAYYts4ybfKRcMbkw78+1ESZ1r8mvG6ckjidIQplYDSxz9Ar3jYOirKg==
X-Received: by 2002:a1c:49c2:: with SMTP id w185-v6mr2125828wma.144.1540988240904;
        Wed, 31 Oct 2018 05:17:20 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id j72-v6sm15219050wrj.7.2018.10.31.05.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 05:17:18 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 40EBE1142338; Wed, 31 Oct 2018 13:17:17 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     davem@davemloft.net
Cc:     Mathieu Malaterre <malat@debian.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: document skb parameter in function 'skb_gso_size_check'
Date:   Wed, 31 Oct 2018 13:16:58 +0100
Message-Id: <20181031121659.30764-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove kernel-doc warning:

  net/core/skbuff.c:4953: warning: Function parameter or member 'skb' not described in 'skb_gso_size_check'

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 net/core/skbuff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7eb7e0e104d4..4e774f34ccc3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4941,6 +4941,8 @@ static unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
  *
  * This is a helper to do that correctly considering GSO_BY_FRAGS.
  *
+ * @skb: GSO skb
+ *
  * @seg_len: The segmented length (from skb_gso_*_seglen). In the
  *           GSO_BY_FRAGS case this will be [header sizes + GSO_BY_FRAGS].
  *
-- 
2.11.0

