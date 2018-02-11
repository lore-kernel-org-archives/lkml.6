Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518325927-2-2481256491796795142
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325926; b=gnmdDCm4o39y5K5GAtPVE1kMO7cKqGUQOFAyMlacrHO20HS
    uTAiGUIpr7+86D7FIWYQGpfV/xP7wgoYsptXzf8rJT/zRZ4ZFnYyZULzzemPtGv0
    TWELk9pSFIRClZ8pF1GL37aHj8ZWG0M7DddcWFUkuowX5uwHy6K4RF8nQO/C8Msf
    3HYny8h/sMOMPPUEkn/1+6cjiqqGg9Kc5+4BzOHxRSYFg6wQCeZk//x3hLMa6owj
    jLZCl/4QwVRcs8K2mNDg19EaUIWs+d85Bc1zSVBQF86W5vRnwvLFp64n0YlJUv/Q
    kAHSXUAB0PND/eEqj8qbdOgd0mkkIph8WxhjA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325926; bh=vX4u+ANjzGk7zVTOO8D
    6cAVX7jtHv5r+60sSFj287u4=; b=a+UnXq1TTPRxvm646yYw/YbOBfdg0eIvxhk
    g7M5rmYW2YsTykHxtRG3DMvNpYkX+MtR/Pt+0CgmoB+TZfYN1gR/rSmFyt91e3pC
    dAF6DhRW4vyek4Ac8BTKRyEF2sTYjczolmmMAAVrpOzHlh0deIg1R7yierViCOoh
    KO2wumJrSM2yNW8qEbecOdrKRGF7zfNbc3hPIt9Rv/em57COnh352IQxN708syHS
    LzVRNxu37j3TZy93XNcx+rUNzl6QdvTJcHjdpF5XRIOLIvfD7pXYtimXq+ffJ327
    VQy5CxNAcFUePcsK9g4mzQpfy0rKHifr+/4fcgvaf4teGrWyBVQ==
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
        id S1753463AbeBKFLF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:11:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41432 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752642AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.400806207@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 56/79] ALSA: usb-audio: Fix potential out-of-bound
 access at parsing SU
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

commit f658f17b5e0e339935dca23e77e0f3cad591926b upstream.

The usb-audio driver may trigger an out-of-bound access at parsing a
malformed selector unit, as it checks the header length only after
evaluating bNrInPins field, which can be already above the given
length.  Fix it by adding the length check beforehand.

Fixes: 99fc86450c43 ("ALSA: usb-mixer: parse descriptors with structs")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1845,7 +1845,8 @@ static int parse_audio_selector_unit(str
 	const struct usbmix_name_map *map;
 	char **namelist;
 
-	if (!desc->bNrInPins || desc->bLength < 5 + desc->bNrInPins) {
+	if (desc->bLength < 5 || !desc->bNrInPins ||
+	    desc->bLength < 5 + desc->bNrInPins) {
 		snd_printk(KERN_ERR "invalid SELECTOR UNIT descriptor %d\n", unitid);
 		return -EINVAL;
 	}
