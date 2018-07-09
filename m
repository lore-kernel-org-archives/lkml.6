Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DCFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5975D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="YR9V3VCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5975D2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeGISWd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:22:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39907 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbeGISWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:22:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so5819716wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7q/Mjcm02KZ5jtHfruihdFHr742HPrEovrhUZJ8k3bA=;
        b=YR9V3VCdErPxz0FF1eGOakzFd5bvsLvy5oUaf5yt6WxVD6WvAfj1sStkCRmDHZp2fh
         229/5c05vS8Od1mOuEFZyeaXIXQMPUmZKMZL6W0K+zvmoNOw3/r7cQh9E8d9L252uNg2
         mgR1qY0VzWBEjYBT0wK3TLd8IOikWj+UoMO/nEGXYGmCWeQdCk/ceLD2o+pbVYcR1lkM
         994Sw6cGRFoNm6AYZhBI/uAxvKqsx4sPabeoDWcHIZtQse4HY0PkI//hyqyz/l5JcEVH
         B+YyD55GQ1A+6yejJ2znXtrQdiI8B+RNAZlGlJxZDcJn0ZaLT04CAK2S2uU6qvkNWJzE
         smKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7q/Mjcm02KZ5jtHfruihdFHr742HPrEovrhUZJ8k3bA=;
        b=kNVRdMzDcOWuiBs/YEYmxz8H8idjBcZLyYabDRSurxshZhgb7uwygx81H7SaMv6S1J
         DWmozJ2Lmmg91loNcD998On3gVfx99GnPLYpIVtd5WqLd8Bge7qOAiOl1syNsVyw6W4z
         wacRtB9PqwiC0KxsjOTBwYPUFCUsW2tsJwFpYJadbpRSbDXy+2aGMkdIvbD1ZRV45Ylm
         Ecci+9kWwdSm6Y5dpDyw0w8Ps5g0S03J0M0z2GRUFzS4C9DIILrEkp/bgRw/jAIBEzw0
         mDSoXrPgfl8pn4QwC9hHPQn3w1hLJE5vE3s/LZslp5OAmY9vGJcMn/prt6Nm6RxGKVAC
         Zsdw==
X-Gm-Message-State: APt69E2xdyby4YQmSkalComrygOUdmyDXnBDni/Fps40nxne+OjnBn7Q
        vQ3AqW1JOoRg/5Wph63taKIwPQ==
X-Google-Smtp-Source: AAOMgpeIy4f3hdqt6NpquMWOPBWN9pL7Dlyjef31wNAp1KDVewWDmOGOg7+LKuwyOjxT72wGkGD1dA==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr14341550wmh.113.1531160549625;
        Mon, 09 Jul 2018 11:22:29 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm25423243wre.95.2018.07.09.11.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 11:22:28 -0700 (PDT)
Subject: Re: [PATCH 12/12] ipc/util.c: Further ipc_idr_alloc cleanups.
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709151019.1336-13-manfred@colorfullife.com>
 <CACT4Y+ZVuhHmrdhVou5KWkV2v2s-jEq4+fz+=6WxK3JJaK087A@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <34a9764d-65ec-3707-7c42-3aa7087b834a@colorfullife.com>
Date:   Mon, 9 Jul 2018 20:22:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZVuhHmrdhVou5KWkV2v2s-jEq4+fz+=6WxK3JJaK087A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On 07/09/2018 07:05 PM, Dmitry Vyukov wrote:
> On Mon, Jul 9, 2018 at 5:10 PM, Manfred Spraul <manfred@colorfullife.com> wrote:
>> If idr_alloc within ipc_idr_alloc fails, then the return value (-ENOSPC)
>> is used to calculate new->id.
>> Technically, this is not a bug, because new->id is never accessed.
>>
>> But: Clean it up anyways: On error, just return, do not set new->id.
>> And improve the documentation.
>>
>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> ---
>>   ipc/util.c | 22 ++++++++++++++++------
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/ipc/util.c b/ipc/util.c
>> index d474f2b3b299..302c18fc846b 100644
>> --- a/ipc/util.c
>> +++ b/ipc/util.c
>> @@ -182,11 +182,20 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
>>   }
>>
>>   /*
>> - * Specify desired id for next allocated IPC object.
>> + * Insert new IPC object into idr tree, and set sequence number and id
>> + * in the correct order.
>> + * Especially:
>> + * - the sequence number must be set before inserting the object into the idr,
>> + *   because the sequence number is accessed without a lock.
>> + * - the id can/must be set after inserting the object into the idr.
>> + *   All accesses must be done after getting kern_ipc_perm.lock.
>> + *
>> + * The caller must own kern_ipc_perm.lock.of the new object.
>> + * On error, the function returns a (negative) error code.
>>    */
>>   static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>>   {
>> -       int key, next_id = -1;
>> +       int id, next_id = -1;
> /\/\/\/\
> Looks good to me. I was also confused by how key transforms into id,
> and then key name is used for something else.
Let's see if there are further findings, perhaps I'll rework the series, 
it may make sense to standardize the variable names:

id: user space id. Called semid, shmid, msgid if the type is known.
     Most functions use "id" already.
     Exception: ipc_checkid(), the function calls is uid.
idx: "index" for the idr lookup
     Right now, ipc_rmid() use lid, ipc_addid() use id as variable name
seq: sequence counter, to avoid quick collisions of the user space id
     In the comments, it got a mixture of sequence counter and sequence 
number.
key: user space key, used for the rhash tree

>>   #ifdef CONFIG_CHECKPOINT_RESTORE
>>          next_id = ids->next_id;
>> @@ -197,14 +206,15 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
>>                  new->seq = ids->seq++;
>>                  if (ids->seq > IPCID_SEQ_MAX)
>>                          ids->seq = 0;
>> -               key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>> +               id = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>>          } else {
>>                  new->seq = ipcid_to_seqx(next_id);
>> -               key = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
>> +               id = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
>>                                  0, GFP_NOWAIT);
>>          }
>> -       new->id = SEQ_MULTIPLIER * new->seq + key;
>> -       return key;
>> +       if (id >= 0)
>> +               new->id = SEQ_MULTIPLIER * new->seq + id;
> We still initialize seq in this case. I guess it's ok because the
> object is not published at all. But if we are doing this, then perhaps
> store seq into a local var first and then:
>
>        if (id >= 0) {
>                new->id = SEQ_MULTIPLIER * seq + id;
>                new->seq = seq:
>        }
>
> ?
No!!!
We must initialize ->seq before publication. Otherwise we end up with 
the syzcall findings, or in the worst case a strange rare failure of an 
ipc operation.
The difference between ->id and ->seq is that we have the valid number 
for ->seq.

For the user space ID we cannot have the valid number unless the 
idr_alloc is successful.
The patch only avoids that this line is executed:

> 	new->id = SEQ_MULTIPLIER * new->seq + (-ENOSPC)

As I wrote, the line shouldn't cause any damage, the code is more or less:
> 	new->id = SEQ_MULTIPLIER * new->seq + (-ENOSPC)
> 	kfree(new);
But this is ugly, it asks for problems.

--
	Manfred

