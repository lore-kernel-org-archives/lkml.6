Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DC621852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762462;
	bh=AnYbM2cZqJvZwpjG56qOT0ymP9juDsf/kj5NSds8tw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MdeBxxybkJtlHkvRih9XMQJJcoYkD7lyBvi7jLPj5ROixiey1qnfiOELIUcXTXxkn
	 ljC3pqVht0ci/jHLIYm+ABlMLJyWvVambWQ0IUnMblq/CfksUtSMZTGmU5jvLYHEdL
	 /R+2nl1l0J4LHMzg1XlqRD1ONN+mCX8OGiwvo0yY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbfA2Lrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfA2Lrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:47:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FD72086C;
        Tue, 29 Jan 2019 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762458;
        bh=AnYbM2cZqJvZwpjG56qOT0ymP9juDsf/kj5NSds8tw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGZTZEsywyzgzVLx3CzPa3Gzt6wjFpXS4ApOWCra90onIzSxAAvAiRxtvscYRfNW0
         7YBMHWeUdPN/rMGhzTHSutAk2+fw7sbIfztd1+oRQN1KJHqfHn2AXDJxsHYxLUk8De
         hJBDPO2F2OSEBQpwB0cEl3blNtk1BsYMWMJA/Yzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 4.14 12/68] mei: me: add denverton innovation engine device IDs
Date:   Tue, 29 Jan 2019 12:35:34 +0100
Message-Id: <20190129113132.593081628@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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


