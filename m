Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F74C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E178721736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866074;
	bh=wCG6wpE9PN9P3bLOtHejkDTlNNVQFM+qFPy9SasVbNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08y5vMQCIqPKxipEI6FNmUv2jTybdL3JolxBGvUyfg3Q5WypVUIs9LeyphDKeIYwi
	 3z69P4OvEsObFQ3eIHpSuGpu8PHH8WJTa/6iqfWLntei5mdnb6Ni53ueJI2TlqQNJ9
	 MxfIdmr32WIbO6b7J6Gyonugoacvxadwtc8csqgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfAGNBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730544AbfAGNBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:01:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE26C2089F;
        Mon,  7 Jan 2019 13:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866068;
        bh=wCG6wpE9PN9P3bLOtHejkDTlNNVQFM+qFPy9SasVbNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pU0LI4/F24qYGLQaseYHq6Io3+M8UZraJp7L4wSj+1qud30YQwkiTW0yRNt5SuPFZ
         CnoETeK4dXEXKqFJTxDeX7CAPuMfemSJ8pXYLhGt8jD5CkHuxcRNS6Kt9uzcMw81oO
         hABHM0cMEtiGZCrh8wPEcai8cZlB4gyI+Hcsvvpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 034/101] qmi_wwan: Add support for Fibocom NL678 series
Date:   Mon,  7 Jan 2019 13:32:22 +0100
Message-Id: <20190107105334.787018519@linuxfoundation.org>
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

[ Upstream commit 7c3db4105ce8d69bcb5c04bfa9acd1e9119af8d5 ]

Added support for Fibocom NL678 series cellular module QMI interface.
Using QMI_QUIRK_SET_DTR required for Qualcomm MDM9x40 series chipsets.

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1258,6 +1258,7 @@ static const struct usb_device_id produc
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0306, 4)},	/* Quectel EP06 Mini PCIe */
+	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */


