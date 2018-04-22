Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406878-2-155421408082839302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406877; b=vXZOYvgzObSMXmc+5iX/za+GU0wuaSlkuJtwAuNJiq16NVqRbt
    Tv6XIkgV2Of7n0kFicjZ0B5eAS+LpjQwwOPa/IZfW8PyiuJKqVKwOtFb1BbcqL2h
    jk1HTl67mbwjK0ssm48kZbNG5bQ9D4+1swBZKaOMsLS9DCJBF0tBAUedZqf///Oc
    U1ufS0Rmbikca0/5V+Pg6rYBDPODausVW38DXFhVe5Pj4RFsng9+Vojv45qy4kXY
    Du2A1PU7ftsOWBVbjLMpN5w1ZoM3AyCzBrV1PEZey/dCH+hJkZrI78Y5PcWZG94D
    3wTkuaDo/fH6WBTeMG5L7RgrTJYH84nKi6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406877; bh=imLXDtg3SXSbD+emrNIUvWlCWyp276
    TJAyIDkZ+i+MA=; b=FVFBsLgoNOzFxjLQ+9KAHmjx+VB+zINX5crl1NdG6i5Fji
    eOaaBl2AC3HD4hMvhQn9VH98tN88vzCf0jKElF+uhjyxAcgY9kkApiaATlv2sqa0
    ywskZQn/F91ZfhanYt46LlEO0JoYFQiwnlVMWU4VNiDQ/NpdLvMKN8WMwaSGg/aR
    BtomeeZ9i/ms71c/VAr0COMxtWw8WMNGrhT54SPzZrqo/ISa9LnTpNsQhzHntKKB
    1iDlyQNTnIVNH9rsvGAaE7YlujkB2igbezbNS0vFdHAmiEvZYdNzvHi9pehrY9Vo
    S/SbG3kmJofSEWJLcriuA4EjfhYhVQU3L6JDpc9g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCFV77Tr1zagw+qb0E02PpN6fPzZOxf2Vz3vjzdQ43gbZGA15q7fHXIYaBy5T1ksvvq5Zby0OyCzx0r11O5v+h8fq57ptN/ICkB0T+m/Spu0M22Sq16o
    ARa1Uqen2ESsi7QdVkqrOUiPgOLYRLokvgnU2CIiYByIV03mb6ux/B0pS/ukHBThLDOQcxJZj+o0bWI1LUniXElzs4EOteZkGInUzwEqhHmOkC7akcgSrEII
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=OoYKBahV9t23uZWXziMA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757534AbeDVOVL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:21:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757511AbeDVOVE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:21:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+c4227aec125487ec3efa@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 33/52] ALSA: pcm: Avoid potential races between OSS ioctls and read/write
Date: Sun, 22 Apr 2018 15:54:06 +0200
Message-Id: <20180422135316.963756299@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 02a5d6925cd34c3b774bdb8eefb057c40a30e870 upstream.

Although we apply the params_lock mutex to the whole read and write
operations as well as snd_pcm_oss_change_params(), we may still face
some races.

First off, the params_lock is taken inside the read and write loop.
This is intentional for avoiding the too long locking, but it allows
the in-between parameter change, which might lead to invalid
pointers.  We check the readiness of the stream and set up via
snd_pcm_oss_make_ready() at the beginning of read and write, but it's
called only once, by assuming that it remains ready in the rest.

Second, many ioctls that may change the actual parameters
(i.e. setting runtime->oss.params=1) aren't protected, hence they can
be processed in a half-baked state.

This patch is an attempt to plug these holes.  The stream readiness
check is moved inside the read/write inner loop, so that the stream is
always set up in a proper state before further processing.  Also, each
ioctl that may change the parameter is wrapped with the params_lock
for avoiding the races.

The issues were triggered by syzkaller in a few different scenarios,
particularly the one below appearing as GPF in loopback_pos_update.

Reported-by: syzbot+c4227aec125487ec3efa@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |  134 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 106 insertions(+), 28 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -833,8 +833,8 @@ static int choose_rate(struct snd_pcm_su
 	return snd_pcm_hw_param_near(substream, params, SNDRV_PCM_HW_PARAM_RATE, best_rate, NULL);
 }
 
