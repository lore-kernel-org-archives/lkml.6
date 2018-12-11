Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C6C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99ADA20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543048;
	bh=NiTYgIS8z/Im6uk4pJxsUphEYulrrvlAjHVgikRwr98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bnxEFhyTvjCU5N/dGCf7zFdzqaqE0YyeUP1z5H+SQUz5eJIUpQ9z9oswkwlmGGm2j
	 TTBoQBcGc8lJ/WjPAZ3lAToMCtmC+AJS9jzXjZhdVfJm+BGMKaCpiB1SEB2KEECRmQ
	 Hcl9lcKIV/MNtIeO7sxgNwzEZ4aY+HyJJI2aTTf0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99ADA20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeLKPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbeLKPoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4B520870;
        Tue, 11 Dec 2018 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543046;
        bh=NiTYgIS8z/Im6uk4pJxsUphEYulrrvlAjHVgikRwr98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcNiRpistrSnRtZZML0OoH2EQHkoEaXwqQLYV5djglp+lkZ0PFAcE0Jb4f64GfKIm
         cEClEcGebMqZEHWGdbSx+9JNFA8zI5pTP8TKM2dS01EI79RjwoBGh1KOwr8YU0S0qY
         NXRxVBTXeV5PjVt3a7KwqpZJMZlKkJ3HchRuuWdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3.18 11/54] USB: usb-storage: Add new IDs to ums-realtek
Date:   Tue, 11 Dec 2018 16:40:59 +0100
Message-Id: <20181211151546.595484463@linuxfoundation.org>
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
@@ -38,4 +38,14 @@ UNUSUAL_DEV(0x0bda, 0x0159, 0x0000, 0x99
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


