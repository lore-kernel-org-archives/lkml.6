Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B1DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88402206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865365;
	bh=38mDG+AjzKqCzlfydXHZQg+lAqqr0BiqnNqBCPjrNwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nj2OU0CW1NYVX0AUvoKhtUlbJZ19qd0OeIAXu2dgmDlqjk96JyCs54QkDG9vag92m
	 vz+GeVECVXwvKa+sQouK+eqaMFH6L+PvRK3JPt7ZDFKiws1goiqv1oc1kCgjDBORaR
	 zaqc5j8CTEUZS8VFESL9Cw6SstDzG1vQbgAfWkls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfAGMtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfAGMtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B0B20651;
        Mon,  7 Jan 2019 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865359;
        bh=38mDG+AjzKqCzlfydXHZQg+lAqqr0BiqnNqBCPjrNwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WI72q5tGtxg9j3oKjq6SClfWItVbpe1yr2CRt82l90Z5OkvFJyU8pnffmUv2jEHPl
         DniZq8qcmUzAu+C5ljFlR51Ex8crWhDT8wCnzc+yr1crONlTwfgpQe1Z9ACDTRMgAc
         eYCIptXzAjuimxUY2g8hJFPw8vcrEb9SwpfZih0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 029/170] qmi_wwan: Add support for Fibocom NL678 series
Date:   Mon,  7 Jan 2019 13:30:56 +0100
Message-Id: <20190107104456.512319858@linuxfoundation.org>
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
@@ -1265,6 +1265,7 @@ static const struct usb_device_id produc
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2cb7, 0x0104, 4)},	/* Fibocom NL678 series */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */


