Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D8DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6C920850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="uAWtTAEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6C920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbeH2Rd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:33:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43661 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeH2Rd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:33:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6-v6so2297810plv.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=voPFBkU1G8vfD5ZupQZFJv5Z07Xm39Fb9zRQKcUg63A=;
        b=uAWtTAEAgfWK0hKnv5YCdVv8oeA2lwYKRQclClA5iX/dqbEwes9KFM2rA5xBgTPUQI
         pUeXocn9RS++B39d+55nXI6gd1t3+UZajrVbgwpFqOSYR6lCw/bqK9zBeRvxmhjFONeS
         3b8aIKOFMbQ0HB5QwV2Wf+Ty00UyN0Tp81u5k8C1hi9v7Zd+kWkBsgqzXki9DO6MgH9k
         Xv0rgWqbOR/HbxzEVOI/O5BDuWBoOfn9C+g6FT/EePl3eBmlV8n16QAYoX4hVjQveLQR
         j2VxuuVbbwIKdKstYn6rwhTIF12U1u7C90OhNEt91NOeY5kZlhhDvnyY0D+qzRlt5bV4
         66BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=voPFBkU1G8vfD5ZupQZFJv5Z07Xm39Fb9zRQKcUg63A=;
        b=mzWUk1C0eQxPgc0CU6mXefriG/VTAmZ55jcvIwu9LMnoaG6UmXyqOilqq2xwrvLIel
         mnWNvpAi0zbclB1DwVcXI7y5AgyuMekZK29wts3nwF9qphQng1PgZQ+iVeehWj/mv9tB
         unGDucaMawZUFGMUiozIcy0Ta+pclrgIA0qAZV/r+YLa1wnnT7dK0Sy/a7ekij+w7dhR
         7Ee0w921GB2rN44pX5WRmo0N5nxRJHOTTaELYAGtxncMBxvmduku3WRiHUdj3Q9VOHEB
         gEkovKUh/oB0IgSie9Fbwy0Ch33TGPE8n/8LzwXyWddvEY8W/QqYsnVb8syyfR1m4tyZ
         O5HA==
X-Gm-Message-State: APzg51BiDJp/UKlkm77ZSO7b5iutt6lA/qP4W/gSLF2NCryd6HuDuh3t
        mVgYu4I5Kevjv6zO1Yg1sUpv1B1TRMesvg==
X-Google-Smtp-Source: ANB0VdaL/vCPaedCKDyQ8TueYlWmq5cYb20IyRnPjTKONg/vCyicHiUoHP/IPVBdf2wqw+01Ds1iVw==
X-Received: by 2002:a17:902:3124:: with SMTP id w33-v6mr6103385plb.235.1535549789248;
        Wed, 29 Aug 2018 06:36:29 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id f87-v6sm13086077pfh.168.2018.08.29.06.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:36:28 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
To:     javier@cnexlabs.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
 <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
 <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e5d4678d-814d-e2a5-da3e-66245034743f@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 03:18 PM, Javier Gonzalez wrote:
>> On 29 Aug 2018, at 15.00, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 10:56 AM, Javier González wrote:
>>> dma allocations for ppa_list and meta_list in rqd are replicated in
>>> several places across the pblk codebase. Make helpers to encapsulate
>>> creation and deletion to simplify the code.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/lightnvm/pblk-core.c     | 69 +++++++++++++++++++++++++---------------
>>>   drivers/lightnvm/pblk-read.c     | 35 ++++++++++----------
>>>   drivers/lightnvm/pblk-recovery.c | 29 ++++++-----------
>>>   drivers/lightnvm/pblk-write.c    | 15 ++-------
>>>   drivers/lightnvm/pblk.h          |  3 ++
>>>   5 files changed, 74 insertions(+), 77 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index 09160ec02c5f..767178185f19 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -237,6 +237,34 @@ static void pblk_invalidate_range(struct pblk *pblk, sector_t slba,
>>>   	spin_unlock(&pblk->trans_lock);
>>>   }
>>>   +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t mem_flags,
>>> +		   bool is_vector)
>>
>>
>> The mem_flags argument can be removed. It is GFP_KERNEL from all the
>> places it is called.
>>
> 
> Thought it was better to have the flexibility in a helper function, but
> we can always add it later on if needed...
> 
>> is_vector, will be better to do nr_ppas (or similar name). Then
>> pblk_submit_read/pblk_submit_read_gc are a bit cleaner.
>>
> 
> We can do that too, yes.
> 
> 
>>> +{
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>> +
>>> +	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, mem_flags,
>>> +							&rqd->dma_meta_list);
>>> +	if (!rqd->meta_list)
>>> +		return -ENOMEM;
>>> +
>>> +	if (!is_vector)
>>> +		return 0;
>>> +
>>> +	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
>>> +	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
>>
>> Wrt to is_vector, does it matter if we just set ppa_list and
>> dma_ppa_list? If we have them, we use them, else leave them alone?
>>
> 
> If we only have 1 address then ppa_addr is set and the ppa_list attempt
> to free in the completion path interpreting ppa_addr as the dma address.
> So I don't think so - unless I'm missing something?

In that case, we could drop is_vector/nr_ppas all together? That would 
be nice.

> 
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +void pblk_clear_rqd(struct pblk *pblk, struct nvm_rq *rqd)
>>> +{
>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>> +
>>> +	if (rqd->meta_list)
>>> +		nvm_dev_dma_free(dev->parent, rqd->meta_list,
>>> +				rqd->dma_meta_list);
>>> +}
>>
>> Looks like setup/clear is mainly about managing the metadata. Would
>> pblk_alloc_rqd_meta()/pblk_free/rqd_meta be better names? Unless we
>> can fold it all into pblk_alloc_rqd/pblk_free_rqd.
>>
> 
> It's not easy to fold them there as we use nvm_rq allocations without
> extra space in the rqd for metadata. This is also a problem for rqd
> allocated in the stack. But I can change the names to make the
> functionality more clear.

Yep, that was what I felt as well. Renaming will be good.

> 
> Javier
> 

