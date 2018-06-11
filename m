Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wdzAD2hDHluNBgAAmS7hNA
	; Mon, 11 Jun 2018 09:39:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 24C88607E4; Mon, 11 Jun 2018 09:39:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A935860792;
	Mon, 11 Jun 2018 09:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A935860792
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932734AbeFKJjs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:39:48 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:39998 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932453AbeFKJjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:39:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 6969B20083;
        Mon, 11 Jun 2018 11:39:45 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kK7IUbm5zhMO; Mon, 11 Jun 2018 11:39:44 +0200 (CEST)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id E7BE52007F;
        Mon, 11 Jun 2018 11:39:44 +0200 (CEST)
Received: from [10.182.7.41] (10.182.7.41) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 11 Jun
 2018 11:39:44 +0200
From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH 1/2] ALSA: hda: add dock and led support for HP EliteBook 830
 G5
Openpgp: preference=signencrypt
Autocrypt: addr=dennis.wassenberg@secunet.com; prefer-encrypt=mutual; keydata=
 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
 YPsSSSBN/R6Xmw==
Organization: secunet Security Networks
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Hui Wang <hui.wang@canonical.com>,
        Florin Tudorache <florin_tudorache@live.com>,
        =?UTF-8?Q?Jer=c3=b3nimo_Borque?= <jeronimo@borque.com.ar>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Message-ID: <0cd9e66b-460a-4dc3-cd9c-3b0124b8284c@secunet.com>
Date: Mon, 11 Jun 2018 11:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 71B1516D-6F57-446E-8B6B-A53342F6E465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing initialisation for HP 2013 UltraSlim Dock
Line-In/Out PINs and activates keyboard mute/micmute leds
for HP EliteBook 830 G5
---
 sound/pci/hda/patch_conexant.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5b4dbcec6de8..bca71f35b34f 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -959,6 +959,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
-- 
2.17.1
