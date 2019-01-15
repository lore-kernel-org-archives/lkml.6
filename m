Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11FEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F9220873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570295;
	bh=iP0p1JHKvElGGGB1ZXCLONmSVBxjvU2n/WqY+/+7gDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bEIm1tnQVX/OPlEND+Ihw1b9R+M5HnjKCPxd8Dw+D9u9f+I5CanN1JjtlrJYWUB0H
	 oYy4lM17sYGC7OTs/yIcsRKXndeh0YrpzayTtvkihDWgaGzNVH9tfbUETVPcRicppq
	 ezCwCzuutK2DMl95PKXQN7kqZCGJuYoS1A0d176I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfAOQiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732021AbfAOQiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4305B20675;
        Tue, 15 Jan 2019 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570291;
        bh=iP0p1JHKvElGGGB1ZXCLONmSVBxjvU2n/WqY+/+7gDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fc2LkVuSPQ5Dt0Ba74zUxoK6+64ms8fEI33AynRM3kTZvsTymezaOrF07H3BxAoLV
         buU3/u/PykfoTlh1QxSG7E/0y5/DraD6xIZ+uX6osM3e7vWZWJZBueHZBe8SywFbue
         LeyR4t3+hfoHzE6+btSRqqootfzd2v+FrvijGf+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Stocker <jackstocker.93@gmail.com>
Subject: [PATCH 4.4 38/51] USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB
Date:   Tue, 15 Jan 2019 17:35:34 +0100
Message-Id: <20190115154852.794599777@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Stocker <jackstocker.93@gmail.com>

commit 3483254b89438e60f719937376c5e0ce2bc46761 upstream.

To match the Corsair Strafe RGB, the Corsair K70 RGB also requires
USB_QUIRK_DELAY_CTRL_MSG to completely resolve boot connection issues
discussed here: https://github.com/ckb-next/ckb-next/issues/42.
Otherwise roughly 1 in 10 boots the keyboard will fail to be detected.

Patch that applied delay control quirk for Corsair Strafe RGB:
cb88a0588717 ("usb: quirks: add control message delay for 1b1c:1b20")

Previous K70 RGB patch to add delay-init quirk:
7a1646d92257 ("Add delay-init quirk for Corsair K70 RGB keyboards")

Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -240,7 +240,8 @@ static const struct usb_device_id usb_qu
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
 	/* Corsair K70 RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
 
 	/* Corsair Strafe */
 	{ USB_DEVICE(0x1b1c, 0x1b15), .driver_info = USB_QUIRK_DELAY_INIT |


