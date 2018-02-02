Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3035697-1517594092-2-11196948845795202765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517594091; b=X2nFohgtRjglpTOekH6KIgQBEEPhjAiP3FqIagrOTm6+TLy
    rZFnwVqhC71znW7DdFemUdTDbqKN6CwiWNz1hHPG4DCMjsXmabWNtktHueBIZ+fk
    ON84t7+TIL6Cx6gc1dB/3FA5PnRX1Y/UKEpUyXiGVaZgJTa8QN0eJfcYCTkhcYI6
    3ctnDW/DkvP/rWHIKT0oHrE4CI0eCqlhFJX+F4PT/7kZJAMjoZ6qZ+IQMuQRB+eg
    cWzaSix6dIs4/W3kFJDCnK5UN5HA2ebsf2tvcK+6gfcUIofnmRXS7HfXLBcpnqhO
    1Pd/+mYH6lKZZcKqRMuaixxn7aeVnKQU3hUHTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517594091; bh=+ZX2Tgy5uw2ERv2iQE70junXds
    +np6t38kuLmQW6OyU=; b=ABmaR9YXm25dFNgfVHNcSMiO96ldeoNR7LQhsRLpHj
    G3uIVeDFniKtXYE/YX33Vqd2hfrG3CgnMtxengFA2gYyhJnBTxtaLy/SLHKzhJHV
    h36aAAkXkwuvNlHyClgObhi5Utx6+ATVC2C8GXQstN3vLMBmg1kHouitAO79dPY5
    vXa1ATokZQxnYRiNW9KnZv5plJpSkPPM8xbaYTinDgFj9Qhc9ZaEEsvHaOxvKA7X
    af4jaVjyUUFGBSZlL6LkVZ5GX3zJz/GYieeyG9nxyUlog7Kxxp8wFDsQrtiglUJ4
    2daEnOZ0vwbStSTebePeVkWmfIhj0l9Ad/ERcIyujDCQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gHT6/ugF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TuCNCV/X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gHT6/ugF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TuCNCV/X;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeBBRyt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:54:49 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36898 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbeBBRyX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:54:23 -0500
X-Google-Smtp-Source: AH8x224r5eQSiiO7k4xCrz5mgZlI+dvMWf0qvg8+sat8EI6hclC2ce1eDRpQOsA4XWn6Ol8cGW+Esg==
Date: Fri, 2 Feb 2018 09:54:14 -0800
From: Tejun Heo <tj@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Joshua Miller <joshmiller@fb.com>, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] FUSE: fix congested state leak on aborted connections
Message-ID: <20180202175414.GM1121507@devbig577.frc2.facebook.com>
References: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If a connection gets aborted while congested, FUSE can leave
nr_wb_congested[] stuck until reboot causing wait_iff_congested() to
wait spuriously which can lead to severe performance degradation.

The leak is caused by gating congestion state clearing with
fc->connected test in request_end().  This was added way back in 2009
by 26c3679101db ("fuse: destroy bdi on umount").  While the commit
description doesn't explain why the test was added, it most likely was
to avoid dereferencing bdi after it got destroyed.

Since then, bdi lifetime rules have changed many times and now we're
always guaranteed to have access to the bdi while the superblock is
alive (fc->sb).

Drop fc->connected conditional to avoid leaking congestion states.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Joshua Miller <joshmiller@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
---
 fs/fuse/dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -381,8 +381,7 @@ static void request_end(struct fuse_conn
 		if (!fc->blocked && waitqueue_active(&fc->blocked_waitq))
 			wake_up(&fc->blocked_waitq);
 
-		if (fc->num_background == fc->congestion_threshold &&
-		    fc->connected && fc->sb) {
+		if (fc->num_background == fc->congestion_threshold && fc->sb) {
 			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);
 			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_ASYNC);
 		}
