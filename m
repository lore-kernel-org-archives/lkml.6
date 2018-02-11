Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325772-2-5681216262315738603
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
    t=1518325771; b=RzD/3eBGU6ea119ciOFfIkMhxQDoPWurVKjCbruIisJoDtO
    9lAPUlIKuIWZsIw/hL36odpOKtrbwYeFHdDWB4/O9LFhy2RmkpPCcACVtUKiokeU
    FUEPeYU9mZePPMqJQ4FzR6CImz0JRvgPNvZWDXviexkoFGJ22mHIu8/efg7QoEDq
    1usZ5Bc9cfeDRv7os2XDmVfm/Ox9uaAyNquers+qmjm3ezF5m3303Z19ORbMZtZc
    QgRtNYdD/FXqQUQPuBbbw0gDdLLhGnW3Vvye6MUT40Dc4y+qHV8+PLjFGX8l6Bui
    0aK0+n9v2kIT2yFCPyDl/xJh2quhjL4iaWGRmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325771; bh=3TjjdGoyLgzRNfR5Vco
    BIY7Vlplbn1L1HN9vYG4XL6U=; b=VOC3ugBBthgcFH9/LFsXIW+EsQDKICmq8TY
    0ktFI/Zwc9tmjoWKKUA26IqqYgoF85vh2C18F/n9QktyuA0E2BR3GBWD/+JgFwQU
    zzDxFEU2ricge/6erG3OwSRzBd5b4sRJPGivWNr/Vs5hVb7SKO2qPIuwQ8QsEcT8
    Ofb/aJ3DvfAwpcMCV/PeOYhn31KqiPznW0ygTnbERnzJaLFgrknTpZlTv3mA2FQs
    U3WyXrn4m+659IpJQZvvsP7l4IDhnMKar+2DIK4X4D6zFp4p7OCyC4OPa/MKc2C3
    LItUHzyEcavNjZtaM3lmUrARpWqzP7jRgNWGXgEiJpp4Pj6KYVQ==
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
        id S1753692AbeBKFJ2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:09:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41453 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752649AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.267761908@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 54/79] ALSA: timer: Remove kernel warning at compat
 ioctl error paths
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

commit 3d4e8303f2c747c8540a0a0126d0151514f6468b upstream.

Some timer compat ioctls have NULL checks of timer instance with
snd_BUG_ON() that bring up WARN_ON() when the debug option is set.
Actually the condition can be met in the normal situation and it's
confusing and bad to spew kernel warnings with stack trace there.
Let's remove snd_BUG_ON() invocation and replace with the simple
checks.  Also, correct the error code to EBADFD to follow the native
ioctl error handling.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/timer_compat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -40,11 +40,11 @@ static int snd_timer_user_info_compat(st
 	struct snd_timer *t;
 
 	tu = file->private_data;
-	if (snd_BUG_ON(!tu->timeri))
-		return -ENXIO;
+	if (!tu->timeri)
+		return -EBADFD;
 	t = tu->timeri->timer;
-	if (snd_BUG_ON(!t))
-		return -ENXIO;
+	if (!t)
+		return -EBADFD;
 	memset(&info, 0, sizeof(info));
 	info.card = t->card ? t->card->number : -1;
 	if (t->hw.flags & SNDRV_TIMER_HW_SLAVE)
@@ -73,8 +73,8 @@ static int snd_timer_user_status_compat(
 	struct snd_timer_status32 status;
 	
 	tu = file->private_data;
-	if (snd_BUG_ON(!tu->timeri))
-		return -ENXIO;
+	if (!tu->timeri)
+		return -EBADFD;
 	memset(&status, 0, sizeof(status));
 	status.tstamp.tv_sec = tu->tstamp.tv_sec;
 	status.tstamp.tv_nsec = tu->tstamp.tv_nsec;
