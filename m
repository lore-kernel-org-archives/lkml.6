Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832806-2-140524750037173452
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
    t=1519832805; b=VBjjLO3f4KZ+Kz3mMkl6n1FCbonya6Eo6ykQ47VbuDIEiCW
    UyMlQzgG++fw9AF+XuQ2OTc7Stp05caZvTmbHepQPoTcMHUjKgbIT3acMBG8K+61
    4dL7SXc4/AGPjPBwgX5/9DghpGTUMewZBOgaT61NcDYDPEbq4OEH5zjoX+5yNnTH
    sStsIjG7hdkP1MHuM5OGplUJMY/6L9aSN0p2oz3zA3j6oTtxiFgIuTwe1//L6OEN
    Q2lZUqvjB+bkGhiNoB7cHMf3KznNrLGAgog4j+YtZyAjdHrf21F6Geaaon73vW9C
    a+7dccKTjMWab8GJhLDFkqaELVsS3wNq3ckHzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832805; bh=EBYnKFHRg29opy8H7Yq
    +pzc9TkYKoWHtV0nWfLVeoI0=; b=bfZwWHzuM4Np3S7EipVKHYncYvyl2eWmI17
    KBsAcrDKcH1eWi3fTINGS/wW6t5x3JUvAvoqjp77ekAXKuXCFnKKK5TsNgwnZSsO
    b3kMHc1ujd+3WeQEXqermA0rdJrYCHEMDICtWyHy48YNrIgq4Uqulzdyj12ni2SE
    Z7fLdI9N/0HbDF7M34IEGXhSkgt8gdLchof/fnXjwQWfTcA/EF5YFsDliMjh871u
    yGHuBkCIWGrIg49tQYj/iurZHBWZhFaWvIUBMA6ntdHHn8hl4sqOQLm3y/JhqBCV
    liJzZGz705DigKuQBA8BV4ss+4Gm0u1xMWbq/N5ZBixYG4yCyTg==
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
        id S1752555AbeB1PpV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:45:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33393 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932652AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.313962098@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 054/140] ALSA: usb-audio: Fix the missing ctl name
 suffix at parsing SU
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
@@ -1923,20 +1923,25 @@ static int parse_audio_selector_unit(str
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
