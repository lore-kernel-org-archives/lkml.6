Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832663-2-17857522689576235722
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
    t=1519832662; b=LiazYGsRhSpWuG75IqrEXzBjP3deEeamXkIv/8u/X9k2AqJ
    mtWiolhWCAy+5FECBeOHLyAQ/W6Bt0OV/8vc75aXY4Bjx2/twCL3TGYoWrmpx78L
    zpn5ycwUCHLaZs/ViO+30zmbpYsGo8Qn+dLLs3tpGr8qcWN1DORR1s71ky9sy8nP
    JCkJssZRE6YKm5cQGiAFkUf2mmXHdGQZN4f2hLd+q+Gn+nwYHzFwY3VptvbMHfEV
    hdF51TPYjHjEHzigp2GOSb/WHv5iJNp70IrhOjQHBI24y+R2p3+zDGYQ7y8QSJih
    FCNQWv1F3OFpEOTCoyFs7ANdqUh54npAPxLXUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832662; bh=b+J3GpBkxDvcCphpRjG
    aKvaF2qW0RyID5Fec1N4+XEE=; b=I3Q/AzziWTpY0plCjr8qXF40gpCCUNBB1RY
    RUa6gy/Eksn+k3bdU7uUX2o+Oco7TjYoytYTzskMEIEulfNmR/UMLOGWTplGFPnk
    dPGk/psTCMig5cA8WSb0dquqxNxxcPR3kYz2pFzn8m/fwgDVYMwkv+Gp3FBYHrwi
    h42WdhM34HWgTMrQu+exFrR/fONS8D4zfDUqsX907FArntidSWj1Dge6aniAVJqr
    1kZ8FrfG6oa/9xuW6vQ2hGtyWkLKHhw79RsHIoZ9IhI0McVBrp81BKg2dxV84fPk
    CivSQGbhW8+P5hsJI7w/d4atx1Kr6Sjs2/cD530ZMvtIP9ulmeA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933205AbeB1Pm7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:42:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33400 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932654AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steve Wise" <swise@opengridcomputing.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.655828574@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 065/140] iw_cxgb4: Only validate the MSN for
 successful completions
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Steve Wise <swise@opengridcomputing.com>

commit f55688c45442bc863f40ad678c638785b26cdce6 upstream.

If the RECV CQE is in error, ignore the MSN check.  This was causing
recvs that were flushed into the sw cq to be completed with the wrong
status (BAD_MSN instead of FLUSHED).

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/cxgb4/cq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -484,10 +484,10 @@ static int poll_cq(struct t4_wq *wq, str
 			ret = -EAGAIN;
 			goto skip_cqe;
 		}
-		if (unlikely((CQE_WRID_MSN(hw_cqe) != (wq->rq.msn)))) {
+		if (unlikely(!CQE_STATUS(hw_cqe) &&
+			     CQE_WRID_MSN(hw_cqe) != wq->rq.msn)) {
 			t4_set_wq_in_error(wq);
-			hw_cqe->header |= htonl(V_CQE_STATUS(T4_ERR_MSN));
-			goto proc_cqe;
+			hw_cqe->header |= cpu_to_be32(V_CQE_STATUS(T4_ERR_MSN));
 		}
 		goto proc_cqe;
 	}
