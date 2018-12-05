Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB1CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5D206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="2UInTKoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA5D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeLEWX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:23:59 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45774 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:23:59 -0500
Received: by mail-io1-f67.google.com with SMTP id o5so12076103iop.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 14:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxNNXr/Mw7gCwonT8ehVka9tv+ZLhL+v52e692VuD+4=;
        b=2UInTKoPSNQoCs1aXJ3uhXUyxZUhWdbOBotNT/Q/ep2QLYQtSBRuNiOvU6Ej+jQWzc
         nLrvTCXcaxhiSCOcnD2HltpXLX7kiCzNq9MtRROSQC58/9xFWyKA21vj5byk0cH0xEcT
         R/z5sH4zwFgHzDM/BHGrYlkfwmuG79Ws8Mh8dYKjx4KacBoPOiGUqkfQx33xaM4PELVm
         4PaF7iPzoxMA6feY7Yqtgn14hgusmAZ2RgByw/N6498MzP+lU+a5jiM62qvBXOIRPnoE
         RgrrJ7qOdBU/4tG2k59suIk5lNHendA2I15JxTzS9xPSW/s8DVPRZOGHga5ZOdlsYoWR
         yzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxNNXr/Mw7gCwonT8ehVka9tv+ZLhL+v52e692VuD+4=;
        b=VfQhwtNjFryXkF1LQldUEoNNBYdIAb89ZWA5Dk1Hxf6jyL+FAZjlcGbrsEBetI/DwW
         LSAhAM55FgguWA/9bDBEmCsRhlXPd66rkmZWlzLgrqCUczUUksbIhUshuhG1/6QD90ql
         xThk/tTU6dF9mBU0P06c/90XXcWkUh1nT9HyLcz7DfknUwnGPEM35JPt+VkKF3/OvYNE
         v5G8L1/xhATfcSTCzxqlbQ3kZg1UoIG0R04/7Fk1gjxqswN93RBZMnK3CQnL5VlrKL0v
         XAugVyhxZCA+rQ4eo4vByF5QEZHgT8f0pXoCQBpB9vviKYeii1QvQzsqrE8lZ5ulwDwb
         vWeA==
X-Gm-Message-State: AA+aEWaJK7wOq5APC3H8qYp3/OUCuM+pJZ4KuUOmnaLPCuPRq+c81rRP
        8n8rZGSGr8eRPzJVOHxrm0LhE7t5bfU=
X-Google-Smtp-Source: AFSGD/VOYnR9gxq2tOooPumU9Y34IengHRAKH4DcPog3Nj8ANbrmNN2gMu/k46cjLd/UmSwQbLtMSw==
X-Received: by 2002:a6b:e612:: with SMTP id g18mr24019001ioh.292.1544048634073;
        Wed, 05 Dec 2018 14:23:54 -0800 (PST)
Received: from localhost ([8.46.75.5])
        by smtp.gmail.com with ESMTPSA id r16sm9098508ioa.16.2018.12.05.14.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 14:23:53 -0800 (PST)
Date:   Wed, 5 Dec 2018 14:23:40 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org, tj@kernel.org,
        david@fromorbit.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 3/4] filemap: drop the mmap_sem for all blocking
 operations
Message-ID: <20181205222340.GB13938@cmpxchg.org>
References: <20181130195812.19536-1-josef@toxicpanda.com>
 <20181130195812.19536-4-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130195812.19536-4-josef@toxicpanda.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:58:11PM -0500, Josef Bacik wrote:
> Currently we only drop the mmap_sem if there is contention on the page
> lock.  The idea is that we issue readahead and then go to lock the page
> while it is under IO and we want to not hold the mmap_sem during the IO.
> 
> The problem with this is the assumption that the readahead does
> anything.  In the case that the box is under extreme memory or IO
> pressure we may end up not reading anything at all for readahead, which
> means we will end up reading in the page under the mmap_sem.

I'd also add that even if readahead did something, the block request
queues could be contended enough that merely submitting the io could
become IO bound if it has to wait for in-flight requests.

Not really a concern with cgroup IO control, but this has always
somewhat defeated the original purpose of the mmap_sem dropping
(avoiding serializing page faults when there is a writer queued).

> Instead rework filemap fault path to drop the mmap sem at any point that
> we may do IO or block for an extended period of time.  This includes
> while issuing readahead, locking the page, or needing to call ->readpage
> because readahead did not occur.  Then once we have a fully uptodate
> page we can return with VM_FAULT_RETRY and come back again to find our
> nicely in-cache page that was gotten outside of the mmap_sem.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Keeping the fpin throughout the fault handler makes things a lot
simpler than the -EAGAIN and wait_on_page_locked dance from earlier
versions. Nice.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