-static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
-				     bool trylock)
+/* call with params_lock held */
+static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hw_params *params, *sparams;
@@ -848,11 +848,8 @@ static int snd_pcm_oss_change_params(str
 	struct snd_mask sformat_mask;
 	struct snd_mask mask;
 
-	if (trylock) {
-		if (!(mutex_trylock(&runtime->oss.params_lock)))
-			return -EAGAIN;
-	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
-		return -ERESTARTSYS;
+	if (!runtime->oss.params)
+		return 0;
 	sw_params = kzalloc(sizeof(*sw_params), GFP_KERNEL);
 	params = kmalloc(sizeof(*params), GFP_KERNEL);
 	sparams = kmalloc(sizeof(*sparams), GFP_KERNEL);
@@ -1079,6 +1076,23 @@ failure:
 	kfree(sw_params);
 	kfree(params);
 	kfree(sparams);
+	return err;
+}
+
+/* this one takes the lock by itself */
+static int snd_pcm_oss_change_params(struct snd_pcm_substream *substream,
+				     bool trylock)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int err;
+
+	if (trylock) {
+		if (!(mutex_trylock(&runtime->oss.params_lock)))
+			return -EAGAIN;
+	} else if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		return -ERESTARTSYS;
+
+	err = snd_pcm_oss_change_params_locked(substream);
 	mutex_unlock(&runtime->oss.params_lock);
 	return err;
 }
@@ -1107,11 +1121,14 @@ static int snd_pcm_oss_get_active_substr
 	return 0;
 }
 
+/* call with params_lock held */
 static int snd_pcm_oss_prepare(struct snd_pcm_substream *substream)
 {
 	int err;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
+	if (!runtime->oss.prepare)
+		return 0;
 	err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_PREPARE, NULL);
 	if (err < 0) {
 		pcm_dbg(substream->pcm,
@@ -1131,8 +1148,6 @@ static int snd_pcm_oss_make_ready(struct
 	struct snd_pcm_runtime *runtime;
 	int err;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (runtime->oss.params) {
 		err = snd_pcm_oss_change_params(substream, false);
@@ -1140,6 +1155,29 @@ static int snd_pcm_oss_make_ready(struct
 			return err;
 	}
 	if (runtime->oss.prepare) {
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
+		err = snd_pcm_oss_prepare(substream);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+/* call with params_lock held */
+static int snd_pcm_oss_make_ready_locked(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime;
+	int err;
+
+	runtime = substream->runtime;
+	if (runtime->oss.params) {
+		err = snd_pcm_oss_change_params_locked(substream);
+		if (err < 0)
+			return err;
+	}
+	if (runtime->oss.prepare) {
 		err = snd_pcm_oss_prepare(substream);
 		if (err < 0)
 			return err;
@@ -1367,13 +1405,14 @@ static ssize_t snd_pcm_oss_write1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
-	if ((tmp = snd_pcm_oss_make_ready(substream)) < 0)
-		return tmp;
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
 			break;
 		}
+		tmp = snd_pcm_oss_make_ready_locked(substream);
+		if (tmp < 0)
+			goto err;
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			tmp = bytes;
 			if (tmp + runtime->oss.buffer_used > runtime->oss.period_bytes)
@@ -1474,13 +1513,14 @@ static ssize_t snd_pcm_oss_read1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
-	if ((tmp = snd_pcm_oss_make_ready(substream)) < 0)
-		return tmp;
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
 			break;
 		}
+		tmp = snd_pcm_oss_make_ready_locked(substream);
+		if (tmp < 0)
+			goto err;
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			if (runtime->oss.buffer_used == 0) {
 				tmp = snd_pcm_oss_read2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
@@ -1536,10 +1576,12 @@ static int snd_pcm_oss_reset(struct snd_
 			continue;
 		runtime = substream->runtime;
 		snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare = 1;
 		runtime->oss.buffer_used = 0;
 		runtime->oss.prev_hw_ptr_period = 0;
 		runtime->oss.period_ptr = 0;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return 0;
 }
@@ -1625,9 +1667,10 @@ static int snd_pcm_oss_sync(struct snd_p
 			goto __direct;
 		if ((err = snd_pcm_oss_make_ready(substream)) < 0)
 			return err;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		format = snd_pcm_oss_format_from(runtime->oss.format);
 		width = snd_pcm_format_physical_width(format);
-		mutex_lock(&runtime->oss.params_lock);
 		if (runtime->oss.buffer_used > 0) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm, "sync: buffer_used\n");
@@ -1695,7 +1738,9 @@ static int snd_pcm_oss_sync(struct snd_p
 		substream->f_flags = saved_f_flags;
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.prepare = 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 
 	substream = pcm_oss_file->streams[SNDRV_PCM_STREAM_CAPTURE];
@@ -1706,8 +1751,10 @@ static int snd_pcm_oss_sync(struct snd_p
 		err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DROP, NULL);
 		if (err < 0)
 			return err;
+		mutex_lock(&runtime->oss.params_lock);
 		runtime->oss.buffer_used = 0;
 		runtime->oss.prepare = 1;
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return 0;
 }
@@ -1726,10 +1773,13 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 1000;
 		else if (rate > 192000)
 			rate = 192000;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
 		}
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return snd_pcm_oss_get_rate(pcm_oss_file);
 }
@@ -1757,10 +1807,13 @@ static int snd_pcm_oss_set_channels(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
 		}
+		mutex_unlock(&runtime->oss.params_lock);
 	}
 	return snd_pcm_oss_get_channels(pcm_oss_file);
 }
@@ -1846,10 +1899,13 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
+			if (mutex_lock_interruptible(&runtime->oss.params_lock))
+				return -ERESTARTSYS;
 			if (runtime->oss.format != format) {
 				runtime->oss.params = 1;
 				runtime->oss.format = format;
 			}
+			mutex_unlock(&runtime->oss.params_lock);
 		}
 	}
 	return snd_pcm_oss_get_format(pcm_oss_file);
