Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D087C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65F425878
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65F425878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933960AbeGASHH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:07:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965732AbeGAQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:28:45 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9D87392B;
        Sun,  1 Jul 2018 16:28:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 098/101] ALSA: hda/realtek - Add a quirk for FSC ESPRIMO U9210
Date:   Sun,  1 Jul 2018 18:22:24 +0200
Message-Id: <20180701160801.071961747@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160757.138608453@linuxfoundation.org>
References: <20180701160757.138608453@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 275ec0cb946cb75ac8977f662e608fce92f8b8a8 upstream.

Fujitsu Seimens ESPRIMO Mobile U9210 requires the same fixup as H270
for the correct pin configs.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200107
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2448,6 +2448,7 @@ static const struct snd_pci_quirk alc262
 	SND_PCI_QUIRK(0x10cf, 0x1397, "Fujitsu Lifebook S7110", ALC262_FIXUP_FSC_S7110),
 	SND_PCI_QUIRK(0x10cf, 0x142d, "Fujitsu Lifebook E8410", ALC262_FIXUP_BENQ),
 	SND_PCI_QUIRK(0x10f1, 0x2915, "Tyan Thunder n6650W", ALC262_FIXUP_TYAN),
+	SND_PCI_QUIRK(0x1734, 0x1141, "FSC ESPRIMO U9210", ALC262_FIXUP_FSC_H270),
 	SND_PCI_QUIRK(0x1734, 0x1147, "FSC Celsius H270", ALC262_FIXUP_FSC_H270),
 	SND_PCI_QUIRK(0x17aa, 0x384e, "Lenovo 3000", ALC262_FIXUP_LENOVO_3000),
 	SND_PCI_QUIRK(0x17ff, 0x0560, "Benq ED8", ALC262_FIXUP_BENQ),


