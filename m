Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D350C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C576120870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545275;
	bh=FBh+eRx0uq+EhrOC+64Ttv7E6TALjqbDpgCj5izm9eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFeVwR52RmAv1mMZy+OlZi1t3mfQf04oc+8Gbe2IX9tHKSIR3tDPUIXqf2Lqr/7r4
	 3l4jUHQA7mL7vupayKBx+meNXIt61VxHtfHtYcCYBJEJ4sDWqH+Qqv4uVGzpz1rS+b
	 zm6rvjzAjhUzq5MOAZ1VlbVGElnKaVIA7A/aUxiw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C576120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeLKQVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:21:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbeLKPof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FAA2082F;
        Tue, 11 Dec 2018 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543074;
        bh=FBh+eRx0uq+EhrOC+64Ttv7E6TALjqbDpgCj5izm9eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHqRKwjURNqOvFIaW6MMVP3ay0a3flTPxGnO2KY2ZEp2E/mkln2Bk56+Nw3XZCpXR
         on/sbmPJF34QE++dpp3BO3g9CrEMyYyrIzcjNmoUcfGyu0pTMdCDTgVYqOUP36q2HW
         CAjYjjF2FIbYZe0tEV68njp5wkTH+0JMRRYuKYkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Johan Hovold <johan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 50/54] USB: serial: option: add device ID for HP lt2523 (Novatel E371)
Date:   Tue, 11 Dec 2018 16:41:38 +0100
Message-Id: <20181211151548.873671412@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

[ Upstream commit 5d03a2fd2292e71936c4235885c35ccc3c94695b ]

Yet another laptop vendor rebranded Novatel E371.

Cc: stable@vger.kernel.org
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/option.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 9db1338002a2..a8d2dd812a7d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2042,6 +2042,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD200, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.19.1



