Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325870-2-4540492704933706114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325870; b=j4P0uWLrwIBh5VIhqbXaaK8WrRQjFnAQpC7lAWRlJH2BjjU
    5QdedBwu1QmspIpFMeBR5ly40VBkSBr6AeKwnAI2EOmmS3K854j3eTCK/QRHBk/1
    bpQeu2L+GChdP2aAQBFdn1oNlnx8jvCC4lJLO6yG15KrGi7CBGBzNWtTL7YgX6xw
    SoZQEvMwv9w3RcuKWhV8R4NUXETB3jT6LdeLBQeTNPhSvc33yC4aJ/Zs3Xx4zxUo
    dPj6ynHwq0p/3uwK9V7RoA5VUootxD4TDgYBmVDT4eK0AfKHRXX2f/GHa3Vhhigj
    +6Q1KuCEn1eWyzQ5V36gST4e39daISzHRPwcdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325870; bh=LSAVzs7QWc1tOWUkIkr
    VPrk/joGxHI3gA6dkvNj2kKE=; b=OAA/66Kf1NbwyNPlBvmA3loREP2J7g20xY1
    KX7XKzKVQmNR+h0NPm2njCnC4/H7+od+z2zU65bgyZyKehrVT9NuN5emmGG/MisX
    MChexCGFBCxIyNboI5mKGn74bXbDrlD1fK4T1ed4fPrJl/0Fvluz4arZu+46HS0m
    P+nAugvIXok1hHK58arqwzS5a/dx7/AinTT/QJF99qc5Ncn3aQSdRIxyuZSmQk7+
    vi9whoInoRyG85qTj4ozVKOe9TTcSQiXmKvlMrGx4+iAUoEO+NlXw8Pd5LG/j5gi
    JGx1ZLGlYMCDGZsf1pWWHUUfhqv1omAhU7qnccwpioOe3V0y6tA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeBKFLG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:11:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41434 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752643AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Andrey Konovalov" <andreyknvl@google.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.750552139@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 55/79] ALSA: usb-audio: Add sanity checks to FE parser
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit d937cd6790a2bef2d07b500487646bd794c039bb upstream.

When the usb-audio descriptor contains the malformed feature unit
description with a too short length, the driver may access
out-of-bounds.  Add a sanity check of the header size at the beginning
of parse_audio_feature_unit().

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.2: use snd_printk() for logging]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1255,6 +1255,12 @@ static int parse_audio_feature_unit(stru
 	__u8 *bmaControls;
 
 	if (state->mixer->protocol == UAC_VERSION_1) {
+		if (hdr->bLength < 7) {
+			snd_printk(KERN_ERR
+				   "usbaudio: unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				   unitid);
+			return -EINVAL;
+		}
 		csize = hdr->bControlSize;
 		if (!csize) {
 			snd_printdd(KERN_ERR "usbaudio: unit %u: "
@@ -1271,6 +1277,12 @@ static int parse_audio_feature_unit(stru
 		}
 	} else {
 		struct uac2_feature_unit_descriptor *ftr = _ftr;
+		if (hdr->bLength < 6) {
+			snd_printk(KERN_ERR
+				   "usbaudio: unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				   unitid);
+			return -EINVAL;
+		}
 		csize = 4;
 		channels = (hdr->bLength - 6) / 4 - 1;
 		bmaControls = ftr->bmaControls;
