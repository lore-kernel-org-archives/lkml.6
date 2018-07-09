Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F37C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6959F2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQZNYKQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6959F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeGISb6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:31:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43290 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeGISb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:31:57 -0400
Received: by mail-pf0-f195.google.com with SMTP id y8-v6so14241005pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0luodhPBemQkzSMo+2d8dfQj7f27nrOq5hZ6O+kK30k=;
        b=wQZNYKQSZkroh+1vxAGfk7nbWlYlcTeo8yWSqylqhzGY/GIiZYTGv8xYAuZM0jNvfk
         K3EUnTCraHKIJuHqmL8SdQbTKMFknMarTVeJEOnygR0AhYkW/Aq73uLbMQMPs/lpKxZT
         wwRJ7WH4rWowPL1QdlszZu+9PKbQg4mrwz+dE/ail/8YoKBmuKgP4RVI+phKQ92f7mei
         BUP4TOB767eNFqSuwZwoxSxDaRSBH3mVinaHveP9wdM0Vmv5KIcNHKBxa5VEUH+KPt2a
         fHcCdFP14Rv7tI3ComQO8MKvrc6cKo8LFbJBAQm5lTw7Skd/OFH+dJPBVQevSkBPW2Io
         Cqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0luodhPBemQkzSMo+2d8dfQj7f27nrOq5hZ6O+kK30k=;
        b=DuFJbMVTxcP9K+Et3LrmY6aUwJTR+Z2m3Nwqa9A8oy1jfUNnHyN2+0MwFkyyksGYJQ
         JbeaZWEeeyoOlXK0IGWHp86Rxt2sau5soRvVRz0DA4jLt0GzOj4Uk33Ib3FTpCl3E6Pq
         4LLN2zkJjYVU9l+2HFfvrDK68wiiTsQDu29R0lHY6S/0uQiOnGw2iLt4YCUPPH9EZPrW
         rAxBrz69qZk03FpltMV7Ohp6Agp7euTvenCmB8Uw+xe3p3a4JPlj7pckEoGVdRgQ/L54
         bvxzPz+V7gJ0aDTR8/fShJ6ulqgCDRZYAM7xah2p/OyNZTi1j9nvkghuSq19i3RuJ3RG
         Dr+g==
X-Gm-Message-State: APt69E0ooNBwWo2HlXXTPg/8wNojBgcKwIosFgsQo1QA6HdgZsXKPrH8
        +x47nsOppIN8e6MsjBXFVIkgxcKNawoXybVhzNMp6hGY
X-Google-Smtp-Source: AAOMgpce/vezaQ7SM/0797Y+JIbk8Q5DrXAArfGONQZYjenCoSlnqRkH5wDPGdMJlkvtcLIvvuZY2QfwqNa5PZtesZg=
X-Received: by 2002:a62:4a41:: with SMTP id x62-v6mr20738006pfa.45.1531161116406;
 Mon, 09 Jul 2018 11:31:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Mon, 9 Jul 2018 11:31:35
 -0700 (PDT)
In-Reply-To: <34a9764d-65ec-3707-7c42-3aa7087b834a@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
 <20180709151019.1336-13-manfred@colorfullife.com> <CACT4Y+ZVuhHmrdhVou5KWkV2v2s-jEq4+fz+=6WxK3JJaK087A@mail.gmail.com>
 <34a9764d-65ec-3707-7c42-3aa7087b834a@colorfullife.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jul 2018 20:31:35 +0200
