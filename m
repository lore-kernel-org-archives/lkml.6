Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2839749-1523464099-2-12195818045721793600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464098; b=T0VZJTgBC0HrIVhHnaBTcFJfnU1csdhVx+IJ25Ksv9QBCPL3Iz
    0BRkx3/pm2JPw2YiOEdXCCNAC9JXY7jtEuYZaVRA94jSMrMq9FB2EoMSSmQHbf5V
    d9Eh76p+A84+8cqRk9bWx7ch+DK/3dBiExLUS8fLeV8dSOI+H2n40GABPO1a3BbF
    fP1Alr5o1S3BOo6p0L8TmyX8IN9R/yGStrw1xBYzjfe1Vea0NAAGrUuvk3CWtBMp
    Iae7wWzOT8/mpg2baBCN9xj70kSuqrA2ICA1Gmi5EA3OC8U5vOI3uEZFQgRkJNDo
    ZFeGDEYNIvFWgsYArblSuLXbYhNJIShmKKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464098;
    bh=1cgMIsVIDTS0ajPT+FW0UKbKtUQuvJUK7ABHxNSnuhU=; b=nHqYy+x7JPlJ
    Fr9L5W6vv50EbWqAEXYU1v4t+dFBZlyClOZKwjt4MGTFfJuthwSN5BwvkURBi6J7
    xmuDscje/bhJnrPZfM88NJQmwRBO7BoLCBdk+Q7UbmBIVhaR6d8RocwDmFBvxKFD
    nZLJ/l07fG3nOCeldJB1oabAuGr6nPg1xq+nTWmfgKZuUYEsUXAimR/D4X7VV4JI
    Hdxvc+zNMVGmwtLakKnh27y1QTzZ8FSiJbIz/7TQTmLvGUQ6VhOd4r5KHjrrzZSY
    ynyzflDeFhw/R3awqHB4EmoAnFCCIxe5CAUOkN+q9VweBDp+wnadaXbuSTCZ+L/F
    13klQlKsdQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHkzxwQbAmQHobcIZnsyKmshSCafQEcVM1RsS7/cn42REwDULxkOAsrwWaODUdVy1IvgMSraIi1CrDDmQ6bO7ZwmJiQPpqxmook/84HepIZRSmQwdWwf
    8GHDNDz1f9hW5vUKt618ZSdcrUPVUYyxea+nN8r97rhRm393t0/RpdgETn+VEBY17B8FMS5TTl4zRblZ99Cf9Pz77migVMOPl1aDqmcaQN9MMhTM4z+tz7f/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=oGMlB6cnAAAA:8
    a=cSiHDGriAQjEs3iDiMIA:9 a=OKF8EwzJlas46_-i:21 a=Z_Svaf6VWpKyLnUl:21
    a=QEXdDO2ut3YA:10 a=_twGcrsKVrYA:10 a=x8gzFH9gYPwA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22 a=NdAtdrkLVvyUPsUoGJp4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754297AbeDKQ0q (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754293AbeDKQ0o (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:44 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/24] x86/mmiotrace: Lock down the testmmiotrace module
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:42 +0100
Message-ID: <152346400272.4030.10900275407737137506.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The testmmiotrace module shouldn't be permitted when the kernel is locked
down as it can be used to arbitrarily read and write MMIO space.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Howells <dhowells@redhat.com
cc: Thomas Gleixner <tglx@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Ingo Molnar <mingo@kernel.org>
cc: "H. Peter Anvin" <hpa@zytor.com>
cc: x86@kernel.org
---

 arch/x86/mm/testmmiotrace.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/testmmiotrace.c b/arch/x86/mm/testmmiotrace.c
index f6ae6830b341..bbaad357f5d7 100644
--- a/arch/x86/mm/testmmiotrace.c
+++ b/arch/x86/mm/testmmiotrace.c
@@ -115,6 +115,9 @@ static int __init init(void)
 {
 	unsigned long size = (read_far) ? (8 << 20) : (16 << 10);
 
+	if (kernel_is_locked_down("MMIO trace testing"))
+		return -EPERM;
+
 	if (mmio_address == 0) {
 		pr_err("you have to use the module argument mmio_address.\n");
 		pr_err("DO NOT LOAD THIS MODULE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!\n");

