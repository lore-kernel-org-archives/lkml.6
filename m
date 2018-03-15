Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3263996-1521081877-2-3405074139168985944
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521081876; b=bnyciEGFmR2rVumSbk5LQw6lWOaPdO1NQltgbnW0yfPaeHD
    edyZMrSmqGm0UmtjBPgpyxCbiD4Wqwsb6CenOyJjCiKZ6IkUpjgVNuuCCEWqBqzJ
    y5VYzCtpawbM+gF37AeMsXOIJqJARbdV1lOs8QVA/NFfm9cEcfSdP5asB5QgdjYt
    eZ8FscskxwCkf77+01UN6eB3hEa3Qz2kZc6hZPdq/RlNL+V0PrEYujkRo6R9LNYB
    +5zlifhPBhmIzt+yh4Q5sSf0kA253Ud6D9dnIolc7edPh90xc5tLGaEI9OxJaeYE
    2L98xyYCXGdF5Jp2uPA0KVPuuFhqQBYDHBsFs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521081876; bh=TOBtHWqOxmDaQ1WFSsIlAqKqIg
    ig84fcy+K9+3lghJk=; b=ajlxOv5bKVPlvAwgglC92pZF0bO9X87821GaDePueG
    FVKvTNnfeECfTH0ZwMJDsEAIZEqvio7j5yEtcjwNiX1P8YXI2habBjRbLYG/bgkc
    p2WzPk3plRdEV3jKrsQ+HoZnJs1FCJESF0HdbSpyV1jCtIj10Jvbv4NQ51UcbVi/
    MHxgI05mSIVdkMJNHCq+nwGSAPwRF26iXB7I4JfhDZWxA3MRJSnyeS9myuRg1DzF
    UrVTqwfkAeJlYbKCL9v/aW3xyTt1zYqTlzLb4nl98t+elg7hdz79hXur9a1i9zUe
    pqTt+O7Z9a4yQq3+dqS7reyK6jvrlGp408KdTOX+Z1Yg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCJXyb0L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=190 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCJXyb0L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=invisiblethingslab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=spam score=190 state=1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=invisiblethingslab.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeCOCoc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 22:44:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36809 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751517AbeCOCob (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 22:44:31 -0400
X-ME-Sender: <xms:Dt6pWsXf6afEhjsn7drls2Y1qZoFWKy0AZUr2I3XqCS9MMTlgfJuUw>
From: Simon Gaiser <simon@invisiblethingslab.com>
To: xen-devel@lists.xenproject.org
Cc: Simon Gaiser <simon@invisiblethingslab.com>,
        stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling
Date: Thu, 15 Mar 2018 03:43:20 +0100
Message-Id: <20180315024322.27429-1-simon@invisiblethingslab.com>
X-Mailer: git-send-email 2.16.2
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
index a493e99bed21..81a84b3c1c50 100644
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
2.16.2
