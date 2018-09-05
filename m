Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75555C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AF42064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TORM+iCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AF42064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeIENJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:09:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36649 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIENJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:09:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so3119013pfo.3;
        Wed, 05 Sep 2018 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=s94i3lMtJ1ylKDSDEHEd6T3aZPG3qrcuEq0sMaIV6Zg=;
        b=TORM+iCBgof66vhzSK783F6CV7hGGro2ip8/qdNzxd59PSeleaa3e05YL27TmCBH+k
         NRKXFPkz4cQmEqgsmQx+bleElcjDMwvjlOm6KxPc2L41hbPnGxwVM+A+EcO5rzlP7C/C
         TetF3cbmc54wnURWItBOAlzX0Lqk/80imD+ZfwPm3iB+z1Ap98vsspSrHymQM77nTAT0
         nU1U0M1Ny4oeXVLJwLo1shAytD6RvBBHigIJELW6iEaR2GFAdpRpZx/SnOZ085IELwV8
         MijCi0LUK2DHPccm8fB8MA9JqC2BVxVYzTRccYSzl6PhDhPDNlDO2VvkB+rVCphoNBGq
         G58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s94i3lMtJ1ylKDSDEHEd6T3aZPG3qrcuEq0sMaIV6Zg=;
        b=cAvUNoa44XhLWNqpwbAWn/QTi5tQLZJiP/5GwcxyGYCR3DWX/tJrDump/OXF6xQGfA
         FvkeRIQHS31CN5Jb1X74e6zrZ8lWIFAghqJs6vmVDneH6sWcRuP5qC1p+EifM/7Vptu0
         Np7F94+uNzWU+hNpYPoHwj+JHBUIoHNQB5hpZGGPcxxPBnwz+z33I67fP3os/FyfkFd9
         TRZXZK1uBt5pjip000A30iK/Uq0Mu19UAAH1MA+w0SGghuY0HpugANyZ/v1y8Vn82jWk
         P1ChBmenpqRkfZaMf+4yNGHusYMVxXiZEJXNmG3c7b/R6r3lzm5DjiNjsM+6y4Kv4Nej
         0tGg==
X-Gm-Message-State: APzg51BbZVvzhTjLqIIXob0PK89WxNq8AwCU25W0mE0S/VyYyTvOFmyU
        5xK7wcvwSzVNuBFIS/2brq4Wl27O
X-Google-Smtp-Source: ANB0VdYtilzP8hSExgHRpgYLIu4IoBczh+n7yCOVAqlngIh66IIsvWK7XMJBMTzlZFYvBepbEPlikA==
X-Received: by 2002:a63:fe4d:: with SMTP id x13-v6mr35447873pgj.152.1536136809209;
        Wed, 05 Sep 2018 01:40:09 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id a72-v6sm1968515pge.85.2018.09.05.01.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 01:40:08 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: Fix two sleep-in-atomic-context bugs in
 pblk_line_submit_smeta_io()
To:     Javier Gonzalez <javier@cnexlabs.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20180901115318.30416-1-baijiaju1990@gmail.com>
 <cbff381f-c2c7-5656-b121-eb1ec3c75da4@lightnvm.io>
 <EFBE4E08-0A3E-442B-BD23-4E79042D2A05@cnexlabs.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <8c3d9191-a3c1-2a6c-a7f1-b0baf50e95e9@gmail.com>
Date:   Wed, 5 Sep 2018 16:40:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <EFBE4E08-0A3E-442B-BD23-4E79042D2A05@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/5 1:52, Javier Gonzalez wrote:
>> On 4 Sep 2018, at 03.11, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 09/01/2018 01:53 PM, Jia-Ju Bai wrote:
>>> The driver may sleep with holding a spinlock.
>>> The function call paths (from bottom to top) in Linux-4.16 are:
>>> [FUNC] nvm_dev_dma_alloc(GFP_KERNEL)
>>> drivers/lightnvm/pblk-core.c, 754:
>>> 	nvm_dev_dma_alloc in pblk_line_submit_smeta_io
>>> drivers/lightnvm/pblk-core.c, 1048:
>>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>>> drivers/lightnvm/pblk-core.c, 1434:
>>> 	pblk_line_init_bb in pblk_line_replace_data
>>> drivers/lightnvm/pblk-recovery.c, 980:
>>> 	pblk_line_replace_data in pblk_recov_l2p
>>> drivers/lightnvm/pblk-recovery.c, 976:
>>> 	spin_lock in pblk_recov_l2p
>>> [FUNC] bio_map_kern(GFP_KERNEL)
>>> drivers/lightnvm/pblk-core.c, 762:
>>> 	bio_map_kern in pblk_line_submit_smeta_io
>>> drivers/lightnvm/pblk-core.c, 1048:
>>> 	pblk_line_submit_smeta_io in pblk_line_init_bb
>>> drivers/lightnvm/pblk-core.c, 1434:
>>> 	pblk_line_init_bb in pblk_line_replace_data
>>> drivers/lightnvm/pblk-recovery.c, 980:
>>> 	pblk_line_replace_data in pblk_recov_l2p
>>> drivers/lightnvm/pblk-recovery.c, 976:
>>> 	spin_lock in pblk_recov_l2p
>>> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
>>> These bugs are found by my static analysis tool DSAC.
>>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>>> ---
>>>   drivers/lightnvm/pblk-core.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index ed9cc977c8b3..5d915c93b6cf 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -802,7 +802,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>>>     	memset(&rqd, 0, sizeof(struct nvm_rq));
>>>   -	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_KERNEL,
>>> +	rqd.meta_list = nvm_dev_dma_alloc(dev->parent, GFP_ATOMIC,
>>>   							&rqd.dma_meta_list);
>>>   	if (!rqd.meta_list)
>>>   		return -ENOMEM;
>>> @@ -810,7 +810,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
>>>   	rqd.ppa_list = rqd.meta_list + pblk_dma_meta_size;
>>>   	rqd.dma_ppa_list = rqd.dma_meta_list + pblk_dma_meta_size;
>>>   -	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_KERNEL);
>>> +	bio = bio_map_kern(dev->q, line->smeta, lm->smeta_len, GFP_ATOMIC);
>>>   	if (IS_ERR(bio)) {
>>>   		ret = PTR_ERR(bio);
>>>   		goto free_ppa_list;
>> Javier,
>>
>> What do you think? I'm OK with applying this, but one could also move
>> the allocs outside the spinlocks?
>>
> Definitely better to take the allocation out of the spin_lock(), as all
> line preparations are made to be lock free.
>
> It is fairly simple to fix this, as it only occurs when calling
> pblk_line_replace_data() from pblk_recov_l2p(). Here the lock can be
> inside the if statement to only cover text_and_clear_bit() and to the
> else statement to cover it entirely.
>
>   Jia-Ju Bai: Do you want to send a patch for this?

Okay, Javier.
I sent a patch just now, please have a look.


Best wishes,
Jia-Ju Bai
