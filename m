Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAABAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B41020863
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfBGPkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:40:35 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36901 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGPke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:40:34 -0500
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2019 10:40:33 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 556741A414C;
        Thu,  7 Feb 2019 16:31:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkn541.domain.local (unknown [10.31.10.124])
        by mail.rt-rk.com (Postfix) with ESMTPSA id 0E3131A2176;
        Thu,  7 Feb 2019 16:31:21 +0100 (CET)
From:   Jurica Vukadin <jurica.vukadin@rt-rk.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Jurica Vukadin <jurica.vukadin@rt-rk.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Dennis Wassenberg <dennis.wassenberg@secunet.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Park Ju Hyung <qkrwngud825@gmail.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda - Add quirk for HP EliteBook 840 G5
Date:   Thu,  7 Feb 2019 16:29:37 +0100
Message-Id: <20190207152938.3596-1-jurica.vukadin@rt-rk.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables mute LED support and fixes switching jacks when the laptop
is docked.

Signed-off-by: Jurica Vukadin <jurica.vukadin@rt-rk.com>
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexan=
t.c
index 152f54137082..a4ee7656d9ee 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -924,6 +924,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] =3D=
 {
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK)=
,
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK)=
,
+	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK)=
,
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK)=
,
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
--=20
2.20.1

