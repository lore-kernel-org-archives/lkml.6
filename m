Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17441C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D148D20877
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D148D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933738AbeGFFty (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:49:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933709AbeGFFtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:49:51 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F13E386A;
        Fri,  6 Jul 2018 05:49:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karoly Pados <pados@pados.hu>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 03/61] USB: serial: cp210x: add Silicon Labs IDs for Windows Update
Date:   Fri,  6 Jul 2018 07:46:27 +0200
Message-Id: <20180706054712.459125045@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karoly Pados <pados@pados.hu>

commit 2f839823382748664b643daa73f41ee0cc01ced6 upstream.

Silicon Labs defines alternative VID/PID pairs for some chips that when
used will automatically install drivers for Windows users without manual
intervention. Unfortunately, these IDs are not recognized by the Linux
module, so using these IDs improves user experience on one platform but
degrades it on Linux. This patch addresses this problem.

Signed-off-by: Karoly Pados <pados@pados.hu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -157,8 +157,11 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8B34) }, /* Qivicon ZigBee USB Radio Stick */
 	{ USB_DEVICE(0x10C4, 0xEA60) }, /* Silicon Labs factory default */
 	{ USB_DEVICE(0x10C4, 0xEA61) }, /* Silicon Labs factory default */
+	{ USB_DEVICE(0x10C4, 0xEA63) }, /* Silicon Labs Windows Update (CP2101-4/CP2102N) */
 	{ USB_DEVICE(0x10C4, 0xEA70) }, /* Silicon Labs factory default */
 	{ USB_DEVICE(0x10C4, 0xEA71) }, /* Infinity GPS-MIC-1 Radio Monophone */
+	{ USB_DEVICE(0x10C4, 0xEA7A) }, /* Silicon Labs Windows Update (CP2105) */
+	{ USB_DEVICE(0x10C4, 0xEA7B) }, /* Silicon Labs Windows Update (CP2108) */
 	{ USB_DEVICE(0x10C4, 0xF001) }, /* Elan Digital Systems USBscope50 */
 	{ USB_DEVICE(0x10C4, 0xF002) }, /* Elan Digital Systems USBwave12 */
 	{ USB_DEVICE(0x10C4, 0xF003) }, /* Elan Digital Systems USBpulse100 */


