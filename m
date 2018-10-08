Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9D1C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD7F21569
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxXh2iTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD7F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeJHWop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeJHWjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C2821526;
        Mon,  8 Oct 2018 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012405;
        bh=Wg/BHAzT2OW+9OlLn0myhvQFzLTS2irD4M4dOEm49c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxXh2iTVJDoJGgspXK/HmJxT16dGnhBxPPosQeY040+e7BiCBmp2duw+jf1XUphnS
         Q2C5ZRTMobYs1ksDwWReWMmczUfmeuK/2cPT3miXP+/BMOdhUUIC4v8EL5eriU+Iku
         3RCMLVVCLUkcqahr8utJJvZpiNfUHHjFEk7buIa4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 16/32] intel_th: pci: Add Ice Lake PCH support
Date:   Mon,  8 Oct 2018 11:26:13 -0400
Message-Id: <20181008152629.70812-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

[ Upstream commit 59d08d00d43c644ee2011d7ff1807bdd69f31fe0 ]

This adds Intel(R) Trace Hub PCI ID for Ice Lake PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index c2a2ce8ee541..ef699477d94a 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -168,6 +168,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x18e1),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Ice Lake PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x34a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 
-- 
2.17.1

