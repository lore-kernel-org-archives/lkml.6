Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406121-2-5202935674307827643
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
    1524406120; b=E9ZpKfAjqCU6cQqtPn5psXg4Ev9SS6/GOT8W5ChfkoO0XDvJgM
    HjOG4mlLlN8p/EauyMXLi4B6/T5XnlDmi0B5fhiuN4GMyjPAuVlU8sK4SnLDVxzI
    OAbgCWYFvKfP/K1sxYCfPqXVFQKOmVnVBJFkWqDbpA963uJ5K1y69A6VwyLUcX2N
    7Uonmbz02cncdg1PO5PY2YB/pkxPz4pT/KipneLpoZlHsmVRLZeOEZK8TTXJwUbT
    B3YrlZGUU5fmqcmCGskD3DL2ZQiHxK6ALFnYiVbbY6DpShkme8cvS/yLkBw9fCi7
    wg0fAwn7aNjTAIAFwTBIiLqvOXvOFC/oIsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406120; bh=AT9cfOE8q0fmto1x3+C+HvHt3J8Dlx
    W1hiuxxykwmSQ=; b=PKhopXcb22ejmX35LXiut6XO6xSjaqRRR5+l1onodYhzdO
    P0m0WIhnjKLJAcX7HyWKDE0PTyYiBfXlxDBIGlmkZzjiI5niRiT7SjUPR7SfXDWY
    kVAm4JPmsj64+aizqP3Fc/nc27N2c5YctpvMB8Db47xUkmhwkiUhh31aaVsbsOVY
    jPNOTkAQGH8/kij8sHZSPErd2cSv9Wvje4mwrlp/uEVg1eTKE4VrGSxXfcusCmHn
    pwugtCNkrNE7VFkw3Gq9PwsDG1bgL2XJcDN4TI9o8l9tyabUWsvvPgbm65HlWS2B
    KV8of7Y0iVc7HBFigoQva1Fazkrr1pqy5MQ2lLGg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfGy3dN+XQ3mP8SoXzRFah1OU+6xO5s2gq+CKykr71z8CguTusNvBYUGNo2ym7eBRzOwgsmDvb9FZabcEIrmCk/h2quOzb+i87s2I+/A4pdOYYPZP5vFQ
    K4IZNBPEIsTBYNAamhXtKj4+e0k68/IS7QIsKuy7wOGPE4hwwW3rVlJ0qhOUw1rNqhGC3ouRZgaoYy00N8aFCXAhk+vlka6l2b/Ivgedk0pO1zMDtfweOg0x
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=aLJ7TmNuWhDDgIU_xPUA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755712AbeDVOIe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:08:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755988AbeDVOId (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:08:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 118/164] ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
Date: Sun, 22 Apr 2018 15:53:05 +0200
Message-Id: <20180422135140.237609317@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f6d297df4dd47ef949540e4a201230d0c5308325 upstream.

The previous fix 40cab6e88cb0 ("ALSA: pcm: Return -EBUSY for OSS
ioctls changing busy streams") introduced some mutex unbalance; the
check of runtime->oss.rw_ref was inserted in a wrong place after the
mutex lock.

This patch fixes the inconsistency by rewriting with the helper
functions to lock/unlock parameters with the stream check.

Fixes: 40cab6e88cb0 ("ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/oss/pcm_oss.c |   67 +++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -823,6 +823,23 @@ static int choose_rate(struct snd_pcm_su
 	return snd_pcm_hw_param_near(substream, params, SNDRV_PCM_HW_PARAM_RATE, best_rate, NULL);
 }
 
+/* parameter locking: returns immediately if tried during streaming */
+static int lock_params(struct snd_pcm_runtime *runtime)
+{
+	if (mutex_lock_interruptible(&runtime->oss.params_lock))
+		return -ERESTARTSYS;
+	if (atomic_read(&runtime->oss.rw_ref)) {
+		mutex_unlock(&runtime->oss.params_lock);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static void unlock_params(struct snd_pcm_runtime *runtime)
+{
+	mutex_unlock(&runtime->oss.params_lock);
+}
+
 /* call with params_lock held */
 static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 {
@@ -1721,6 +1738,8 @@ static int snd_pcm_oss_set_rate(struct s
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
@@ -1728,15 +1747,14 @@ static int snd_pcm_oss_set_rate(struct s
 			rate = 1000;
 		else if (rate > 192000)
 			rate = 192000;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		if (runtime->oss.rate != rate) {
 			runtime->oss.params = 1;
 			runtime->oss.rate = rate;
 		}
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 	}
 	return snd_pcm_oss_get_rate(pcm_oss_file);
 }
@@ -1761,18 +1779,19 @@ static int snd_pcm_oss_set_channels(stru
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		if (runtime->oss.channels != channels) {
 			runtime->oss.params = 1;
 			runtime->oss.channels = channels;
 		}
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 	}
 	return snd_pcm_oss_get_channels(pcm_oss_file);
 }
@@ -1845,6 +1864,7 @@ static int snd_pcm_oss_get_formats(struc
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
 {
 	int formats, idx;
+	int err;
 	
 	if (format != AFMT_QUERY) {
 		formats = snd_pcm_oss_get_formats(pcm_oss_file);
@@ -1858,15 +1878,14 @@ static int snd_pcm_oss_set_format(struct
 			if (substream == NULL)
 				continue;
 			runtime = substream->runtime;
-			if (atomic_read(&runtime->oss.rw_ref))
-				return -EBUSY;
-			if (mutex_lock_interruptible(&runtime->oss.params_lock))
-				return -ERESTARTSYS;
+			err = lock_params(runtime);
+			if (err < 0)
+				return err;
 			if (runtime->oss.format != format) {
 				runtime->oss.params = 1;
 				runtime->oss.format = format;
 			}
-			mutex_unlock(&runtime->oss.params_lock);
+			unlock_params(runtime);
 		}
 	}
 	return snd_pcm_oss_get_format(pcm_oss_file);
@@ -1914,12 +1933,11 @@ static int snd_pcm_oss_set_subdivide(str
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		err = snd_pcm_oss_set_subdivide1(substream, subdivide);
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 		if (err < 0)
 			return err;
 	}
@@ -1954,12 +1972,11 @@ static int snd_pcm_oss_set_fragment(stru
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
-		if (atomic_read(&runtime->oss.rw_ref))
-			return -EBUSY;
-		if (mutex_lock_interruptible(&runtime->oss.params_lock))
-			return -ERESTARTSYS;
+		err = lock_params(runtime);
+		if (err < 0)
+			return err;
 		err = snd_pcm_oss_set_fragment1(substream, val);
-		mutex_unlock(&runtime->oss.params_lock);
+		unlock_params(runtime);
 		if (err < 0)
 			return err;
 	}
