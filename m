Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E75C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709402082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709402082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeLJUzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:55:37 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:47127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbeLJUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:55:34 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MryKp-1hHusn2Rt7-00nyn0; Mon, 10 Dec 2018 21:54:48 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/ca0132 - make pci_iounmap() call conditional
Date:   Mon, 10 Dec 2018 21:54:25 +0100
Message-Id: <20181210205445.2913413-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F4RDkWOdHd/Trvm9PYXyPHgh1AWbnLIVcutmzHJWoa1WND9rUTB
 g3h2yvlDzxCeMvXeLCBjyEQ0BR2w3QaJ7yxJPS5Ceg+50FH8n+I49MPmuOpJoW0ahnOao+x
 Pr0aF2CJ1k8TlPDoMFSTiDqRDvBBd3hvb6+Ql2Y9evFRVSV8pvPcmKXWwCCgEPSqVIoQGQp
 L/Wufo/qQdsMP3nBn7nRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mMzYYV3G32c=:up9mTc/mS2SmLgM2fa1OKu
 KY4ORKlrNHMD8KRVFuWui4tF8o4XPB9ot3L7EN+X3jaKO4lth/NaO4oFAkGBGN9QAZqNW0piW
 xSWAXWLwQATS5cSfOB9oDJQQV4gznI82DK8BSf4tXTEOqpM+pGjjYY4QsfFT6TM7YnqAi50QS
 cugq3FtuwKS2Ip3eYIHEPRRLSQCjj+zDEEie9BgEHUFPXK1eMxQRnwXTuzpsKh6+qfDId0so7
 uxlje3fLAdhVi/+fcBpxhaQs8Fs7L05SPpOwSbG4Lpl/xdb8rTdwpthjg/tSLhLuHEDKJx4k/
 ABW8I+QUYO/VErEAzeg84N/yH9dKpuCRhexUdCNZwK16KffjvDELlNl2DA5wdfAdjcEDa2gVP
 /Xss1gDhCjzXtDEYNXGeybaalmLzC0I5ZitSIyPz7lmXsS+GbA9mw7thhqQcGqQfQHR/J2g4t
 PliaYdTZ65D8PN+ZIZ9tOYgXcRP9k+01yOjrzyMcZkULf/ql+hS4KNgxbzRYbJ7ENStjWGQEZ
 GDIJL2X6rmDifSn0mnFkOQFXVnrGoKWz9InIow9Iu53O25OCBWRLBs4INfRKAnSpiK15ahiDY
 L4gzS/DxalL1U9LnDH+Aj+Z1rr6QYl7bMK3lGdTwFCJ/T+vDjdS03N/xeBu8aVuXIrmkkXHrQ
 svXeuI79T3yoUutclfyHUrc1eGfh06tNYwNOwlprEepruvVjf4/30ZtohaiwD4bt402Dczr6T
 MNT7am3lS3rp/uLFWIg/NpNGQCTSTFteO2BaCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building without CONFIG_PCI, we can (depending on the architecture)
get a link failure:

ERROR: "pci_iounmap" [sound/pci/hda/snd-hda-codec-ca0132.ko] undefined!

Adding a compile-time check for PCI gets it to work correctly on
32-bit ARM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c40cb6336017..e5bdbc245682 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8451,7 +8451,7 @@ static void ca0132_free(struct hda_codec *codec)
 	ca0132_exit_chip(codec);
 
 	snd_hda_power_down(codec);
-	if (spec->mem_base)
+	if (IS_ENABLED(CONFIG_PCI) && spec->mem_base)
 		pci_iounmap(codec->bus->pci, spec->mem_base);
 	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
-- 
2.20.0

