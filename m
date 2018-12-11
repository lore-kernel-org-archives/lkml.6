Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64799C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283412086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543803;
	bh=RZ9P5POzx5DGYu3wMbLziF2mvY7dvwTrEm0txs2k3z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzfWhD16bZ2GFLamwAFDt87aI1+WSdRAe+ITWOsnf7/DtqahgAq1KlXI3HAuCTkhI
	 h6SJIb4Tod6jcnrAGIZMjZPuDNW/GSZ6vFJCkRZKCe6OLEXM0z+oOtMp+0guIyvYMn
	 F19cNL+HFIY7h43zWloSrc09z0Z7Qs2jdNbt14HA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283412086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbeLKP4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbeLKP4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 337112146D;
        Tue, 11 Dec 2018 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543798;
        bh=RZ9P5POzx5DGYu3wMbLziF2mvY7dvwTrEm0txs2k3z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elkZJAsItVw2ZzWZZ85o/8HzWEDQe1+50UzwIf3zQrlSoZ/VVhjFkYU7SRxtvP34y
         wk3mVWEt4PV7pD+/tNDOvzZYqrSV38FMYOIWxI9JxuAdbYm/A3lRHyD/sY6KvIkicn
         UgxJ7HNR3wQfl6k8OwYj5+o84VCMuo7MRn9jqPhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 067/118] ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880
Date:   Tue, 11 Dec 2018 16:41:26 +0100
Message-Id: <20181211151646.941553439@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Chris Chiu <chiu@endlessm.com>

commit 33aaebd48ae2d2c78fef5063a0381e17db19b060 upstream.

Acer Aspire U27-880(AIO) with ALC286 codec can not detect headset mic
and internal mic not working either. It needs the similar quirk like
Sony laptops to fix headphone jack sensing and enables use of the
internal microphone.

Unfortunately jack sensing for the headset mic is still not working.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5519,6 +5519,7 @@ enum {
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
+	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6396,6 +6397,15 @@ static const struct hda_fixup alc269_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_auto_mute_via_amp,
 	},
+	[ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7074,6 +7084,10 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x19, 0x04a11040},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0286, 0x1025, "Acer", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0288, 0x1028, "Dell", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},


