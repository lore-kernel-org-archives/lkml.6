Return-Path: <SRS0=gsCl=F4=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891914-1520357677-2-1947298936700957644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=gsCl=F4=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357677; b=giWuHp1yxl4tHnzPdvJHUfDJfSdPVga5KvrQz4IJwo28exx
    0+48oOBHuvZLAxUrqZL9Om5BOxcnYJN2oYKoSIeRnN6aw9rqDkghVq4qiZtJuWLQ
    YdPbl6vuc5+XatyMgV6KCa87OTkgjh6hAD1bHYNr2vIHgONO8uZJFzKQ0rhqXtWP
    6lWBa6hoAvFB//VUOQtiKPCimnIduJpsMr5w1VEHNN5WX9UL4XJWYblv27dd+cBG
    VsqkKjdjt6n+gjOW+bOdra2L/2URBMR+NPWtneckMdTWolKVSkZCPKZEr1l+ztdQ
    W03RwBlmbGtyk1gGampDM30nDRGWXNOJ4nJJVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1520357677; bh=BizgwUPkxZF
    cerMykfid3sJPS6OUA8kmmCyGoQUnzYE=; b=TAPT4WxDqVannbAlp9qb55AYetn
    /r2zqXT/spotQCB8lnQn50e1TgPQJ/D23mRrLL6WeEB0hZ+KIWers6aTpebC1ZH2
    EjfRWrwZ9KDtoHkMyhP6zXyC0Qy4e0xWPNbCUlftaALXbmOi+Mhx78rF/2zCGX8L
    WZEOq/rikvwY7ttnQf0L7qDa4oExYNRFpORGOsnPSDrX8JYW42RnXI43h3EJDXZO
    4q+CU324heTyibLTgAla/qHi22hwkuTJY+dXuATEndPlDkj3aLtsqckfrC+NH/Zw
    5h5g0uQq/ippxPXsIqOB6kYJK2kxz1/f9076Dh0oiaZYcCfK40Cl9oZCeMA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wi+tikhz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ktdoZXRl;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Wi+tikhz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ktdoZXRl;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CFD20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELus1vmMa9Z8oNk1bF/qBLH7JZRSa/w3MUV1P+IvsMzCV0YJ8FRnQ55hwKoVln+Rv46njHb8PA==
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	jannh@google.com,
	paulmck@linux.vnet.ibm.com,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH 3/7] RDMAVT: Fix synchronization around percpu_ref
Date: Tue,  6 Mar 2018 09:33:12 -0800
Message-Id: <20180306173316.3088458-3-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180306173316.3088458-1-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

rvt_mregion uses percpu_ref for reference counting and RCU to protect
accesses from lkey_table.  When a rvt_mregion needs to be freed, it
first gets unregistered from lkey_table and then rvt_check_refs() is
called to wait for in-flight usages before the rvt_mregion is freed.

rvt_check_refs() seems to have a couple issues.

* It has a fast exit path which tests percpu_ref_is_zero().  However,
  a percpu_ref reading zero doesn't mean that the object can be
  released.  In fact, the ->release() callback might not even have
  started executing yet.  Proceeding with freeing can lead to
  use-after-free.

* lkey_table is RCU protected but there is no RCU grace period in the
  free path.  percpu_ref uses RCU internally but it's sched-RCU whose
  grace periods are different from regular RCU.  Also, it generally
  isn't a good idea to depend on internal behaviors like this.

To address the above issues, this patch removes the the fast exit and
adds an explicit synchronize_rcu().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: linux-rdma@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Hello, Dennis, Mike.

I don't know RDMA at all and this patch is only compile tested.  Can
you please take a careful look?

Thanks.

 drivers/infiniband/sw/rdmavt/mr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 1b2e536..cc429b5 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -489,11 +489,13 @@ static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
 	unsigned long timeout;
 	struct rvt_dev_info *rdi = ib_to_rvt(mr->pd->device);
 
-	if (percpu_ref_is_zero(&mr->refcount))
-		return 0;
-	/* avoid dma mr */
-	if (mr->lkey)
+	if (mr->lkey) {
+		/* avoid dma mr */
 		rvt_dereg_clean_qps(mr);
+		/* @mr was indexed on rcu protected @lkey_table */
+		synchronize_rcu();
+	}
+
 	timeout = wait_for_completion_timeout(&mr->comp, 5 * HZ);
 	if (!timeout) {
 		rvt_pr_err(rdi,
-- 
2.9.5
