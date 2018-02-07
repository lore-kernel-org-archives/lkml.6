Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-924688-1518042232-2-4278136175770373203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518042231; b=e8WCZuKkH/ATiIRjBQzI87X/TTMkayze5K32EtJQiyo1tgA
    JvBjD/O8YN7itrvT07z9YLJBJuQXg80mE+MP7hAOAQ3JOFw3TNLdTvwDFmi9/9MJ
    GNWOYSzPd3eCRhdQm31/C5XNNoro7/hf9/alxNPsTvhSfnxw9LycpwlAw//4MsOA
    AN8XtAha/oGfuOOZObKfIsRZ4R9WpIGHOX7iIaL4mOV+/6LgkEMDZwnHZbx4B9GW
    JZ0Mtpbcs7ZDUuP38MNLzRfWdIE2nO7Cp61DcwiS2ELxOD0kswptVpiU8wdfu5oF
    GfdqLS42xbtptUkau4Q87XnoHFxZafWhcp3FGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518042231; bh=Bz+0FRUsv2sQqgcFsIh+LfQ1qB
    jEKAkofIX5eY5FqZg=; b=e1cM3/qtlNKvPepNzyGFr0poptIdEMiO4mRDTKOBB3
    jmg26iH5XHJ/PjDEGw4MFJnRFMG64vUvg+PALX3JNwDjBp6PqFvWPjo2kfFeqpk7
    g8wLrqRDlRFdgMkO3dxP3kVed3wDMQU0JNvqfR+G1cV5OExBDJ8FGtvF93L/IzP/
    nkay3VgfhTR2AhpmsrxKp7iITbi7aUoMsgV7+yWiK6q4/saV7ZE6EOUN9u5MSJE1
    4cfjiESLXlZHIHBhIXAF7qsR7ijKub1wu2u895+KwBRc5ecaMuo2jlu+ZE3bB7Sq
    qpdme8SaQRoENmGVS8Wm4TKfba7jYYfzGK6+KF2OZTcw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqkpCcAL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqkpCcAL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750745AbeBGWXu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 17:23:50 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51325 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750729AbeBGWXu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 17:23:50 -0500
X-ME-Sender: <xms:dXx7WmLaFSyy8JEVAgwLpayBd6jMaUi4uPUVHHvTFM0CQz1D0Slr4A>
From: Simon Gaiser <simon@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: Simon Gaiser <simon@invisiblethingslab.com>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling
Date: Wed,  7 Feb 2018 23:22:35 +0100
Message-Id: <20180207222236.7434-1-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.15.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
concurrent xenstore accesses") made a subtle change to the semantic of
xenbus_dev_request_and_reply() and xenbus_transaction_end().

Before on an error response to XS_TRANSACTION_END
xenbus_dev_request_and_reply() would not decrement the active
transaction counter. But xenbus_transaction_end() has always counted the
transaction as finished regardless of the response.

The new behavior is that xenbus_dev_request_and_reply() and
xenbus_transaction_end() will always count the transaction as finished
regardless the response code (handled in xs_request_exit()).

But xenbus_dev_frontend tries to end a transaction on closing of the
device if the XS_TRANSACTION_END failed before. Trying to close the
transaction twice corrupts the reference count. So fix this by also
considering a transaction closed if we have sent XS_TRANSACTION_END once
regardless of the return code.

Cc: <stable@vger.kernel.org> # 4.11
Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
---
 drivers/xen/xenbus/xenbus_dev_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index f3b089b7c0b6..d2edbc79384a 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -365,7 +365,7 @@ void xenbus_dev_queue_reply(struct xb_req_data *req)
 			if (WARN_ON(rc))
 				goto out;
 		}
-	} else if (req->msg.type == XS_TRANSACTION_END) {
+	} else if (req->type == XS_TRANSACTION_END) {
 		trans = xenbus_get_transaction(u, req->msg.tx_id);
 		if (WARN_ON(!trans))
 			goto out;
-- 
2.15.1
