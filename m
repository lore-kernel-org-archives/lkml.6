Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAADEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814D22086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762725;
	bh=evI7+zUqRjrRcRJznoDWf8i9N1bIT/nC5a3KA0Bd6Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MraZhwKeFZ88aerAOh2vbiiip8WPWA5lJ2Guu8Zj8HwTHz5J+6GOkok/mj+rPCi4m
	 9NPrPyK53rtkWGwv/u9c6txwJEkq7reGSvyAhPQCTamSobGY+LIVEOCC4vs+b+1cnt
	 ApQjG2FXmKXySCr8jgByxYM56O25gvN33sQFYivg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfA2LwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:52:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbfA2LwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:52:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7762083B;
        Tue, 29 Jan 2019 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762721;
        bh=evI7+zUqRjrRcRJznoDWf8i9N1bIT/nC5a3KA0Bd6Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W661MQdhzxOAL8+jfN20jKLfIxOw38cK46E4cM3sF3oS581RtZSQSeqb2WU1bgjOG
         otCmNIwbdEf3nc4JEtUFThezjWdYPd9q/ZVzgfwST3ynO6i/JpJMVqsoacBRFGCRfi
         hJIx8osXLNceLaKOZVg7QPaRqaSA3ryWR4XReIGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 4.9 18/44] staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1
Date:   Tue, 29 Jan 2019 12:36:13 +0100
Message-Id: <20190129113141.453490445@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -43,6 +43,7 @@ static struct usb_device_id rtw_usb_id_t
 	{USB_DEVICE(0x2001, 0x330F)}, /* DLink DWA-125 REV D1 */
 	{USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */
+	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */


