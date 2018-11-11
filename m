Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9282C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2B020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="srdr+Afz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2B020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387667AbeKLITT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbeKLITS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:18 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95DAD21104;
        Sun, 11 Nov 2018 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975362;
        bh=C56nGRWvqdRtagaiQ9bgXwaKi/sdO0aleDFJAlfUi34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srdr+Afzh3jxYehOeJoZMJTe76fm0+8OZ3AqbQLJ0LRj0HLg5FDOIWBOtyyVvHV4g
         8Ab0Mhy7Zlyndb6wOUFuTfXF2NbTQNGMG7F7fT6M3ZOhs3TkHske4CP7JvC1ynhM1Y
         wY0TnMxIqmdJO80TQydHkdLjWHdnt38ZaWkIVbAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Ploumistos <alex.ploumistos@gmail.com>,
        Jeremy Cline <jcline@redhat.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 033/350] ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)
Date:   Sun, 11 Nov 2018 14:18:17 -0800
Message-Id: <20181111221708.569211791@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jcline@redhat.com>

commit e7bb6ad5685f05685dd8a6a5eda7bfcd14d5f95b upstream.

The Lenovo G50-30, like other G50 models, has a Conexant codec that
requires a quirk for its inverted stereo dmic.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1249364
Reported-by: Alexander Ploumistos <alex.ploumistos@gmail.com>
Tested-by: Alexander Ploumistos <alex.ploumistos@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -980,6 +980,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
+	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),


