Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D1CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD5D20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="FnBWe18D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD5D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeH2RkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:40:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41270 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH2RkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:40:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so2294660pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2FDYv9WEGWccXGgI8hWA0Mn5qz5OC03lWnru63uBdv0=;
        b=FnBWe18DphrcrpkNk1cfmWC0KT32lIebxMPhunUJ/XljDyvbDqVsyZWRIHtIKUdBxg
         BoilFNeiGC6tWR2e7HqQw62/fnSZL0oBiQvK6kFj3PTcmmDe42+02WCKCkspdll7Gtpd
         hnxiw2u5eZGnwxaYIwHz+bu1BsfdPeI4Djj5wXwD4R5gVaTlC6ZL5EOqdro2gJMmG7UW
         b+Hw8SYNIVF1Qkd7vXrogwN0V43SrTh4ueFjMp8I7eZZQkQup3pnGsiTLNWDRXvKq65N
         gxxhvDqap+Tez7b+EtNSTfSIOSi3NUy3vhZUGiXCzkPHh8X8J/b45MrsSTAIVr6W1sEz
         Ayjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2FDYv9WEGWccXGgI8hWA0Mn5qz5OC03lWnru63uBdv0=;
        b=dKL6w7V5LWI6sRd5sLLS1FRH/+UpoSRzmeXr5GmrIhKS566Uzl0Bh8cCQamttrcCR+
         X5Z5QmkqqngAMqbB/6qA3hiJ+W5CryVO6MXSlGiLpe3SO2na0m50JNX49D6zhWcrX2Di
         W0iDfeONc1W/9ZhN8G82oNI84avjfJuQjiNpYutI4RF55iXnUW7Zo4yATUthWtJM/vrY
         9GqHOBbhQNhYVcp31RoocExqYIO3SSoNICZAlvLnq5fSkB20GVUfvDi/Z1+y/dpIUFBJ
         978C1h3Vpl8yE2Rat8hQenxM0Nah7suSQcm+52INZBz7QXc2Z6d/tSYqJXjk+1tgfA3M
         4faA==
X-Gm-Message-State: APzg51ATkcy6t7I/YLLMZMsllunn9aAGxsiincNysjrnovw807+wu0J+
        96HphRlHZ2n8V7CaIa37P8yA2yMmM8SRNg==
X-Google-Smtp-Source: ANB0VdbJsGMkJhB3fykseOrSlUyzE6X0yfwQNgsQRaPNvlwNhpPhNqjQCSm59wRMn+7XszsbLUPS6Q==
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr6051311pfa.93.1535550181664;
        Wed, 29 Aug 2018 06:43:01 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id p26-v6sm7957668pfi.183.2018.08.29.06.42.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:43:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] lightnvm: encapsule rqd dma allocations
To:     javier@cnexlabs.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
 <1535532980-27672-3-git-send-email-javier@cnexlabs.com>
 <559e39f2-1601-95ea-9305-6a0566943798@lightnvm.io>
 <8B4755CD-3C36-49B4-9F94-1169E19EF090@cnexlabs.com>
 <e5d4678d-814d-e2a5-da3e-66245034743f@lightnvm.io>
 <1CF9AE13-2C0C-426C-8B62-E0B111EDEB5E@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <c6414a97-607d-2bd8-c575-4c54e5ee84e1@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1CF9AE13-2C0C-426C-8B62-E0B111EDEB5E@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 03:41 PM, Javier Gonzalez wrote:
> 
>> On 29 Aug 2018, at 15.36, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/29/2018 03:18 PM, Javier Gonzalez wrote:
>>>> On 29 Aug 2018, at 15.00, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> On 08/29/2018 10:56 AM, Javier González wrote:
>>>>> dma allocations for ppa_list and meta_list in rqd are replicated in
>>>>> several places across the pblk codebase. Make helpers to encapsulate
>>>>> creation and deletion to simplify the code.
>>>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>>>> ---
>>>>>   drivers/lightnvm/pblk-core.c     | 69 +++++++++++++++++++++++++---------------
>>>>>   drivers/lightnvm/pblk-read.c     | 35 ++++++++++----------
>>>>>   drivers/lightnvm/pblk-recovery.c | 29 ++++++-----------
>>>>>   drivers/lightnvm/pblk-write.c    | 15 ++-------
>>>>>   drivers/lightnvm/pblk.h          |  3 ++
>>>>>   5 files changed, 74 insertions(+), 77 deletions(-)
>>>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>>>> index 09160ec02c5f..767178185f19 100644
>>>>> --- a/drivers/lightnvm/pblk-core.c
>>>>> +++ b/drivers/lightnvm/pblk-core.c
>>>>> @@ -237,6 +237,34 @@ static void pblk_invalidate_range(struct pblk *pblk, sector_t slba,
>>>>>   	spin_unlock(&pblk->trans_lock);
>>>>>   }
>>>>>   +int pblk_setup_rqd(struct pblk *pblk, struct nvm_rq *rqd, gfp_t mem_flags,
>>>>> +		   bool is_vector)
>>>>
>>>>
>>>> The mem_flags argument can be removed. It is GFP_KERNEL from all the
>>>> places it is called.
>>> Thought it was better to have the flexibility in a helper function, but
>>> we can always add it later on if needed...
>>>> is_vector, will be better to do nr_ppas (or similar name). Then
>>>> pblk_submit_read/pblk_submit_read_gc are a bit cleaner.
>>> We can do that too, yes.
>>>>> +{
>>>>> +	struct nvm_tgt_dev *dev = pblk->dev;
>>>>> +
>>>>> +	rqd->meta_list = nvm_dev_dma_alloc(dev->parent, mem_flags,
>>>>> +							&rqd->dma_meta_list);
>>>>> +	if (!rqd->meta_list)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	if (!is_vector)
>>>>> +		return 0;
>>>>> +
>>>>> +	rqd->ppa_list = rqd->meta_list + pblk_dma_meta_size;
>>>>> +	rqd->dma_ppa_list = rqd->dma_meta_list + pblk_dma_meta_size;
>>>>
>>>> Wrt to is_vector, does it matter if we just set ppa_list and
>>>> dma_ppa_list? If we have them, we use them, else leave them alone?
>>> If we only have 1 address then ppa_addr is set and the ppa_list attempt
>>> to free in the completion path interpreting ppa_addr as the dma address.
>>> So I don't think so - unless I'm missing something?
>>
>> In that case, we could drop is_vector/nr_ppas all together? That would be nice.
>>
> 
> The problem is that the metadata region still needs to be used, even if
> the ppa_list is not set. Thing that the oob area can be larger than
> 64bits, so we cannot do the dma address is the actual value trick.
> 
> So if encapsulating, we need to know if we need to allocate the ppa_list
> or not.
> 
> Does it make sense?

Cool. We'll just leave it as is.
