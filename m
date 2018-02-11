Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324182-2-11950185012516340246
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324181; b=a9WdRHoLFn7AZBHE2P4LzK8GqWzYeCt6zw52yrBjBgSFY8X
    vInqo7lBlofW6pnADBUhBhZhy+hCQrWHDcKNtdniQOFOSuM0OivLL6tjh5/1K2qD
    iBqJ+cmlKF0GMe3/VDIHW7X6kPaIBrK/bHVQF+j1pI8yGTTNqSAK/JOB8UIl7+LA
    +fSLLielC/Z9IWoffyJLzVQUElm6uU4cP8AApTO/+WbMQkcrG5GxVZjAgIZqEn+Q
    vBsjWqfsKrQ41oklWR8awT9xYrCvQvRFme7XXAvIxR4yhgBGGmpj8eB15Xs+JFS7
    cKpStcyA1Nniy6fNA6LLLx2TwVX1OrvxmmQjfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324181; bh=yYzCj7M6EeCEs4xkRJs
    FZwZ6rxS8/SMnU21O/SPtzMg=; b=inb2o/cGZguu99fnUIei7x2M54/3QiFx9KE
    VlD4H6ZKJItP6+nmRKyUz+AGgVFO721boJpjWk7RnUoRnxJVI/siYgRStXtm8/7d
    hfmHOdO24hkJ3p0sSOiRF1TNFQS+mC0pJgRUnf7eF843ZPzI+s0kPIitWW2PYZ8b
    nuwxtIOExcHLp/Y0ChHqKX/HIwLW+Z4ZN3b5bkWtA895vcUFYQL6dAsbOVIEzGHU
    k9KUfYusE6mPbol8aEJ3c/TTVJhZSAqAZbnn+LBkHpucifG8TlwfaJtnmMuFXoA0
    0FfQ6vzEgaZCfHLRuzvCaJMx7i91xF2DNfPYx5sZ/nNY7oCED7g==
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
        id S1753030AbeBKEkx (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41682 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752938AbeBKEeH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:07 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.966584375@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 045/136] drm/ttm: once more fix ttm_buffer_object_transfer
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit 4d98e5ee6084f6d7bc578c5d5f86de7156aaa4cb upstream.

When the mutex is locked just in the moment we copy it we end up with a
warning that we release a locked mutex.

Fix this by properly reinitializing the mutex.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -463,6 +463,7 @@ static int ttm_buffer_object_transfer(st
 	INIT_LIST_HEAD(&fbo->lru);
 	INIT_LIST_HEAD(&fbo->swap);
 	INIT_LIST_HEAD(&fbo->io_reserve_lru);
+	mutex_init(&fbo->wu_mutex);
 	drm_vma_node_reset(&fbo->vma_node);
 	atomic_set(&fbo->cpu_writers, 0);
 
