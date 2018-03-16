Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221591-3-10123402496110735848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221590; b=hTwq2FpvxEVY8zMQ+VVWHUAZk0OyIlWVCMLKN+C3XJjhxjM
    U0Ft3dEoXnzlgmZHQyGouJdiNP9Q+w5IOlP9obTXqDqD+fh8locrxz8M/uAZ+U7W
    onhJ8mJnJpoalh+GW5MC2pZa40dvf8qLeqfO/deM/eaTs7YNZHKzG8Ses4pSefUm
    85KjlA9y/bl6Fvja10UE09HM0lYqSwH8b2S3fvRrLxMFUnhVmW1+KjDAhOqEgoHl
    YIdTQXoAJMwyWBJf5uBrnl/m8oEtP1NBmYqlqN/eNiRKkM+lFn3PsRPWalSiPMC8
    Gi2XYdVFUMRXblMRiCa81MAO8rjAwWxVsBhXNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221590; bh=dqOc2DVwvV+0hyX9K9nPzxpjAr
    G91KGTeMFD0dzD4yQ=; b=KQ3+heZV89d3FJfw71qkLRwIL/vhVXB7/h98CR62SJ
    56X8YAnk0bz4oRxQ3st9IRSCkHvx3o+FA0Su9JkmkNMx9FdxBQncjbb0Z/8lgk6B
    dDLS1fXHD9A/Xn85iQX5CYaLGbKCTpn1ElAMw2pwpF0eTKSytiSw8uvfaOvurrX0
    yw8c3NcL5wumSj+eTad3q2D9G93yxVBj8wedOiOv84mTdRDYgVS3eQUGpHIY8TrG
    2T8OYq6Y7GQ6qRn7naBjElKiTx4+M9EmNvq6xK4FVz8oP+ee1VTx12alVqDiFa2c
    KBkv+4ahNN+xK/s+dP6A5nH3tF/CzvZgOP97Xa2hvOlA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeCPP1V (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:27:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbeCPP1R (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 19/63] bcache: dont attach backing with duplicate UUID
Date: Fri, 16 Mar 2018 16:22:51 +0100
Message-Id: <20180316152302.184398395@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Lyle <mlyle@lyle.org>

commit 86755b7a96faed57f910f9e6b8061e019ac1ec08 upstream.

This can happen e.g. during disk cloning.

This is an incomplete fix: it does not catch duplicate UUIDs earlier
when things are still unattached.  It does not unregister the device.
Further changes to cope better with this are planned but conflict with
Coly's ongoing improvements to handling device errors.  In the meantime,
one can manually stop the device after this has happened.

Attempts to attach a duplicate device result in:

[  136.372404] loop: module loaded
[  136.424461] bcache: register_bdev() registered backing device loop0
[  136.424464] bcache: bch_cached_dev_attach() Tried to attach loop0 but duplicate UUID already attached

My test procedure is:

  dd if=/dev/sdb1 of=imgfile bs=1024 count=262144
  losetup -f imgfile

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/super.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -935,6 +935,7 @@ int bch_cached_dev_attach(struct cached_
 	uint32_t rtime = cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
 	char buf[BDEVNAME_SIZE];
+	struct cached_dev *exist_dc, *t;
 
 	bdevname(dc->bdev, buf);
 
@@ -958,6 +959,16 @@ int bch_cached_dev_attach(struct cached_
 		return -EINVAL;
 	}
 
+	/* Check whether already attached */
+	list_for_each_entry_safe(exist_dc, t, &c->cached_devs, list) {
+		if (!memcmp(dc->sb.uuid, exist_dc->sb.uuid, 16)) {
+			pr_err("Tried to attach %s but duplicate UUID already attached",
+				buf);
+
+			return -EINVAL;
+		}
+	}
+
 	u = uuid_find(c, dc->sb.uuid);
 
 	if (u &&
