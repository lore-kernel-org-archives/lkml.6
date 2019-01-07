Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088D02089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866070;
	bh=fp5NOO8fo0WrB0bgMTBycfyDhloiPGRgM6pqcDuaRn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foHPqxYR7CannULGrZRG2Y4xdOj/oo3AvN+d6TGxrImbjAbwruaZ3X7HtcaZi+3A+
	 1kz2VV2LxltsuzogIF64kPhM2UIz4l+gUIsLbzHVa9I5csqd79PPEDNp9YiYGlHnU4
	 8cTjFYfyyadWUBOFWBusI9qbMdB7qE5wt7raPLAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfAGNBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730525AbfAGNBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DFF2173C;
        Mon,  7 Jan 2019 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866065;
        bh=fp5NOO8fo0WrB0bgMTBycfyDhloiPGRgM6pqcDuaRn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0mdWtboixAlwNNdI5iT0TYWgSb8X9OShRFcHdfPbM080n6LrFtAhcWSGdaBaHdBz
         Ss8g7gyVzDbRISYs/ggrLGb+zb3oI9KrstqEvDWblSeAlXbmnT6AEyH5k+DHfhq1M2
         ItYXhp90QZueJ4FFLQQ4dMKhiRXrTMNlU6C9Zshw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 033/101] qmi_wwan: Added support for Fibocom NL668 series
Date:   Mon,  7 Jan 2019 13:32:21 +0100
Message-Id: <20190107105334.707537726@linuxfoundation.org>
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

[ Upstream commit 110a1cc28bc383adb4885eff27e18c61ddebffb4 ]

Added support for Fibocom NL668 series QMI interface.
Using QMI_QUIRK_SET_DTR required for Qualcomm MDM9x07 chipsets.

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1109,6 +1109,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1435, 0xd181, 3)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 5)},	/* Wistron NeWeb D18Q1 */
+	{QMI_QUIRK_SET_DTR(0x1508, 0x1001, 4)},	/* Fibocom NL668 series */
 	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
 	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
 	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */


