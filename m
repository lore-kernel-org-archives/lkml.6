Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525397101; cv=none;
        d=google.com; s=arc-20160816;
        b=albiK75hOeFtpT6OVf9bjrxdp5yniW0pPxzceSo20ssPX4oj3M4Dcc7PYVNFGlZJUw
         tOBaFQ+iYqj6+5bMj1gttlagrcCXOci+s+esYIR8KflcAD9d7VXvCkvri2ZrxmnUVnKE
         h5x9EMxWtOGECsq8fUABBNDSykWQCCMGMmkxS1141CIgaeZ50HSJb1WJkWl99wn2pID9
         cqtGYtypZ/3zKxLrXbL+/nvPjAIYx3sj8gDZ6zCpLmvquuFtXRqjaFrTlZ/zW1XDfapi
         rH2fDM+pM1rQtpidgRL4IBSML1Zw+TtWBmVmtY8M0C6iS9VbGVlBO6YSFVxPZV/UbEz/
         +Vrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=uMtwz6KZeVeu/sRPAAhu7jGuHvvZczbRw4yeXDSlWGc=;
        b=ix9naHMxhtoTNMtRue9eg1SOSGudt8xwSP69aotB2eSpEq0A1/dLdi9RDWaETJkrUV
         Q7nwfaTBmK5igh4+I+KeQ+vnGcWZmoiPRlkCwpuhcCTLbwWnEAHmSMCUWVaJjVxLAMoR
         PKJV/jtupF/Wm1YipXLQU4JAkl6jnnAl10nHB1NeUF7jIXaVa0WHIlacWxjL1RksV7ks
         ry9ocFJj7S9Ekdz8cLHyB0PQnPKFjmH/EkvM6zrZ5UotjZl+SkUua3UmyI7yUhguN8N0
         j+Mn6EjRs7IwN1JcyIQPmpQXuRYNjlpCy+CYttqAw0Zub5bopzAobCP4as+dyY3ILfQi
         uVsg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LDGbkEGQ;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LDGbkEGQ;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZr3pj5QRIh9K3ba8sJmpkSmrMLISCRAn4mQaEXuaSrA2HzJXRMfbzpBZbfAhavkIb8HQINSNw==
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>,
	Andrew Chant <achant@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] include: usb: audio-v3: add BADD-specific values
Date: Fri,  4 May 2018 04:24:03 +0300
Message-Id: <1525397044-15080-7-git-send-email-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
References: <1525397044-15080-1-git-send-email-ruslan.bilovol@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599494791393898765?=
X-GMAIL-MSGID: =?utf-8?q?1599494791393898765?=
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
