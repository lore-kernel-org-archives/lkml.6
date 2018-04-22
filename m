Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406874-2-15874110052306781821
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406873; b=LXbWRZrYbQgo2b1WpyK2jJhjk8lqJRY3rvgHzD1cBlNODm55xX
    8OeH9k9RGEEclhocQNMSOa/i/x2epYSgHZ14ofGn5yHWwabZDqsBBONyvDrKwUmG
    o4KTT8HwBhcXhSftIkIZCDzeb09qPPkDoc7dL0P2ktQP0vRLVrSjzPPK2mYZ4d+Y
    otkoTdGYMLcMUJqRQpwxIFc0877iUW+YUeHveFBoUazZp8B8veSQutCPaTBUKA2T
    xISolBzvu/2J0ovBVOYuVJFpwtxWWNBVQmXDVUoRv7PjJc1L/0RLKWNdq+GNq70i
    dsFRK5mWG7CIV54sRgXeZaEPdkBsifujHs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406873; bh=tHFqfxaWGDHRHtTzoLAaKrUrDgsn/r
    0fFT6ynS+TnRY=; b=fMVB51zkSixSmZ+czzh0Ui+WqFGZhow6ILACEP/K3smnlC
    1yaAPigPNLmdTs8DxcLGqGeaLVsgXN2xaZxE+7ulDMmjDPNzXish78v4hW2yb1Mb
    OPQ1zhMF4abH1QNsN1zBCsaufIXrX0an9fvpQTpO8hgT77Vd4tsigxYtB1bxDEch
    dqPw0xs9QkPss5X2JAn7hXmLw1mF0iKoygWTBlqG6fHcyI+NFiDeQvKpv1myVIIq
    2OculwaUuG/TA8W7R1eU8+KfEfgR2lQnK1d2X1JT5lR/YOXSmMwQMz8t9zhddppA
    IGy0Q0szMwDpZMOKpXZ2p/C62F6d9LjtNLhO0dNA==
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
X-CM-Envelope: MS4wfFjExrOUbN8hjmFp0Phr0QBlrI570uPvNjEvTbtFxRByRrw5yCDJZgjI0/XneT8PtbeZ8F6MAQWqZ7lDQ+KCaEYXwRVEnZ+sh5aP7QBdg3brMun/APax
    GEIb4/s4tTuaPpOvbqkPfhrV7ji/ABi75Xu2loulhqE2Zpx3x9018OpYKq9+eoRRIOlVyyPyl2nBL+Zkcc1pGxQ2HODB+LTj0hSzmn+fI8aytg0PytL4OHXc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=KCxme9i-pAh4H1pcXl8A:9 a=QEXdDO2ut3YA:10
    a=HUqATDVKn4QA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755523AbeDVOVK (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:21:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756043AbeDVOVH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:21:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 34/52] ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams
Date: Sun, 22 Apr 2018 15:54:07 +0200
Message-Id: <20180422135317.006953444@linuxfoundation.org>
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

commit 40cab6e88cb0b6c56d3f30b7491a20e803f948f6 upstream.

OSS PCM stream management isn't modal but it allows ioctls issued at
any time for changing the parameters.  In the previous hardening
patch ("ALSA: pcm: Avoid potential races between OSS ioctls and
read/write"), we covered these races and prevent the corruption by
protecting the concurrent accesses via params_lock mutex.  However,
this means that some ioctls that try to change the stream parameter
(e.g. channels or format) would be blocked until the read/write
finishes, and it may take really long.

Basically changing the parameter while reading/writing is an invalid
operation, hence it's even more user-friendly from the API POV if it
returns -EBUSY in such a situation.

This patch adds such checks in the relevant ioctls with the addition
of read/write access refcount.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/pcm_oss.h  |    1 +
 sound/core/oss/pcm_oss.c |   36 +++++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

--- a/include/sound/pcm_oss.h
+++ b/include/sound/pcm_oss.h
@@ -57,6 +57,7 @@ struct snd_pcm_oss_runtime {
 	char *buffer;				/* vmallocated period */
 	size_t buffer_used;			/* used length from period buffer */
 	struct mutex params_lock;
+	atomic_t rw_ref;		/* concurrent read/write accesses */
 #ifdef CONFIG_SND_PCM_OSS_PLUGINS
 	struct snd_pcm_plugin *plugin_first;
 	struct snd_pcm_plugin *plugin_last;
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1405,6 +1405,7 @@ static ssize_t snd_pcm_oss_write1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1468,6 +1469,7 @@ static ssize_t snd_pcm_oss_write1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1513,6 +1515,7 @@ static ssize_t snd_pcm_oss_read1(struct
 	if (atomic_read(&substream->mmap_count))
 		return -ENXIO;
 
+	atomic_inc(&runtime->oss.rw_ref);
 	while (bytes > 0) {
 		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
 			tmp = -ERESTARTSYS;
@@ -1561,6 +1564,7 @@ static ssize_t snd_pcm_oss_read1(struct
 		}
 		tmp = 0;
 	}
+	atomic_dec(&runtime->oss.rw_ref);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1667,8 +1671,11 @@ static int snd_pcm_oss_sync(struct snd_p
 			goto __direct;
 		if ((err = snd_pcm_oss_make_ready(substream)) < 0)
 			return err;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		atomic_inc(&runtime->oss.rw_ref);
+		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
+			atomic_dec(&runtime->oss.rw_ref);
 			return -ERESTARTSYS;
+		}
 		format = snd_pcm_oss_format_from(runtime->oss.format);
 		width = snd_pcm_format_physical_width(format);
 		if (runtime->oss.buffer_used > 0) {
@@ -1680,10 +1687,8 @@ static int snd_pcm_oss_sync(struct snd_p
 						   runtime->oss.buffer + runtime->oss.buffer_used,
 						   size);
 			err = snd_pcm_oss_sync1(substream, runtime->oss.period_bytes);
-			if (err < 0) {
-				mutex_unlock(&runtime->oss.params_lock);
-				return err;
-			}
+			if (err < 0)
+				goto unlock;
 		} else if (runtime->oss.period_ptr > 0) {
 #ifdef OSS_DEBUG
 			pcm_dbg(substream->pcm, "sync: period_ptr\n");
@@ -1693,10 +1698,8 @@ static int snd_pcm_oss_sync(struct snd_p
 						   runtime->oss.buffer,
 						   size * 8 / width);
 			err = snd_pcm_oss_sync1(substream, size);
-			if (err < 0) {
-				mutex_unlock(&runtime->oss.params_lock);
-				return err;
-			}
+			if (err < 0)
+				goto unlock;
 		}
 		/*
 		 * The ALSA's period might be a bit large than OSS one.
@@ -1727,7 +1730,11 @@ static int snd_pcm_oss_sync(struct snd_p
 				snd_pcm_lib_writev(substream, buffers, size);
 			}
 		}
+unlock:
 		mutex_unlock(&runtime->oss.params_lock);
+		atomic_dec(&runtime->oss.rw_ref);
+		if (err < 0)
+			return err;
 		/*
 		 * finish sync: drain the buffer
 		 */
@@ -1775,6 +1782,8 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 192000;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
@@ -1809,6 +1818,8 @@ static int snd_pcm_oss_set_channels(stru
 		runtime = substream->runtime;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
@@ -1899,6 +1910,8 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
+			if (atomic_read(&runtime->oss.rw_ref))
+				return -EBUSY;
 			if (mutex_lock_interruptible(&runtime->oss.params_lock))
 				return -ERESTARTSYS;
 			if (runtime->oss.format != format) {
@@ -1953,6 +1966,8 @@ static int snd_pcm_oss_set_subdivide(str
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
@@ -1991,6 +2006,8 @@ static int snd_pcm_oss_set_fragment(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
+		if (atomic_read(&runtime->oss.rw_ref))
+			return -EBUSY;
 		if (mutex_lock_interruptible(&runtime->oss.params_lock))
 			return -ERESTARTSYS;
 		err = snd_pcm_oss_set_fragment1(substream, val);
@@ -2385,6 +2402,7 @@ static void snd_pcm_oss_init_substream(s
 	runtime->oss.maxfrags = 0;
 	runtime->oss.subdivision = 0;
 	substream->pcm_release = snd_pcm_oss_release_substream;
+	atomic_set(&runtime->oss.rw_ref, 0);
 }
 
 static int snd_pcm_oss_release_file(struct snd_pcm_oss_file *pcm_oss_file)
