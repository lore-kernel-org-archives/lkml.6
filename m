Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C190C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B5208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2B5208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755150AbeFRPXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:23:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754110AbeFRPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:23:31 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0Lpvbr-1g6Tvv3fKp-00fjAT; Mon, 18 Jun 2018 17:23:09 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] ipv6: xfrm: use 64-bit timestamps
Date:   Mon, 18 Jun 2018 17:22:14 +0200
Message-Id: <20180618152242.1566661-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180618152242.1566661-1-arnd@arndb.de>
References: <20180618152242.1566661-1-arnd@arndb.de>
X-Provags-ID: V03:K1:MumUtdStB+H7OHowHs5Dcrf+8C5zawBp39altZ0CBRX/P/rSezf
 /ZYMxO1hj5Enwdvff3psaUnnoPR22wB/9MSlojFjgpihmzsfq3njgQE57C3mWhAUqw6SZXi
 GTKN4qGBZYyBgk6tFvw94pEsjkHWCNQC0XaVKJD6NMWbqn7cQSR9gd34y3d9SxW9oMh4vb4
 hLBQ112szslLAyYfBuAIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DdqbT/qtOlo=:Jz7ILWoAsbYd7qjuavkI0B
 wvTMNERisN6+ye9w1Eq0bbuy3wxgXpiErRcoLY1UcF3CG4N7aJefPWLeVnhXacAdH8aQZUss6
 5Q1kQ+emx+SX0q+xz+fGmyiRZZvUrQfGnDxPc0yhGmBVVAHWG94QzIZ1r8KBHoEHsdBJXb2rL
 wTFCp/7YAkR13cOQx1l1Nd7yUuvkH8rshBvNCFA/0uOtxnKgLw+9R4jDgnz9AebeDsgj5Y0IS
 YOoZO/aJLjTYqU2s90F6jYpjhNhUjy48ILtg63fYCqYmrws/4L6ehEKaerA0p57ofUmnuYFk+
 PrUS/7dulARJr26ozgyUpWzSa5snlENtEW7+5cm3LhHQCRsvXIO+o9uD8un6HnsODuCLv+zvc
 xhpIQzO1dqm1y/PyOaieVomrQe43SlYW8zObFJsow2z2XpQUiYxrXHuBRgyYFpbI3mbpY1ijs
 WpvGApiUY4e3zrXe8P+e01qZvDrmjRUGZqwGXdEpD97cY6/EH5/rXdsThosxj+TMUMCKp2XlK
 vra4mLcl0dmdnGZdWzw2WQ4OZn5jnymJ0Eb0lN0wPECHGtPGyqypWE4Pm0cS/AIQNA0CxFct4
 m2PviToQL+OI+CA2Y8jxJE07uvgkC8t+lZoVUe45IyCP/pwBUSEFpEWKT76KdRoTHzYgVltYm
 ekNuyQZ+/j6rWlBHXfxE5RC75CGcp/LVitkeC6h8bmjmjaTi4quc9b3boc0UNFskVijE=
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
index 557122846e0e..d9031415402f 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -225,7 +225,7 @@ struct xfrm_state {
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

