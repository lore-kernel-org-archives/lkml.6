Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835345-2-6693595294763374467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835344; b=oHWj4jYKVj9fgva6731609Mqsjat6R2h6A5waExTMwST5PH
    Bp8ZZgOBIibrnlXaqbcAkSWHAOBNnzYfjfAcZpF45Px/lKEUlk9NVZCPqEy06eyB
    t09s3XdvKrLC75ZJe7toW3qFU9E407TWRslWIH6u6ZqsuKjjulfHtY2jbREqjOax
    4nAZKLq7w7Pt91QO5uYPTm0qEkLdoiikVX6viFium2naCyWpVTwHFKNI2SmzO8zr
    OsWGZtpiuqUqf3luXsDn3wKXL0L5oBiI3D8gbRVp5tTcGNSletfCnw2+G+IrgtXY
    fE/p55gPxbJg1NePtt6WWqZqIcgfgfoXozNbvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835344; bh=FiQfLPaoyMwpbxkARhl
    ac4+NlVoS48h/f/3l133kQBI=; b=gZMU/RUEZHiN4jHIU1GY/OrpAKF72CNqDpn
    DRFO4REWQQFpXp7G6gUVsl+bTYew5lsMrj5/RmJlRLqTVXHbS3NnkZUsMK1ZBgN8
    Hho0KxsFIEv0/2WqveOwSgUtAxzBGDOJR2FS2fHPf0g5ypyNiWGlHYD6K3cxljxo
    D7wjdMyZhSXCI/yOEBW0p8dKlNLdNK4umduLWqek7H4oMDLcKEVEmK70+LyiD4cp
    qdtpQ0PugU2Oe+n2qF0oTLk+1xXRYREwnCdb8ytLXQGiVSmAX1u8UtDsIZreldsz
    82ziJLuY4qEm15pV0oAIHjjCdDZNPxglIQSY6uTPxQb+W+fuxeQ==
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
        id S934906AbeB1Q21 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:28:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35190 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934855AbeB1QPg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:36 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?="
        <ville.syrjala@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Daniel Kurtz" <djkurtz@chromium.org>,
        "Sean Paul" <seanpaul@chromium.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.336374005@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 018/254] drm/i915: Don't try indexed reads to
 alternate slave addresses
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

commit ae5c631e605a452a5a0e73205a92810c01ed954b upstream.

We can only specify the one slave address to indexed reads/writes.
Make sure the messages we check are destined to the same slave
address before deciding to do an indexed transfer.

Cc: Daniel Kurtz <djkurtz@chromium.org>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <seanpaul@chromium.org>
Fixes: 56f9eac05489 ("drm/i915/intel_i2c: use INDEX cycles for i2c read transactions")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171123194157.25367-2-ville.syrjala@linux.intel.com
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
(cherry picked from commit c4deb62d7821672265b87952bcd1c808f3bf3e8f)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_i2c.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/i915/intel_i2c.c
+++ b/drivers/gpu/drm/i915/intel_i2c.c
@@ -448,6 +448,7 @@ static bool
 gmbus_is_index_read(struct i2c_msg *msgs, int i, int num)
 {
 	return (i + 1 < num &&
+		msgs[i].addr == msgs[i + 1].addr &&
 		!(msgs[i].flags & I2C_M_RD) && msgs[i].len <= 2 &&
 		(msgs[i + 1].flags & I2C_M_RD));
 }
