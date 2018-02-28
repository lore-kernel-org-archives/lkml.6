Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837472-2-1013770059692398693
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
    t=1519837472; b=oBzkSs55a1cLVzFLqTlgHG1emDkubbhEgUp5j71+lS7S5qu
    lILfhEAHTg0wsUgaiz+iNJ99CkYdFwFHo+5VdAGDVcfAXAwanJBYjLqU1OJdN0g5
    yQC2Tb5mpZcnbCTdWLznw9txasIvNXQLXfs3/EL5CzyM5RWU35yzqMaLbawqhALL
    /aWdlg/f2qbe2yWC8p2xlsssPaq8PEck38xpDt/74uAHWr2wQ3mpGm+zssGPl2Nh
    QCRTxO0P22r2kVUz1tVYeUHDiUVY5HiFLrdQBZ4thPFWLRHEbwI7b5hAsEzaFS88
    JYTvNXmXpwDtNPDjA/59esiaABhDp175gu01S1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837472; bh=4JGIp8YMxMalE4PbpdQ
    TmcPjG0k/XEPm8k+CnoO7mcM=; b=ukNB0CK5nM1blWBYM5WdQmdIj2ZOBD6QlAt
    uizpG731ymPmr6VSLITQaTFukgZ47aFU3wIQo6696mVXu6HV6KWcVduGS5sEij0O
    GgEmjGOWIzxpBcxU/0ntfqR03VQqg0B53y+uGFEI/iy2Rl/+8vuCOnrz9wHu7725
    +G9Xh5iX/tJw/itypB+XlMqeJKbS9z+hE4k7pOFr9pMcyGmqG73o1fWxyQdVEOgi
    9fH6NvvbT7bEACEoPWbtz4vn/AmJnooU5DVC8/o6Cugr1Up+vyxtenzO+9toFPFi
    9P2MnTK2ilaQAZrziPhe0WNntJQpnr+3R2o1Jl91mPA6tNBNM+A==
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
        id S933598AbeB1Pv3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:51:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34333 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933272AbeB1Pv1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:51:27 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        syzbot+6f11c7e2a1b91d466432@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.852109083@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 155/254] ALSA: pcm: Remove incorrect snd_BUG_ON() usages
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

commit fe08f34d066f4404934a509b6806db1a4f700c86 upstream.

syzkaller triggered kernel warnings through PCM OSS emulation at
closing a stream:
  WARNING: CPU: 0 PID: 3502 at sound/core/pcm_lib.c:1635
  snd_pcm_hw_param_first+0x289/0x690 sound/core/pcm_lib.c:1635
  Call Trace:
  ....
   snd_pcm_hw_param_near.constprop.27+0x78d/0x9a0 sound/core/oss/pcm_oss.c:457
   snd_pcm_oss_change_params+0x17d3/0x3720 sound/core/oss/pcm_oss.c:969
   snd_pcm_oss_make_ready+0xaa/0x130 sound/core/oss/pcm_oss.c:1128
   snd_pcm_oss_sync+0x257/0x830 sound/core/oss/pcm_oss.c:1638
   snd_pcm_oss_release+0x20b/0x280 sound/core/oss/pcm_oss.c:2431
   __fput+0x327/0x7e0 fs/file_table.c:210
   ....

This happens while it tries to open and set up the aloop device
concurrently.  The warning above (invoked from snd_BUG_ON() macro) is
to detect the unexpected logical error where snd_pcm_hw_refine() call
shouldn't fail.  The theory is true for the case where the hw_params
config rules are static.  But for an aloop device, the hw_params rule
condition does vary dynamically depending on the connected target;
when another device is opened and changes the parameters, the device
connected in another side is also affected, and it caused the error
from snd_pcm_hw_refine().

That is, the simplest "solution" for this is to remove the incorrect
assumption of static rules, and treat such an error as a normal error
path.  As there are a couple of other places using snd_BUG_ON()
incorrectly, this patch removes these spurious snd_BUG_ON() calls.

Reported-by: syzbot+6f11c7e2a1b91d466432@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/oss/pcm_oss.c | 1 -
 sound/core/pcm_lib.c     | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -465,7 +465,6 @@ static int snd_pcm_hw_param_near(struct
 		v = snd_pcm_hw_param_last(pcm, params, var, dir);
 	else
 		v = snd_pcm_hw_param_first(pcm, params, var, dir);
-	snd_BUG_ON(v < 0);
 	return v;
 }
 
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1631,7 +1631,7 @@ int snd_pcm_hw_param_first(struct snd_pc
 		return changed;
 	if (params->rmask) {
 		int err = snd_pcm_hw_refine(pcm, params);
-		if (snd_BUG_ON(err < 0))
+		if (err < 0)
 			return err;
 	}
 	return snd_pcm_hw_param_value(params, var, dir);
@@ -1678,7 +1678,7 @@ int snd_pcm_hw_param_last(struct snd_pcm
 		return changed;
 	if (params->rmask) {
 		int err = snd_pcm_hw_refine(pcm, params);
-		if (snd_BUG_ON(err < 0))
+		if (err < 0)
 			return err;
 	}
 	return snd_pcm_hw_param_value(params, var, dir);
