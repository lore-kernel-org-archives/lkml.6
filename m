Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52E520651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865441;
	bh=27zeDSdaXrk7UO+lisfSV3iaMbT5C7/rPJqn2m2KQKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ITrWHpRHy8dsGuN56oxJBLx5A/fDvSv09QoCpo+HI07GJOTgleAeqbg8dpitoAC6P
	 1d0LLj4ZmbuE8rS25URIopnU/gMor/Xa0rFcPpnaGt6ufvyw746vruJ+uZ/2Edo5ul
	 ZaIY56jhxWJGbIXYglnSgBZmT8a4gdKbAEHRVKLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfAGMtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729403AbfAGMtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC13206BB;
        Mon,  7 Jan 2019 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865352;
        bh=27zeDSdaXrk7UO+lisfSV3iaMbT5C7/rPJqn2m2KQKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Cdzm2shvhwPJZlWOHJF1KSzIEeHhX5I5Vt62sYQ0S7xUJvtgz5Y8tT8sbD3M3bU8
         FprRAHUQk9zbx/Z8QVEy0vg/SZrYhvTK/2zdXuV9KLve3z2zkCj64w4nRxcsuG9df5
         IPFy87ZSym0OComfawgAKg4/iM24rQEHZkfIa9zA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 028/170] qmi_wwan: Added support for Telit LN940 series
Date:   Mon,  7 Jan 2019 13:30:55 +0100
Message-Id: <20190107104456.382670211@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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
@@ -1230,6 +1230,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1201, 2)},	/* Telit LE920, LE920A4 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */


