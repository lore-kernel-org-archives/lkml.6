Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD68C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202B2217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277341;
	bh=vrcybyZXwypp1K+VCES0D5BbQbVVjhCOb4fALIi5D9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ARAH2X15J+gKNc8DvLj8yABlP/cb6o2ffO4rCYGA4wpw4GHza5PCJIKPCUZBSebRG
	 /PHy1854OjT8IOxtT4hxeBuy+8xKbwZpYvjgsm6tjEexCfZqA81+UruFq50ULQEFOx
	 IUoPG5/ygshUjxvRgil1ZOb8ABlRV2SsrYvQi++8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfBDKs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731916AbfBDKs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549FD2070C;
        Mon,  4 Feb 2019 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277335;
        bh=vrcybyZXwypp1K+VCES0D5BbQbVVjhCOb4fALIi5D9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqxiXUZoTBWcbnnzDRDhhY2lJs6GQoKxpVia6yb8NX13THVbbKvz4SFkl6NNoOxYI
         w0r0UBv81dOHc5Wg6SL+4X2oThCVocYaJbh4dHKTzkAdDyAoHH2w7r08g8N5rcLGL+
         FxrvjiulZ27+iThDQtk7q4wAyYz6e5sTQfDP+Q6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olek Poplavsky <woodenbits@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 53/74] ALSA: usb-audio: Add Opus #3 to quirks for native DSD support
Date:   Mon,  4 Feb 2019 11:37:06 +0100
Message-Id: <20190204103626.747770689@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Olek Poplavsky <woodenbits@gmail.com>

commit 9e6966646b6bc5078d579151b90016522d4ff2cb upstream.

This patch adds quirk VID/PID IDs for the Opus #3 DAP (made by 'The Bit')
in order to enable Native DSD support.

[ NOTE: this could be handled in the generic way with fp->dvd_raw if
  we add 0x10cb to the vendor whitelist, but since 0x10cb shows a
  different vendor name (Erantech), put to the individual entry at
  this time -- tiwai ]

Signed-off-by: Olek Poplavsky <woodenbits@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1373,6 +1373,7 @@ u64 snd_usb_interface_dsd_format_quirks(
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
+	case USB_ID(0x10cb, 0x0103): /* The Bit Opus #3; with fp->dsd_raw */
 	case USB_ID(0x152a, 0x85de): /* SMSL D1 DAC */
 	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
 	case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */


