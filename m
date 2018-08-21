Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B39C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC58521774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC58521774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeHUJku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:40:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:40:49 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36D6B8A5;
        Tue, 21 Aug 2018 06:22:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.18 11/35] ALSA: hda: Correct Asrock B85M-ITX power_save blacklist entry
Date:   Tue, 21 Aug 2018 08:20:37 +0200
Message-Id: <20180821055020.480563964@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 8e82a728792bf66b9f0a29c9d4c4b0630f7b9c79 upstream.

I added the subsys product-id for the HDMI HDA device rather then for
the PCH one, this commit fixes this.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1525104
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2207,7 +2207,7 @@ out_free:
  */
 static struct snd_pci_quirk power_save_blacklist[] = {
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
-	SND_PCI_QUIRK(0x1849, 0x0c0c, "Asrock B85M-ITX", 0),
+	SND_PCI_QUIRK(0x1849, 0xc892, "Asrock B85M-ITX", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */
 	SND_PCI_QUIRK(0x1849, 0x7662, "Asrock H81M-HDS", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1525104 */


