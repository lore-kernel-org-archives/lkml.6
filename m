Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F9AC0044B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B8220871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B8220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbeKLNMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:12:35 -0500
Received: from shell.v3.sk ([90.176.6.54]:59667 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbeKLNMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:12:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F24F1C6A35;
        Mon, 12 Nov 2018 04:21:24 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oO8sutL-oE2o; Mon, 12 Nov 2018 04:21:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C5564C6A31;
        Mon, 12 Nov 2018 04:20:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eBUYClaFBRsr; Mon, 12 Nov 2018 04:20:43 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3EA76C6A30;
        Mon, 12 Nov 2018 04:20:39 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 13/18] ARM: mmp2: initialize clocks before the timer
Date:   Mon, 12 Nov 2018 04:20:22 +0100
Message-Id: <20181112032027.653931-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer shall enable its clock.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm/mach-mmp/mmp2-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 0341359b24a4..50c5e8b5be3d 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -26,8 +26,8 @@ static void __init mmp_init_time(void)
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init(0);
 #endif
-	mmp_dt_init_timer();
 	of_clk_init(NULL);
+	mmp_dt_init_timer();
 }
=20
 static const char *const mmp2_dt_board_compat[] __initconst =3D {
--=20
2.19.1

