Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214813-2-11407867035543878025
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
    t=1521214813; b=dI4WAIdWpIEowVHdpZqNQtRtX+gAZzz014qUrHI7Fjj9JEG
    lEoXn9uEhTnMo0mrCV4A3mu0+imR6jOi8wmdGfJOMZyh9BJXYYSz8jDeEY74C+WR
    sM9FFv0+nnBTv3i0YvyP/pE/SLSyUbA0pYfNJ3WBaJHnAAUIcv3rsf7ZoM/s03rr
    iNMtTXHM7xgAMTi9P5/zQbnAHsy6mxji+mh951FLyIo21uU/fAPoRSYUdx3gLc41
    vo7FEPJaNmcC8Ytf7l76Q/I5aQdXrhZf869GW125iircmd/TrPBdRsirxFaF0uDC
    ty0jSnovrTXyy3AOPr15f8WntkSwA8GScPdE4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214813; bh=EnlbDRM+n7d0Q9hUYvXVlbpCEC
    gTvNKOrTJAd9/dolo=; b=uyea5Ch0MEHyg3CM7C9YBFU+s0feMPD5hLqHABWgdR
    U5i6ayQ/SXn/1NAo6TpLt+59QKj0JaBoBA1Xzbbj6HSDaIVOS1YUuoR9YbSyxT5G
    mrR4bGA65GqdMFIoga7VCeoGxoESoaUpFvEfwtAmhZ/oXBVadvrU1xgRkpduevbs
    5rkJwxARsnhTS4WNocw9CRUJDmkrqOgyG0ssGKUJ3S4NQVeAOPz/mqMApToqpqxL
    0BsOaDXIKLvkC1zEef97IOui9FI77HiCFYNLQVG2+eV0mc0qY8W3Re28ppGFZpUS
    OkmmGxmixdoNNnzddD3YrqGOpOQzzPqmfc+xxLvjaAKg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S964981AbeCPPkG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:40:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934286AbeCPPkE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:40:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.15 024/128] dm mpath: fix passing integrity data
Date: Fri, 16 Mar 2018 16:22:45 +0100
Message-Id: <20180316152337.711806161@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Maier <maier@linux.vnet.ibm.com>

commit 8c5c147339d2e201108169327b1f99aa6d57d2cd upstream.

After v4.12 commit e2460f2a4bc7 ("dm: mark targets that pass integrity
data"), dm-multipath, e.g. on DIF+DIX SCSI disk paths, does not support
block integrity any more. So add it to the whitelist.

This is also a pre-requisite to use block integrity with other dm layer(s)
on top of multipath, such as kpartx partitions (dm-linear) or LVM.

Also, bump target version to reflect this fix.

Fixes: e2460f2a4bc7 ("dm: mark targets that pass integrity data")
Cc: <stable@vger.kernel.org> #4.12+
Bisected-by: Fedor Loshakov <loshakov@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-mpath.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1968,8 +1968,9 @@ static int multipath_busy(struct dm_targ
  *---------------------------------------------------------------*/
 static struct target_type multipath_target = {
 	.name = "multipath",
-	.version = {1, 12, 0},
-	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
+	.version = {1, 13, 0},
+	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE |
+		    DM_TARGET_PASSES_INTEGRITY,
 	.module = THIS_MODULE,
 	.ctr = multipath_ctr,
 	.dtr = multipath_dtr,
