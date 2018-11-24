Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C46C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E2920868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 22:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E2920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeKYJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 04:06:43 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:43980 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeKYJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 04:06:42 -0500
Received: from localhost.localdomain (85-76-84-147-nat.elisa-mobile.fi [85.76.84.147])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 64090200D2;
        Sun, 25 Nov 2018 00:17:14 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 4/5] USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
Date:   Sun, 25 Nov 2018 00:17:07 +0200
Message-Id: <20181124221708.31003-5-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181124221708.31003-1-aaro.koskinen@iki.fi>
References: <20181124221708.31003-1-aaro.koskinen@iki.fi>
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
index 33250e569af8..9b23e04c8f02 100644
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

