Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40983C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F8D20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761902;
	bh=0uynyqNaPeNVnMEm2lB1VhEnM+5doSQMskXa+4MRJXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pAAz9MQ54oBd/ToMKKxKRQqiUsig/3hrHCiIyEI4cyXOm1dEZbdZg7Tmy8Is+3svW
	 Ddg2UUB1T13BlLn6yTqxY8W5LTPw+9LxY9FtmKQvStdCDgUnWPBQqiWJVMqyNgLcjw
	 i8RV5W28rc5dTyjxKFQxgLebhZyGp183Ed2xurxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfA2LiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbfA2LiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1B47214DA;
        Tue, 29 Jan 2019 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761896;
        bh=0uynyqNaPeNVnMEm2lB1VhEnM+5doSQMskXa+4MRJXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfziku7tzsgMBrN3C5FnY4zFha/bJiTHkxWm0QK2CuHD/oJsjwjTClaNJzhHL/r7I
         iadmo5rwxvdG3Aci2O0bitbe7E88eTBxAn/2P5X0EbmmiwLj9clztKkz+aC5nYOLyu
         WfwJQK6tg2S82TjQ094xXieGpHzgqvVuAHBoygIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 039/117] ALSA: hda/realtek - Fix typo for ALC225 model
Date:   Tue, 29 Jan 2019 12:34:50 +0100
Message-Id: <20190129113209.563542487@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit 82aa0d7e09840704d9a37434fef1770179d663fb upstream.

Fix typo for model alc255-dell1 to alc225-dell1.

Enable headset mode support for new WYSE NB platform.

Fixes: a26d96c7802e ("ALSA: hda/realtek - Comprehensive model list for ALC259 & co")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6842,7 +6842,7 @@ static const struct hda_model_fixup alc2
 	{.id = ALC293_FIXUP_LENOVO_SPK_NOISE, .name = "lenovo-spk-noise"},
 	{.id = ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY, .name = "lenovo-hotkey"},
 	{.id = ALC255_FIXUP_DELL_SPK_NOISE, .name = "dell-spk-noise"},
-	{.id = ALC225_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "alc255-dell1"},
+	{.id = ALC225_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "alc225-dell1"},
 	{.id = ALC295_FIXUP_DISABLE_DAC3, .name = "alc295-disable-dac3"},
 	{.id = ALC280_FIXUP_HP_HEADSET_MIC, .name = "alc280-hp-headset"},
 	{.id = ALC221_FIXUP_HP_FRONT_MIC, .name = "alc221-hp-mic"},


