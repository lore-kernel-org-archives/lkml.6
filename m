Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A69C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F206921564
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F206921564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbeHMTUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:20:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54036 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:20:02 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C82C9145A6BF2;
        Mon, 13 Aug 2018 09:37:03 -0700 (PDT)
Date:   Mon, 13 Aug 2018 09:37:02 -0700 (PDT)
Message-Id: <20180813.093702.2205532109074390272.davem@davemloft.net>
To:     zong@andestech.com
Cc:     rostedt@goodmis.org, mingo@redhat.com, dsahern@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        zongbox@gmail.com, greentime@andestech.com
Subject: Re: [PATCH] net: Change the layout of structure
 trace_event_raw_fib_table_lookup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1534127212-13186-1-git-send-email-zong@andestech.com>
References: <1534127212-13186-1-git-send-email-zong@andestech.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 09:37:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zong Li <zong@andestech.com>
Date: Mon, 13 Aug 2018 10:26:52 +0800

> There is an unalignment access about the structure
> 'trace_event_raw_fib_table_lookup'.
> 
> In include/trace/events/fib.h, there is a memory operation which casting
> the 'src' data member to a pointer, and then store a value to this
> pointer point to.
> 
> p32 = (__be32 *) __entry->src;
> *p32 = flp->saddr;
> 
> The offset of 'src' in structure trace_event_raw_fib_table_lookup is not
> four bytes alignment. On some architectures, they don't permit the
> unalignment access, it need to pay the price to handle this situation in
> exception handler.
> 
> Adjust the layout of structure to avoid this case.
> 
> Signed-off-by: Zong Li <zong@andestech.com>

Applied, with Fixes tag from David added.
