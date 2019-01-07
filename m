Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71949C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7620859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865359;
	bh=SVfGuiry9K3kc7cbG2J51uux1c3uovvIGGqJpKO5gMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mBa7FRby9Tki74h1G6QBikIqCmso25ZNyymsPf5DawPtAAY+FQ1B+OedZAKdCRpDf
	 xhccdMIamVbMeJPAzVYo9/HFc+9r0CNXxhPIVexh85P65oY6chvfJ8Aa4jRcsI6jxq
	 fxJuHx3dQ8yKQJP1E0YiQ0ZcKcG8NawHofb3v6Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfAGMtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbfAGMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8D6206BB;
        Mon,  7 Jan 2019 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865349;
        bh=SVfGuiry9K3kc7cbG2J51uux1c3uovvIGGqJpKO5gMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vVAQKYkABGHBKzEZVz6dQy8NkQJ3Ub4dDMVuFXijvp7Y8yEw1BZ9xsSOKeJwAAAan
         n8l7Ckt5s583IGj0xrLYwhwEp05msCnKmZXkJEJK0RTXePBga0zRqN2+dwnYq+o5i0
         arKOQwKxF02u1NAHNtoZDchwMv+3BdTMvJGkIEho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 027/170] qmi_wwan: Added support for Fibocom NL668 series
Date:   Mon,  7 Jan 2019 13:30:54 +0100
Message-Id: <20190107104456.283149405@linuxfoundation.org>
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
@@ -1117,6 +1117,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1435, 0xd181, 4)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd181, 5)},	/* Wistron NeWeb D18Q1 */
 	{QMI_FIXED_INTF(0x1435, 0xd191, 4)},	/* Wistron NeWeb D19Q1 */
+	{QMI_QUIRK_SET_DTR(0x1508, 0x1001, 4)},	/* Fibocom NL668 series */
 	{QMI_FIXED_INTF(0x16d8, 0x6003, 0)},	/* CMOTech 6003 */
 	{QMI_FIXED_INTF(0x16d8, 0x6007, 0)},	/* CMOTech CHE-628S */
 	{QMI_FIXED_INTF(0x16d8, 0x6008, 0)},	/* CMOTech CMU-301 */


