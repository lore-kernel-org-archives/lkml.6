Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEE823F7C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="kfGn3j5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEE823F7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934616AbeFZKii (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:38:38 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37062 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933721AbeFZKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:38:36 -0400
Received: by mail-io0-f194.google.com with SMTP id s26-v6so15506829ioj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PGjaJkx8JYwxLrpAIRhc9X4PUQdLg8duSHk1z4QSlDs=;
        b=kfGn3j5fWvrWOiDGSeiuqyiUeqAyjh6Y82JMJxjkbnKJFxersJj9SEQKP6Z2pk4KQm
         mewRhuAjeejwBcXSgtjDe4kmVbzFb/cEprSPi2F8tNsz8VYYlQgA+xIgmBtPMpHZRxq4
         l3nq5oD2W/OOjBm99ODvpizwbHXeKnQwoEdPeXeDgf6ob+DOuFCvDAE4ntbcHrGuTF19
         CrHwOFH6iDZjVb+Tmo1tV9WDoRpbPWtAWCYTMPxZwgF8w+J2dAUibuGwBnbE9REDgX0g
         1Hz26QNEKBO9opc3PbvWNIN+ku5w4BdlwefGcPg190Iiexaib4kImAVcI9ooWZzk8TPh
         Semg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PGjaJkx8JYwxLrpAIRhc9X4PUQdLg8duSHk1z4QSlDs=;
        b=fTBKowPrB02XkwQsXQWwMfzR6vSm9wh8Zv5zKgfNfJnH/8BpVcOQVWX+iLcs3tvQet
         D8K7kHL0f8yfMzQ+ix2hn+KgrjcL1acoYsCjqU7V7Z2nt4a1lTGvhSy2eIM6Kk1+gJCE
         xTOd0lAkbKznrWleVpwbr4i5AkOtbU8nnVVHnV5utTQ5iWw1eTW28Rs3jZiLkNqdKJ2z
         m+fGBB2wiJ1vEJbxhwI8jFI9RKTcXSGZSNdGdkYLWMLrbKcYdzfzR+icRhMdUmAx4cLJ
         PRjDQeZkML0AaYJxrwQn/0/YksJF8BoW7eypVcJ0nvHL5JdsBjeWykATRrMqSBzzIs1K
         N6UQ==
X-Gm-Message-State: APt69E2FKdfN60yPwIDt19nE6+liFjejyN6QPNoWAxuKmhXufYima6cf
        GxkRO57obDNolbxG5qMHk4NLzdgA
X-Google-Smtp-Source: AAOMgpfTfiS3QDWVIB0RBMNSPQBZv6afjX6I3WIpTsDNrTiISKDNnP1oP/7qIwb84tGMyNjT5VuE/Q==
X-Received: by 2002:a6b:c992:: with SMTP id z140-v6mr749602iof.266.1530009515460;
        Tue, 26 Jun 2018 03:38:35 -0700 (PDT)
Received: from [10.86.48.245] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id i19-v6sm632767ioj.2.2018.06.26.03.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:38:34 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: assume that chunks are closed on 1.2
 devices
To:     javier@cnexlabs.com
Cc:     hans.ml.holmberg@owltronix.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hans.holmberg@cnexlabs.com
References: <1529399189-3239-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <a2bb1959-5244-f8af-b747-6d87e8d456a4@lightnvm.io>
 <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <ed909bcb-8e91-7e6d-521e-b5f36db61efa@lightnvm.io>
Date:   Tue, 26 Jun 2018 12:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1612C143-24C3-4B6F-B745-945EAF684DFC@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 11:37 AM, Javier Gonzalez wrote:
> 
> 
>> On 26 Jun 2018, at 10.41, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 06/19/2018 11:06 AM, Hans Holmberg wrote:
>>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> We can't know if a block is closed or not on 1.2 devices, so assume
>>> closed state to make sure that blocks are erased before writing.
>>> Fixes: 32ef9412c114 ("lightnvm: pblk: implement get log report chunk")
>>> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> ---
>>> This patch applies on:
>>> ssh://github.com/OpenChannelSSD/linux branch for-4.19/core
>>>   drivers/lightnvm/pblk-init.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>>> index aa24264..3b8aa4a 100644
>>> --- a/drivers/lightnvm/pblk-init.c
>>> +++ b/drivers/lightnvm/pblk-init.c
>>> @@ -717,10 +717,11 @@ static int pblk_setup_line_meta_12(struct pblk *pblk, struct pblk_line *line,
>>>     		/*
>>>   		 * In 1.2 spec. chunk state is not persisted by the device. Thus
>>> -		 * some of the values are reset each time pblk is instantiated.
>>> +		 * some of the values are reset each time pblk is instantiated,
>>> +		 * so we have to assume that the block is closed.
>>>   		 */
>>>   		if (lun_bb_meta[line->id] == NVM_BLK_T_FREE)
>>> -			chunk->state =  NVM_CHK_ST_FREE;
>>> +			chunk->state =  NVM_CHK_ST_CLOSED;
>>>   		else
>>>   			chunk->state = NVM_CHK_ST_OFFLINE;
>>>
>>
>> pblk should scan (or the lightnvm subsystem) the blocks for their
>> state, such that it doesn't have to reinitialize a full drive if it is
>> already in a closed state. If marking closed, it does a full erase
>> cycle on initialization, which should be avoided since it is a limited
>> resource.
> 
> In 1.2 there is no such state unfortunately. However, pblk will never
> attempt to reinitialize the whole drive - metadata for closed blocks
> will be recovered and only those going to GC will be erased before
> usage. In fact, a full close drive is the state pblk expects.
> 
> This patch only affects "unknown blocks", thus the only case in which
> pblk would attempt to double erase is when blocks have been pre-erased
> (e.g., factory or through liblightnvm). After an erase round though,
> pblk will only erase pre-usage. One thing we could do is attempting to
> read the first page of these unknown blocks and mark them as free if
> "empty page" is returned. Is this what you mean? 

Yes, that is what I mean.

Note that this can be
> costly on large drives; this is the reason we returned to the pre-2.0
> behaviour with this patch. We are implementing a log that, among other
> things, keeps the state so that pblk can have an accurate state for the
> cases this can be a problem.

Yep, it will take some time. Good to hear with the log.

-Matias
