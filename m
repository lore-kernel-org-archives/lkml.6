Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523658283; cv=none;
        d=google.com; s=arc-20160816;
        b=H+ytq9SMZtiqwODlQy5bA8/HxHdJ0dWS0MW4E4iB8Uwc6Q14N2QKnZ/kZUlZjr+zaF
         yu+LR20o81+RcfUj/S47oumH8DvTKgH26566GjB0KkoY235S2EotUGx8EQvuMw1wJRfj
         xHh5sqakepVf1nWd+7U6jyAr3C31fVLybS30VRLreAS1Xaqjf8biLx0JgC0KS1a7zFlD
         GMQ6wD4gIKur1uuEHJPADuTsKkjXjRv6ItHKJKGK1dhNI7QcEI+ukhZofDRFOg/iHwYH
         5b5spjk1KQkJ/FKtwxoHGXZzS0NFaHhfqbyh5+gG/YWv3gk9VdQ258RvGdtTENGOMo4s
         RM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uMtwz6KZeVeu/sRPAAhu7jGuHvvZczbRw4yeXDSlWGc=;
        b=hXlnP1FW6juvaRQVIxwkbALLOcEDxktqT8VlgycqwlozfiIAqcvpUv0gye5Dp09AiY
         Lz7pz/7dSVE76Z1ptjYN6ShQKDsIZ4tYkkmUMr/yDfzzTQla1oPIQ+sw4jkrLqgR2Rmc
         HSuY8VAJkfti688Lm/j4Dy52HTUnNpSlnOxzwrk7HvnK87r/ANFo1Ogr/i6jcULGHR/Y
         JLMsR4OZORWfTeIy9qcz4VWbn5iEjwU4pS9VOJlaBYubt8E0RDp1tST3xFi3x1T+88/z
         Ir44Nj1JsJ48Amiy3xCp/HqZv8REJp6wjUvdfmAEeGiWNrxjcpaLTLAbXZlbSwu2ZPMG
         BKuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PBeWgduK;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PBeWgduK;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/kzQ4iptw0uEr45D1EpjG9lcs4NDaJyueOKG2N8cdKeWbJENBH18MZkhT3UXW8MzXpoNvCJQ==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] include: usb: audio-v3: add BADD-specific values
Date: Sat, 14 Apr 2018 01:24:24 +0300
Message-Id: <1523658266-2259-3-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671507799755096?=
X-GMAIL-MSGID: =?utf-8?q?1597671507799755096?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add BADD-specific predefined values to audio-v3
so usb-audio in ALSA and UAC3 gadget can use them

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---
 include/linux/usb/audio-v3.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
index a8959aa..38add1d 100644
--- a/include/linux/usb/audio-v3.h
+++ b/include/linux/usb/audio-v3.h
@@ -392,4 +392,30 @@ struct uac3_interrupt_data_msg {
 #define UAC3_AC_ACTIVE_INTERFACE_CONTROL	0x01
 #define UAC3_AC_POWER_DOMAIN_CONTROL		0x02
 
+/* BADD predefined Unit/Terminal values */
+#define UAC3_BADD_IT_ID1	1  /* Input Terminal ID1: bTerminalID = 1 */
+#define UAC3_BADD_FU_ID2	2  /* Feature Unit ID2: bUnitID = 2 */
+#define UAC3_BADD_OT_ID3	3  /* Output Terminal ID3: bTerminalID = 3 */
+#define UAC3_BADD_IT_ID4	4  /* Input Terminal ID4: bTerminalID = 4 */
+#define UAC3_BADD_FU_ID5	5  /* Feature Unit ID5: bUnitID = 5 */
+#define UAC3_BADD_OT_ID6	6  /* Output Terminal ID6: bTerminalID = 6 */
+#define UAC3_BADD_FU_ID7	7  /* Feature Unit ID7: bUnitID = 7 */
+#define UAC3_BADD_MU_ID8	8  /* Mixer Unit ID8: bUnitID = 8 */
+#define UAC3_BADD_CS_ID9	9  /* Clock Source Entity ID9: bClockID = 9 */
+#define UAC3_BADD_PD_ID10	10 /* Power Domain ID10: bPowerDomainID = 10 */
+#define UAC3_BADD_PD_ID11	11 /* Power Domain ID11: bPowerDomainID = 11 */
+
+/* BADD wMaxPacketSize of AS endpoints */
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_16		0x0060
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_16		0x0062
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_MONO_24		0x0090
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_MONO_24		0x0093
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_16		0x00C0
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_16		0x00C4
+#define UAC3_BADD_EP_MAXPSIZE_SYNC_STEREO_24		0x0120
+#define UAC3_BADD_EP_MAXPSIZE_ASYNC_STEREO_24		0x0126
+
+/* BADD sample rate is always fixed to 48kHz */
+#define UAC3_BADD_SAMPLING_RATE				48000
+
 #endif /* __LINUX_USB_AUDIO_V3_H */
-- 
1.9.1
