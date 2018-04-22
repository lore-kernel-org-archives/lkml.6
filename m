Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406520-2-14660124398019339424
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
    1524406519; b=ACqRDKHxuiPC+q+UhMMoxuu1rWip7EQzJtXFpI+4KAWs7OHFF9
    GwUd/ViamzRDHNx5d3+VyliQBPpYvf+jtEVhb7aH34mGiNWrzC7/merFMt1YSrDq
    8HA1shtkgTuy4P4Ut1UIX1EfEUnN/ZCmIBWTTZ1qCGo3svjS7giPu+xpuesWYLot
    3I4cSCtS7a4VmCVVa9ikeG7jWKq1kZLoE1ZlWmdkZUY55jognFTdrXtNt0KTl8hL
    2YAMkgEf3FpmFnMy1YZ6SteLTqQsPKnoBcq9gfdkJkXcEWJeiB3BKxgusQrBQMT4
    12EeESajhYvR1YUmgYnmVgFcOXeaFy/ZyZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406519; bh=3jezXGxzLPoVvsz354sKx1QU6rTOr8
    opMNyYEf7qyEY=; b=ieCxIFAoUyem4c/KQQ2oTheRANsqgmGiJvwHyJaeo6c+QY
    hOQ38t1b1ui6ZwJJuOg2ymDnBTO8wReun60/ITxsckIu6O3DcmwqGrX5IyNCpgOR
    zdJ1FN4ewPRJYZIFEswJwvn4zzoSGW3E86a7aIcqBXim+BLcKA6qmNjZP830wx/o
    VSv0ySP53SUTs3oCHm9PlppETnDih4GLQFrqCILnMS+B2ErtGoWq6Hy+5lAEmQV9
    raNrtkA6VhgqrkBrr0IOo3m0tP4rgpvHWz7ofaH4yvFypajQh8iqtVEWYHc8RffE
    nBGw3W7Sx7X+JQbA4M2XDUF/XFAY+V+3XF+LolxQ==
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
X-CM-Envelope: MS4wfFtepgjoVXcT51xRngqKzffXRdTgwoWWu8nyYWUacoqBgApEb/yL+znTko0hKQ9UumEljR+7bF9ZiUjZ0M7WQhBtKG0VyOA0NLoWN3HzmGs9At0xMCBE
    2eH/lUnSCTHZ8iE1oWvbpiB8Txrvy8h/khuGkcMoTL/h0DAX/8yQPgkzTbLrHuupL4yku238ZOKlPvJVc9TImE2AZaLvHSlAIrhfjFOEzwolD9OXrRmlBuSw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=aLJ7TmNuWhDDgIU_xPUA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932129AbeDVOPL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:15:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932094AbeDVOPI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:15:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 63/95] ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls
Date: Sun, 22 Apr 2018 15:53:32 +0200
Message-Id: <20180422135213.002616201@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -834,6 +834,23 @@ static int choose_rate(struct snd_pcm_su
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
@@ -1773,6 +1790,8 @@ static int snd_pcm_oss_set_rate(struct s
 	for (idx = 1; idx >= 0; --idx) {
 		struct snd_pcm_substream *substream = pcm_oss_file->streams[idx];
 		struct snd_pcm_runtime *runtime;
+		int err;
+
 		if (substream == NULL)
 			continue;
 		runtime = substream->runtime;
@@ -1780,15 +1799,14 @@ static int snd_pcm_oss_set_rate(struct s
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
@@ -1813,18 +1831,19 @@ static int snd_pcm_oss_set_channels(stru
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
@@ -1897,6 +1916,7 @@ static int snd_pcm_oss_get_formats(struc
 static int snd_pcm_oss_set_format(struct snd_pcm_oss_file *pcm_oss_file, int format)
 {
 	int formats, idx;
+	int err;
 	
 	if (format != AFMT_QUERY) {
 		formats = snd_pcm_oss_get_formats(pcm_oss_file);
@@ -1910,15 +1930,14 @@ static int snd_pcm_oss_set_format(struct
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
@@ -1966,12 +1985,11 @@ static int snd_pcm_oss_set_subdivide(str
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
@@ -2006,12 +2024,11 @@ static int snd_pcm_oss_set_fragment(stru
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
