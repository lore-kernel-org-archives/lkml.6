Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17C62082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBrtRGz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17C62082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeLDLLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbeLDLIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C01214DA;
        Tue,  4 Dec 2018 11:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921731;
        bh=f5Nw+lv/EtCS9RZqrVyxNA0JctRhwpkQrsZn2O9NMLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBrtRGz5JkNb08prYaXUoj4Yb5uf00MSLJwdmIbZpBxUq3VRBQNPP3R0JAl8M8cBP
         dkfmbX9wcfD9iDmgn51+hxpf11HR7FjR3riEr03rxn/B4I/3dtW50QktFXpNUKUnhq
         crjjNwl8i6WtcniKVaYiFXMiJ8y0sawjEsFlLza8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.9 36/50] USB: usb-storage: Add new IDs to ums-realtek
Date:   Tue,  4 Dec 2018 11:50:31 +0100
Message-Id: <20181204103716.308106131@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit a84a1bcc992f0545a51d2e120b8ca2ef20e2ea97 upstream.

There are two new Realtek card readers require ums-realtek to work
correctly.

Add the new IDs to support them.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/unusual_realtek.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/usb/storage/unusual_realtek.h
+++ b/drivers/usb/storage/unusual_realtek.h
@@ -39,4 +39,14 @@ UNUSUAL_DEV(0x0bda, 0x0159, 0x0000, 0x99
 		"USB Card Reader",
 		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
 
+UNUSUAL_DEV(0x0bda, 0x0177, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
+UNUSUAL_DEV(0x0bda, 0x0184, 0x0000, 0x9999,
+		"Realtek",
+		"USB Card Reader",
+		USB_SC_DEVICE, USB_PR_DEVICE, init_realtek_cr, 0),
+
 #endif  /* defined(CONFIG_USB_STORAGE_REALTEK) || ... */


