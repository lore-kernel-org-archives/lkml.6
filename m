Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839082-2-11576040302713688393
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
    t=1519839081; b=rtEOoqP/fc9mo+Kgz/Uy1Ory3MPvxxyukpfvhU0WJlWyBh6
    fe5xdSXLT+rFnF59PrWqxpUnmaNMKXzj+jMHuu1eXMW+lAX+nE5772c5NcyzJkc5
    KjbDqb0I/CUotHPZF6XjvKzE/9QkJFTlWQn14wjChn3zjXsSmTeTrZc3ZzJMOz1W
    QySoynk6/1yJqFYWE2aLm47Q2FJ397XjVZMFRwcib/1g0vPy0Mi4LmZxG3L9v+XP
    h42Ruj9uuZ0kxyPYyQaxaTgRHgCdRe9BIGSLVLF4/M4Ywg/SoEMBctU8PPZ+Ygba
    ezWod/D8njUycu6aAHSZzBZ0syeu7efYcnsK8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839081; bh=ZciXysK8gzzK3Y8X6AY
    X3vz4+hbaNS4adqD8ldl49gE=; b=mz5mZEGMP1LdsIwfHVGNc4ciC/aDMpPGfSK
    AsYAGA2GrbzBF7htedTuJB/jEsheV8/CLnYv+ycLPYT+HkS61b2VDI8NnaYZWmKt
    1AqLYfonJzEMNHtm29ySjcHaaqmAl6UTFMFkwVaovko9x0fr0iakLFR3kjbtCsNv
    zUi7DqisNrb4IGdxcQ2XaPvGopYfFmL2A8B4EivOphRwszH+nfPPf89Jeu9/o5sn
    NtzgE/GesWxdBVjIoQMLhrFzt4gdco2oLnl+i+Ox5JApMVPcQJ6Xg6PD85jbUSc+
    D0QLlCQJvktETayOwrBGeLBZeL/uaFDYPyYJuA+JZjzRhaorZFA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbeB1R3G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:29:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932589AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Li Jinyue" <lijinyue@huawei.com>,
        dvhart@infradead.org, peterz@infradead.org,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.626129355@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 098/140] futex: Prevent overflow by strengthen input
 validation
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

From: Li Jinyue <lijinyue@huawei.com>

commit fbe0e839d1e22d88810f3ee3e2f1479be4c0aa4a upstream.

UBSAN reports signed integer overflow in kernel/futex.c:

 UBSAN: Undefined behaviour in kernel/futex.c:2041:18
 signed integer overflow:
 0 - -2147483648 cannot be represented in type 'int'

Add a sanity check to catch negative values of nr_wake and nr_requeue.

Signed-off-by: Li Jinyue <lijinyue@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: dvhart@infradead.org
Link: https://lkml.kernel.org/r/1513242294-31786-1-git-send-email-lijinyue@huawei.com
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/futex.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1376,6 +1376,9 @@ static int futex_requeue(u32 __user *uad
 	struct plist_head *head1;
 	struct futex_q *this, *next;
 
+	if (nr_wake < 0 || nr_requeue < 0)
+		return -EINVAL;
+
 	if (requeue_pi) {
 		/*
 		 * Requeue PI only works on two distinct uaddrs. This
