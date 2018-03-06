Return-Path: <SRS0=gsCl=F4=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-870783-1520357720-2-1725398618340640004
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
    t=1520357719; b=daaXasYXV9rhHmKnGR5Kn5GitMiqQnXg1Th2JzrTdOCKk4R
    kLmyA6YJL2UtDzMzZ2i1dGHDHasSIIoFRc12KeDIWjETXfMOqU+e9YRxctY/ivF9
    3XJ+QcSv2CY5s0yTuHrxkUebYNg9/jSFbfraH0Ifpl+cWs+F1S5d7/a6Xew9IQ3X
    1zYNfFyVfORZl8OsndW8t2HWtWDr3NFI+/PpiLibgEwg1gTmQxpNQpNQCnUnw945
    GdKjYw+sLY/Px8elUZGwQ23nad/LT0ACyq1T7rvCkA/E01E5ys/XQ3H6aXRPo9DC
    zUJGlvLMyDs/elN5XJRRKESTXVfA6bg0l0hSF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1520357719; bh=AnhtS6EV7vG
    wicWnJ1Jq18HmGBzG/qLrYzc0e+f+bP8=; b=fENpaSOywkkSBF6/89NugCkmhJ8
    fttWWTitb2wLnD5lpDvN06sSx0rMhj3KEzoKYx9m/B1U0cMH1y1Q1PMWhSSRzUU6
    IH96IfvlTA/+7u+Fxr3B4PLK7rSapHa8vW/D+cGf/VoVjSFuW+k0kDK4+wqQDZMy
    bpJqaiZMuEsJ8EV+XQs0vp3sjNIFch1t9gPqKGP7iKw/pCJi6/yxzNAcwmz8/8h6
    iZZyMIgGztzSJamyCLNr4iX4khycgFXNlg//r8DaA6bDYlrqus+SShJqNU7B4CuY
    aB0gQqVaplY9wm5Bt1/R8S7hS7F2lTqpSgt+be2WeAQZQocsoNUPRfSpVXA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hkfv96eJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ra6KsUfG;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hkfv96eJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ra6KsUfG;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802B420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELt+VeHe4He6oK4vCMP0KjPAotv3w8yzN50BhObbV1W1IiavUvNQh8VS/MEa72Wx8vyomVYd0Q==
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
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/7] block: Remove superflous rcu_read_[un]lock_sched() in blk_queue_enter()
Date: Tue,  6 Mar 2018 09:33:14 -0800
Message-Id: <20180306173316.3088458-5-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180306173316.3088458-1-tj@kernel.org>
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work
reliably") added rcu_read_[un]lock_sched() to blk_queue_enter() along
with other changes but it doesn't seem to be doing anything.

blk_queue_enter() is called with @q - the pointer to the target
request_queue, so the caller obviously has to guarantee that @q can be
dereferenced, and inside the RCU-sched protected area, there's nothing
which needs further protection.

Let's remove the superflous rcu_read_[un]lock_sched().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
Hello, Bart.

This came up while auditing percpu_ref users for problematic RCU
usages.  I couldn't understand what the RCU protection was doing.
It'd be great if you can take a look and tell me whether I missed
something.

Thanks.

 block/blk-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6d82c4f..e3b4d1849 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -827,7 +827,6 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		bool success = false;
 		int ret;
 
-		rcu_read_lock_sched();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
 			/*
 			 * The code that sets the PREEMPT_ONLY flag is
@@ -840,7 +839,6 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 				percpu_ref_put(&q->q_usage_counter);
 			}
 		}
-		rcu_read_unlock_sched();
 
 		if (success)
 			return 0;
-- 
2.9.5
