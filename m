Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C43CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4A4206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4A4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeK2KpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:45:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeK2KpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:45:02 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 829EC9D;
        Wed, 28 Nov 2018 23:41:42 +0000 (UTC)
Date:   Wed, 28 Nov 2018 15:41:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: writeback throttle
Message-Id: <20181128154141.d67b70957bc4833d9f0d6635@linux-foundation.org>
In-Reply-To: <20181127055429.251614-8-minchan@kernel.org>
References: <20181127055429.251614-1-minchan@kernel.org>
        <20181127055429.251614-8-minchan@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 14:54:29 +0900 Minchan Kim <minchan@kernel.org> wrote:

> On small memory system, there are lots of write IO so if we use
> flash device as swap, there would be serious flash wearout.
> To overcome the problem, system developers need to design write
> limitation strategy to guarantee flash health for entire product life.
> 
> This patch creates a new konb "writeback_limit" on zram. With that,
> if current writeback IO count(/sys/block/zramX/io_stat) excceds
> the limitation, zram stops further writeback until admin can reset
> the limit.

I'm not really understanding this.  Does this only refer to suspending
the idle page writeback feature?  Not all zram writeback, surely?

I don't think the documentation gives an administrator sufficient
information to effectively use the feature.  Some additional discussion
would help.  What sort of values should it be set to and why?

And what is the default setting?  And why?

And the limit isn't persistent across reboots which makes me wonder
whether the overall feature is particularly valuable?

