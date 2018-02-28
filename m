Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834802-2-13374845561168746164
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
    t=1519834801; b=kPmWDNu5spMQ6Ij+ZP3kOl5gMxamAwOt7NhVlXb2G6zAzPw
    /FgnU9WZMgTkmh0k8PZrlBWz3HqIHAnwCCS+INI42m3fSrcON9c6CFptxJiPcHk8
    d3Oyy+eY59axzk6HcO1VMLbOx8A7rh/RQETPZXELUn64Z/z3L4ItP2JEJDGLlzM4
    u/xY4ju1YeKyKhVg16mJhZ8xRM+icmou5ZfHuSv/pHiR9+9utSBxpsS1KtK59Rif
    Du1gmPqcPl36BOrOF1l8hxptYTs49qW1HQw6gsHmh6Ba2s691KVzO6nUYFvJW8lA
    jG6L7zRWSFKkLghbXL/+aLrMKsVJuynnntWVUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834801; bh=8LYD2TqJnDcsSJp22Rs
    0EecBQCYaliTsKiUaJlFN9u8=; b=Z3qxuylLQryyLbDUaKkf8RksySiVNINItUC
    h8qiOdbaW4wtHKU75Ngibz8htDP9t6bKj2fjZcU3Gls5Stt3AZS3kuVNuFODByG5
    V0y6QApCDe6WCuyE6wsooJAz9qdn8D3rhRMp+kKMWpbqdVcKj0kgC32kP7OrMWDU
    AuJg60GhXKZntvD91IjZ2nk3VBBjfRp+KKBCfO/XJQM4tfuyA54hVyt0F6sbjjsX
    V8NJ45orIvmtCcJe053kREUldqotYKVNxTP1SnvVwa38hzV/EDWSqVEZzGe1wjzh
    HBlXBrl/bR1p5I7uqpGZfDIjCX30WSol3PkPYn/o29pXAAVLtgw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbeB1QQI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:16:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35217 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934923AbeB1QQG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:16:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        syzbot+7e6ee55011deeebce15d@syzkaller.appspotmail.com
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.267517181@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 201/254] ALSA: pcm: Remove yet superfluous WARN_ON()
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

commit 23b19b7b50fe1867da8d431eea9cd3e4b6328c2c upstream.

muldiv32() contains a snd_BUG_ON() (which is morphed as WARN_ON() with
debug option) for checking the case of 0 / 0.  This would be helpful
if this happens only as a logical error; however, since the hw refine
is performed with any data set provided by user, the inconsistent
values that can trigger such a condition might be passed easily.
Actually, syzbot caught this by passing some zero'ed old hw_params
ioctl.

So, having snd_BUG_ON() there is simply superfluous and rather
harmful to give unnecessary confusions.  Let's get rid of it.

Reported-by: syzbot+7e6ee55011deeebce15d@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/pcm_lib.c | 1 -
 1 file changed, 1 deletion(-)

--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -644,7 +644,6 @@ static inline unsigned int muldiv32(unsi
 {
 	u_int64_t n = (u_int64_t) a * b;
 	if (c == 0) {
-		snd_BUG_ON(!n);
 		*r = 0;
 		return UINT_MAX;
 	}