Message-ID: <CACT4Y+YbFBfB9xM2bjbxick42ZFQPTa_oQ4ejcmL=ASsZ2GY6A@mail.gmail.com>
Subject: Re: [PATCH 12/12] ipc/util.c: Further ipc_idr_alloc cleanups.
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 8:22 PM, Manfred Spraul <manfred@colorfullife.com> wrote:
> Hello Dmitry,
>
>
> On 07/09/2018 07:05 PM, Dmitry Vyukov wrote:
>>
>> On Mon, Jul 9, 2018 at 5:10 PM, Manfred Spraul <manfred@colorfullife.com>
>> wrote:
>>>
>>> If idr_alloc within ipc_idr_alloc fails, then the return value (-ENOSPC)
>>> is used to calculate new->id.
>>> Technically, this is not a bug, because new->id is never accessed.
>>>
>>> But: Clean it up anyways: On error, just return, do not set new->id.
>>> And improve the documentation.
>>>
>>> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
>>> Cc: Dmitry Vyukov <dvyukov@google.com>
>>> ---
>>>   ipc/util.c | 22 ++++++++++++++++------
>>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/ipc/util.c b/ipc/util.c
>>> index d474f2b3b299..302c18fc846b 100644
>>> --- a/ipc/util.c
>>> +++ b/ipc/util.c
>>> @@ -182,11 +182,20 @@ static struct kern_ipc_perm *ipc_findkey(struct
>>> ipc_ids *ids, key_t key)
>>>   }
>>>
>>>   /*
>>> - * Specify desired id for next allocated IPC object.
>>> + * Insert new IPC object into idr tree, and set sequence number and id
>>> + * in the correct order.
>>> + * Especially:
>>> + * - the sequence number must be set before inserting the object into
>>> the idr,
>>> + *   because the sequence number is accessed without a lock.
>>> + * - the id can/must be set after inserting the object into the idr.
>>> + *   All accesses must be done after getting kern_ipc_perm.lock.
>>> + *
>>> + * The caller must own kern_ipc_perm.lock.of the new object.
>>> + * On error, the function returns a (negative) error code.
>>>    */
>>>   static inline int ipc_idr_alloc(struct ipc_ids *ids, struct
>>> kern_ipc_perm *new)
>>>   {
>>> -       int key, next_id = -1;
>>> +       int id, next_id = -1;
>>
>> /\/\/\/\
>> Looks good to me. I was also confused by how key transforms into id,
>> and then key name is used for something else.
>
> Let's see if there are further findings, perhaps I'll rework the series, it
> may make sense to standardize the variable names:
>
> id: user space id. Called semid, shmid, msgid if the type is known.
>     Most functions use "id" already.
>     Exception: ipc_checkid(), the function calls is uid.
> idx: "index" for the idr lookup
>     Right now, ipc_rmid() use lid, ipc_addid() use id as variable name
> seq: sequence counter, to avoid quick collisions of the user space id
>     In the comments, it got a mixture of sequence counter and sequence
> number.
> key: user space key, used for the rhash tree
>
>>>   #ifdef CONFIG_CHECKPOINT_RESTORE
>>>          next_id = ids->next_id;
>>> @@ -197,14 +206,15 @@ static inline int ipc_idr_alloc(struct ipc_ids
>>> *ids, struct kern_ipc_perm *new)
>>>                  new->seq = ids->seq++;
>>>                  if (ids->seq > IPCID_SEQ_MAX)
>>>                          ids->seq = 0;
>>> -               key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>>> +               id = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
>>>          } else {
>>>                  new->seq = ipcid_to_seqx(next_id);
>>> -               key = idr_alloc(&ids->ipcs_idr, new,
>>> ipcid_to_idx(next_id),
>>> +               id = idr_alloc(&ids->ipcs_idr, new,
>>> ipcid_to_idx(next_id),
>>>                                  0, GFP_NOWAIT);
>>>          }
>>> -       new->id = SEQ_MULTIPLIER * new->seq + key;
>>> -       return key;
>>> +       if (id >= 0)
>>> +               new->id = SEQ_MULTIPLIER * new->seq + id;
>>
>> We still initialize seq in this case. I guess it's ok because the
>> object is not published at all. But if we are doing this, then perhaps
>> store seq into a local var first and then:
>>
>>        if (id >= 0) {
>>                new->id = SEQ_MULTIPLIER * seq + id;
>>                new->seq = seq:
>>        }
>>
>> ?
>
> No!!!
> We must initialize ->seq before publication. Otherwise we end up with the

Right!

> syzcall findings, or in the worst case a strange rare failure of an ipc
> operation.
> The difference between ->id and ->seq is that we have the valid number for
> ->seq.
>
> For the user space ID we cannot have the valid number unless the idr_alloc
> is successful.
> The patch only avoids that this line is executed:
>
>>         new->id = SEQ_MULTIPLIER * new->seq + (-ENOSPC)
>
>
> As I wrote, the line shouldn't cause any damage, the code is more or less:
>>
>>         new->id = SEQ_MULTIPLIER * new->seq + (-ENOSPC)
>>         kfree(new);
>
> But this is ugly, it asks for problems.
>
> --
>         Manfred
>
