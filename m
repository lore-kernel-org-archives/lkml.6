Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4272086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762233;
	bh=tsm9T1zjjCzcQ0SqRJI0vYEbtTz1J3wz6y1HYq4YR28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qr2GsOV53vnkH9qVI+vd7LGF6DsCu+aPZ3pReU8N+91e+hS7LifJ2X6CyXLVvN1lY
	 zS/wmXMqgFJxI/Bzrx+lhPu46fB3kqGq59Lag8Dal9hXwGyXvutxnwLXGmK7u4XnWN
	 1bgOFgDuvgbe0RufLG/jbXeH3ta0xXQWUH+W8VCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfA2Lnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729459AbfA2Lns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199C420882;
        Tue, 29 Jan 2019 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762227;
        bh=tsm9T1zjjCzcQ0SqRJI0vYEbtTz1J3wz6y1HYq4YR28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DOKInTD+Th4lOlwt75o0La5or4hF+L4SrU3ZLNOspFz8+Bokh0FOIzt17+1iBusk8
         wOSXDGBA82taVz9lScqs63XJFW28s9Uq1hj702NiNhWj78RfxkQZkZsv/ZTaXyUEf1
         29trGGoqoEw6CcvFilpwCkupQT8406MPP75lvhcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Wong <anthony.wong@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 035/103] ALSA: hda - Add mute LED support for HP ProBook 470 G5
Date:   Tue, 29 Jan 2019 12:35:12 +0100
Message-Id: <20190129113201.653881694@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthony Wong <anthony.wong@canonical.com>

commit 699390381a7bae2fab01a22f742a17235c44ed8a upstream.

Support speaker and mic mute LEDs on HP ProBook 470 G5.

BugLink: https://bugs.launchpad.net/bugs/1811254
Signed-off-by: Anthony Wong <anthony.wong@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -931,6 +931,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x822e, "HP ProBook 440 G4", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x836e, "HP ProBook 455 G5", CXT_FIXUP_MUTE_LED_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x837f, "HP ProBook 470 G5", CXT_FIXUP_MUTE_LED_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8455, "HP Z2 G4", CXT_FIXUP_HP_MIC_NO_PRESENCE),


