Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD337C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D11721903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498252;
	bh=6GxmvJbn1/g5axU3mvOOYUW0Fn4UzhrcEi5VRorSQ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q2rDH1aVzwVjI0X5gr4PYNqwiI05iECpTMHusVxwH4vuSY0ibEiY4pMY5hMFEyKpc
	 hhI6/VnkocEkulRJbIgVy6vX4Ga1pxd9sImHD1PSoCrFDgz5CIPMtsDogCnucespRm
	 jd4MyGAZj1VtrzDEY3UfsBYcg1AjfUw2tIKpFDAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbfBRN5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733108AbfBRN52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:57:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853C9217F9;
        Mon, 18 Feb 2019 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498248;
        bh=6GxmvJbn1/g5axU3mvOOYUW0Fn4UzhrcEi5VRorSQ0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJhlFw+8LgF92+0jeqv4ybGJfQWHFxxtmcSf/SIDgZjTY2uJDAh426tBA32oAfBtk
         7FAQS8Blx+iEshSjPHAtPHYtULZ1RqFUIU4ZL91u2rLsI0GtH1k7cMrYzg4Ip44znV
         lSG9SBBePfAvlsUJ0tWK8mPBcI1HyIY7OgmXdksc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jurica Vukadin <jurica.vukadin@rt-rk.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 44/62] ALSA: hda - Add quirk for HP EliteBook 840 G5
Date:   Mon, 18 Feb 2019 14:43:50 +0100
Message-Id: <20190218133509.642934606@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -962,6 +962,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x828c, "HP EliteBook 840 G4", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x83b2, "HP EliteBook 840 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83b3, "HP EliteBook 830 G5", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x83d3, "HP ProBook 640 G4", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),


