Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326039-2-7285228480450106244
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
    t=1518326038; b=a4Z3XUbwY2fu1hNSki6eDn6+qcID078IGVYSufGRTslSjfH
    +Yc1ZhXgahT0hV9TzltDMin2LeEnyu6usaI03jrF6kxecyBLa3FoZzkHEdP+gAez
    QRBg+dLyj8oocmk5Efrqg26ayoIZL+bJIuy2zJP+7nKmbllpwkeYuv818LbQ2R+J
    YoHmXtKEI+Ip+R1onwPyqLNnYctkVHintbOfmJ3mSych7URuZSpSJL1KFfDY1ebr
    LanfYSov8BZnOfgUAiuJAohOagRvKtbNZ5cUYFWHfZLaGAntS/7IGy/q2LnuoTPb
    akeoSV2eyK6RKh/9kTi5A8jvq5b1sEpnBQI8KlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326038; bh=66jE1+rBH/UnOKUQPHq
    aV5c7hpFUc028rx15Tloyl0M=; b=HUv1gASQXMw4OHeb8TX9Wzz1msDXA4gAFVR
    x2ugDk2+mFtGemjyCBGGMRx9zIK2sVGCVabaHAukR+SrQOyDvA586ZTboLz/6tV5
    iFZGdu4jOP78yKW2w3fDYV7xljl7H0uIBR6KZjMb2YokLquH8+usIAglby+M1mMz
    YGcHwF8ZSxl989OOmqCbba0dWUxSxESEtnEHMAEZUK207atdpmubSPEguY053fzk
    AG44W71NGrl2+4eyFWwwWQrlyIVSbiAXN6BYG0pFkYrxz5QzBA8i96ZEzOiqlaGG
    vpJXHCOilDINWTMeJBAkRXHDytVNDfjF3sf2GESYdqZBp4SVfKg==
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
        id S1753783AbeBKFMZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:12:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752622AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "NeilBrown" <neilb@suse.com>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ian Kent" <raven@themaw.net>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.178912720@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 52/79] autofs: fix careless error in recent commit
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

From: NeilBrown <neilb@suse.com>

commit 302ec300ef8a545a7fc7f667e5fd743b091c2eeb upstream.

Commit ecc0c469f277 ("autofs: don't fail mount for transient error") was
meant to replace an 'if' with a 'switch', but instead added the 'switch'
leaving the case in place.

Link: http://lkml.kernel.org/r/87zi6wstmw.fsf@notabene.neil.brown.name
Fixes: ecc0c469f277 ("autofs: don't fail mount for transient error")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: NeilBrown <neilb@suse.com>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.2: autofs4_write() doesn't take an autofs_sb_info
 pointer]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/autofs4/waitq.c | 1 -
 1 file changed, 1 deletion(-)

--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -181,7 +181,6 @@ static void autofs4_notify_daemon(struct
 
 	mutex_unlock(&sbi->wq_mutex);
 
-	if (autofs4_write(pipe, &pkt, pktsz))
 	switch (ret = autofs4_write(pipe, &pkt, pktsz)) {
 	case 0:
 		break;
