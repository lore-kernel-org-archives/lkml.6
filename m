Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B4DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2964320882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762269;
	bh=/9uHdx9ZaBevq42RDeuCYUMKz4tGPtuN7DJxgJgk1ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wM4zRaHQzbgDge+Aj7nY/p+mhd9+Hd+twyv3AW5jbpGnfQi1LQ9HCxBfQMLxV3Q5s
	 jvUAZUao/isSCdI3PiQfHkuGkay8xNtvBqimmvrZuII92IaXlRv4UEzdRUyzv/CuoN
	 7PFNBTLEPUVb18hEwHEFFJg0YiN59/8QwbNpEf3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfA2Lo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729985AbfA2LoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 006D62083B;
        Tue, 29 Jan 2019 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762262;
        bh=/9uHdx9ZaBevq42RDeuCYUMKz4tGPtuN7DJxgJgk1ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xi3hrkwNY4OcI8j4aprjG8TgiGM7vbmhA009HSTXobUvsoSA6o2Op0lNqjUZpKJFg
         YNxBjZzPdJzUsjO5QmZr0reEBaEX8rOlDlVFMlCpAkbJAtZzVu7sP4KneAXDRrOrzu
         0tPbP6doop+3pLWRqiKB3yABJ2KgCSyh1NbksfJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4.19 046/103] staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1
Date:   Tue, 29 Jan 2019 12:35:23 +0100
Message-Id: <20190129113202.250401635@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: Michael Straube <straube.linux@gmail.com>

commit 5f74a8cbb38d10615ed46bc3e37d9a4c9af8045a upstream.

This device was added to the stand-alone driver on github.
Add it to the staging driver as well.

Link: https://github.com/lwfinger/rtl8188eu/commit/a0619a07cd1e
Signed-off-by: Michael Straube <straube.linux@gmail.com>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -35,6 +35,7 @@ static const struct usb_device_id rtw_us
 	{USB_DEVICE(0x2001, 0x330F)}, /* DLink DWA-125 REV D1 */
 	{USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */
+	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */


