Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3617087-1524599849-2-12969143088691943601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524599848; b=Kcc/kl9FuIHhC0xi8tF6cT4BnvcF2GlR/yaTLVgG5XiSKruKBf
    Tus8s7yLKgZkqGEMlErt4Rjz3yGuYkjZeOmslLYRM9SEiCKzca2qWQ328u5irYTC
    WnZ0fe/Z+tIPS8Du7UB0ORcwgDCR83Oyjc00CYqwTYHk+kp/e2rWZcv468TUZrBp
    cec2Y5eEu3SaKwQmkYPB7/TgsMlapP+cN1F4uUPJX2GPO2UZbd7NTrAIERN0Bu0J
    JC2BQawyNi/8V6jC2DqhKH0BN0xBtUHkBwid7XT6EtDY6ollNE/ZBpG19pqn4jBd
    dIjrnpQaa9GnPydVbRoOW8tylBZCaE4444Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524599848; bh=Pk8Ux
    egUzrI9QX1ZAbJVO2ofy8dhdJunga8lFC1q/2Q=; b=aIrJsd++UelZqRwTmxpoo
    NUNlfm54vILrTjIdNNrd1lJfneZME+N4XwqLCvvtWFD/zstcA5LNNYDD2XWd4FsN
    v0c4Ze5oNKQzVyqJ/zanZW9CUGJsticbjz8vg5S9M9s3Sy0GgBkCkQSCCM8PlSfw
    MhT/N6OR9/Cw3cWz7DKaqwVKCM+RWCRRl9yc6cEkpgSQ+bJvW8KgMFqeYoEo2q45
    dqUS4nmZdFVu88pszAPkO2nm7IUFjPnG0X2piymsKe5q03xnuut5FEfY0QqHkSUV
    nXHdktJalVjk061ed79M70TreUo8IxPgCV3wb6Uc2V/+uCEttNyLoPbcC+ccouWi
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=amRTbrNi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QhNpsDu2;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=amRTbrNi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QhNpsDu2;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBo8Nv1iyW/ZHlzUs1MpHT05S5gjVPTv7UBENCIQJUCL/907TB4q/rfxdQiiGyibvT0dP6+oiVVZRTFdGsrC+CDWN2kUW7Q07vq4rebp1H5gX7MimDmn
    FtAJyERfO8BzexZc3VTXZpXJILl4968gPfJnOk4nKW4Y8EQAjIZGhTbjVWZVx60iQ8MbH85tmop/BUCORcH0Q3g4Ov41AMSbR/2jkCkG+ll3YT+lh20qFKHO
    U8VLMbxDqjDf7jxokOOU5w==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=1FiBMPE2lCMA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=-VAfIpHNAAAA:8 a=5mpuRNi4AAAA:8 a=ag1SF4gXAAAA:8
    a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=lTbjQzD5AAAA:8
    a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=T4DKFURFxS8N7kdTdKIA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=eHWn0xJZPbZ7L6UZR85b:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=Fp8MccfUoT0GBdDC_Lng:22 a=1CNFftbPRP8L7MoqJWF3:22 a=w8YF5asEQ23juLwKoPR8:22
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+hoNwLuvk+25ZhysfxXUze+TG4Dlt8+tZ7ysG3ofR1Lou55wYFhv8ZJGI5lvBnbWfHtTGkgw==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: bcm2835-audio: Disconnect and free vchi_instance
 on module_exit()
Date: Tue, 24 Apr 2018 21:57:29 +0200
Message-Id: <20180424195729.8433-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
References: <9e4fc4a0-370b-9101-2809-4040de58553c@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 Kirill Marinushkin <k.marinushkin@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the current implementation, vchi_instance is inited during the first
call of bcm2835_audio_open_connection(), and is never freed. It causes a
memory leak when the module `snd_bcm2835` is removed.

Here is how this commit fixes it:

* the VCHI context (including vchi_instance) is created once in the
  platform's devres
* the VCHI context is allocated and connected once during module_init()
* all created bcm2835_chips have a pointer to this VCHI context
* bcm2835_audio_open_connection() can access the VCHI context through the
  associated bcm2835_chip
* the VCHI context is disconnected and freed once during module_exit()

After this commit is applied, I don't see other issues with the module's
init/exit, so I also remove the associated TODO task.

Steps to reproduce the memory leak before this commit:

~~~~
root@raspberrypi:/home/pi# aplay test0.wav
Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
^CAborted by signal Interrupt...
root@raspberrypi:/home/pi# rmmod snd_bcm2835
root@raspberrypi:/home/pi# modprobe snd_bcm2835
root@raspberrypi:/home/pi# aplay test0.wav
Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
^CAborted by signal Interrupt...
root@raspberrypi:/home/pi# echo scan > /sys/kernel/debug/kmemleak
root@raspberrypi:/home/pi# cat /sys/kernel/debug/kmemleak
unreferenced object 0xb6794c00 (size 128):
  comm "aplay", pid 406, jiffies 36870 (age 116.650s)
  hex dump (first 32 bytes):
    08 a5 82 81 01 00 00 00 08 4c 79 b6 08 4c 79 b6  .........Ly..Ly.
    00 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff  .........N......
  backtrace:
    [<802af5e0>] kmem_cache_alloc_trace+0x294/0x3d0
    [<806ce620>] vchiq_initialise+0x98/0x1b0
    [<806d0b34>] vchi_initialise+0x24/0x34
    [<7f1311ec>] 0x7f1311ec
    [<7f1303bc>] 0x7f1303bc
    [<7f130590>] 0x7f130590
    [<7f111fd8>] snd_pcm_open_substream+0x68/0xc4 [snd_pcm]
    [<7f112108>] snd_pcm_open+0xd4/0x248 [snd_pcm]
    [<7f112334>] snd_pcm_playback_open+0x4c/0x6c [snd_pcm]
    [<7f0e250c>] snd_open+0xa8/0x14c [snd]
    [<802ce590>] chrdev_open+0xac/0x188
    [<802c57b4>] do_dentry_open+0x10c/0x314
    [<802c6ba8>] vfs_open+0x5c/0x88
    [<802d9a68>] path_openat+0x368/0x944
    [<802dacd4>] do_filp_open+0x70/0xc4
    [<802c6f70>] do_sys_open+0x110/0x1d4
~~~~

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
---
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 64 +++++++++++++---------
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 43 ++++++++++++++-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  | 12 ++++
 3 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 3c6f1d91d22d..389a18f9350a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -33,7 +33,6 @@
 
 /* ---- Include Files -------------------------------------------------------- */
 
-#include "interface/vchi/vchi.h"
 #include "vc_vchi_audioserv_defs.h"
 
 /* ---- Private Constants and Types ------------------------------------------ */
@@ -371,14 +370,46 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
 	return 0;
 }
 
+int bcm2835_new_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
+{
+	int ret;
+
+	/* Initialize and create a VCHI connection */
+	ret = vchi_initialise(&vchi_ctx->vchi_instance);
+	if (ret) {
+		LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
+			__func__, ret);
+
+		return -EIO;
+	}
+
+	ret = vchi_connect(NULL, 0, vchi_ctx->vchi_instance);
+	if (ret) {
+		LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
+			__func__, ret);
+
+		kfree(vchi_ctx->vchi_instance);
+		vchi_ctx->vchi_instance = NULL;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
+{
+	/* Close the VCHI connection - it will also free vchi_instance */
+	WARN_ON(vchi_disconnect(vchi_ctx->vchi_instance));
+
+	vchi_ctx->vchi_instance = NULL;
+}
+
 static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream)
 {
-	static VCHI_INSTANCE_T vchi_instance;
-	static VCHI_CONNECTION_T *vchi_connection;
-	static int initted;
 	struct bcm2835_audio_instance *instance =
 		(struct bcm2835_audio_instance *)alsa_stream->instance;
-	int ret;
+	struct bcm2835_vchi_ctx *vhci_ctx = alsa_stream->chip->vchi_ctx;
 
 	LOG_INFO("%s: start\n", __func__);
 	BUG_ON(instance);
@@ -390,28 +421,9 @@ static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream
 		return 0;
 	}
 
-	/* Initialize and create a VCHI connection */
-	if (!initted) {
-		ret = vchi_initialise(&vchi_instance);
-		if (ret) {
-			LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
-				__func__, ret);
-
-			return -EIO;
-		}
-		ret = vchi_connect(NULL, 0, vchi_instance);
-		if (ret) {
-			LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
-				__func__, ret);
-
-			kfree(vchi_instance);
-			return -EIO;
-		}
-		initted = 1;
-	}
-
 	/* Initialize an instance of the audio service */
