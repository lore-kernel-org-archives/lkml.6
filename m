Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583B4214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCAuTaMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583B4214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeJYWxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731241AbeJYWxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:51 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25819208A3;
        Thu, 25 Oct 2018 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477253;
        bh=jyV9qLKk8ZiwGexiD4AHT1o5VMGOt76OdH54pkoIlXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCAuTaMhei0M3dUpAa+g76bFpGYzshJee9Gw3JYflye4CZbw0HTWrg/IXeV7bqqQY
         Qi+JsIG7j2HiUPdKpqH4XjtGmcsfp6M79QwtshSD4pTmfUbFDeowpmzIZAEQ2daWs5
         UkMeK9nRaV+Z/RVS1kwqhxMQegjowPSMURGj/Y7E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Sylwestrzak <matisec7@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 78/98] ALSA: hda - Add headset mic support for Acer Aspire V5-573G
Date:   Thu, 25 Oct 2018 10:18:33 -0400
Message-Id: <20181025141853.214051-78-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Sylwestrzak <matisec7@gmail.com>

[ Upstream commit 0420694dddeb9e269a1ab2129a0119a5cea294a4 ]

Acer Aspire V5 with the ALC282 codec is given the wrong value for the
0x19 PIN by the laptop's BIOS. Overriding it with the correct value
adds support for the headset microphone which would not otherwise be
visible in the system.

The fix is based on commit 7819717b1134 with a similar quirk for Acer
Aspire with the ALC269 codec.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96201
Cc: <stable@vger.kernel.org>
Signed-off-by: Mateusz Sylwestrzak <matisec7@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fd3bbcf317ee..c32d51d51b3e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5185,7 +5185,7 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x14, 0x90170110 },
 			{ 0x17, 0x40000008 },
 			{ 0x18, 0x411111f0 },
-			{ 0x19, 0x411111f0 },
+			{ 0x19, 0x01a1913c },
 			{ 0x1a, 0x411111f0 },
 			{ 0x1b, 0x411111f0 },
 			{ 0x1d, 0x40f89b2d },
-- 
2.17.1

