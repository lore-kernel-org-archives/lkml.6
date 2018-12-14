Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CEC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A0721479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789221;
	bh=rgkShTxoicZXUSZZD+KQMeEUBJld1D5BDdR+aC7DTzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvockoFg5tOWME/BJp1rQVK5ecJxcTBVfkHENoh5B7U9nXsDw9iwDH7DvP6GMVHmx
	 vuVsMPxB1v4Rg1XEf8mkLTyiluTdOT/QonjNsRgRBJ7NmOS9meXtmgYpsHPfTOi4b+
	 IhSYiz4WaGzLHbpXdxds4IQoVd70ch3Ql6Iv0rRA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A0721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbeLNMHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbeLNMG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5EA921479;
        Fri, 14 Dec 2018 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789217;
        bh=rgkShTxoicZXUSZZD+KQMeEUBJld1D5BDdR+aC7DTzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTXb2PZRBWWwMSNOfWK2Fh8GkaLWlmVPvcBOwePk0sVvIs2e8MUdj17LvZ8gZHVtS
         F75VtiUy4cfYY1iBBmPW/vQjo6IKpNCx8URzccvmInLlB5jh8ZBF6gCR/l6qyltZd8
         xvof0zsRXxFJ2VbFJOcOLpfv9ilBoPfzoAPHlBQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 139/142] ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with ALC294
Date:   Fri, 14 Dec 2018 13:00:24 +0100
Message-Id: <20181214115752.596932657@linuxfoundation.org>
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

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 0bea4cc8383519f78f3f74caca7bdebdfb346d3b upstream.

The ASUS UX433FN and UX333FA with ALC294 cannot detect the headset MIC
and output through the internal speaker and the headphone until
ALC294_FIXUP_ASUS_SPK and ALC294_FIXUP_ASUS_HEADSET_MIC quirk applied.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7193,6 +7193,10 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},


