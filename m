Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A10C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9236B208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9236B208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936824AbeFRKlp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:41:45 -0400
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:53847 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933488AbeFRKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:41:04 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jun 2018 06:41:04 EDT
Received: from faui49man5 (faui49man5.informatik.uni-erlangen.de [131.188.42.193])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 4B5E858C53E;
        Mon, 18 Jun 2018 12:31:31 +0200 (CEST)
Received: by faui49man5 (sSMTP sendmail emulation); Mon, 18 Jun 2018 12:31:31 +0200
From:   Roman Sommer <roman.sommer@fau.de>
Cc:     Roman Sommer <roman.sommer@fau.de>, linux-kernel@i4.cs.fau.de,
        Daniel Graefe <daniel.graefe@fau.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        =?UTF-8?q?Hans=20P=2E=20M=C3=B6ller=20Ebner?= <hmoller@uc.cl>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Fabi=C3=A1n=20Inostroza?= <soulsonceonfire@gmail.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sound/line6: unsigned -> unsigned int
Date:   Mon, 18 Jun 2018 12:29:38 +0200
Message-Id: <1529317779-15908-3-git-send-email-roman.sommer@fau.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
References: <1529317779-15908-1-git-send-email-roman.sommer@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: Takashi Sakamoto <o-takashi@sakamocchi.jp>
CC: "Hans P. Möller Ebner" <hmoller@uc.cl>
CC: Kees Cook <keescook@chromium.org>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "Fabián Inostroza" <soulsonceonfire@gmail.com>
CC: Bhumika Goyal <bhumirks@gmail.com>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: alsa-devel@alsa-project.org
CC: linux-kernel@vger.kernel.org

This patch replaces all occurrences of 'unsigned' in sound/usb/line6 with
'unsigned int'.

Signed-off-by: Roman Sommer <roman.sommer@fau.de>
Signed-off-by: Daniel Graefe <daniel.graefe@fau.de>
---
 sound/usb/line6/driver.c | 10 +++++-----
 sound/usb/line6/driver.h |  8 ++++----
 sound/usb/line6/pcm.c    |  4 ++--
 sound/usb/line6/pcm.h    |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index df7e761..fd176ef 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -346,13 +346,13 @@ static void line6_data_received(struct urb *urb)
 /*
  * Read data from device.
  */
-int line6_read_data(struct usb_line6 *line6, unsigned address, void *data,
-		    unsigned datalen)
+int line6_read_data(struct usb_line6 *line6, unsigned int address, void *data,
+		    unsigned int datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
 	unsigned char len;
-	unsigned count;
+	unsigned int count;
 
 	if (address > 0xffff || datalen > 0xff)
 		return -EINVAL;
@@ -417,8 +417,8 @@ EXPORT_SYMBOL_GPL(line6_read_data);
 /*
  * Write data to device.
  */
-int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
-		     unsigned datalen)
+int line6_write_data(struct usb_line6 *line6, unsigned int address, void *data,
+		     unsigned int datalen)
 {
 	struct usb_device *usbdev = line6->usbdev;
 	int ret;
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index b307944..1dfb6de 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -187,8 +187,8 @@ struct usb_line6 {
 
 extern char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1,
 				      int code2, int size);
-extern int line6_read_data(struct usb_line6 *line6, unsigned address,
-			   void *data, unsigned datalen);
+extern int line6_read_data(struct usb_line6 *line6, unsigned int address,
+			   void *data, unsigned int datalen);
 extern int line6_read_serial_number(struct usb_line6 *line6,
 				    u32 *serial_number);
 extern int line6_send_raw_message_async(struct usb_line6 *line6,
@@ -200,8 +200,8 @@ extern ssize_t line6_set_raw(struct device *dev, struct device_attribute *attr,
 extern void line6_start_timer(struct timer_list *timer, unsigned long msecs,
 			      void (*function)(struct timer_list *t));
 extern int line6_version_request_async(struct usb_line6 *line6);
-extern int line6_write_data(struct usb_line6 *line6, unsigned address,
-			    void *data, unsigned datalen);
+extern int line6_write_data(struct usb_line6 *line6, unsigned int address,
+			    void *data, unsigned int datalen);
 
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 20a2da3..c4d698c 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -529,8 +529,8 @@ int line6_init_pcm(struct usb_line6 *line6,
 		   struct line6_pcm_properties *properties)
 {
 	int i, err;
-	unsigned ep_read = line6->properties->ep_audio_r;
-	unsigned ep_write = line6->properties->ep_audio_w;
+	unsigned int ep_read = line6->properties->ep_audio_r;
+	unsigned int ep_write = line6->properties->ep_audio_w;
 	struct snd_pcm *pcm;
 	struct snd_line6_pcm *line6pcm;
 
diff --git a/sound/usb/line6/pcm.h b/sound/usb/line6/pcm.h
index acef244..cd1da40 100644
--- a/sound/usb/line6/pcm.h
+++ b/sound/usb/line6/pcm.h
@@ -104,13 +104,13 @@ struct line6_pcm_stream {
 	/* Count processed bytes;
 	 * This is modulo period size (to determine when a period is finished).
 	 */
-	unsigned bytes;
+	unsigned int bytes;
 
 	/* Counter to create desired sample rate */
-	unsigned count;
+	unsigned int count;
 
 	/* period size in bytes */
-	unsigned period;
+	unsigned int period;
 
 	/* Processed frame position in the buffer;
 	 * The contents of the ring buffer have been consumed by the USB
-- 
2.7.4

