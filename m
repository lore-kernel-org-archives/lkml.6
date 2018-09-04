Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7569820843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Ub3FzuLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7569820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeIDOgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:36:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36940 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIDOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:36:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so2652132ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJypMo4BIljP59qcXIbNyj8DUqFbihhLIWHf4iDF+f8=;
        b=Ub3FzuLu0IkfuKJofKp4mbc5xUvxcoYtTPX9ZOjLyRnihdD0/kMVUU0rMnADMapLrG
         NgO7Oz3S9TEmvKdYSMj0L7ASC1PHuqrwox37CnriR/nasH326Apz2gDzrt+f8KQvXdyk
         EhjZ2qziuX0ucA0v4Yq0LuzHA9KWRlrm82LNfBV9fvDLr/3Z0b0uOklVMzmFYoINK9cN
         1qBggz6iT2k5wyDqaTRIcfC/4ZH2gh4OoJPfUqsg7Za/Prymvz+Cb12ChAwfasfixCdh
         znqqEr8dNvdHtuSLs/IuKEI5J9XZNmDfv2Q/c1U5SYCtgcthnqfnrYlaUTwpN9ZBiDeT
         DXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJypMo4BIljP59qcXIbNyj8DUqFbihhLIWHf4iDF+f8=;
        b=AcnSw5hzqgvV8h8ueGONVHmd1eQZ6dOkjpyIS+jUv4cns153cnQEGRulRJ9l7WtMRI
         rSfncaTuwEQY0D/dy5rdLu2E7JYEob7fz53dGcELy5ugT0FdxDdKU8MqmXgBN7TEv9Bh
         KPNZgLlObQnWXJ7q8rCWqSE/WGeLTvmcPRHP5BzsNHDPbgVNVjdL/4DX/OEEk5ip95Oq
         4khcCu5UaZLjspfXrHmFUqNYGhaSl0MAouc7q1wA64HoaCMmkIY6z0XQHlMyg9/qQQUl
         M5Oi7k8x7VTS7fjjCHUsjm6j9f2iCU5/hLvd6TkLCW+fAQA2dI1WYpIIpCZ2uiuMR3/s
         L2Pg==
X-Gm-Message-State: APzg51CXiwVItUqbOVFjburlsrB/xCfWMg4Ekw0UpsIovtYPt8B66G9z
        O0WNLcvs/HWggWrC8VG0WPtRJg==
X-Google-Smtp-Source: ANB0Vda3S8lcwzvI3jnVK0CKWlfgcMWhbwJYcc5ebyPRr82R1Xj9GTgK6ug92mEAjTeW6M9f2ipC+Q==
X-Received: by 2002:a2e:7a08:: with SMTP id v8-v6mr19436634ljc.121.1536055913601;
        Tue, 04 Sep 2018 03:11:53 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id f25-v6sm3943351ljc.97.2018.09.04.03.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 03:11:52 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in
 pblk_line_submit_smeta_io()
To:     baijiaju1990@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <20180901115318.30416-1-baijiaju1990@gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <cbff381f-c2c7-5656-b121-eb1ec3c75da4@lightnvm.io>
Date:   Tue, 4 Sep 2018 12:11:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180901115318.30416-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2018 01:53 PM, Jia-Ju Bai wrote:
> The driver may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 754:
> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
> 	pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
> 	pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
> 	pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
> 	spin_lock in pblk_recov_l2p
> 
> [FUNC] bio_map_kern(GFP_KERNEL)
> drivers/lightnvm/pblk-core.c, 762:
> 	bio_map_kern in pblk_line_submit_smeta_io
> drivers/lightnvm/pblk-core.c, 1048:
> 	pblk_line_submit_smeta_io in pblk_line_init_bb
> drivers/lightnvm/pblk-core.c, 1434:
> 	pblk_line_init_bb in pblk_line_replace_data
> drivers/lightnvm/pblk-recovery.c, 980:
> 	pblk_line_replace_data in pblk_recov_l2p
> drivers/lightnvm/pblk-recovery.c, 976:
> 	spin_lock in pblk_recov_l2p
> 
> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> These bugs are found by my static analysis tool DSAC.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>   drivers/lightnvm/pblk-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index ed9cc977c8b3..5d915c93b6cf 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>   
>   	memset(&rqd, 0, sizeof(struct nvm_rq));
>   
> -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
> +	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_ATOMIC,
>   							&rqd.dma_meta_list);
>   	if (!rqd.meta_list)
>   		return -ENOMEM;
> @@ -810,7 +810,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>   	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
>   	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
>   
> -	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
> +	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_ATOMIC);
>   	if (IS_ERR(bio)) {
>   		ret = PTR_ERR(bio);
>   		goto free_ppa_list;
> 

Javier,

What do you think? I'm OK with applying this, but one could also move 
the allocs outside the spinlocks?

-Matias