-	instance = vc_vchi_audio_init(vchi_instance, &vchi_connection, 1);
+	instance = vc_vchi_audio_init(vhci_ctx->vchi_instance,
+				      &vhci_ctx->vchi_connection, 1);
 
 	if (IS_ERR(instance)) {
 		LOG_ERR("%s: failed to initialize audio service\n", __func__);
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 9030d71a3d0b..662e05bd8f05 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -65,6 +65,36 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
 	return 0;
 }
 
+static void bcm2835_devm_free_vchi_ctx(struct device *dev, void *res)
+{
+	struct bcm2835_vchi_ctx *vchi_ctx = res;
+
+	bcm2835_free_vchi_ctx(vchi_ctx);
+}
+
+static int bcm2835_devm_add_vchi_ctx(struct device *dev)
+{
+	struct bcm2835_vchi_ctx *vchi_ctx;
+	int ret;
+
+	vchi_ctx = devres_alloc(bcm2835_devm_free_vchi_ctx, sizeof(*vchi_ctx),
+				GFP_KERNEL);
+	if (!vchi_ctx)
+		return -ENOMEM;
+
+	memset(vchi_ctx, 0, sizeof(*vchi_ctx));
+
+	ret = bcm2835_new_vchi_ctx(vchi_ctx);
+	if (ret) {
+		devres_free(vchi_ctx);
+		return ret;
+	}
+
+	devres_add(dev, vchi_ctx);
+
+	return 0;
+}
+
 static void snd_bcm2835_release(struct device *dev)
 {
 	struct bcm2835_chip *chip = dev_get_drvdata(dev);
@@ -106,8 +136,6 @@ static int snd_bcm2835_dev_free(struct snd_device *device)
 	struct bcm2835_chip *chip = device->device_data;
 	struct snd_card *card = chip->card;
 
-	/* TODO: free pcm, ctl */
-
 	snd_device_free(card, chip);
 
 	return 0;
@@ -133,6 +161,13 @@ static int snd_bcm2835_create(struct snd_card *card,
 
 	chip->card = card;
 
+	chip->vchi_ctx = devres_find(card->dev->parent,
+				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
+	if (!chip->vchi_ctx) {
+		kfree(chip);
+		return -ENODEV;
+	}
+
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err) {
 		kfree(chip);
@@ -403,6 +438,10 @@ static int snd_bcm2835_alsa_probe_dt(struct platform_device *pdev)
 			 numchans);
 	}
 
+	err = bcm2835_devm_add_vchi_ctx(dev);
+	if (err)
+		return err;
+
 	err = snd_add_child_devices(dev, numchans);
 	if (err)
 		return err;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index f1e43e45fd67..1c82c2ee47dc 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -26,6 +26,8 @@
 #include <sound/pcm-indirect.h>
 #include <linux/workqueue.h>
 
+#include "interface/vchi/vchi.h"
+
 /*
  * #define AUDIO_DEBUG_ENABLE
  * #define AUDIO_VERBOSE_DEBUG_ENABLE
@@ -97,6 +99,11 @@ enum snd_bcm2835_ctrl {
 	PCM_PLAYBACK_DEVICE,
 };
 
+struct bcm2835_vchi_ctx {
+	VCHI_INSTANCE_T vchi_instance;
+	VCHI_CONNECTION_T *vchi_connection;
+};
+
 /* definition of the chip-specific record */
 struct bcm2835_chip {
 	struct snd_card *card;
@@ -115,6 +122,8 @@ struct bcm2835_chip {
 	unsigned int opened;
 	unsigned int spdif_status;
 	struct mutex audio_mutex;
+
+	struct bcm2835_vchi_ctx *vchi_ctx;
 };
 
 struct bcm2835_alsa_stream {
@@ -153,6 +162,9 @@ int snd_bcm2835_new_simple_pcm(struct bcm2835_chip *chip,
 int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip);
 int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip);
 
+int bcm2835_new_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx);
+void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx);
+
 int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
-- 
2.13.6

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
