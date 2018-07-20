Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABF72064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABF72064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeGTUW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:22:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387989AbeGTUW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:22:26 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C141A720;
        Fri, 20 Jul 2018 19:32:44 +0000 (UTC)
Date:   Fri, 20 Jul 2018 12:32:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill@shutemov.name, hughd@google.com, rientjes@google.com,
        aaron.lu@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
Message-Id: <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
In-Reply-To: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 02:13:50 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> By digging into the original review, it looks use_zero_page sysfs knob
> was added to help ease-of-testing and give user a way to mitigate
> refcounting overhead.
> 
> It has been a few years since the knob was added at the first place, I
> think we are confident that it is stable enough. And, since commit
> 6fcb52a56ff60 ("thp: reduce usage of huge zero page's atomic counter"),
> it looks refcounting overhead has been reduced significantly.
> 
> Other than the above, the value of the knob is always 1 (enabled by
> default), I'm supposed very few people turn it off by default.
> 
> So, it sounds not worth to still keep this knob around.

Probably OK.  Might not be OK, nobody knows.

It's been there for seven years so another six months won't kill us. 
How about as an intermediate step we add a printk("use_zero_page is
scheduled for removal.  Please contact linux-mm@kvack.org if you need
it").
