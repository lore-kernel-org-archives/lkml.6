Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120032173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866029;
	bh=vqXQqaBfTDGqFFYKA6aUlhxE5VqIz7BEEr6K6w55SCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tuC9YQ3D2aoqu92+RWPD0N+2H5UGBZP3XDs8jji1hSuqWbG20hLg24PN0hWq766FT
	 bV7LGYlg9dYD+zicvrQD1drIGwEBFg6YhG4eUp4x+EfQoHxi3/pCm8P/trKA/L2jpF
	 B3xX7ni/PSO3wHra6WxJURjtzvt0iZKXYB7EjqcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfAGNA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730208AbfAGNAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801CA2089F;
        Mon,  7 Jan 2019 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866021;
        bh=vqXQqaBfTDGqFFYKA6aUlhxE5VqIz7BEEr6K6w55SCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bd18+33Naguqo+MxpHZjNY0Tq/tppYLF42bJDEZh2MDyRzgwI8LtNawTAe/NCJ9tk
         KJHmHwfH3XFLCFgMuPmz/+WGeNF513r1buV1sGYr9256I9y0DjjwBCTEfk0OUr7Ujb
         ZSo/zggaHX44bvkSHGlwjLlaTNC7CkCDhmdWELCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 020/101] qmi_wwan: Added support for Telit LN940 series
Date:   Mon,  7 Jan 2019 13:32:08 +0100
Message-Id: <20190107105334.056192068@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jörgen Storvist <jorgen.storvist@gmail.com>

[ Upstream commit 1986af16e8ed355822600c24b3d2f0be46b573df ]

Added support for the Telit LN940 series cellular modules QMI interface.
QMI_QUIRK_SET_DTR quirk requied for Qualcomm MDM9x40 chipset.

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1221,6 +1221,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1201, 2)},	/* Telit LE920, LE920A4 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */


