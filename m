Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F87C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165272070B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999792;
	bh=D0PAI3AM5KAq8V3mPMetl6GyKgT9yCR+W1c+8Qu4vyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y/wZqONOM/ssp7NaTmtyrdC0rHS1XBCtsMtkoyPsXlC2uHeLHQKcHWQQ/AWyHVvPQ
	 8o25s6OKslWyRI5HgpfQxfDVLFgLo2jjei7obHlkQeno5ZFrkLLej8LG89/a3SXZn5
	 379cj3QwqaObw93PFp8YPjZHllgRZqB+mv5ZMoRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeL1MO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731315AbeL1MOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:14:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B36672148E;
        Fri, 28 Dec 2018 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999292;
        bh=D0PAI3AM5KAq8V3mPMetl6GyKgT9yCR+W1c+8Qu4vyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVr/juI/aTT/OPyP0PWdZQb32MZVMfpqbjo3k7Bz5X3zSU0J39Aj5cv85K5iJnzYn
         TzOcptJE/yW0FyIoCqm3ZQwwvU7Ug15WvgJj20OG9b0Q5BYBV0m+YvSkr3fu94geCM
         3DWH8cciY8SaAtNM4tPPAXphUFVpzwMbSYCIajZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ihab Zhaika <ihab.zhaika@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.19 38/46] iwlwifi: add new cards for 9560, 9462, 9461 and killer series
Date:   Fri, 28 Dec 2018 12:52:32 +0100
Message-Id: <20181228113127.111816281@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
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

From: Ihab Zhaika <ihab.zhaika@intel.com>

commit f108703cb5f199d0fc98517ac29a997c4c646c94 upstream.

add few PCI ID'S for 9560, 9462, 9461 and killer series.

Cc: stable@vger.kernel.org
Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -518,6 +518,56 @@ static const struct pci_device_id iwl_hw
 	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8265_2ac_cfg)},
 
 /* 9000 Series */
+	{IWL_PCI_DEVICE(0x02F0, 0x0030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0038, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x003C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0060, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x023C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0260, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x0264, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x02A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x2034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x02F0, 0x42A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0038, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x003C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0060, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0064, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x00A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x00A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0230, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0238, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x023C, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0260, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x0264, iwl9461_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x02A0, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x02A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x1551, iwl9560_killer_s_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x1552, iwl9560_killer_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x2030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x2034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4030, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4034, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x40A4, iwl9462_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x4234, iwl9560_2ac_cfg_soc)},
+	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x0010, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0014, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0018, iwl9260_2ac_cfg)},


