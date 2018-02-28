Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836179-2-12868214862517170720
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
    t=1519836178; b=iVBSsFQ1LSVdEPPmnsMZnFPu9/LVLjfEx8IciiSMzVHITks
    /tuR7Rz70U18x7jkgiP8Ld0J+GikJxW/PBP6T/7bAs4iD1mM2Otuz7Ic8uljUd6s
    oOYMbFg+FmAQySUlSqjGtNpkW6kLhmdFka9EYt1ttPxV9V1ZdNFiiK+zirwjpbBE
    u4FazOiHdhjmlGL+a5Qr0lk3/Qyj8IdjtxIW1f7VW/ejstG2oArDPIBwccR5EAYm
    Lg2tLmJLRgaEt2PtBLy/xAVRX6coEopoKtoLM/rvkHPnQ9OrFyF0Fd4rahkhjZUE
    xB/zbQvqPfplluyyZ5wVYBHUAWviLh1WLAoGmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836178; bh=CeBUPzw9YO+I0hw0CQZ
    2xn+LLX1EE/rX9WP5IiqE33Y=; b=dUlswk9PMjeaqg8wRvOT4oCs49VOqAsmK6t
    9AR6D0hNMRSuk/ogoif1UtIgZDCjScrP6rjqm32UePG7JI4m+DCqto7N40RlWIMA
    wIeucNYD/jt+xR20hVEv3d9bZr+fW5/mGqkpoRhK0gycsRThkW4kMZHa9E7Btet2
    lARXEgIlbJgukbJ1hsarn4YZybw2tJxmU1F797hGQc47HGHMWYOlfDB9KyI9YvaW
    CNCkGZRpkwW/euyyrTRgaQagil9E4j2kK0CYlvcE+oCvmL67NeO2IvtxPvFd5h0e
    fZF6vbI0nN6jLZVrchQkj5nj79RSGS8jbvx3KzhacKD11gUVb3g==
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
        id S932751AbeB1QDQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:03:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34749 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932699AbeB1QDO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.273446789@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 175/254] ALSA: aloop: Release cable upon open error path
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -659,12 +659,31 @@ static int rule_channels(struct snd_pcm_
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
 
@@ -683,7 +702,6 @@ static int loopback_open(struct snd_pcm_
 	if (!cable) {
 		cable = kzalloc(sizeof(*cable), GFP_KERNEL);
 		if (!cable) {
-			kfree(dpcm);
 			err = -ENOMEM;
 			goto unlock;
 		}
@@ -725,6 +743,10 @@ static int loopback_open(struct snd_pcm_
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
@@ -733,20 +755,10 @@ static int loopback_close(struct snd_pcm
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
