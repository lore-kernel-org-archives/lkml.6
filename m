Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7096C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A622B28
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90A622B28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeGBVBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:01:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752683AbeGBVBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:01:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4EF9DA2;
        Mon,  2 Jul 2018 21:01:10 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:01:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v7 REBASED 00/17] Improve shrink_slab() scalability (old
 complexity was O(n^2), new is O(n))
Message-Id: <20180702140109.38f65bdc5cb48b47f923b610@linux-foundation.org>
In-Reply-To: <46d951be-d3c4-91a0-0e33-711591914470@virtuozzo.com>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
        <46d951be-d3c4-91a0-0e33-711591914470@virtuozzo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 12:10:47 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Hi, Andrew,
> 
> this series is made on top of 4.18-rc1, while now I see "mm-list_lru-add-lock_irq-member-to-__list_lru_init.patch"
> in mm tree, which conflicts with two of patches from series.

Well, "mm: use irq locking suffix instead local_irq_disable()" is a
fairly straightforward cleanup series, so it would be best to base your
patches on that work, please.

There is a significant review comment from Vladimir against "mm:
list_lru: add lock_irq member to __list_lru_init()" to which Sebastian
has yet to respond (please).

> Should I rebase the series on top of current mm tree? What are you plans on this series?

It looks like they're ready for an initial merge.
