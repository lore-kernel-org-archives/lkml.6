Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838609-2-10663393958068895316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838608; b=kVRhdRV/R4A9qW/lT9Gn9SqZBmHlofSbxXlO3+iuVh2062W
    5sRiUo59Hl5xpuQ6DnFW/VpBQUFM42wWgPAOnkBilnC2rtogB6IDM+6TndU46vEH
    1h83Gfza66XjrGbFoGlfZnU0Ckw7MH6O73p7avhzlSIVRob6neE6QOQuC3HnvluD
    K2O4g/5DzY3bMS615p4TM3z6AXkZBlMCdSAa0HcTHG1uFOqoJn54KcK8yQdP3SC0
    ls1nlT0DL56AEP6tqryvmcAs0gAbMhnKv1plcU/ei+3X5kyWkQAjjYA6B7cJ+T2R
    c5/bCIaDLxfSr/HK1ip6iPaiWgT2RSFITt7+IjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838608; bh=n9/nxaedlhYsPKx5sF+
    iVPGu0Hkiuvnv2t9MtwQD+9o=; b=UHvpBFVyTOoNESTqO9HlH/RgBDtgPkTpUCq
    jWFaI9T5n8L2IaP+f+gkkok+bk1GSXcz3MEUMshdwaW7rdcxpaE31z/BviVu4BFL
    oF6LqH4/PfJ/VI77zirUmkLupb0e0fj6o2geVsAXlmm66xdL8S2/ctQu8nahIAKr
    Qi1wIzGzYpD8xd+qcP5b3IXuBBJuLNfe9sG81yaYFfO05pZ+uccoyGYSRnBmL6fW
    ulCWPC13zHMKOYfSH3mqHiOffHWwUURNTq7AwV245ccgvJKfGAwAIFBzWxnYqD/y
    o8kLyI213BA9ztgMzQRn8QOSo1KawsBgilwF/ZN6LLZIOwDldiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeB1RXY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:23:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33321 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932627AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.108486295@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 085/140] ALSA: aloop: Release cable upon open error path
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 9685347aa0a5c2869058ca6ab79fd8e93084a67f upstream.

The aloop runtime object and its assignment in the cable are left even
when opening a substream fails.  This doesn't mean any memory leak,
but it still keeps the invalid pointer that may be referred by the
another side of the cable spontaneously, which is a potential Oops
cause.

Clean up the cable assignment and the empty cable upon the error path
properly.

Fixes: 597603d615d2 ("ALSA: introduce the snd-aloop module for the PCM loopback")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/drivers/aloop.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -648,12 +648,31 @@ static int rule_channels(struct snd_pcm_
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
+static void free_cable(struct snd_pcm_substream *substream)
+{
+	struct loopback *loopback = substream->private_data;
+	int dev = get_cable_index(substream);
+	struct loopback_cable *cable;
+
+	cable = loopback->cables[substream->number][dev];
+	if (!cable)
+		return;
+	if (cable->streams[!substream->stream]) {
+		/* other stream is still alive */
+		cable->streams[substream->stream] = NULL;
+	} else {
+		/* free the cable */
+		loopback->cables[substream->number][dev] = NULL;
+		kfree(cable);
+	}
+}
+
 static int loopback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm;
-	struct loopback_cable *cable;
+	struct loopback_cable *cable = NULL;
 	int err = 0;
 	int dev = get_cable_index(substream);
 
@@ -673,7 +692,6 @@ static int loopback_open(struct snd_pcm_
 	if (!cable) {
 		cable = kzalloc(sizeof(*cable), GFP_KERNEL);
 		if (!cable) {
-			kfree(dpcm);
 			err = -ENOMEM;
 			goto unlock;
 		}
@@ -715,6 +733,10 @@ static int loopback_open(struct snd_pcm_
 	else
 		runtime->hw = cable->hw;
  unlock:
+	if (err < 0) {
+		free_cable(substream);
+		kfree(dpcm);
+	}
 	mutex_unlock(&loopback->cable_lock);
 	return err;
 }
@@ -723,20 +745,10 @@ static int loopback_close(struct snd_pcm
 {
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
-	struct loopback_cable *cable;
-	int dev = get_cable_index(substream);
 
 	loopback_timer_stop(dpcm);
 	mutex_lock(&loopback->cable_lock);
-	cable = loopback->cables[substream->number][dev];
-	if (cable->streams[!substream->stream]) {
-		/* other stream is still alive */
-		cable->streams[substream->stream] = NULL;
-	} else {
-		/* free the cable */
-		loopback->cables[substream->number][dev] = NULL;
-		kfree(cable);
-	}
+	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
