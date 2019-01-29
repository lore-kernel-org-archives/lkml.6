Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D70DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420BE2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762251;
	bh=CewEtcIuvGBsCsNgwAEpzSedjxy1b/q3HLwU0AVy+Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QQuahdHwyoAW+IkymaZtvrZi0koZ3HqSZzcJTX9tFytBlNGwA7s8lML2XiAvBaHzP
	 aVaVA23j/v7BueF0RxNPX7+LnmcbXqF21ByR/1C7J6lfDDkaAVsyBhDX9x7Z06QImr
	 6AJa30+XsVJNWE3U26Uda9mZxaZAZZCW8T8q6kH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbfA2LoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbfA2LoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:44:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E262083B;
        Tue, 29 Jan 2019 11:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762246;
        bh=CewEtcIuvGBsCsNgwAEpzSedjxy1b/q3HLwU0AVy+Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yx9SsozEK95nIG3k0twrijW7QRkRUzOCWcYrVnVjazY9aNDNFoVjU/P9PxiIkT5JZ
         06FoDD/dOwdu0hJG9dPCjtYMEqR8cmE3t1qiOWm0U77yh2INN+g6FvjvTu4IBrsulg
         zM5QxCSOkVAmnWf4tVG7rIBWMLVFaVmoogx+N48c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 4.19 023/103] mei: me: add denverton innovation engine device IDs
Date:   Tue, 29 Jan 2019 12:35:00 +0100
Message-Id: <20190129113200.956132294@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: Tomas Winkler <tomas.winkler@intel.com>

commit f7ee8ead151f9d0b8dac6ab6c3ff49bbe809c564 upstream.

Add the Denverton innovation engine (IE) device ids.
The IE is an ME-like device which provides HW security
offloading.

Cc: <stable@vger.kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    2 ++
 drivers/misc/mei/pci-me.c     |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -127,6 +127,8 @@
 #define MEI_DEV_ID_BXT_M      0x1A9A  /* Broxton M */
 #define MEI_DEV_ID_APL_I      0x5A9A  /* Apollo Lake I */
 
+#define MEI_DEV_ID_DNV_IE     0x19E5  /* Denverton IE */
+
 #define MEI_DEV_ID_GLK        0x319A  /* Gemini Lake */
 
 #define MEI_DEV_ID_KBP        0xA2BA  /* Kaby Point */
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -93,6 +93,8 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_BXT_M, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_DNV_IE, MEI_ME_PCH8_CFG)},
+
 	{MEI_PCI_DEVICE(MEI_DEV_ID_GLK, MEI_ME_PCH8_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_KBP, MEI_ME_PCH8_CFG)},


