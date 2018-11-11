Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB006C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634DF216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa6E7IUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634DF216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387694AbeKLITU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387649AbeKLITT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:19 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1328208A3;
        Sun, 11 Nov 2018 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975363;
        bh=Vgup4Uh1wKbbiOGU3MvI/nOVD61ANsWXgoVN9wlE4RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wa6E7IUJkNfvZf2m9EF3jGRfr/YeBPmoehT+/4CZ54wmBWRctO7RuqyqlWr6f1qPy
         cUVhSksU0uIE9z0oW5NXkN85FjoJyNThpyX+ienn+tUtRGgsD6pRld5JQHJSX3IE2i
         0Vsorw2fsP/p+btT5PNP18bwq+ImnNYOz8K3H+Tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 034/350] ALSA: hda: Add 2 more models to the power_save blacklist
Date:   Sun, 11 Nov 2018 14:18:18 -0800
Message-Id: <20181111221708.608748328@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit 5cb6b5fc013ee711d19bfc4e9deb8d6ae80741db upstream.

Power-saving is causing plops on audio start/stop on Dell Precision T3600
laptops and Intel DZ77BH boards, add these to the power_save blacklist.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2215,8 +2215,12 @@ static struct snd_pci_quirk power_save_b
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1581607 */
 	SND_PCI_QUIRK(0x1558, 0x3501, "Clevo W35xSS_370SS", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x1028, 0x0497, "Dell Precision T3600", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	/* Note the P55A-UD3 and Z87-D3HP share the subsys id for the HDA dev */
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte P55A-UD3 / Z87-D3HP", 0),
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
+	SND_PCI_QUIRK(0x8086, 0x2040, "Intel DZ77BH-55K", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=199607 */
 	SND_PCI_QUIRK(0x8086, 0x2057, "Intel NUC5i7RYB", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1520902 */


