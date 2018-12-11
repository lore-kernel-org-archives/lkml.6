Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D03CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4C22084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545003;
	bh=qoWOv9u/0EBNJLgDuR9Sw6tatcpwtJ/edl7TInkeCWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CZxOrOek6B6qYJ6z9EOfZMIdvUUFwmMc7J/LarGPh+DP1ZZBwsoARQfoXFPS4iOh0
	 CAP93WIZP7BGep9C2X1mfBD2CNcXbWCiFhkbL1RsOkeCUQFJNAJgQ9FubGu/J9uiYM
	 Pp1KPDo+9byIPxV2NybcRplUOxFRYyrT9S5S9y/w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4C22084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeLKPrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbeLKPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304EA20989;
        Tue, 11 Dec 2018 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543261;
        bh=qoWOv9u/0EBNJLgDuR9Sw6tatcpwtJ/edl7TInkeCWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bM3rxYDUIv4nb8H03rDGpYmleiu6+jHh+FvjVwx/05gJype097ydiq05D5DcicOIg
         7yJuIP8XqAQECYVXrDa4sZjj+aWM79Ut8oMjyxPH3aKhbxDbOZ5BIBBriFI0AQ7w4c
         0vJCaDGw9TTWkE6OyshhwKV6/LZCVQLtqpBtO1no=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 74/91] ALSA: hda: Add support for AMD Stoney Ridge
Date:   Tue, 11 Dec 2018 16:41:33 +0100
Message-Id: <20181211151612.452925185@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 3deef52ce10514ccdebba8e8ab85f9cebd0eb3f7 upstream.

It's similar to other AMD audio devices, it also supports D3, which can
save some power drain.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2363,6 +2363,10 @@ static const struct pci_device_id azx_id
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	/* AMD Stoney */
+	{ PCI_DEVICE(0x1022, 0x157a),
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |
+			 AZX_DCAPS_PM_RUNTIME },
 	/* AMD Raven */
 	{ PCI_DEVICE(0x1022, 0x15e3),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |


