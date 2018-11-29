Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0CBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4152321019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zwh4z+MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4152321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeK2RDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:03:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeK2RDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:30 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D4D21104;
        Thu, 29 Nov 2018 05:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471160;
        bh=MZx7sEqYq7f/8NRXbVinBynqyxycWcTUl18acKqFgJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwh4z+MFwS+9+pbLv9eIUEg6Na0/zgMldE3WsvcPJ304gpmJyo4f+pz6r/aU+bAU5
         7MhWwU/r832fCrFFLdJdE81jt0d4lyr5FwLqRpeIhlIGBX61l3FPDQgAFW/OIFIwLp
         dYhpcoxc3OPJIL/4JYB8KSHaQ94cnvoS4cM0osTs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 40/68] ALSA: hda/ca0132 - Add new ZxR quirk
Date:   Thu, 29 Nov 2018 00:55:31 -0500
Message-Id: <20181129055559.159228-40-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor McAdams <conmanx360@gmail.com>

[ Upstream commit cce997292a5264c5342c968bbd226d7c365f03d6 ]

This patch adds a new PCI subsys ID for the ZxR, as found and tested by
other users. Without a way to know if any Z's use it as well, it keeps
the quirk of QUIRK_SBZ and goes through the HDA subsys test function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index dffd60cebc31..cc2bb0057810 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1065,6 +1065,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
+	SND_PCI_QUIRK(0x1102, 0x0033, "Sound Blaster ZxR", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
-- 
2.17.1

