Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE79C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A13206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864503;
	bh=XyO0CCoN/vCdFwJFhSheWrCrNkbGax6Siun67tUOBaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X6Q3guaHFDo0ipNsqgGGRdk/CKH3hx6X/X2XrQi9D+b0DetSsBrG37oH50Nur6uUw
	 gKm54mlnrmpybyVrDToFe1TRt5BrxyzrX6hyggBO+SFYcAq2udKMa2loqEWhQSaxBJ
	 /vCOa2eVl8pjwnnvbXdD1/9FQDAGSnTIC/C0jruE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfAGMfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:48064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727364AbfAGMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:34:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A175206BB;
        Mon,  7 Jan 2019 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864498;
        bh=XyO0CCoN/vCdFwJFhSheWrCrNkbGax6Siun67tUOBaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNb+IDGk8oFWb36P/kV6aJD/KmC6IXAOk+aG+R5wI1ezVl6MDdipblFbIUU6fLtkp
         XzSt4wAgrQGmlJKdPjWCC+y4RVmxBkdALfEPOJvHd/nvg0ADz9pNKycIvK+yacrsyB
         r4ZyNeJbnXCLHuPU3xTk2myA4zz5VsvZayuw6QY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wandrille RONCE <w@ndrille.fr>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 031/145] ALSA: hda/realtek: Enable audio jacks of ASUS UX391UA with ALC294
Date:   Mon,  7 Jan 2019 13:31:08 +0100
Message-Id: <20190107104441.399458310@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Wandrille RONCE <w@ndrille.fr>

commit 9cf6533e8060d3896b88ea14b27f620e6504b84b upstream.

By default, there is no sound on Asus UX391UA on Linux.

This patch adds sound support on Asus UX391UA. Tested working by three
different users.

The problem has also been described at
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1784485

Signed-off-by: Wandrille RONCE <w@ndrille.fr>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6573,6 +6573,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x106d, "Asus K53BE", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA", ALC294_FIXUP_ASUS_SPK),
 	SND_PCI_QUIRK(0x1043, 0x10c0, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x10d0, "ASUS X540LA/X540LJ", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x115d, "Asus 1015E", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),


