Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3402054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570566;
	bh=s597yL38OPOSdq/APoG90zgowwOLYMEXLde9z4vR4Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qbU2ZV3wAnNjeKGCcNBeSY2lLWV7sQtYBpwou8FVsA/y73OyTPttJkmxWg5CSQJpJ
	 8uIcXNcSIxVpX1CUwCQ51sTHmg3y+8GeSna4K0WHt5FCzDUCF40QZWaGOLeZ9nuekw
	 wuJmk/xuyaZYfXtJQ0HNmjrkFPsO8EQSI7tKByhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbfAOQmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbfAOQmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7612A20675;
        Tue, 15 Jan 2019 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570561;
        bh=s597yL38OPOSdq/APoG90zgowwOLYMEXLde9z4vR4Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YEZlZLsqhdddb7KY2H08ZA0v0F5CWBdPKcSxBRUr4dWg2nAg3d0afD7GU1Niml+WF
         xGZoTLtBDbhCpps0GrYTefAHGiaQTU96lzYK1d8SiBW7UWkbuP/+c7jxOBE3XxmI6S
         2/Thf+VmNiH6esfdi8ujsCahVFHhzKkyLrNI6pN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 07/50] ALSA: hda/realtek - Add unplug function into unplug state of Headset Mode for ALC225
Date:   Tue, 15 Jan 2019 17:35:43 +0100
Message-Id: <20190115154910.431274019@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit 4d4b0c52bde470c379f5d168d5c139ad866cb808 upstream.

Forgot to add unplug function to unplug state of headset mode
for ALC225.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4102,6 +4102,7 @@ static void alc_headset_mode_unplugged(s
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
+		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
 		break;
 	case 0x10ec0867:


