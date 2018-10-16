Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9045C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F0B21477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJb1aygx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F0B21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbeJQBPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:15:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBBAB2098A;
        Tue, 16 Oct 2018 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710638;
        bh=n6/QXmCFmJBzJtYhkDwf69glfd4UU1jNQ/+EziFdrzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJb1aygxkrvYNnIW645o74ZxfAubOs9IZeqzoK/r/LO9dFychBToV6oJzSMasm7Oh
         tZrCZVVz6NY8OHhHosdaJbLpqiiytd+TXFBei3t5C5acLQw/Rk37O5FR+0DwGhaIVm
         XQRuxf0m9gRLMz9T7ZHMtlpbMY9XpMvJQlGT8b9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giacinto Cifelli <gciofono@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 35/71] qmi_wwan: Added support for Gemaltos Cinterion ALASxx WWAN interface
Date:   Tue, 16 Oct 2018 19:09:32 +0200
Message-Id: <20181016170541.153390417@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giacinto Cifelli <gciofono@gmail.com>

[ Upstream commit 4f7617705bfff84d756fe4401a1f4f032f374984 ]

Added support for Gemalto's Cinterion ALASxx WWAN interfaces
by adding QMI_FIXED_INTF with Cinterion's VID and PID.

Signed-off-by: Giacinto Cifelli <gciofono@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -934,6 +934,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x0b3c, 0xc00b, 4)},	/* Olivetti Olicard 500 */
 	{QMI_FIXED_INTF(0x1e2d, 0x0060, 4)},	/* Cinterion PLxx */
 	{QMI_FIXED_INTF(0x1e2d, 0x0053, 4)},	/* Cinterion PHxx,PXxx */
+	{QMI_FIXED_INTF(0x1e2d, 0x0063, 10)},	/* Cinterion ALASxx (1 RmNet) */
 	{QMI_FIXED_INTF(0x1e2d, 0x0082, 4)},	/* Cinterion PHxx,PXxx (2 RmNet) */
 	{QMI_FIXED_INTF(0x1e2d, 0x0082, 5)},	/* Cinterion PHxx,PXxx (2 RmNet) */
 	{QMI_FIXED_INTF(0x1e2d, 0x0083, 4)},	/* Cinterion PHxx,PXxx (1 RmNet + USB Audio)*/


