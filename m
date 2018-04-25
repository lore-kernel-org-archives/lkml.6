Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3948364-1524617218-2-7838413596030801619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='jp',
  MailFrom='org'
X-Spam-charsets: plain='ISO-2022-JP'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524617217; b=iW2Ndj3nYmtH9oKi+dkBFEFdU0k9OZvgdsQBJ2FjKlIRzCplOg
    GJJB/xIORulBVa74y6NEwiWm9FIoyNuY/dxb+pqsB700nOFBwv/O7Wwav9q72KDB
    l63lkiaoLMFENPDh1fPnypGqlDxQ3K81+eXl5BFaUy5RczT6YhULq7tQMCTg5UNf
    WY4QZXjdDjrhvFUWDNAIOGBpVM8//xUpzFJ6vDh/rwNf6jj9kW03LLnEytobin+4
    vzQ4kfrtEm05UWv5bfiTnCISvOittLPNVRYHtytbJB0qJDd9minRZbJNoNG1UWUe
    WsJLdYpoVwWv1ydMSIeoL9NhU8V4d3IbiQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc
    :mime-version:content-transfer-encoding:date:references
    :in-reply-to:content-type:sender:list-id; s=fm2; t=1524617217;
    bh=Qu/uCxcYPzf9ss2C3Z6bASoNYE57sGbhsqX6wyqzbxU=; b=fQXRvAABzzVq
    cGhR/+73WNwPIDZxuPoIOsVGx7UsLW8uI9mwcpTdUwIIc/beO35Pj7BAt3wptZ41
    bXvunH8OeDVjDRZfA7/MFvbEXLjzP7zy7aESdLtrDXZhIoXyeYou5el/kaqLQ4y8
    clhxD+tzwSvn8imQt9QNIpwxwRTQlM4JM46ZSha2DP7UGXoS/oGRYsNpi72p2/zR
    2tduoegccgITDw6NXp/IZVVkBgDYGdyJ2eoVgirT/8v7yviror1vlGF81gNhez9+
    KgsZ7bRRdZWjtBQj2MT25rOIeu6EXqb+zFKlNxLBlABsU9rD1bEnEuFucHrdBnFy
    8ys3kJmRMg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBS5gEpEi4JY4OWBPcT5lUlRlXIvyHq1Ya0hld2rHkoBBF1X4dyXX7qVRZldEfzktzAL9FXImUl5DyvwfRXGG2Y06JFv3JaWZQA5Z9DDEUTKbe8+CL/m
    YeYobkBF/JcDJb8qzDRCKHq0HP9tdKZg6SPybBO/wOqdd1JfGgoCKvV0dO1V1tP+NI80S6iR0LvBbzdBTdokpxZkgE18pvkKkacMs9QlFNPurVfmF+Uzp+/H
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=ZPSk82zQDygA:10 a=Kd1tUaAdevIA:10
    a=WOIhxxpJ4jf4QV2mRS0A:9 a=UAVRJdkkkM0A:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeDYAqv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 20:46:51 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:38188 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDYAqr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 20:46:47 -0400
Message-Id: <201804250046.w3P0kgkd045841@www262.sakura.ne.jp>
Subject: Re: [PATCH] random: fix possible sleeping allocation from irq context
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: "\"\\\"Theodore Ts\'o\\\"\"" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Apr 2018 09:46:42 +0900
References: <20180424034138.23994-1-tytso@mit.edu>
In-Reply-To: <20180424034138.23994-1-tytso@mit.edu>
Content-Type: text/plain; charset="ISO-2022-JP"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Theodore Ts\'o wrote:
> We can do a sleeping allocation from an irq context when CONFIG_NUMA
> is enabled.  Fix this by initializing the NUMA crng instances in a
> workqueue.

Offloading to workqueue context itself would be OK,
but this patch makes linux.git unbootable because

	if (crng == &primary_crng && crng_init < 2) {
		invalidate_batched_entropy();
		numa_crng_init(); // <= Deferred to workqueue context.
		crng_init = 2; // <= Not waiting for workqueue context, and oops before console becomes ready. ;-)
		process_random_ready_list();
		wake_up_interruptible(&crng_init_wait);
		pr_notice(\"random: crng init done\\n\");
	}

Please don\'t pretend rng_ready() before workqueue context is processed.
