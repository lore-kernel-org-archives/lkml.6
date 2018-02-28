Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834038-2-16532043853625212567
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834037; b=epuCuww1NRGBHPZDazZssqNKd6EXpD/Bagfu3PU+4nozMju
    u6k67covOE0aqi4AvWKUC2NV9wNvGgwheSMb9U8YGiq0J81tPMPL+2nFha67LIds
    KOYnB0tOA4eyEuWdDLeg1/UmsigftUAGmV9GaGrcc3r/JxzX4mKs5JK8fgQbU1ra
    FpSA5mKmLX94IEV5VoZrOn0j9inYmP7ZDdqotX6Qyc8olifOd876kDszwJgCR3oY
    KAVJhrAsOOFPXjYjWxXbGo8fDx3kcbEE4XGYrXG6jmIxsrnShkZj/Qk3K7vtptlj
    Ikpp+j2czaXEyepuX5wVRk5drXP3L2YMbWLcMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834037; bh=MHTYMAWVDsOsY1G61cT
    o7Q0XzjsWJV1a3FqNPTlVSpI=; b=DXLoJ6DHU0q74y9F8GJMXKKvJlCZj8qwssp
    DvdPxFBSNn8yqhKj+qRJYbM3Jrio+1cUq59HrpJNsVvYGkmZt2GDSP1lJR8i3m1p
    Ka2CnxyazWPZZMNEsxg6WrtT1mFIqDu/Ny8qZv9w716DAkzJDhbIHOF1XdfzRFU0
    BQleTbyKlIK/muN0i/hTt0sUMbn4Z8sLXCIHqxZF1vJfWC3uS7stEP7iWlzZJ40W
    fq8VQdTK/ZFpDN1q929oENFODSAcoVh45s4pfJoeATuLPReUkVBXKYXbkGUEq8gt
    gr7m8SUQZsiq1rrsvTWI/zeoJWANs4TKzOj+c44FKoTOlqPo4eQ==
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
        id S934386AbeB1QHI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:07:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34884 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932383AbeB1QFY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.258198970@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 163/254] ALSA: pcm: Add missing error checks in OSS
 emulation plugin builder
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

commit 6708913750344a900f2e73bfe4a4d6dbbce4fe8d upstream.

In the OSS emulation plugin builder where the frame size is parsed in
the plugin chain, some places miss the possible errors returned from
the plugin src_ or dst_frames callback.

This patch papers over such places.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/oss/pcm_plugin.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -591,18 +591,26 @@ snd_pcm_sframes_t snd_pcm_plug_write_tra
 	snd_pcm_sframes_t frames = size;
 
 	plugin = snd_pcm_plug_first(plug);
-	while (plugin && frames > 0) {
+	while (plugin) {
+		if (frames <= 0)
+			return frames;
 		if ((next = plugin->next) != NULL) {
 			snd_pcm_sframes_t frames1 = frames;
-			if (plugin->dst_frames)
+			if (plugin->dst_frames) {
 				frames1 = plugin->dst_frames(plugin, frames);
+				if (frames1 <= 0)
+					return frames1;
+			}
 			if ((err = next->client_channels(next, frames1, &dst_channels)) < 0) {
 				return err;
 			}
 			if (err != frames1) {
 				frames = err;
-				if (plugin->src_frames)
+				if (plugin->src_frames) {
 					frames = plugin->src_frames(plugin, frames1);
+					if (frames <= 0)
+						return frames;
+				}
 			}
 		} else
 			dst_channels = NULL;
