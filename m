Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2126129-1523980900-2-12075653545006088197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523980899; b=NcHgvG9zk/g7NfzXhev908+LJ3NF+a0XEnDUPxssACiKwlSNT3
    mJv5AhxaWru7tEyrcsnHZFuPAro57+2LosqsdfzUZ4u59eLM5SpreqevqARGyX+G
    t+uieemiUEYc0caBg0R8tnixxV1Gz8AitKoc7gnjDGEJdF51B68aPgPj4lq/fhRy
    IfkwEfM2nFPyaSmJaPOXQZ5Y6DY3aVn0+M9D/MNVD9UEd5u9fzQ9FG8Z9rPBjxKr
    oPIGuuLZ4atF7MKsi+xDI2PkQlM4Vlv5ZoKeXqA9b+495FdhFNzmNJHqvRYpM64S
    a5s40XvhDSutPhqCAP53FifMKtl0AAZ38OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523980899; bh=rVs1uqfQX0BF7kn3xdi4fK6HXfgUfy
    5Rni5v2Qm22s8=; b=SdW7DmRqzmu30ZhSXQCCUXKzj9KhN66bhLtmhA3/RUl+Ji
    UTGaPCppWk81yGkTArDpo1i61z01IZDLInwwJFE+6OdXfpCNuZ59sL3L1u6GqoR9
    Xi+/CWGZaWoGTkFAhEs87TWcXOmJ8aZGeTgKj71A93Jccd3Cc92EvA3O0VC/zd/D
    8G8C4fb6Evyvvfg2JJKBUMkt2SeX4SXUGKypZJE9nznatNNOkBhAQeeIddAtZLB6
    T+ncVsXB7ZHdbhM4kvaq4En54TH2UNQYfrRvxAvrKZs3RxWIYwJObizgo9IXm1Cp
    icu0hWc6dPx9FtF5ckJT5bPkYUqi2E+95gEeA5NQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKgsYcY+8CYT4JL6YeL+B82PCNQ+bvQEQrNSeNWPT8G2QWAkE3rH4PMI7yhq9AtUNwpgG3YehwHxIMqVEjQEN+AFMqtQHddvG6U61X8yTUiwvvEBBj3n
    LFQUQIYLyI0VqLrGgsRA/vZNmsT0oiIpRYv9QGmDJXVqt/dxzhDTxS6x9yI30cZaSDtfnqXmwdMK0+M3elykoNyvFr0Q/nyPdVqdnYDuyImScNzx8pKkYAwO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=NSgSl6uiuIS8w7tqW_gA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753779AbeDQQBg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:01:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeDQQBc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:01:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 42/68] blk-mq: make sure that correct hctx->next_cpu is set
Date: Tue, 17 Apr 2018 17:57:55 +0200
Message-Id: <20180417155751.044663858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit a1c735fb790745f94a359df45c11df4a69760389 upstream.

>From commit 20e4d81393196 (blk-mq: simplify queue mapping & schedule
with each possisble CPU), one hctx can be mapped from all offline CPUs,
then hctx->next_cpu can be set as wrong.

This patch fixes this issue by making hctx->next_cpu pointing to the
first CPU in hctx->cpumask if all CPUs in hctx->cpumask are offline.

Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Fixes: 20e4d81393196 ("blk-mq: simplify queue mapping & schedule with each possisble CPU")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2439,6 +2439,8 @@ static void blk_mq_map_swqueue(struct re
 		 */
 		hctx->next_cpu = cpumask_first_and(hctx->cpumask,
 				cpu_online_mask);
+		if (hctx->next_cpu >= nr_cpu_ids)
+			hctx->next_cpu = cpumask_first(hctx->cpumask);
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
 	}
 }
