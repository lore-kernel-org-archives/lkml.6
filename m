Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834272-2-15777510173162626406
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
    t=1519834271; b=f0sWx0FECH27iKcC7K1g/wLmtJ9XxNaIzbDhafpy1MsUGwY
    wzwnH3eyeQP4pIn359yEu+ICpt/lvTrj4oh+8pf7nGz0OC7plCc3LkVz4nyYdN9D
    gc3FGeX14eSOwAUAJDuLpbCMNimbGSdbT/EdgVhnqp+FNGzeaboIFjywYYZeS6Kj
    JI0uNxUHBqFc8jMxL9U8nLlut4PH8ym1nWCRU05/bMPhoLuoK15+HbxSd8H/5s68
    sWgFe2e00SuuFkVlvUtqcw7zgdB0kAcqanPqCSdMyjhQtoP0Aqa3k+LCJPKTtN9d
    fZm8X8pv/NCsqKh8Kgl6UJa5O8X1kTxhWF4mYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834271; bh=4ACUat9d7eRE2dGNOUu
    91XLhfC7FRiQsx1lXlAaqd68=; b=Wfxp3i4PhaT5Uqz6ZvvpqBnQaSZ9cJHlT69
    3kfxLhM4QIRFYzu7fE+BphEQgjQHpPD2ReSljIDdmIgGu9EhbbruoCSoBD30jj+r
    GO8k27wkQ/mYKXvjmqlSb0cFNkmzUS0pvDZ9yo3zKxQZhRKuMzbmCb0RZHMA9n+L
    F/4n2AZIrkc+4xKLe6NCZ1mMF2oRp/CDTsKSt7KJNrssC0oRhExtGXyYvR0cvYeP
    T98loKCJxJtf8FCSQx8Vz6IpjhHZH5Xhzk8JOrthxsvEvbNR+7/3Quywt43uCVGJ
    UahPvVAMwF6A3TKXjJ1wumRTJ4hOdtAvXaFsmvt4g0Y93E9PxWQ==
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
        id S1753071AbeB1QKy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:10:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34967 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933374AbeB1QIs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:48 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steve Wise" <swise@opengridcomputing.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.883573634@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 138/254] iw_cxgb4: Only validate the MSN for
 successful completions
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

From: Steve Wise <swise@opengridcomputing.com>

commit f55688c45442bc863f40ad678c638785b26cdce6 upstream.

If the RECV CQE is in error, ignore the MSN check.  This was causing
recvs that were flushed into the sw cq to be completed with the wrong
status (BAD_MSN instead of FLUSHED).

Signed-off-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/hw/cxgb4/cq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -574,10 +574,10 @@ static int poll_cq(struct t4_wq *wq, str
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
