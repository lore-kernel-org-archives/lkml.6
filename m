Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C77AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503CA218CD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503CA218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbeHMSfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:35:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37802 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMSfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:35:16 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B3E1F72D1A8;
        Mon, 13 Aug 2018 18:46:51 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id A519C7CC7A1; Mon, 13 Aug 2018 18:46:51 +0300 (MSK)
Date:   Mon, 13 Aug 2018 18:46:51 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        Takashi Iwai <tiwai@suse.de>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: fix linux/usb/audio.h userspace compilation error
Message-ID: <20180813154651.GB22820@altlinux.org>
Mail-Followup-To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        Takashi Iwai <tiwai@suse.de>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace NULL with 0 in uac_mixer_unit_bmControls() to fix the following
linux/usb/audio.h userspace compilation error:

/usr/include/linux/usb/audio.h: In function 'uac_mixer_unit_bmControls':
/usr/include/linux/usb/audio.h:304:10: error: 'NULL' undeclared (first use in this function)
   return NULL;

Fixes: 6cfd839ae78e ("ALSA: usb-audio: UAC3. Add support for mixer unit.")
Cc: <stable@vger.kernel.org> # v4.18
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/usb/audio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 74e520fb944f..2b61fe34b2ca 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -301,7 +301,7 @@ static inline __u8 *uac_mixer_unit_bmControls(struct uac_mixer_unit_descriptor *
 	case UAC_VERSION_3:
 		return &desc->baSourceID[desc->bNrInPins + 2];
 	default:
-		return NULL;
+		return 0;
 	}
 }
 
-- 
ldv
