Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753525AbeDMBEf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbeDMBEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:04:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BDC21781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Thu, 12 Apr 2018 18:04:33 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH] f2fs: set deadline to drop expired inmem pages
Message-ID: <20180413010433.GB51348@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180408081312.6190-1-yuchao0@huawei.com>
 <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/4/8 16:13, Chao Yu wrote:
> > f2fs doesn't allow abuse on atomic write class interface, so except
> > limiting in-mem pages' total memory usage capacity, we need to limit
> > start-commit time as well, otherwise we may run into infinite loop
> > during foreground GC because target blocks in victim segment are
> > belong to atomic opened file for long time.
> > 
> > Now, we will check the condition with f2fs_balance_fs_bg in
> > background threads, once if user doesn't commit data exceeding 30
> > seconds, we will drop all cached data, so I expect it can keep our
> > system running safely to prevent Dos attack.
> 
> Is it worth to add this patch to avoid abuse on atomic write interface by user?

Hmm, hope to see a real problem first in this case.

> Thanks,
