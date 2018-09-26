Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB8EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF94214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF94214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeIZGet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:34:49 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:62526 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbeIZGet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 02:34:49 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 26 Sep 2018 09:54:41 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1g4xd9-0006T8-R9; Wed, 26 Sep 2018 10:24:39 +1000
Date:   Wed, 26 Sep 2018 10:24:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org, riel@redhat.com,
        hannes@cmpxchg.org, tj@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/8] btrfs: drop mmap_sem in mkwrite for btrfs
Message-ID: <20180926002439.GB18567@dastard>
References: <20180925153011.15311-1-josef@toxicpanda.com>
 <20180925153011.15311-9-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925153011.15311-9-josef@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:30:11AM -0400, Josef Bacik wrote:
> @@ -1454,6 +1463,11 @@ static inline int fixup_user_fault(struct task_struct *tsk,
>  	BUG();
>  	return -EFAULT;
>  }
> +stiatc inline struct file *maybe_unlock_mmap_for_io(struct vm_area_struct *vma,
> +						    int flags)
> +{
> +	return NULL;
> +}

This doesn't compile either.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
