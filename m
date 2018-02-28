Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838936-2-566113122792103496
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
    t=1519838936; b=otFOa0dCsqUxP1O7BoXdv8pUszdYHadKlXsIgqEKGqwtFg6
    jDh44w2MkkOjL5f3Xc/Q0UJL5q1mKChbjNGLrWko+iXE5OdwSg6iVuPC+rXciPkp
    vTawZErWzD9uIxEa3D0ka7t2cVY+tpHVkhHbfgJC5n6XuGSrcn+1hQNKZd+//wUz
    8M1iUOVY1ht1av7hecLPil4Iwxg/crUsbGU3iiXKKgF00rxrszIOvo972525O29y
    cPAEyWnL/dvWbFoupYIkHsZmXwLDvGO2QcGwyT9NuzV32e/04yN7OtlAftrBNFo6
    Kfr1YWnDmF4sdPp9NOXvptQFUVib/cN4Fr/Xi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838936; bh=1E+Q9vssKijWE7jc5Ox
    Y4RMzOzznMzmRFEjl1SUB1V0=; b=GzL59fV4ySBKYZfH4HgY5S+qN7ZxJccGHYO
    e/khMzUxtvpgniqL4cSxJQepcy9oyPc5jgPdq+nnf8qFv8qfxAEf1gE2Cxs29dO1
    NS1bqCvWrwEPBNnxVnueqxWo+3QUlD9X2s/esOPxiETrxroecicq1om0RNJcd785
    rRQYMQOTRTsjURIn2PELZHzqtV+/N5TYmEeSTd2fFJiudLQr6H0t7iP+e6XZr5GB
    HiHVE3VbcJYPiKjJgj0AJSYSa8E5lcfL6nGgmLTAhptN0Z96Ks9Bpvvxtw89+r6e
    u3kywssjVBlJ6NufywqNWe1FvjDF7j0IlrOiXHmLl+mgVkLsbCQ==
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
        id S932674AbeB1R1d (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:27:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33276 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932605AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+3902b5220e8ca27889ca@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.688879217@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 086/140] ALSA: aloop: Fix inconsistent format due to
 incomplete rule
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

commit b088b53e20c7d09b5ab84c5688e609f478e5c417 upstream.

The extra hw constraint rule for the formats the aloop driver
introduced has a slight flaw, where it doesn't return a positive value
when the mask got changed.  It came from the fact that it's basically
a copy&paste from snd_hw_constraint_mask64().  The original code is
supposed to be a single-shot and it modifies the mask bits only once
and never after, while what we need for aloop is the dynamic hw rule
that limits the mask bits.

This difference results in the inconsistent state, as the hw_refine
doesn't apply the dependencies fully.  The worse and surprisingly
result is that it causes a crash in OSS emulation when multiple
full-duplex reads/writes are performed concurrently (I leave why it
triggers Oops to readers as a homework).

For fixing this, replace a few open-codes with the standard
snd_mask_*() macros.

Reported-by: syzbot+3902b5220e8ca27889ca@syzkaller.appspotmail.com
Fixes: b1c73fc8e697 ("ALSA: snd-aloop: Fix hw_params restrictions and checking")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/drivers/aloop.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -39,6 +39,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/info.h>
 #include <sound/initval.h>
 
@@ -612,14 +613,12 @@ static int rule_format(struct snd_pcm_hw
 {
 
 	struct snd_pcm_hardware *hw = rule->private;
-	struct snd_mask *maskp = hw_param_mask(params, rule->var);
+	struct snd_mask m;
 
-	maskp->bits[0] &= (u_int32_t)hw->formats;
-	maskp->bits[1] &= (u_int32_t)(hw->formats >> 32);
-	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX-64) / 8); /* clear rest */
-	if (! maskp->bits[0] && ! maskp->bits[1])
-		return -EINVAL;
-	return 0;
+	snd_mask_none(&m);
+	m.bits[0] = (u_int32_t)hw->formats;
+	m.bits[1] = (u_int32_t)(hw->formats >> 32);
+	return snd_mask_refine(hw_param_mask(params, rule->var), &m);
 }
 
 static int rule_rate(struct snd_pcm_hw_params *params,
