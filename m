Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAE0208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAE0208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbeIXSTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:19:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbeIXSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:19:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D46BD107E;
        Mon, 24 Sep 2018 12:17:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Roux <xpros64@hotmail.fr>
Subject: [PATCH 4.14 092/173] USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB controller
Date:   Mon, 24 Sep 2018 13:52:06 +0200
Message-Id: <20180924113122.818601365@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxence Duprès <xpros64@hotmail.fr>

commit 9b83a1c301ad6d24988a128c69b42cbaaf537d82 upstream.

WORLDE Controller KS49 or Prodipe MIDI 49C USB controller
cause a -EPROTO error, a communication restart and loop again.

This issue has already been fixed for KS25.
https://lore.kernel.org/patchwork/patch/753077/

I just add device 201 for KS49 in quirks.c to get it works.

Signed-off-by: Laurent Roux <xpros64@hotmail.fr>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -37,6 +37,10 @@ static const struct usb_device_id usb_qu
 	/* CBM - Flash disk */
 	{ USB_DEVICE(0x0204, 0x6025), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* WORLDE Controller KS49 or Prodipe MIDI 49C USB controller */
+	{ USB_DEVICE(0x0218, 0x0201), .driver_info =
+			USB_QUIRK_CONFIG_INTF_STRINGS },
+
 	/* WORLDE easy key (easykey.25) MIDI controller  */
 	{ USB_DEVICE(0x0218, 0x0401), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },


