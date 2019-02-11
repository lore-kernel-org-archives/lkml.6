Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439F8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB5E21479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549869464;
	bh=osoV0i+qzhqLaqxHJT+Tin4HlOs0E/oPTuLQyP+EeuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WAAlQ0AltAOxmRDR4Hxq4+gK0z7K8uisPuwjAQ1aOy64fCYaDo9EAONjXpZaYremi
	 cjqjjLJ72BFaJGuZHZaN+JGLXNUYl9yG96yXz2xYdXfQ+kslWm74TqMpAJUXEXSaVd
	 qzE9IONQASfxEVbtvlCQX1p+rPQWMBKba58kDf18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfBKHRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:17:42 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38923 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBKHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:17:42 -0500
Received: by mail-wm1-f48.google.com with SMTP id f16so14850893wmh.4;
        Sun, 10 Feb 2019 23:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P391kL3gCuHtB35uoThpUQh+6nAAuRZBYwumEQnFhZ4=;
        b=nVlbSnzwd/nNU1LcGA0d1msKClONCBeVYAa7IdWJzBYmY7xZrFPxDe+4gvCdGKubqo
         I9qvjYihoEsFuMPeKMzEWSu+JcT8/L7/hPzf9ovi7BDWDABe8v0zrDYjv5vKar4h5t9r
         mk5L7kXjaPUhNcjD46t6RIx5UExNwkewQu3Z6AwJMHy8DDy+acg5150Tr1BEbqlfU7wj
         0ggAoAaaqVuf1PN7ektD3gYJjOI79x1+V7XZUxrhPip9fJK81fqFXllmpcYbH7ydWrSH
         aY1m3SZJ/ld7kqI7rpYvPzUuEK1Pogh/MK6Kq9EoJ63xszOJ3EHXeOHFNdSjYS6OqLSx
         nLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P391kL3gCuHtB35uoThpUQh+6nAAuRZBYwumEQnFhZ4=;
        b=lbBoxzCawckrjmIabDuwri8fsLzmR2VNIA+DoDb2Zu6wZUuZdVqaHFqYdLbezG56gl
         IOTW/y7JZ4VNJ9ViNLCJyBZ49i3hGUTemlL4IcIThzDO+tu163Nq7N9X8mr62nDqfdNR
         h3BzfUm2Rd+NxvNhu3dMZSBgzSDnnPRrVj9XN0rD372GjEMO+2T/u4vN9ea2Om5bBWOe
         Bp3ifE34dW8KqRZxuh1X8CjALbnWgT591EN+RWbuzxUlf2HY9/hypmPm1PVWi4Sl+9CT
         pAr4Htw8dIc0JUHlIXjswXfMnZxs57lXdUIIrYbOYF1nXfmilidYF6Lda2shWPWYIVH0
         PRwQ==
X-Gm-Message-State: AHQUAubWk4AyITqNDXa5JWixOH5fun82TjLXHWiG++O7TcDGnW9s00p2
        J5JjsiZikofLbkSURXJkGaKrLQPb
X-Google-Smtp-Source: AHgI3IYW4UtEaqivMCP/Ea0X72eVRXzviAM5IshE4ja7MZLWtuJM8viOFWo15pTB32WDFvnMOSLH3Q==
X-Received: by 2002:a5d:680d:: with SMTP id w13mr20730790wru.196.1549869460101;
        Sun, 10 Feb 2019 23:17:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z21sm4815659wmf.19.2019.02.10.23.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:17:39 -0800 (PST)
Date:   Mon, 11 Feb 2019 08:17:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20190211071737.GB55579@gmail.com>
References: <20190211073657.7f9cd5ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211073657.7f9cd5ef@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   f6783319737f ("sched/fair: Fix insertion in rq->leaf_cfs_rq_list")
> 
> Fixes tag
> 
>   Fixes: 9c2791f936ef ("Fix hierarchical order in rq->leaf_cfs_rq_list")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject

It's still a unique substring of the original subject, so not a big deal 
IMO.

Thanks,

	Ingo

