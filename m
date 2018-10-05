Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE691C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E32D2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E32D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbeJFCqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:46:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35708 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbeJFCqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:46:54 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 370B767B0;
        Fri,  5 Oct 2018 19:46:40 +0000 (UTC)
Date:   Fri, 5 Oct 2018 12:46:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] writeback: fix range_cyclic writeback vs writepages
 deadlock
Message-Id: <20181005124640.3de2ba9dec8c713ee8cf286b@linux-foundation.org>
In-Reply-To: <20181005054526.21507-1-david@fromorbit.com>
References: <20181005054526.21507-1-david@fromorbit.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Oct 2018 15:45:26 +1000 Dave Chinner <david@fromorbit.com> wrote:

> From: Dave Chinner <dchinner@redhat.com>
> 
> We've recently seen a workload on XFS filesystems with a repeatable
> deadlock between background writeback and a multi-process
> application doing concurrent writes and fsyncs to a small range of a
> file.
> 
> ...
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.de>

Not a serious enough problem for a -stable backport?
