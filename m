Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519836845-2-2771465636883351076
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
    t=1519836844; b=mOnSq4A9+UgfaV6CDbOVr8dT0KuFwUjTkIRN4NFdG5fC9SH
    Oe6gNuxBkbpSh6btPdCq5PKH7zLyeLUQyeY2EIK0IpHE7XZ2vBHwNKQxG3dwFNSL
    zBf2ZwkxsBCTe5L6n58R/nosTmhK7BZ9rE07EF9Bwm1fKPh89DdUkBkG920YyTa9
    MvAOC1ipUF5k2w0UyKqhBEFqQ2HIq8g6YOwJxr8Bg9Ttfte1MXdm6f31hXnOLgQL
    YT7I8LtpUQcqEE4inMGKJ8ASfQNI1sdVGG0dGV2fTztNoFUQnql2JaXxAPDJxWS0
    jhdXzn50VV8CxfAe9l+8aM3DgsJc7jvzy+LILoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836844; bh=oZtyL762pbCke+S6eel
    TuPLgzXTELDs0dJx3auV7XrY=; b=YFenqBKK2qiVO8+kWBdUT49XSTI2JwtVUxX
    ZNeBu9NezArQXa6JcFL2dwLijB/Ibap2VVdmP/gmp4XH4VPTS9WB1mR8Njaq3ZLQ
    DoDdMW+ecVlbs0Di59kt5R3R0VJHkA0/QAe4HBXXu7Q46fRgr6RIrhPhdOhxwJyp
    8qr4YPPKybq5pQK/LLKL0rLj/QnumSzMofUCeL8EKDvjZZKjRUOCh81n8FHed8a0
    IZhFiPm9BiKF7ZbJISLKVp/5vlsm7V2/6pU63SdTLy6+SCmiaPT7Xd4Q5Lm3yTlJ
    rw1s3DxvKj1DXrGXop3tpaQK14sK6Qu3ioju9QnaLgxPXiLqJWw==
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
        id S934128AbeB1P5y (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:57:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34529 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933979AbeB1P5x (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:57:53 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Johan Hovold" <johan@kernel.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.605078292@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 186/254] Input: twl4030-vibra - fix sibling-node lookup
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

From: Johan Hovold <johan@kernel.org>

commit 5b189201993ab03001a398de731045bfea90c689 upstream.

A helper purported to look up a child node based on its name was using
the wrong of-helper and ended up prematurely freeing the parent of-node
while searching the whole device tree depth-first starting at the parent
node.

Fixes: 64b9e4d803b1 ("input: twl4030-vibra: Support for DT booted kernel")
Fixes: e661d0a04462 ("Input: twl4030-vibra - fix ERROR: Bad of_node_put() warning")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/misc/twl4030-vibra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -180,12 +180,14 @@ static SIMPLE_DEV_PM_OPS(twl4030_vibra_p
 			 twl4030_vibra_suspend, twl4030_vibra_resume);
 
 static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
-			      struct device_node *node)
+			      struct device_node *parent)
 {
+	struct device_node *node;
+
 	if (pdata && pdata->coexist)
 		return true;
 
-	node = of_find_node_by_name(node, "codec");
+	node = of_get_child_by_name(parent, "codec");
 	if (node) {
 		of_node_put(node);
 		return true;