@@ -1869,8 +1925,6 @@ static int snd_pcm_oss_set_subdivide1(st
 {
 	struct snd_pcm_runtime *runtime;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (subdivide == 0) {
 		subdivide = runtime->oss.subdivision;
@@ -1894,9 +1948,16 @@ static int snd_pcm_oss_set_subdivide(str
 
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
+		struct snd_pcm_runtime *runtime;
+
 		if (substream == NULL)
 			continue;
-		if ((err = snd_pcm_oss_set_subdivide1(substream, subdivide)) < 0)
+		runtime = substream->runtime;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
+		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (err < 0)
 			return err;
 	}
 	return err;
@@ -1906,8 +1967,6 @@ static int snd_pcm_oss_set_fragment1(str
 {
 	struct snd_pcm_runtime *runtime;
 
-	if (substream == NULL)
-		return 0;
 	runtime = substream->runtime;
 	if (runtime->oss.subdivision || runtime->oss.fragshift)
 		return -EINVAL;
@@ -1927,9 +1986,16 @@ static int snd_pcm_oss_set_fragment(stru
 
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
+		struct snd_pcm_runtime *runtime;
+
 		if (substream == NULL)
 			continue;
-		if ((err = snd_pcm_oss_set_fragment1(substream, val)) < 0)
+		runtime = substream->runtime;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
+		err = snd_pcm_oss_set_fragment1(substream, val);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (err < 0)
 			return err;
 	}
 	return err;
@@ -2013,6 +2079,9 @@ static int snd_pcm_oss_set_trigger(struc
 	}
       	if (psubstream) {
       		runtime = psubstream->runtime;
+		cmd = 0;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (trigger & PCM_ENABLE_OUTPUT) {
 			if (runtime->oss.trigger)
 				goto _skip1;
@@ -2030,13 +2099,19 @@ static int snd_pcm_oss_set_trigger(struc
 			cmd = SNDRV_PCM_IOCTL_DROP;
 			runtime->oss.prepare = 1;
 		}
-		err = snd_pcm_kernel_ioctl(psubstream, cmd, NULL);
-		if (err < 0)
-			return err;
-	}
  _skip1:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (cmd) {
+			err = snd_pcm_kernel_ioctl(psubstream, cmd, NULL);
+			if (err < 0)
+				return err;
+		}
+	}
 	if (csubstream) {
       		runtime = csubstream->runtime;
+		cmd = 0;
+		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+			return -ERESTARTSYS;
 		if (trigger & PCM_ENABLE_INPUT) {
 			if (runtime->oss.trigger)
 				goto _skip2;
@@ -2051,11 +2126,14 @@ static int snd_pcm_oss_set_trigger(struc
 			cmd = SNDRV_PCM_IOCTL_DROP;
 			runtime->oss.prepare = 1;
 		}
-		err = snd_pcm_kernel_ioctl(csubstream, cmd, NULL);
-		if (err < 0)
-			return err;
-	}
  _skip2:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (cmd) {
+			err = snd_pcm_kernel_ioctl(csubstream, cmd, NULL);
+			if (err < 0)
+				return err;
+		}
+	}
 	return 0;
 }
 
