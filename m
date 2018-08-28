Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6998AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4C0208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLda8ldd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C0208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeH1Ev2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:51:28 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37252 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeH1Ev2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:51:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id p84-v6so1617666oic.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UkdkB66DcDKPsx5gPCA60ye2TuaPQTYrquCIowXnBe0=;
        b=CLda8lddAHpqYWdr0iydv9XVwHhnrkodyCCB1wOTI4+dStrF8ovo9D7zfLzWtYwm/P
         /fbrAvcvxW5YrqPLMTsCL3S4k9JA1aTAthtUdj28Jv3ffkf1A5NTfXts2hkcVWAbnU/g
         2mHfDG6TW1x2nBNVubVem3XlLh1OEz7Wq09VOnawKR2ScMBnIfTixlB2p5AlT0muaAHI
         wG5tfJHaPCcCwzSXkg7I0B6+MHEwYcFDHM+HYI5+joEo4RhlvZdv72mTGtm/R1FR+wWM
         p2qyEq4AnpqVaFk9gIrk272VwcEQg0Y4H9jT/O7dLLRxCC+0N9sHvCI+Qz4hDjOR8tsQ
         lzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UkdkB66DcDKPsx5gPCA60ye2TuaPQTYrquCIowXnBe0=;
        b=JcGQ30b19+pa/LGnPqxbcPvb3H2Pu0uaNHRJKuUH2HJ+zCMsDOjBlsAClJ4qpRuoY+
         j4RcoHH2Add6QKPjbKkl2pjQqIHEmVTAyJ7D/KlldqbY3UByNXR8l3HVTE6rnsMnwFoA
         D2RXPyPKknpZcIIxr9QX9gRYC1AeiSsP41ON9TIb6et3WAdHTtH3dbNFELfJA82Y/4XU
         9GoabhM93QIpGqqoqJI3QUO6nfRFFByDCN1Bdy+AmK6yLp3Id2EDmlOxuQAOd1rBdAUu
         0lm/x0mhiZFI+Nk2AExDsObpb5pqsmjh+9xONcU2GNsB0FPPx7vjD/K9Lw7s8Cr8ybK5
         cMIw==
X-Gm-Message-State: APzg51BAZwudsrvC3Z0jVNN2pcZx9cOXY67ow1uiJtCAtQckjZY9BVJP
        MSCqfKKvbwO0Pi449KGMPb6pJf87
X-Google-Smtp-Source: ANB0VdYVW8U0d4cpS9KBQDy4dDdaYKp5xRXwEPOrqZH7JJjFeygaVOub63wMqrq2ApsVBr9y3HklwQ==
X-Received: by 2002:aca:90d:: with SMTP id 13-v6mr853684oij.300.1535418143183;
        Mon, 27 Aug 2018 18:02:23 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([47.89.83.53])
        by smtp.gmail.com with ESMTPSA id q204-v6sm415233oih.49.2018.08.27.18.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:02:22 -0700 (PDT)
Subject: Re: [Ocfs2-devel] [PATCH] fix dead lock caused by ocfs2_defrag_extent
To:     Larry Chen <lchen@suse.com>, mfasheh@suse.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20180827080121.31145-1-lchen@suse.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <804e11ca-39e3-575b-2e25-a00c95cf1311@gmail.com>
Date:   Tue, 28 Aug 2018 09:02:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827080121.31145-1-lchen@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On 18/8/27 16:01, Larry Chen wrote:
> ocfs2_defrag_extent may fall into dead lock.
> 
> ocfs2_ioctl_move_extents
>   ocfs2_ioctl_move_extents	
>     ocfs2_move_extents
>       ocfs2_defrag_extent
>         ocfs2_lock_allocators_move_extents  
> 
>           ocfs2_reserve_clusters
>             inode_lock GLOBAL_BITMAP_SYSTEM_INODE
> 
> 	  __ocfs2_flush_truncate_log
>             inode_lock GLOBAL_BITMAP_SYSTEM_INODE
> 
> As back trace shows above, ocfs2_reserve_clusters will call inode_lock
> against the global bitmap if local allocator has not sufficient cluters. 
> Once global bitmap could meet the demand, ocfs2_reserve_cluster will 
> return success with global bitmap locked.
> 
> After ocfs2_reserve_cluster, if truncate log is full, 
> __ocfs2_flush_truncate_log will definitely fall into dead lock
> because it needs to inode_lock global bitmap, which has
> already been locked.
> 
> To fix this bug, we could remove from ocfs2_lock_allocators_move_extents 
> the code which intends to lock global allocator, and put the removed
> code after __ocfs2_flush_truncate_log
> 
> The ocfs2_lock_allocators_move_extents has been refered by 2 places, one
> is here, the other does not need the data allocator context, which means
> this patch does not affect the caller so far.
> 
After this change, data_ac in ocfs2_lock_allocators_move_extents() is
no longer used. So I'd prefer we also clean it up.

Thanks,
Joseph

> 
> 
> Signed-off-by: Larry Chen <lchen@suse.com>
> ---
>  fs/ocfs2/move_extents.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index 7eb3b0a6347e..064dedf40d74 100644
> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -192,13 +192,6 @@ static int ocfs2_lock_allocators_move_extents(struct inode *inode,
>  		goto out;
>  	}
>  
> -	if (data_ac) {
> -		ret = ocfs2_reserve_clusters(osb, clusters_to_move, data_ac);
> -		if (ret) {
> -			mlog_errno(ret);
> -			goto out;
> -		}
> -	}
>  
>  	*credits += ocfs2_calc_extend_credits(osb->sb, et->et_root_el);
>  
> @@ -283,6 +276,12 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
>  		}
>  	}
>  
> +	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
> +	if (ret) {
> +		mlog_errno(ret);
> +		goto out_unlock_mutex;
> +	}
> +
>  	handle = ocfs2_start_trans(osb, credits);
>  	if (IS_ERR(handle)) {
>  		ret = PTR_ERR(handle);
> 
