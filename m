Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6682AC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACC4214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d648d4dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACC4214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeLDLZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeLDLAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:00:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE32C2087F;
        Tue,  4 Dec 2018 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921231;
        bh=HDJ7Jd+Ohp5eO3RC3znumK/w8QDko4u1TWDqcjRscPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d648d4dncVJAvEHkvG2w99DUuYTB1eBBL7UsXVSbMU1D4PjzEw/cFbN3HyFG18nRe
         QUQk8sU/oAbyFN67jQxj7EljHZVLaTneDng+iUV63xuWCvaoTVhd3BeVuSSfcOA/rI
         5Yml5knZrgg2aFaoRIKj3Pz6Ei0NgTEgnw27JI+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>
Subject: [PATCH 4.19 131/139] usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream series
Date:   Tue,  4 Dec 2018 11:50:12 +0100
Message-Id: <20181204103656.180300651@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Niewöhner <linux@mniewoehner.de>

commit effd14f66cc1ef6701a19c5a56e39c35f4d395a5 upstream.

Cherry G230 Stream 2.0 (G85-231) and 3.0 (G85-232) need this quirk to
function correctly. This fixes a but where double pressing numlock locks
up the device completely with need to replug the keyboard.

Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
Tested-by: Michael Niewöhner <linux@mniewoehner.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -209,6 +209,9 @@ static const struct usb_device_id usb_qu
 	/* Microsoft LifeCam-VX700 v2.0 */
 	{ USB_DEVICE(0x045e, 0x0770), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* Cherry Stream G230 2.0 (G85-231) and 3.0 (G85-232) */
+	{ USB_DEVICE(0x046a, 0x0023), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0841), .driver_info = USB_QUIRK_DELAY_INIT },


