Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835195-2-4955366962218536379
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
    t=1519835194; b=WzbVL/7YKJBeENy4QzBWn4IpUZDtpTpU5G4yIGIANNmIlH0
    KSpuQWpFuhvWNlia034KzP8MqLyn4wY/QSym52hV0y0xSd3MGVJLJSurx961HQDi
    FG9Td+IuPeFesBa51dB2cWv0H8xrgf7X6wFyaEWz7np0oEhUTyXxehvE6uN/v8NM
    lxQrDsBKsJ9eS72KxEYcmzTq3gC/AMxOLAp/nqXu4/xtyIgLPCNobSmOtObtCJ8P
    BgZXvC4F21hNW56o4Uf4+rxRl5qcXZtilzW4goQi05bJiyeow6jKRaJwX0DymGsE
    js1RsC8iUVhOGMZdfun/eqmfmSyi1PM/ZzZgi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835194; bh=VOzdRPOvkpZJbr7eMCt
    6/uNQx3w0x+ncZSdJMBH5nho=; b=WTtqQdFlOpFgVo33rb29hGc+E2Lp0uBdSMR
    pN7HLvSb+XCGus9zaJDa8HMk/sCWEor7tiuIg3nvu4RmSeqLNy5q9C8Od22Ie3eV
    g9fWhOQQySc/lCGmigzhGCOV0g7TAmVYsA83SiWRcP0XnvTJXp7RmdREeJxJe1rL
    WFh3Hiyz7AWwVxhreKI1tOBsBHpdtZ3mHE0d/rMgpTVJKphMVXglDs+4zuReOPYX
    MD6b4aNpRl71vjI63aiJPTxDgSe2WFAyWiq59cS/vsIyEmdHGTKZrEwA61znsgN0
    qvT0wQY6buVfi/d3df6MFmGAKuUbSlmIUMPycQFTRlslCHj2HAA==
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
        id S932712AbeB1Q0R (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:26:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35318 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933235AbeB1QUK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:10 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "syzbot" <syzkaller@googlegroups.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.392932626@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 021/140] ALSA: seq: Remove spurious WARN_ON() at timer
 check
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

commit 43a3542870328601be02fcc9d27b09db467336ef upstream.

The use of snd_BUG_ON() in ALSA sequencer timer may lead to a spurious
WARN_ON() when a slave timer is deployed as its backend and a
corresponding master timer stops meanwhile.  The symptom was triggered
by syzkaller spontaneously.

Since the NULL timer is valid there, rip off snd_BUG_ON().

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -357,7 +357,7 @@ static int initialize_timer(struct snd_s
 	unsigned long freq;
 
 	t = tmr->timeri->timer;
-	if (snd_BUG_ON(!t))
+	if (!t)
 		return -EINVAL;
 
 	freq = tmr->preferred_resolution;
