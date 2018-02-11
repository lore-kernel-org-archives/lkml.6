Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324654-2-431163829662976922
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
    t=1518324653; b=kzBimB4DbT8QUk0IPPsIFXlTfbZwDXagkLcrdurJXYMp0oO
    C+iTHxYVoQ+iNlOnXdb8L14hRMN5rt4XPywTHGc0Sp9hsuPns6STUITm8BvpKgaK
    AlFS68D4SY130wd0H3PGKJcL/p3sB12DwOQg17ES3lEOGarhvPisMecf23Qffh03
    Iheh5gZXai1nNk7077FHlvl8c0yQrYWQAchZbRkGTaPnk8umuUjjhH34PUM7rDPM
    amT3VQpvIB2I4jJxccVU7F3MXMY6yblvT4oWVLVPVNYnXQtsLCAhPRO6IHRGXbJg
    CgsIpwYySYvdIsbiX30QPqtojagrLGncc8OgATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324653; bh=21+H5VLSddFNx2MqCaB
    u1SoyuRoz/XACkermhAk2Cz0=; b=hNiyDczJhSG5lxJYRB80+5x1AXuiDH+MftV
    g4ycUlbdJEjLGFl8ZmOZB36IzgVGMopGXUvq+iPylasL5jwQ6QU7NpP2O6sPsxpw
    2Da92fKp3ZLUTobudHUx17AHRN3kUcAYxDJOMO6lDVPqXbvN4AqmQFgbZ4GOVQP/
    d4FSknvlYqqSL4UamWTuSJHcQiMSLqMdCsifctSecQ3xFE5U0mAU/WEFre6Kzybu
    xtlPW0uxp098BQgyMVRyek2N5vdfu6P2HFrg0S3hDiIv9F02ZUjMPbp3N4eIr2p+
    CtDDCrTm8t8CfFJtCIfJwq1YIM9APVKrrzHdFA0s0L6HD+7IhFg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeBKEtm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:49:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41806 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752835AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.140199901@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 103/136] ALSA: timer: Remove kernel warning at compat
 ioctl error paths
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
