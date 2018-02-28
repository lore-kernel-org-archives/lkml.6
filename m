Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837329-2-2140718948108333560
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
    t=1519837328; b=rjzHc28cDyT/gpcd6bNJJEimdmIFmBdOY9a3kDBWshXl/uk
    DzkvAQgyM7uXMtDG4HCHuzRwuft5ctCUqyEbyD/U7Q3YqJ7AQCOPSrEO9v8uu2Tz
    2EPL8JjF8GG2P3d0T+9Rx0rqNXQkuB0tq8vpxoAGqo2PIy/LeiWesqrDw9KSI+jF
    U79gidfKjbhgguPnaf0tsmuYS5v5kyyk7xiYQ7MzyxijEkR/3alXjmfztVGG3byU
    Pq2dIl//HJ21z84hm2UJJkcGoi92F126nPPpwPa/1lsLXgMV1UW65qqb2QCeBQFD
    Y+swXAVYPiEWRmR7TuMHwr/HcBEF+S7eggPG1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837328; bh=Hg6/rF56nWCt67Idhep
    M+YaUqPAhwziLQ4TNT14XkL0=; b=t5DMRRg+eH3fHL7RIj3fhQGmmu/ygGAJGjf
    cqhCSl53YIJOBe8hJElDUmDJT1Zg4pPo5wCB7vZ/RjlcInbW5BVZnat3d1h18A1C
    e53UqgJ7AypPK2Gzot5f4gzbbiVOwvVQqRFkWn+Z7kcpiYLVfzrULovomRApC9x2
    g4iEDJkB1SAGYSb1b94RcexJ1r5FMgQJgtn6S758IRZWNPKfDPnIH3G07st3u1t0
    oRbH4kIME6Tc1UF0+6w8v923INSfU8EP1rXSQOMrDxsELGeeLnj7QyzVBaGnvn0v
    E7zilwKAOA7hZxCnUYI9vNe/1cBdBlUB6LGDZNV9Iy+Nh+7mKWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932747AbeB1RBw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:01:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34369 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932696AbeB1PwE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:04 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.5007307@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 124/254] ALSA: usb-audio: Fix the missing ctl name
 suffix at parsing SU
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

commit 5a15f289ee87eaf33f13f08a4909ec99d837ec5f upstream.

The commit 89b89d121ffc ("ALSA: usb-audio: Add check return value for
usb_string()") added the check of the return value from
snd_usb_copy_string_desc(), which is correct per se, but it introduced
a regression.  In the original code, either the "Clock Source",
"Playback Source" or "Capture Source" suffix is added after the
terminal string, while the commit changed it to add the suffix only
when get_term_name() is failing.  It ended up with an incorrect ctl
name like "PCM" instead of "PCM Capture Source".

Also, even the original code has a similar bug: when the ctl name is
generated from snd_usb_copy_string_desc() for the given iSelector, it
also doesn't put the suffix.

This patch addresses these issues: the suffix is added always when no
static mapping is found.  Also the patch tries to put more comments
and cleans up the if/else block for better readability in order to
avoid the same pitfall again.

Fixes: 89b89d121ffc ("ALSA: usb-audio: Add check return value for usb_string()")
Reported-and-tested-by: Mauro Santos <registo.mailling@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2095,20 +2095,25 @@ static int parse_audio_selector_unit(str
 	kctl->private_value = (unsigned long)namelist;
 	kctl->private_free = usb_mixer_selector_elem_free;
 
-	nameid = uac_selector_unit_iSelector(desc);
+	/* check the static mapping table at first */
 	len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
-	if (len)
-		;
-	else if (nameid)
-		len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
-					 sizeof(kctl->id.name));
-	else
-		len = get_term_name(state, &state->oterm,
-				    kctl->id.name, sizeof(kctl->id.name), 0);
-
 	if (!len) {
-		strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
+		/* no mapping ? */
+		/* if iSelector is given, use it */
+		nameid = uac_selector_unit_iSelector(desc);
+		if (nameid)
+			len = snd_usb_copy_string_desc(state, nameid,
+						       kctl->id.name,
+						       sizeof(kctl->id.name));
+		/* ... or pick up the terminal name at next */
+		if (!len)
+			len = get_term_name(state, &state->oterm,
+				    kctl->id.name, sizeof(kctl->id.name), 0);
+		/* ... or use the fixed string "USB" as the last resort */
+		if (!len)
+			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
 
+		/* and add the proper suffix */
 		if (desc->bDescriptorSubtype == UAC2_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
 		else if ((state->oterm.type & 0xff00) == 0x0100)
