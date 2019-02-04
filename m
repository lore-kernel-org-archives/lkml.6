Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0982C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0FF214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276718;
	bh=0kF7HDsvcSUSsHxDdCH7/nim6E063HjH4bAeC1Kxb0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pihBdAP0FEpHIfbDTxOxRttQT6LGrn1lVbT2K/Z8rmlT0beae05LjfRQA052IfaFu
	 SEmHTtX2sl51szaOn0sd75UncXmfi3FmkKeq3qnyDZJYavg7NzCNvnW/tfgGJMXvrG
	 8Gs3ZhoUGMp9c8WPm8572+fu5EWxAntRzZzNVz/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfBDKih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729404AbfBDKig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:38:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEA72070C;
        Mon,  4 Feb 2019 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276715;
        bh=0kF7HDsvcSUSsHxDdCH7/nim6E063HjH4bAeC1Kxb0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQm14Xl/hvwj56YDQmhGjjuCg/NnfHSe2toL5+pgcUlMS/wOqRNh9UzjfLsyXUYUo
         hgaqkYVyjB5S8eCaQ54nZUEoCtE89/bVN1O9XWrCNcJlJIZAjbBNjiQxyh4DZ4PZyG
         qvX7YK+ZJgEK4i8Ns18YKRquR8kwsGGSZ5AcDSZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3.18 05/31] staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1
Date:   Mon,  4 Feb 2019 11:36:20 +0100
Message-Id: <20190204103559.080498093@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -48,6 +48,7 @@ static struct usb_device_id rtw_usb_id_t
 	{USB_DEVICE(0x2001, 0x330F)}, /* DLink DWA-125 REV D1 */
 	{USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */
+	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */


