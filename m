Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8AAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7CA20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7CA20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeGKKYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:24:06 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40601 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732499AbeGKKYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:24:05 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lnopk-1gIpVx2qO8-00fwBt; Wed, 11 Jul 2018 12:20:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [RESEND, net-next] ipv6: xfrm: use 64-bit timestamps
Date:   Wed, 11 Jul 2018 12:19:14 +0200
Message-Id: <20180711101941.4039411-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180711101941.4039411-1-arnd@arndb.de>
References: <20180711101941.4039411-1-arnd@arndb.de>
X-Provags-ID: V03:K1:oPTogUBpFHn0fyK8ppcY26kg3RNuctUI+j2Z/4enDutxGpW9bSv
 MISQcAq/LbXnIPpjHy94HA/Hu9VlP6e585Z4JCtAJD4PaIlhr2Z8WOborRNrFjA7FT2v8TP
 9om3d0nYNXsdokWvm33H04GUI1ZIQ3SJUwrUVP1HtQ/U8QR2PhqzVjEQm6wcO4cVfaVrBty
 nMkcZtC+iHoSPsPTWR2lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E7NASbAE02s=:gQJKalm6BOP3IqAvN8tsF9
 AhKkb4S+54c/yaarIDeD2I7emUBuosxh8hW1HB8uigzJFmK9/fBeFA5ZrSzcg82oO3VxEP7w0
 4EQa4dy2lNp8HUspUN3SFYLTzh3xGvj16sM5hHHF+CAOvN1/kYwz0GCSoO2obWCC4ZNDnw83e
 8FQmgU7f6fmovRC/P5i41RE2fw/08LQSmCNn+rqO1G5kh9fM8+0LCrLEwuVFv9X4YQgMpbnm9
 Ru8VxnIZEuV4T732SKAGnKvEHPvikgfPe91IKb3J/DusXTH201EVIoziWS9BBiApUEteXr0xL
 bzxBlnFc4VBPKST5RZ4+cv/lJ59nVgdFBa57ngdAqKrx8HDdVfZR3yLZCblOxZbWw1QVvalvG
 mxi+5nz1LDHQlNsQNg4HKwKXb500gLtf6fnjdW8tpTn3bivq7xPVC+/NU4FwBgovi3DBExvx/
 Tmn+bW2GWEOGuCRkrJMSljlYcLaYkHpcbEMQIVx0PCrlWd+ZZGB9KJsnfZpcmiTZBmZ1cmZyJ
 sQks/MiJSvdMK2yKR9+PRx07jIh5y7Ym31nfm0+SNCUfqZdSOhIQEyNLLTVt+u5WemRoBN8nL
 LynxuhUFVdBkmhKMXOM8z1z7H9W6+YVhoidttMWMHbp65gX8S3PvKb8a6U9+y3BlIXty3QDFD
 UQTkVxlgDrqeyiEAcLqUf7HJ6WF3LJQrlo07kx7AJnoaw3qlOqBbT0scssYHglwCAYic=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() is deprecated because it can overflow on 32-bit
architectures.  For the xfrm_state->lastused member, we treat the data
as a 64-bit number already, so we just need to use the right accessor
that works on both 32-bit and 64-bit machines.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/xfrm.h       | 2 +-
 net/ipv6/xfrm6_mode_ro.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 51cc475b87e0..d704b662a94b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -227,7 +227,7 @@ struct xfrm_state {
 	long		saved_tmo;
 
 	/* Last used time */
-	unsigned long		lastused;
+	time64_t		lastused;
 
 	struct page_frag xfrag;
 
diff --git a/net/ipv6/xfrm6_mode_ro.c b/net/ipv6/xfrm6_mode_ro.c
index 07d36573f50b..da28e4407b8f 100644
--- a/net/ipv6/xfrm6_mode_ro.c
+++ b/net/ipv6/xfrm6_mode_ro.c
@@ -55,7 +55,7 @@ static int xfrm6_ro_output(struct xfrm_state *x, struct sk_buff *skb)
 	__skb_pull(skb, hdr_len);
 	memmove(ipv6_hdr(skb), iph, hdr_len);
 
-	x->lastused = get_seconds();
+	x->lastused = ktime_get_real_seconds();
 
 	return 0;
 }
-- 
2.9.0

