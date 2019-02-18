Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B5E21902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498876;
	bh=APTFU3A+pfJnhljcYHTAdFSEQuUcQcbvBYtR9hMP2v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kU1QK7jw6bkm5hiyWheX84ghPcVSCLuhQa2XP6LUm0KvVEKekDeQ4PvNz1G/Z8Ryi
	 GdkdgU8vd6ok3Xo+xnQ2fj3dBjIbJVxIgMZi0x8HawUaxuOanFqmpYNNFeao6f3OKZ
	 uoc/9kAHP2dEVZFKR+C/7yBhRUseoPwEeaB/W35A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390816AbfBROHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:07:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390795AbfBROHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:07:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6563021901;
        Mon, 18 Feb 2019 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498867;
        bh=APTFU3A+pfJnhljcYHTAdFSEQuUcQcbvBYtR9hMP2v4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9BuBQtpJZXlkOR5vMdW4Y3urgKg5DCliv/o/jHL/B6MlbLzfh73UhXUSBZX9AsoA
         6kmnQb+e/0ihlh04NaiEKGyImRbdyY6pRMAmL687QIQOHL7Cfmjp/B9dixzb5N/lNf
         Ld9ZqPOeQL88nuBx1hLDAret50Xzo4HtKbwYpAww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jurica Vukadin <jurica.vukadin@rt-rk.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 128/143] ALSA: hda - Add quirk for HP EliteBook 840 G5
Date:   Mon, 18 Feb 2019 14:44:16 +0100
Message-Id: <20190218133533.669379188@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -854,6 +854,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),


