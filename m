Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45996C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B79A2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="riL2LQze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfBRGgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:36:12 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:59632 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfBRGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:36:12 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x1I6ZVhQ016992;
        Mon, 18 Feb 2019 15:35:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x1I6ZVhQ016992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550471731;
        bh=KZ6waXrvZG9Xr56Nonejv6eOkhjv33RQzKN2a8rzlxw=;
        h=From:To:Cc:Subject:Date:From;
        b=riL2LQzeXheBTsDARRP9arKk/4Tc9VlRe7H8fU7qprD1WwxoykSRQWWXl8iXCvFKg
         kc74ghvevRHA53q9ncI6nh/BRUJ0LW7FaX9OuvkZNwvdUHJIV6FXBcCujv5tK6FaZo
         /ZF6faPdcyAPNPWb+FIyFQ+p5TW/N7toPwjHkHOdDw+hrU55rfdEMhLuxwm0Tb6WvS
         3rZ/4bd62utittOPwFrlC1yOaPjIxSU85+59dm6aCpPRN+Ifn7u9gDitwQgLvaPifz
         YOfN6/svjksjyHzoiWXtCIsAo53cW/kKjMIoUpwvideBgCEOInnGSihigTFU+TwEso
         CT+NG2B+LEF4g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-hams@vger.kernel.org,
        Thomas Sailer <t.sailer@alumni.ethz.ch>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: hamradio: remove unused hweight*() defines
Date:   Mon, 18 Feb 2019 15:35:25 +0900
Message-Id: <1550471725-5575-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file does not use hweight*() at all, and the definition is
surrounded by #if 0 ... #endif.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/net/hamradio/baycom_ser_fdx.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/hamradio/baycom_ser_fdx.c b/drivers/net/hamradio/baycom_ser_fdx.c
index 190f66c..ed08416 100644
--- a/drivers/net/hamradio/baycom_ser_fdx.c
+++ b/drivers/net/hamradio/baycom_ser_fdx.c
@@ -203,32 +203,6 @@ static inline void ser12_set_divisor(struct net_device *dev,
          */
 }
 
-/* --------------------------------------------------------------------- */
-
-#if 0
-static inline unsigned int hweight16(unsigned int w)
-        __attribute__ ((unused));
-static inline unsigned int hweight8(unsigned int w)
-        __attribute__ ((unused));
-
-static inline unsigned int hweight16(unsigned int w)
-{
-        unsigned short res = (w & 0x5555) + ((w >> 1) & 0x5555);
-        res = (res & 0x3333) + ((res >> 2) & 0x3333);
-        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
-        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
-}
-
-static inline unsigned int hweight8(unsigned int w)
-{
-        unsigned short res = (w & 0x55) + ((w >> 1) & 0x55);
-        res = (res & 0x33) + ((res >> 2) & 0x33);
-        return (res & 0x0F) + ((res >> 4) & 0x0F);
-}
-#endif
-
-/* --------------------------------------------------------------------- */
-
 static __inline__ void ser12_rx(struct net_device *dev, struct baycom_state *bc, struct timespec64 *ts, unsigned char curs)
 {
 	int timediff;
-- 
2.7.4

