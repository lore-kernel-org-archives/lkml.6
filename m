Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD3C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FB820664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FB820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeKZUZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:25:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37811 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKZUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:25:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so18084947wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 01:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uL7bgYzARgyTxVflDQBrnEwkDPt+c8BtMRqKstMHjRA=;
        b=bcCLtQU+S1IxIUgec4cUbRgr5xyYkhiYko1bxNjL9pIv9IET1eCBDnzkaG0+JTjaCQ
         +XqZgTI/juAJr49sdulY8vS4LEvFELRLWDj+CHVXBvaUU6ttHQdK9HWth2vDKXFUMp2p
         Z3tWRAcXINOX4BHWNOefgDWu86ozt/V5zCw+DE9MTKhh8Wmz49NyJ16WQs9NWJkAeDUW
         w1AF6vNBuES1I/SyOyajlIcCtdUcE6XRrQqqgAbqZN6l9hvtcFiDAq3VgTxlBdCbzaA6
         J3rLDK1PDmp319bwMLjszW4SWqWpazhMa7BK3wnbWxghbj8zfC3H5rpGhQ3L0HaUR9MW
         t7WQ==
X-Gm-Message-State: AA+aEWakmj4uQ7t3FkmO3l49nprZMjqwXtgPdxF0pTms9569kAdcZefo
        071I+6k2BaSgsim6P2E/HAHRlA==
X-Google-Smtp-Source: AFSGD/Uwu1NwgzyQkFGZ3bdutLAvHRhb3MjDk7b4+1x86C7p49Wm7+ohDmNstRU2CCFrHr6r0ZZiog==
X-Received: by 2002:adf:dec4:: with SMTP id i4mr22019329wrn.307.1543224702478;
        Mon, 26 Nov 2018 01:31:42 -0800 (PST)
Received: from hades.usersys.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 60sm38143230wrb.81.2018.11.26.01.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 01:31:41 -0800 (PST)
Date:   Mon, 26 Nov 2018 10:31:39 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: libxfs: move xfs_perag_put late
Message-ID: <20181126093139.cgojlmtubzuzdb23@hades.usersys.redhat.com>
Mail-Followup-To: Pan Bian <bianpan2016@163.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org
References: <1543052660-58625-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543052660-58625-1-git-send-email-bianpan2016@163.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 05:44:20PM +0800, Pan Bian wrote:
> The function xfs_alloc_get_freelist calls xfs_perag_put to drop the
> reference. In this case, pag may be released. However,
> pag->pagf_btreeblks is read and write after the put operation. This may
> result in a use-after-free bug. This patch moves the put operation late.
> 

The patch looks reasonable, can you detail more how did you find it? Via code
inspection of you hit this user-after-free in some way?

Cheers

> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  fs/xfs/libxfs/xfs_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index e1c0c0d..4be387d 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -2435,7 +2435,6 @@ xfs_alloc_get_freelist(
>  	be32_add_cpu(&agf->agf_flcount, -1);
>  	xfs_trans_agflist_delta(tp, -1);
>  	pag->pagf_flcount--;
> -	xfs_perag_put(pag);
>  
>  	logflags = XFS_AGF_FLFIRST | XFS_AGF_FLCOUNT;
>  	if (btreeblk) {
> @@ -2443,6 +2442,7 @@ xfs_alloc_get_freelist(
>  		pag->pagf_btreeblks++;
>  		logflags |= XFS_AGF_BTREEBLKS;
>  	}
> +	xfs_perag_put(pag);
>  
>  	xfs_alloc_log_agf(tp, agbp, logflags);
>  	*bnop = bno;
> -- 
> 2.7.4
> 
> 

-- 
Carlos
