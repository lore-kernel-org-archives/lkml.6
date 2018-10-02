Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C57C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709F2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5709F2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJCDqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:46:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:54725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeJCDqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:46:03 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M593i-1g8XiA3BSe-001AvM; Tue, 02 Oct 2018 23:00:34 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M593i-1g8XiA3BSe-001AvM; Tue, 02 Oct 2018 23:00:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: cavium/nitrox - Fix format strings
Date:   Tue,  2 Oct 2018 23:00:03 +0200
Message-Id: <20181002210022.2369756-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:PjQLwbb2rTqQI4e5OB+cG/RycqvIdhraYqhi0Zk7CKPBnfdg52U
 IFfqozBPM4yVBTs+Fo0oFFtMVnnNQ3fjBXnP2QOMvPPQC4r3AU7/wTQGJ1KBNmn4cMQSkhw
 mLXBaWpNXwfUdpKQliz7TqGTQqKPDitjFF1gZ8zumndYp6AjxrRlRwcsdiVfZa81hfaImNU
 Agu3+y6z/zqM46V3odOIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LzY+TrwnrKw=:ZngXvB5xN291WCNdDr3bTp
 p+KCUYRZowky//vbzxia1rbI3AVHGDBzmfjj2KkWUZk+RzN3V3hvWiawA+0HWIBkfj2QjAyUn
 HuHvkyRiZRh3rCVH98dmC1Hamk+LHDB51MWPvOH5QdivwwK+m6prTvQt5kpShP9rnZRxNRdJP
 OejrgOvKUDQXM7GNz6tPthlhEZFQNaqrPPzaQRKipqwA1UNceoiBkbik3clA3+oJJDvLL4aZm
 q0pXNKRIe96xJA1q6mWvV3/AnJq1C62+8XSPHf073ryWcEM5XWT1uIGg6Rc1CuODCTSsWxGeH
 txrHw8Vhdlzo4Bje6890jKqZv91tMlyeeGgJ5BR+znVcwP41fCYCIQH9qwl/8htbFcfbboIqp
 WmgOgO/l+dVsS0f3QOJUkzHkqJNPTlvgNo9iy60PvZNfi6XWLrHCulu3b0hWSrnRai0T9/BAc
 kfWdn2BIQK5JvR1fOwWs2xn5MOFCuwrmRsySTT00+IvyBH8lzm2gO3GqthRv4cGyuup5CPIz3
 9+xr6C5/t1yMVxfgLiHV0dgr+i4olLX9cEwEIRnLQOPT8JkL7VJbo209b1v6LbZFIGMpSkJFR
 SWDuAaS6L/SYNbCR5lJu2NMjk6FcXc1Dqz7EgufeMRetT3ztOIR1JGEFisxF92VVhP6ecDOFf
 AAA68Op/B7v2SOpZYMeTGelLln+E3zGhv1smluqbrql8qLvJrn/Ye2DO2/RHN5e3ib1U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type of atomic64_read() is unfortunately architecture
specific, it can be 'long', 'long long', or 's64'. When it is 'long',
we get a build warning:

drivers/crypto/cavium/nitrox/nitrox_debugfs.c: In function 'stats_show':
drivers/crypto/cavium/nitrox/nitrox_debugfs.c:62:30: error: format '%lld' expects argument of type 'long long int', but argument 3 has type 'long int' [-Werror=format=]
  seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
                           ~~~^
                           %ld
drivers/crypto/cavium/nitrox/nitrox_debugfs.c:63:33: error: format '%lld' expects argument of type 'long long int', but argument 3 has type 'long int' [-Werror=format=]
  seq_printf(s, "  Completed: %lld\n",
                              ~~~^
                              %ld
drivers/crypto/cavium/nitrox/nitrox_debugfs.c:65:31: error: format '%lld' expects argument of type 'long long int', but argument 3 has type 'long int' [-Werror=format=]

Add an explicit cast to 's64' to get a consistent behavior on all
architectures here during compile testing.

Fixes: 2a8780be9c26 ("crypto: cavium/nitrox - updated debugfs information.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/cavium/nitrox/nitrox_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
index 2f1e74ea846e..c5be91e5034c 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_debugfs.c
@@ -59,10 +59,10 @@ static int stats_show(struct seq_file *s, void *v)
 	struct nitrox_device *ndev = s->private;
 
 	seq_printf(s, "NITROX [%d] Request Statistics\n", ndev->idx);
-	seq_printf(s, "  Posted: %lld\n", atomic64_read(&ndev->stats.posted));
+	seq_printf(s, "  Posted: %lld\n", (s64)atomic64_read(&ndev->stats.posted));
 	seq_printf(s, "  Completed: %lld\n",
-		   atomic64_read(&ndev->stats.completed));
-	seq_printf(s, "  Dropped: %lld\n", atomic64_read(&ndev->stats.dropped));
+		   (s64)atomic64_read(&ndev->stats.completed));
+	seq_printf(s, "  Dropped: %lld\n", (s64)atomic64_read(&ndev->stats.dropped));
 
 	return 0;
 }
-- 
2.18.0

