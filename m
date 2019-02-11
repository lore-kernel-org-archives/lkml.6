Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24203C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1D120818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895768;
	bh=mofi7z66SVjHyEHqzpfwiE6dIub3H5nXnrQ94Lh5im0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cCqMsygMdNx4cBFshqf2nagaJtZL+hxx28186DGOrlrlteuL9GNFTHbwOyadwU/P+
	 bkaVtdv2dZMYHjn2Xl9tU4amXLM2naMPc3lXn0ugG/mit7GV6j1v/lk8LdJZEThw0y
	 5VHvqWsBQnPz53T/Ha8iI4FTPp0Kszoja2Cc4ODs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfBKOgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731173AbfBKOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D12520818;
        Mon, 11 Feb 2019 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895762;
        bh=mofi7z66SVjHyEHqzpfwiE6dIub3H5nXnrQ94Lh5im0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paFPPzCbS3WmosZzQMmfdaxBvlyiKoCHUmedABfXCDRRYkMpe1IRJE2xr/mhPIIkv
         hsvkS7S8NxDVun4N31+st65BVRNT7UqKMAqfjjBNnZfxFsTXetlcTTafwhauoeI3ZV
         +KfMWcSUoyabWFls+E7EAI1GE0L2qtg7duQCdqXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Udo Eberhardt <udo.eberhardt@thesycon.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 315/352] ALSA: usb-audio: Add support for new T+A USB DAC
Date:   Mon, 11 Feb 2019 15:19:02 +0100
Message-Id: <20190211141906.860312382@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

From: Udo Eberhardt <udo.eberhardt@thesycon.de>

commit 3bff2407fbd28fd55ad5b5cccd98fc0c9598f23b upstream.

This patch adds the T+A VID to the generic check in order to enable
native DSD support for T+A devices. This works with the new T+A USB
DAC model SD3100HV and will also work with future devices which
support the XMOS/Thesycon style DSD format.

Signed-off-by: Udo Eberhardt <udo.eberhardt@thesycon.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1448,6 +1448,7 @@ u64 snd_usb_interface_dsd_format_quirks(
 	case 0x20b1:  /* XMOS based devices */
 	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
+	case 0x2ab6:  /* T+A devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;


