Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7DFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9425B20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9425B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeK0UNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:13:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39206 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbeK0UNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:13:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so13876704wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vqw+1BG9wm2Ae2DFDGrBcwk5MzIueJBNcdoCUm0IGeI=;
        b=XwnDzP1pKd5HV2Rw06kdWwE4zMwvTOtKZMODKzJPYbE+lMK7JSRMW6Z7KeYlke4tAF
         15Y33P506MjheU9y8uY3+k0eciMRV0/RM1corW6JEh/lO6ZRZCpifhLDeGn+YnFWo40L
         I/6A3r1kdWoZVD3juJPx3lPepMD8blezycefcptEcgQcF2YKwMGxIRQlrHLW+CL+QaG8
         BksZ1nzz/CDPsCekd/b/Q/pnDnlBhkaZb0FgW2/XPM0ovAfue2QQ1bC2cR14y45LbRzi
         cPMuEyJdUsAoWqT6788E4Q715oCDa8EvmQzeGohqu6hQXLfx1scWwL+kYcLzZv3FUp7+
         ZcpA==
X-Gm-Message-State: AA+aEWbeLPAtqSIP1rROymMQhYnv9MIpq3sI9ZLXexY6ov+wS5HsYRTu
        SO2jrvpY2MQJQjyVfHyad+jMgw==
X-Google-Smtp-Source: AFSGD/WoPo8xx6O8kkkIhPT8V01l/Z0yeqIYOPkySgu+q7o3JDXV1G8lSf+olJD9QttntdBOdPAdag==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr28655307wrr.39.1543310165572;
        Tue, 27 Nov 2018 01:16:05 -0800 (PST)
Received: from hades.usersys.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x79sm8320584wmd.42.2018.11.27.01.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 01:16:04 -0800 (PST)
Date:   Tue, 27 Nov 2018 10:16:02 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Pan Bian <bianpan2016@163.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] xfs: libxfs: move xfs_perag_put late
Message-ID: <20181127091602.eaeczahefobpx544@hades.usersys.redhat.com>
Mail-Followup-To: Pan Bian <bianpan2016@163.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543278818-117362-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543278818-117362-1-git-send-email-bianpan2016@163.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:33:38AM +0800, Pan Bian wrote:
> The function xfs_alloc_get_freelist calls xfs_perag_put to drop the
> reference. However, pag->pagf_btreeblks is read and write after the 
> put operation. This patch moves the put operation late.

I'm not a native English speaker too, but I believe it should be "is read and
written after..."

But, for the code itself, you can add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

Cheers

> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
> V2: correct the commit log
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
