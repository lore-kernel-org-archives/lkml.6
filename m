Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19956C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06A321906
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497695;
	bh=Cl752oasIqfxEM4Z9h0ncNY81IheVTooZ9PS6c/w5Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qdQ+MbXzXr5Kgbrm+KfjRzpkBmq4x8C5IY3B79gKUow28OyWDWsFZ/n+eIiriV2at
	 odzH6I1MLtwo1jSwt5IpIFN9QAYeB9zeJEaP3tHDeN+yi3l4MXIpkXRcR3rt1u8qTo
	 gwIS09qxbW/9CMBjjiAdL5cHiN3SzteE+dfO5vT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfBRNsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfBRNsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA56217F5;
        Mon, 18 Feb 2019 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497691;
        bh=Cl752oasIqfxEM4Z9h0ncNY81IheVTooZ9PS6c/w5Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHEX2vRjQFP1ELwlLB4OoWHXN6/5egLcNoaHo68cAKxRcmsCIZdFlqR2wgjRtUi+/
         gyTHBOyNnpssBp+0dodFd8jqFChZoU2SW6GRZuFLPeiduji+rq64J3poJ97P/mIyrR
         wOYqAIj2P5soK4KTDd65zXGe+2ENGdPlfCLTfDLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jurica Vukadin <jurica.vukadin@rt-rk.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 56/92] ALSA: hda - Add quirk for HP EliteBook 840 G5
Date:   Mon, 18 Feb 2019 14:42:59 +0100
Message-Id: <20190218133500.060791670@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

From: Jurica Vukadin <jurica.vukadin@rt-rk.com>

commit 4cd3016ce996494f78fdfd87ea35c8ca5d0b413e upstream.

This enables mute LED support and fixes switching jacks when the laptop
is docked.

Signed-off-by: Jurica Vukadin <jurica.vukadin@rt-rk.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -924,6 +924,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),


