Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A60EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6622081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="cSnqlj0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6622081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeJ2UCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:02:39 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41624 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbeJ2UCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:02:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id c16so5676831lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u02piwy98jV4diXh5JEcUYhbrIMGWe01LooOY0f54iM=;
        b=cSnqlj0mGD3YHReNi766WoWEm36nyqu28ZDG9kECc0sRkF3L2FhrfdpDYwBb4sdG78
         f1d7nQTUvap2o0O/j5YQ8TusghNWJ14zVLtgSR4ofwrh2AsEIBKvtWFkFskJvoNlyTMa
         /JFWITQH+1iXk9QYS0lp6NeX2a2td81N7DX4tYVCutH5dC4gyO96f2aIid8g4PNe4d+l
         AQHWGDs5OI8EZKJ2jgKYcvhD4aRKJ9lm6n8nOXAf4iIo++J+pkLB1nIgnLMxb08CRSPy
         R19gkjwSNMOaCubxpSSEi9Hrv7c47vnYAiRLJ/c1Ou5EwEKsqzEfbSlh62XbOOf7hdpQ
         hVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u02piwy98jV4diXh5JEcUYhbrIMGWe01LooOY0f54iM=;
        b=JudFS1xg/BoZ7Yjqkq5xzgPS6ixppkRwZg0mJNRUcUJvyGmpyU8572V9pwh79Wafo6
         tt2/5Bita1vwaHfXgJm1JFYYOZ5ti6SDYYtreCoEWFae5GRGLC9x66S22av+UyrrLM+o
         +pwa8xmUyc+rn6tT3b7pDgvLxYtrtei1v+p5CcqkOn4ZI6gr3ELHhdbWhDsJTE2FUVbA
         NPwPtqizap2zwkKN8p8FCRceGQFF21SRjzSrmG+1L1+uzUWyxl0DuujdpWTeFAHQt+di
         a82C5RL3CFsmdoYPts4hqieGnQo8pOGnzajIRrzESnEEDVjJaIwlRCQMFwh/nFpzbmqh
         3xlQ==
X-Gm-Message-State: AGRZ1gKP0t/Ti4jFACe5Z/Us2jOscmKHd+UK8NFmbT+Trn2SHhTZdCdq
        4HY2KOPvOjV0Ehk8zjZzJBH+Kg==
X-Google-Smtp-Source: AJdET5d/JfcNw3R4pV3Lphx0PJzob5/cedJULQ3m0YkqHQuwyXnvfbrxvud4To21GV78HyCjce54aQ==
X-Received: by 2002:a19:54d7:: with SMTP id b84mr4605588lfl.131.1540811664944;
        Mon, 29 Oct 2018 04:14:24 -0700 (PDT)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id d13-v6sm3028106ljc.25.2018.10.29.04.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 04:14:24 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: fix chunk close trace event check
To:     hans@owltronix.com
Cc:     linux-block@vger.kernel.org, javier@cnexlabs.com,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1540541544-7761-1-git-send-email-hans.holmberg@cnexlabs.com>
 <e884c6c9-d875-e282-59dd-f1733ffc38fb@lightnvm.io>
 <CANr-nt0kcMYrGA5fmG1HBG+Hp6DUwi7B+SWTVfjYtHYE5EGELw@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <35331f13-983b-fb96-3885-f4e617c4adee@lightnvm.io>
Date:   Mon, 29 Oct 2018 12:14:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt0kcMYrGA5fmG1HBG+Hp6DUwi7B+SWTVfjYtHYE5EGELw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/2018 10:56 AM, Hans Holmberg wrote:
> On Fri, Oct 26, 2018 at 8:49 PM Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 10/26/2018 10:12 AM, Hans Holmberg wrote:
>>> The check for chunk closes suffers from an off-by-one issue, leading
>>> to chunk close events not being traced. Fix this.
>>>
>>> Fixes: 4c44abf43d00 ("lightnvm: pblk: add trace events for chunk states")
>>>
>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> ---
>>>
>>>    drivers/lightnvm/pblk-core.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>>> index 6944aac43b01..6581c35f51ee 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -531,7 +531,7 @@ void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
>>>                if (caddr == 0)
>>>                        trace_pblk_chunk_state(pblk_disk_name(pblk),
>>>                                                        ppa, NVM_CHK_ST_OPEN);
>>> -             else if (caddr == chunk->cnlb)
>>> +             else if (caddr == (chunk->cnlb - 1))
>>>                        trace_pblk_chunk_state(pblk_disk_name(pblk),
>>>                                                        ppa, NVM_CHK_ST_CLOSED);
>>>        }
>>>
>>
>> Thanks Hans, Applied for 4.21/5.1. Note that you're sending from your
>> owntronix email account. Checkpatch complains that sender and author
>> doesn't match.
> 
> Ah, I must have messed up my git configuration.
> Would you mind updating the patch author to "Hans Holmberg
> <hans.holmberg@cnexlabs.com>" in for-4.21/core?
> 
> Thanks,
> Hans
> 

Will do. Thanks.
