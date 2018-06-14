Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C5381C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866AF208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866AF208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936224AbeFNOGK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:10 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36949 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936203AbeFNOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:05 -0400
Received: from [148.252.241.226] (helo=ct-lt-1121.office.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fTSt0-0005OK-9j; Thu, 14 Jun 2018 15:06:02 +0100
From:   Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ruslan.bilovol@gmail.com
Subject: [PATCH v2 1/4] ALSA: usb-audio: Add bi-directional terminal types.
Date:   Thu, 14 Jun 2018 15:05:55 +0100
Message-Id: <20180614140558.28277-2-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
References: <20180612143201.29988-1-jorge.sanjuan@codethink.co.uk>
 <20180614140558.28277-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the bi-directional USB terminal types for audio devices.

Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
---
 include/uapi/linux/usb/audio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 13d98e6e0db1..74e520fb944f 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -230,6 +230,14 @@ struct uac1_output_terminal_descriptor {
 #define UAC_OUTPUT_TERMINAL_COMMUNICATION_SPEAKER	0x306
 #define UAC_OUTPUT_TERMINAL_LOW_FREQ_EFFECTS_SPEAKER	0x307
 
+/* Terminals - 2.4 Bi-directional Terminal Types */
+#define UAC_BIDIR_TERMINAL_UNDEFINED			0x400
+#define UAC_BIDIR_TERMINAL_HANDSET			0x401
+#define UAC_BIDIR_TERMINAL_HEADSET			0x402
+#define UAC_BIDIR_TERMINAL_SPEAKER_PHONE		0x403
+#define UAC_BIDIR_TERMINAL_ECHO_SUPPRESSING		0x404
+#define UAC_BIDIR_TERMINAL_ECHO_CANCELING		0x405
+
 /* Set bControlSize = 2 as default setting */
 #define UAC_DT_FEATURE_UNIT_SIZE(ch)		(7 + ((ch) + 1) * 2)
 
-- 
2.11.0

