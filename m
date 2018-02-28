Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519838933-2-9395042464675911769
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
    t=1519838932; b=WjW8rQxSTJVCf+guRC/cFwZ3FE/j8Xi506R4T2aOTOUTme/
    sjX0vODlwepUd6H8Wfvkr5OXa3h8eK+4S2MT1QhiMXgOmQQbuZ/quIAZGbeDkEWn
    qt1nXHyfP+2zjI9l36cX0425RpRImSB9ncghHyvE3SsqFXCEJPCCXPAHcp7trjrP
    YfTUWAoWtJ+P1sSjxn4j0x6YLYgRkqaphUJG8og68zKSQwxnWF17ji4kUK6l8pgC
    81WpIYaYG/1FDsyMjX+ojS5LuMIf1nvf9TxU0Wo1G/eu6UaPv1qy8XhwsfnCkdhS
    Xqej1pFAaXEPIJfVPyF5ElX3v0zVTMsPAZ/8POA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838932; bh=wedCyBu+MmlLQfmsAqu
    /se7grpn6MO9apcfus7c9498=; b=UluwgSKZW2Rv8qH/akJbrAF8bjSTqHwewHB
    qUYdRJYWgT5qnr173ot7tDwOoYE0nNXYZgCBcvvP2ohVz5D8CRkPlP9Zy8miy8b8
    x5/9t/ud5bqc77NcWeOlsyryM852zp0xhcxgWZtHY4DfedIY/BGG1DzCe4UVTMtC
    7Tg8P2N+AYp2hb3DabfdAD072K604YI3/N/Df1GzlWz/vckDQrZWc2XyXGOx4ful
    /sAg6AHF/h7dbJx024N2IMKsT4Jel+Vo8oumbkpwS+Huv+qP3CQ6DM+upPuz+wH1
    7c8ffeYDmGWscjS2ZoOIuHoZb5egzlZ59AhB6kMcfZ6nC3iNtuw==
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
        id S932615AbeB1R1d (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:27:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33256 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932596AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        syzbot+993cb4cfcbbff3947c21@syzkaller.appspotmail.com
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.702925477@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 089/140] ALSA: pcm: Abort properly at pending signal
 in OSS read/write loops
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
@@ -1422,6 +1422,10 @@ static ssize_t snd_pcm_oss_write1(struct
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
@@ -1507,6 +1511,10 @@ static ssize_t snd_pcm_oss_read1(struct
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
