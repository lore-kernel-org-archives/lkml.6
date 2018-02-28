Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519835056-2-5487168364027846731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835055; b=UsTGGzzbfUYgiF4IqpIk66jxl1WUzWrNBjv3gMbqj6w+sgF
    6NqJJPjsOtI4NxEIuhGMGJTiYC3rJluGoZCwMNk6jZcbI9AnYBgvXLmQOEBFqTDm
    Va32dmQJxbphlmaKDiaBkQ65Q7tnVT0OIjXZNuPFDYIGYoh5CeQTTuLQqtkHGoSz
    Z9ApvYGOZA7AiCz2Ys9u3Ry2VuAd/5myNULLEGN0eKuOLRBpzG+4qlBODOC3qDof
    RiB29cHIloIjm24ga/brtNYWC4OjUKqS1e9DKwlMy40BK7aVCY0owquKEWQkR9gW
    3W6rApNugY1FM+S73Qt2uH/rfVYJdEeEe1kVkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835055; bh=MAi84YeOo6JMZwJKilO
    Q23xZu0J9R7FNuIygZ5j6is0=; b=e+Mdc8QcUeQQTeP2ZJxfKXG0W+RnGyzs7gX
    g/KFnJKDix3iLg2AzirxFoCvAApS04aGJb1/ZLuoZZJK70liIUdy+axWW5cNCRNW
    LkBq3z2WiL+1lXpPWWgfmSa+7ToZY5FRInAy68cbXan/RNw9SBasepI/6qWwx3iL
    /L1O4tqtbnayloYUTorKl4x+zS/LgQOZEkmMoMGuB4r9jW0csb1XfGWWnoilbd+h
    cJ5Ic6DoFar1T7cK++1uD+OeAs4/s7Yzey0wwsqeS9uayRsezBzlcXDcoByJKfKm
    WnyPmkr76XaTRTC2xBRBF4HXgKD9EF0Bkg+zwLKpO6nmIPJHngA==
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
        id S935190AbeB1QUm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:20:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35375 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935188AbeB1QUk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Daniel Kurtz" <djkurtz@chromium.org>,
        "Sean Paul" <seanpaul@chromium.org>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?="
        <ville.syrjala@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.243422314@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 019/254] drm/i915: Prevent zero length "index" write
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 56350fb8978bbf4aafe08f21234e161dd128b417 upstream.

The hardware always writes one or two bytes in the index portion of
an indexed transfer. Make sure the message we send as the index
doesn't have a zero length.

Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <seanpaul@chromium.org>
Fixes: 56f9eac05489 ("drm/i915/intel_i2c: use INDEX cycles for i2c read transactions")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171123194157.25367-3-ville.syrjala@linux.intel.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
(cherry picked from commit bb9e0d4bca50f429152e74a459160b41f3d60fb2)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_i2c.c
+++ b/drivers/gpu/drm/i915/intel_i2c.c
@@ -449,7 +449,8 @@ gmbus_is_index_read(struct i2c_msg *msgs
 {
 	return (i + 1 < num &&
 		msgs[i].addr == msgs[i + 1].addr &&
-		!(msgs[i].flags & I2C_M_RD) && msgs[i].len <= 2 &&
+		!(msgs[i].flags & I2C_M_RD) &&
+		(msgs[i].len == 1 || msgs[i].len == 2) &&
 		(msgs[i + 1].flags & I2C_M_RD));
 }
 
