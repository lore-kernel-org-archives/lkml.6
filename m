Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E53C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0E20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="noDXX3At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E0E20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeJCSZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:25:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39318 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:25:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so5275497wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 04:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TmHEJNdlA5uuxQkPzMDBjKmdyHB2o61sZKH6oMEGAbg=;
        b=noDXX3At0sKSLBK7WcWorXygH57BKKiR0ivzHBU/mCZFS2mlp1POlQh2X2ztm1yq09
         PhBBxfjaSMUU5QxBlLA224gLbD+tC3jmTKblckImqrl6Y4u/TnXuN9sNUUdQZcDho8ef
         /vspxFgzvwqR7XK6VZUa/EdSEDiiaFfJuYxqpEWRC7jsdfpaRitPfAQ5vG7ifWzfhnOd
         TXHhROcYS3GbiNTdckZNVYmTSZDZFFopeHxl8qSIu8I2HvF2ZWqVt3tThOtFN2vlSDl3
         hBzY9B+QkJdHljeRXgfWruVY6oQmF0DuV0QlR9GGOzB7NVsH3CJ+UwoUjWQzAmqD3/V3
         9DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TmHEJNdlA5uuxQkPzMDBjKmdyHB2o61sZKH6oMEGAbg=;
        b=Vo4OyoUYRx5srmBIESDjpRJTer2F+kGIYTxzmV4ArLdpRCJfa1QkoAUoMM7jw9TzzM
         z/G0kJWLkqXHAIYxv/s2CtlqcdL4HSL5qYVh5392+dL40ZgcJw5wQZ1yMOG2nfhUPEVW
         uVigFdGx7fJiUNlDK/8oTffLMzD9tQ6VJEhEMgxVSXDQXOrtIgloIHoroRQOXPWODgO4
         d6At5DKvbbdzz/gu3lmlHe9gt4qDEZpRlmNHNwV5UqG0PgDdn7j+H8oil3VRp22GY8yU
         j9MdB25ryViOjyPK9O4gdi4RF1lABLBsT2vgeOXg1nqedS0flFilgsZwvWoPseeGtkVz
         g4Nw==
X-Gm-Message-State: ABuFfog6zY6683zy74HxuolyHVUYC4iwHcQmAAD6x13ApiT151a75Uor
        mJEQ0mcpaCM7m/AiAyXz6+PFUA==
X-Google-Smtp-Source: ACcGV62Tlxa0z6aVSCA8fxYd45moaO2VzMmMXVBTliVw+lDMA+BOsXN0Emf3eaApfROYAwCBazbKwg==
X-Received: by 2002:a1c:aacd:: with SMTP id t196-v6mr1122586wme.121.1538566630282;
        Wed, 03 Oct 2018 04:37:10 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C8CD00D84A1C283583219C.dip0.t-ipconnect.de. [2003:d9:93c8:cd00:d84a:1c28:3583:219c])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm1380371wma.17.2018.10.03.04.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 04:37:08 -0700 (PDT)
Subject: Re: [RFC, PATCH] ipc/util.c: use idr_alloc_cyclic() for ipc
 allocations
To:     Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20181002161942.1037-1-manfred@colorfullife.com>
 <1b8bcd5c-1264-08da-0b91-ebb4c02f6035@redhat.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <268a5f08-c2d7-aeba-80f6-70daa093c548@colorfullife.com>
Date:   Wed, 3 Oct 2018 13:37:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1b8bcd5c-1264-08da-0b91-ebb4c02f6035@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/18 8:27 PM, Waiman Long wrote:
> On 10/02/2018 12:19 PM, Manfred Spraul wrote:
>> A bit related to the patch series that increases IPC_MNI:
>>
>> (User space) id reuse create the risk of data corruption:
>>
>> Process A: calls ipc function
>> Process A: sleeps just at the beginning of the syscall
>> Process B: Frees the ipc object (i.e.: calls ...ctl(IPC_RMID)
>> Process B: Creates a new ipc object (i.e.: calls ...get())
>> 	<If new object and old object have the same id>
>> Process A: is woken up, and accesses the new object
>>
>> To reduce the probability that the new and the old object
>> have the same id, the current implementation adds a
>> sequence number to the index of the object in the idr tree.
>>
>> To further reduce the probability for a reuse, switch from
>> idr_alloc to idr_alloc_cyclic.
>>
>> The patch cycles over at least RADIX_TREE_MAP_SIZE, i.e.
>> if there is only a small number of objects, the accesses
>> continue to be direct.
>>
>> As an option, this could be made dependent on the extended
>> mode: In extended mode, cycle over e.g. at least 16k ids.
>>
>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>> ---
>>
>> Open questions:
>> - Is there a significant performance advantage, especially
>>    there are many ipc ids?
>> - Over how many ids should the code cycle always?
>> - Further review remarks?
>>
>>   ipc/util.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/ipc/util.c b/ipc/util.c
>> index 0af05752969f..6f83841f6761 100644
>> --- a/ipc/util.c
>> +++ b/ipc/util.c
>> @@ -216,10 +216,30 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>>   	 */
>>   
>>   	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
>> +		int idr_max;
>> +
>>   		new->seq = ids->seq++;
>>   		if (ids->seq > IPCID_SEQ_MAX)
>>   			ids->seq = 0;
>> -		idx = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>> +
>> +		/*
>> +		 * If a user space visible id is reused, then this creates a
>> +		 * risk for data corruption. To reduce the probability that
>> +		 * a number is reduced, two approaches are used:
>    reduced -> reused?
Of course.
>
>> +		 * 1) the idr index is allocated cyclically.
>> +		 * 2) the use space id is build by concatenating the
>> +		 *    internal idr index with a sequence number
>> +		 * To avoid that both numbers have the same cycle time, try
>> +		 * to set the size for the cyclic alloc to an odd number.
>> +		 */
>> +		idr_max = ids->in_use*2+1;
>> +		if (idr_max < RADIX_TREE_MAP_SIZE-1)
>> +			idr_max = RADIX_TREE_MAP_SIZE-1;
>> +		if (idr_max > IPCMNI)
>> +			idr_max = IPCMNI;
>> +
>> +		idx = idr_alloc_cyclic(&ids->ipcs_idr, new, 0, idr_max,
>> +					GFP_NOWAIT);
>>   	} else {
>>   		new->seq = ipcid_to_seqx(next_id);
>>   		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
>
> Each of IPC components have their own sysctl parameters limiting the max
> number of objects that can be allocated. With cyclic allocation, you
> will have to make sure that idr_max is not larger than the corresponding
> IPC sysctl parameters. That may require moving the limits to the
> corresponding ipc_ids structure so that it can be used in ipc_idr_alloc().

First, I would disagree:

the sysctl limits specify how many objects can exist.

idr_max is the maximum index in the radix tree that can exist. There is 
a hard limit of IPCMNI, but that's it.


But:

The name is wrong, I will rename the variable to idx_max

> What is the point of comparing idr_max against RADIX_TREE_MAP_SIZE-1? Is
> it for performance reason.

Let's assume you have only 1 ipc object, and you alloc/release that object.

At alloc time, ids->in_use is 0 -> idr_max 1 -> every object will end up 
with idx=0.

This would defeat the whole purpose of using a cyclic alloc.

Thus: cycle over at least 63 ids -> 5 additional bits to avoid collisions.


--

     Manfred

