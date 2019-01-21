Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C44C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FF720989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfAUHid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:38:33 -0500
Received: from shell.v3.sk ([90.176.6.54]:49580 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfAUHid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:38:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 40688CAE4E;
        Mon, 21 Jan 2019 07:23:26 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7e007fhqLtJl; Mon, 21 Jan 2019 07:23:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 58A46CAF41;
        Mon, 21 Jan 2019 07:23:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mFr6-D1hTPZV; Mon, 21 Jan 2019 07:23:18 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id AD077CAF2E;
        Mon, 21 Jan 2019 07:23:17 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/3] Revert "dt-bindings: marvell,mmp2: Add clock id for the SP clock"
Date:   Mon, 21 Jan 2019 07:22:56 +0100
Message-Id: <20190121062255.551587-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121062255.551587-1-lkundrak@v3.sk>
References: <20190121062255.551587-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the kernel has no business managing this clock: once the SP
clock is disabled, it's not sufficient to just enable it in order to brin=
g
the SP core back up.

Pretty sure nothing ever used this and it's safe to remove.

This reverts commit e8a2c779141415105825e65a4715f1130bba61b1.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 include/dt-bindings/clock/marvell,mmp2.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindin=
gs/clock/marvell,mmp2.h
index 7b24fc791146..228a5e234af0 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -71,7 +71,6 @@
 #define MMP2_CLK_CCIC1_MIX		117
 #define MMP2_CLK_CCIC1_PHY		118
 #define MMP2_CLK_CCIC1_SPHY		119
-#define MMP2_CLK_SP			120
=20
 #define MMP2_NR_CLKS			200
 #endif
--=20
2.20.1

