Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA32C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543653;
	bh=abefNrNhV/hdAdhZ0mPDAGoo5xCDc87Iv9S3hLLr5Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UmjrlhqJTJXlQGy4lWKxqajrGmmoBCFWPY+VFllfnps558VzSME8vihtbx05KktAC
	 iDB7Le1JPUe6+/bUDmN8PuQZjgCtaJEAR+X4NtNzromc/Ii74CrC+ReyDmtgpFRHRq
	 3MI4hy9a0uoFY4EkHqgteicPPk91k1lJq50FdIeY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0C02146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeLKPyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbeLKPyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D0FB2087F;
        Tue, 11 Dec 2018 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543646;
        bh=abefNrNhV/hdAdhZ0mPDAGoo5xCDc87Iv9S3hLLr5Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m55nfLh7PuUBnKFocVkTbNx6C5zzXpQFXOvlF89NqA9k1mKyOvOXTKM2m4dLG2Vkb
         qEnC71fHZJMpZPqxH3Ua/HVMOayhTzWhHvkOEPLtuCFGu/UV1Pjfke+RJY/9v9BWBD
         2PijSKskufbyat5Vpr9vB7p80ZfIDLgo4FsXZSKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Martin Elshuber <martin.elshuber@theobroma-systems.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/118] can: ucan: remove set but not used variable udev
Date:   Tue, 11 Dec 2018 16:40:29 +0100
Message-Id: <20181211151644.642333539@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

[ Upstream commit 207681fc5f3d5d398f106d1ae0080fc2373f707a ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/can/usb/ucan.c: In function 'ucan_disconnect':
drivers/net/can/usb/ucan.c:1578:21: warning:
 variable 'udev' set but not used [-Wunused-but-set-variable]
  struct usb_device *udev;

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/ucan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38b1af4..c9fd83e8d947 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1575,11 +1575,8 @@ err_firmware_needs_update:
 /* disconnect the device */
 static void ucan_disconnect(struct usb_interface *intf)
 {
-	struct usb_device *udev;
 	struct ucan_priv *up = usb_get_intfdata(intf);
 
-	udev = interface_to_usbdev(intf);
-
 	usb_set_intfdata(intf, NULL);
 
 	if (up) {
-- 
2.19.1



