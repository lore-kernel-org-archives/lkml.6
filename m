Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Dq9EDCUIHlsDEgAAmS7hNA
	; Mon, 11 Jun 2018 05:27:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0D8C6607BB; Mon, 11 Jun 2018 05:27:01 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIPKuqdr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8CFC8606FA;
	Mon, 11 Jun 2018 05:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CFC8606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932380AbeFKF07 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:26:59 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38773 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932272AbeFKF0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:26:54 -0400
Received: by mail-pg0-f65.google.com with SMTP id c9-v6so9177194pgf.5;
        Sun, 10 Jun 2018 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h1C0XpA1CA0aMQwbiP00P8drmN+/awCRYrM820R6Y90=;
        b=sIPKuqdrJEbCe6b71m/VMv/8F22ucUV+cVmKOQMO4lG3Gi2Ueh6MidKs1y/GC0lgPH
         YlSN3Kpee+mM+o5Urti94S+97UjkPAlvape3A3qIEqprQNlX4OFJEdzmO6WnZU78UrWn
         45l5IvKsDanXhFhPe3Tb9y2DH/5ZxuEyETWyjxOvJ7+xfl239YqQp5N0hh8h2S9KQyEZ
         yzq0uYexKc12HP1FUWHfy/PWObRb2xm6koaAI1puzMfMnHLS1dwIOM/VTLmQnce9CXZF
         pYvaj5ogB9vun8SMIl2CysIoIeax2ulZXVhlmkkYCgwvIwxJ/I8758sFFHcITLcsXTXJ
         e6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h1C0XpA1CA0aMQwbiP00P8drmN+/awCRYrM820R6Y90=;
        b=IjCp+PB9I6TFsVHojHPjhwGYhnpofeOX//KL2yf5BVl5itwzO5sXY92LGx26E2fmfp
         GE5zES+HI+AHPTr255tiQUTyW0o1eb2kSgBTLUJlWAt4x1vTpp2/ntKaMKwdE04fI7Kc
         PRJ3OaQxkI7Y8Ciqvu1yfGQj+f0uC1MCb/75ORx9iTqO7clVa6iSHReFCoPtUspSkuBI
         PNKT3MISSjpgFNn+Sr9eH5TtYegsBk8SU0Vwkkefy1pcKemBflLH55DAOTrmYjvTIEzG
         vro/6313PloAGbafCxNBjcfYXIEFClIPZCSrrgrkETqj1TUZ735CZDryjCUwwJPzRT0q
         g29w==
X-Gm-Message-State: APt69E3kFH56mhnmNI7u39bdStXQX6kaJLd3pOeuMhIqNihGlv5ZYM0D
        ebp1s8klq5Q4/oNpIaKlBZgJPwxWMgk=
X-Google-Smtp-Source: ADUXVKLzvyUoo/OZX0XGIsrUiFKqIuko/RjUs40Rj+p9XcBNXgvjlXwV3LGbLlU+PjNxntwy3LKzhg==
X-Received: by 2002:a62:9385:: with SMTP id r5-v6mr15997959pfk.59.1528694814270;
        Sun, 10 Jun 2018 22:26:54 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id p12-v6sm22608383pfi.175.2018.06.10.22.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 22:26:53 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: add error handling for pskb_trim_rcsum
Date: Mon, 11 Jun 2018 13:26:35 +0800
Message-Id: <1528694795-32000-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pskb_trim_rcsum fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pskb_trim_rcsum.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 net/dsa/tag_trailer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/dsa/tag_trailer.c b/net/dsa/tag_trailer.c
index 7d20e1f..56197f0 100644
--- a/net/dsa/tag_trailer.c
+++ b/net/dsa/tag_trailer.c
@@ -75,7 +75,8 @@ static struct sk_buff *trailer_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb->dev)
 		return NULL;
 
-	pskb_trim_rcsum(skb, skb->len - 4);
+	if (pskb_trim_rcsum(skb, skb->len - 4))
+		return NULL;
 
 	return skb;
 }
-- 
2.7.4
