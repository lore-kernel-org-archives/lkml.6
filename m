Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A121C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB8C20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRR05m4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB8C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeLEJpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:45:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeLEJp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:45:26 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC8820878;
        Wed,  5 Dec 2018 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003125;
        bh=Wn9OKzUbKI0/ji237hMKT73/yq85aYcvz1ZwsQRcub4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRR05m4yDt+Tn/p0Wsfyq8NmZ9/a338LVI+9HoiVdbgmevQnzNvh2p7AlgAQ27DKV
         A5C8Jp+dnH5Y9CtUKnD9SqiFIa2p+SCLJd+bw8UCuesYSAVbJrCTnjXDxgjWDtO9uf
         5S35hkctUQ4tRTxAB+A1EKBmwe4H9/h9i5cvLjg4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 37/69] USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
Date:   Wed,  5 Dec 2018 04:42:15 -0500
Message-Id: <20181205094247.6556-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@iki.fi>

[ Upstream commit 2c2322fbcab8102b8cadc09d66714700a2da42c2 ]

On Palm TE nothing happens when you try to use gadget drivers and plug
the USB cable. Fix by adding the board to the vbus sense quirk list.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/omap_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 9060b3af27ff..c8facc8aa87e 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2037,6 +2037,7 @@ static inline int machine_without_vbus_sense(void)
 {
 	return machine_is_omap_innovator()
 		|| machine_is_omap_osk()
+		|| machine_is_omap_palmte()
 		|| machine_is_sx1()
 		/* No known omap7xx boards with vbus sense */
 		|| cpu_is_omap7xx();
-- 
2.17.1

