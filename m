Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836542-2-987151056146025001
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
    t=1519836542; b=YFuZXo9nBTSm7GPjoUeBLuFfJ+rQH317Yh8sEEO0VVRSFZj
    VUTsiERw6Y3E2gJX+0oEdDGh27lbaNe8T7Dcm63JdxExfcxNpCRjM5EvaEvI2vXs
    jGRPCJL8vX3xnAeJhdoSqxOcZJRX5aDy8IZXS0yBw8kiBQYkyhhBoLMp8ml/LDef
    bfbmy3tKfH3QODovTDYRJHIVAOl2/SQt7wgzO8DeYbuqNVl00jR6ShrjAZt1fY4K
    yfGOSs1n7Ldo6csJHXaO+KXm6KJ3UE7g1ZebTKU1vz+BiAvyJ8JCo7vuHbiF2dzM
    F9m4Cb+Jk9BG/9azj6IvXhoU1zmwG0bF7wsGVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836542; bh=pfWxPBxbAITE51oE8kM
    C/bw3VcZwBgpcAwGTqwsRxXA=; b=khaubyroNe1FcOp+uYqNHvmXoVA3HzlsRrR
    wPMc7BxHrVDPQ9WRl9ZsPlMt+tGL9MYV+EeLXMyhdtFHrpsViZozKNkqvIW+iMop
    gr+oEobpiiK3TJgV7uNOxEFdi13u7BPVgWnbBF/2bWnvZbKs23nyjTWyBKEqdIr8
    aBP1M9MkC7Yu+4jZsWJA5VFC3hGtgXztO7CdYnHcxFu5/Oskukpxx0dPG/GC9UeV
    dwYyh5pcRvyPfXQfPU0SUOvJJnaRJ9g0htZmb1Rw12d92BSbTjFlJckOxPRrNdrA
    yv4Mpl5Mf7s/4pTh8QPtnS1g1/Ms1uHPg9C9Zr987FwM1SWWu2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeB1Qs0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:48:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34588 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934311AbeB1P6x (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:53 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        syzbot+993cb4cfcbbff3947c21@syzkaller.appspotmail.com
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.86264421@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 181/254] ALSA: pcm: Abort properly at pending signal
 in OSS read/write loops
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

commit 29159a4ed7044c52e3e2cf1a9fb55cec4745c60b upstream.

The loops for read and write in PCM OSS emulation have no proper check
of pending signals, and they keep processing even after user tries to
break.  This results in a very long delay, often seen as RCU stall
when a huge unprocessed bytes remain queued.  The bug could be easily
triggered by syzkaller.

As a simple workaround, this patch adds the proper check of pending
signals and aborts the loop appropriately.

Reported-by: syzbot+993cb4cfcbbff3947c21@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/oss/pcm_oss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1417,6 +1417,10 @@ static ssize_t snd_pcm_oss_write1(struct
 			    tmp != runtime->oss.period_bytes)
 				break;
 		}
+		if (signal_pending(current)) {
+			tmp = -ERESTARTSYS;
+			goto err;
+		}
 	}
 	mutex_unlock(&runtime->oss.params_lock);
 	return xfer;
@@ -1502,6 +1506,10 @@ static ssize_t snd_pcm_oss_read1(struct
 			bytes -= tmp;
 			xfer += tmp;
 		}
+		if (signal_pending(current)) {
+			tmp = -ERESTARTSYS;
+			goto err;
+		}
 	}
 	mutex_unlock(&runtime->oss.params_lock);
 	return xfer;
