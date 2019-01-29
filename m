Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFCE20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761860;
	bh=i+I51aoOZxnoku1V2DWmtbi5zZ49uhh3HO+U1WkU8DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0icfl+idwZhGau8BZ1LIStDbs8LcFhFmDbLmiwvTJSTEyp0+JyiWJM4M/n3gacyov
	 CSoUALf+Tfh09PibTuu212lrjzhR3+f6MPZSPbb56OYqRAjzQrtzTvt6GetrcEGKZZ
	 aLd28OWeLK7zsKlXvLXbbzSS3zTGP2llUCE0scLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfA2Lhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfA2Lhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089C820844;
        Tue, 29 Jan 2019 11:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761857;
        bh=i+I51aoOZxnoku1V2DWmtbi5zZ49uhh3HO+U1WkU8DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JL+vbJXZx+4+h2Hwbo8obQguOrbghWGfE3of6JDJ83xyWAY7yvxPx0Ox/9pAWRZtF
         ocibeivcWL+ZdjpFw1bh75HfLZhxj+LQ01g0dbVSOXUAS+UNaOJPIdmd8ZHxC1AVx6
         GRfZPvDnUJRYCUeNLpfbM5UuI4det0MbvC7Maumk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.20 024/117] mei: me: mark LBG devices as having dma support
Date:   Tue, 29 Jan 2019 12:34:35 +0100
Message-Id: <20190129113208.865155315@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 173436ba800d01178a8b19e5de4a8cb02c0db760 upstream.

The LBG server platform sports DMA support.

Cc: <stable@vger.kernel.org> #v5.0+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 73ace2d59dea..c2bf3e99955e 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -88,7 +88,7 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_2, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H, MEI_ME_PCH8_SPS_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_SPT_H_2, MEI_ME_PCH8_SPS_CFG)},
-	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH8_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_LBG, MEI_ME_PCH12_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_BXT_M, MEI_ME_PCH8_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_APL_I, MEI_ME_PCH8_CFG)},


