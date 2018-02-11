Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325827-2-16113071372312303794
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
    t=1518325827; b=A0vj5A1PSaf6He7crzUDz8drGjzmyEex+HpvKWZjdYQRUdj
    8wH58MoU+bJx0YzIUEXcRr+qGjM9HEBxhSw6FsEqKy0DJg84SGjQfdubLcxFyDfF
    A4KuQHtcEMetm6gv9rm9/bq42VvCn8uqJCa7N+x7ocn6ayNF2HSgnZv8KE02VSNr
    3ROyswuTSK2uZdf4A1EdKy6VLf4t4F47uJXxYhrUA6nLUSIOSZ/+A1lZdnrBqNmQ
    NRmX4MnKD1LUDhAipXOZW5RdgLr2L8OMWu5s7bneq7AnGGXdzH+g8ri5EGksKC8E
    JHDKnP0/+bs3ivb2Hp65IiIIRbYmdHfs9k/qY2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325827; bh=ZdKncuDQGb3WIojt5Zb
    Lu1M9fUMifd7oBeTtURJ9tw0=; b=Gd0PnKtIir2K16KRD/TWnyrS4lS/KSShz9X
    5dzNBiVpNjvlgmZq7vmH6KrSCeikiuJkAsh8Ougg9BiRjGx4mBmycZqZ4agNVUsa
    83V94wLIjXJDeVg8skd6ZuxilJ8mWfV0Q6Toa859GZqWey7wd+pkk+IAYso/iK+d
    PE2ffEEy9kv/eg16EPE37GpUYEf/HWu/2Z8A8BW5BTuiRIEzRZu3qXIAhxjW9A07
    hsRqVZsYFZxSpml5fyLPo9pLIvr1iBQjxpZp9RcY+BjNJQ5eUSzAFdSGN+pAFseP
    frCFTvOIpDI1rR0p2qNS0Iiy1HZyxH+j2PrYrNUie52CKXqsGpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeBKFKY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:10:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41433 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752644AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.943407157@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 57/79] ALSA: usb-audio: Fix potential zero-division at
 parsing FU
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

commit 8428a8ebde2db1e988e41a58497a28beb7ce1705 upstream.

parse_audio_feature_unit() contains a code dividing potentially with
zero when a malformed FU descriptor is passed.  Although there is
already a sanity check, it checks only the value zero, hence it can
still lead to a zero-division when a value 1 is passed there.

Fix it by correcting the sanity check (and the error message
thereof).

Fixes: 23caaf19b11e ("ALSA: usb-mixer: Add support for Audio Class v2.0")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1262,9 +1262,9 @@ static int parse_audio_feature_unit(stru
 			return -EINVAL;
 		}
 		csize = hdr->bControlSize;
-		if (!csize) {
+		if (csize <= 1) {
 			snd_printdd(KERN_ERR "usbaudio: unit %u: "
-				    "invalid bControlSize == 0\n", unitid);
+				    "invalid bControlSize <= 1\n", unitid);
 			return -EINVAL;
 		}
 		channels = (hdr->bLength - 7) / csize - 1;
