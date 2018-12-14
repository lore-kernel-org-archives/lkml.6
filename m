Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C8C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896C120892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790972;
	bh=xIyqiv1hYLocp3nrjhnP9L4qJjRtd1GCTvZdxP/j/XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRDP+FTIBmMRkpr5+EgIWU2QrnWgc9db+hr27A0zsl9phJsrwLWcVj0fc3/rL/Us2
	 vw/mk46ypaFttpxqH07dsDFgZQm775zmKrFLzexnufMoMD24RgFXSLjppjBU1W1P/o
	 R7zERLak4NOdHG6UbMME6Rfw8XKr8r4Rx0WmWp/s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896C120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbeLNMgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:36:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730524AbeLNMGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B9421479;
        Fri, 14 Dec 2018 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789212;
        bh=xIyqiv1hYLocp3nrjhnP9L4qJjRtd1GCTvZdxP/j/XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yI+9FS3+ifxEbHyD8txmwsE/ysjUZULqCz8+21w/SSXgg0xlUStp3tt9aA160dGMO
         hNBckqzmU+t8B8+Ddwo4GQ0f8ssqKKhSiFOZevrK+A/Kmv3ECdNOZ9afh39Gs43NK2
         HqyAH/zsifPINjXdyEwz+JngcEiXnwF2t1Wmgn0U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 137/142] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN
Date:   Fri, 14 Dec 2018 13:00:22 +0100
Message-Id: <20181214115752.519506077@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

commit d8ae458eeca9ed686e09a1b894867cb91fc4c1cb upstream.

The known ALC256_FIXUP_ASUS_MIC fixup can fix the headphone jack
sensing and enable use of the internal microphone on this laptop
X542UN. However, it's ALC294 so create a new fixup named
ALC294_FIXUP_ASUS_MIC to avoid confusion.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5520,6 +5520,7 @@ enum {
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+	ALC294_FIXUP_ASUS_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6406,6 +6407,16 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x13, 0x90a60160 }, /* use as internal mic */
+			{ 0x19, 0x04a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7155,6 +7166,10 @@ static const struct snd_hda_pin_quirk al
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_MIC,
+		{0x14, 0x90170110},
+		{0x1b, 0x90a70130},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},


