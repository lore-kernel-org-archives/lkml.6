Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6996C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89572075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89572075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKSGUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:20:51 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:45784 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeKSGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:20:50 -0500
Received: from localhost.localdomain (85-76-71-135-nat.elisa-mobile.fi [85.76.71.135])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 30EF220056;
        Sun, 18 Nov 2018 21:59:37 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 4/4] USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
Date:   Sun, 18 Nov 2018 21:59:12 +0200
Message-Id: <20181118195912.14026-4-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181118195912.14026-1-aaro.koskinen@iki.fi>
References: <20181118195912.14026-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Palm TE nothing happens when you try to use gadget drivers and plug
the USB cable. Fix by adding the board to the vbus sense quirk list.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 7c240b1921bd..0bf755e6acea 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2033,6 +2033,7 @@ static inline int machine_without_vbus_sense(void)
 {
 	return machine_is_omap_innovator()
 		|| machine_is_omap_osk()
+		|| machine_is_omap_palmte()
 		|| machine_is_sx1()
 		/* No known omap7xx boards with vbus sense */
 		|| cpu_is_omap7xx();
-- 
2.17.0

