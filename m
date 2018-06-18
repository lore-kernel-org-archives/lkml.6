Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30196C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC89220836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="urn1hTuY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bgh8gO8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC89220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935955AbeFRWKv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:10:51 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40684 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933036AbeFRWKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:10:50 -0400
Received: by mail-yb0-f195.google.com with SMTP id v17-v6so6561983ybe.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fnY/d62ljkEPQYxKqXry0rYSvQFo5/bLV3wUd9r5wKQ=;
        b=urn1hTuY6WcQQm6GVMDWeLyRznNrAkTFYRVoS1Ahpd1EhMIa6I23+VqTlv5RMc7CxB
         iuTq4erqVDd/t25SGvyKvavR6sJzrXXJQ0Tox0DIV7OFWRTR1dzXEL8Foq10DHFaOmNg
         6dBg2lv/4umVsQUoLp7+dXQitTYjY0sl9lEH0UoJtDD36KzFV94u7hnW5B08V+u/4Qya
         6P9ETQ0BQSgGyF+jPXiumepXlZM4+iX4HYW+8nY2KwyXzILaFdEiAEu9joVZ8PNX9ecK
         IC5DKOJhMJyHsltJvKUBAmPS07+pvS53VVe52R1KL+E5GStErXraIiDTUE8uasG9IaiK
         iEig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fnY/d62ljkEPQYxKqXry0rYSvQFo5/bLV3wUd9r5wKQ=;
        b=Bgh8gO8P4o6vAkLd6aS/JT3fkEn9+pbEjyR/g/IGNjky1/18yGm4vx0wy+AEyd6qRq
         8O84AkscIKwYyJ8t5FRDYLmQomhcqLrjV6SGt0j6syNo8F7CVU2dPpGpWp50TVjYvYRm
         2lOhtym1NxdckMfe06q6JnHO0Z7QAUZoy1xSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fnY/d62ljkEPQYxKqXry0rYSvQFo5/bLV3wUd9r5wKQ=;
        b=P3VfUwfKKYOxDrpYyorxQ9uEzSvQkR6xe5mZDuZVZkKYeTR0A6cqspgh21DDbP7x0r
         SC6MMZxIlale0U6hBTsAZY1Kdbpd7WzxkrnBa/Y5fJZWlB9+mb+itaQhzpDaVMFtrQjf
         IISpM0moFQCADE9nOAp8W57Oqe6pkbiGNHnLvUdYJpNTpoYtmTjwoeRDtUgQnalfxowt
         PVzsAb0RICK8crx5BsPEfkUVhaAU754ky5b3QBeeAbszZLpxK/wuMfAw280S0MWoL/bY
         U5Hzr/DMDcwYrvn4t5YwcbAKx/sA4EG8hull0z+JVP+SJ9mUwK1sMZRb87zAhbBTr76P
         rk2Q==
X-Gm-Message-State: APt69E330Y/OSaN7QS4R3wXRNEXAdr3bJyUDARGyyqBTGZSjdssXz1zd
        +JzYBcr+R0bW6f0V/FCK5SkMk8J/+hEy0LlZXUWKUw==
X-Google-Smtp-Source: ADUXVKJfy4viacenfgksG2/tm8EUFhmomS5aSQzjs6D7MPEMXnPFHRz3STAFvufMfPcAwrJuuR+9h3B0ZfCvMkv/Zmg=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr7526196ybi.193.1529359849211;
 Mon, 18 Jun 2018 15:10:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 15:10:48
 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1806181708060.15433@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180618175033.GA2627@beast> <alpine.LRH.2.02.1806181708060.15433@file01.intranet.prod.int.rdu2.redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 18 Jun 2018 15:10:48 -0700
X-Google-Sender-Auth: IMV0cYza_xQyHU0wzIPgbg3hOhY
Message-ID: <CAGXu5jLYQtqWjsKcUeDyBkaaPSc_m9-56yQU3B=ovDc_AjS6dQ@mail.gmail.com>
Subject: Re: [PATCH] dm: writecache: Use 2-factor allocator arguments
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 2:12 PM, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Mon, 18 Jun 2018, Kees Cook wrote:
>
>> This adjusts the allocator calls to use the 2-factor argument style, as
>> already done treewide for better defense against allocator overflows.
>> Additionally adjusts style nit to avoid assignments in test expressions.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/md/dm-writecache.c | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
>> index 5961c7794ef3..7773f4c75701 100644
>> --- a/drivers/md/dm-writecache.c
>> +++ b/drivers/md/dm-writecache.c
>> @@ -259,7 +259,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>>       if (da != p) {
>>               long i;
>>               wc->memory_map = NULL;
>> -             pages = kvmalloc(p * sizeof(struct page *), GFP_KERNEL);
>> +             pages = kvmalloc_array(p, sizeof(struct page *), GFP_KERNEL);
>>               if (!pages) {
>>                       r = -ENOMEM;
>>                       goto err2;
>> @@ -859,7 +859,8 @@ static int writecache_alloc_entries(struct dm_writecache *wc)
>>
>>       if (wc->entries)
>>               return 0;
>> -     wc->entries = vmalloc(sizeof(struct wc_entry) * wc->n_blocks);
>> +     wc->entries = vmalloc(array_size(sizeof(struct wc_entry),
>> +                                      wc->n_blocks));
>>       if (!wc->entries)
>>               return -ENOMEM;
>>       for (b = 0; b < wc->n_blocks; b++) {
>> @@ -1480,10 +1481,13 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
>>               bio_set_dev(&wb->bio, wc->dev->bdev);
>>               wb->bio.bi_iter.bi_sector = read_original_sector(wc, e);
>>               wb->page_offset = PAGE_SIZE;
>> -             if (max_pages <= WB_LIST_INLINE ||
>> -                 unlikely(!(wb->wc_list = kmalloc(max_pages * sizeof(struct wc_entry *),
>> -                                                  GFP_NOIO | __GFP_NORETRY |
>> -                                                  __GFP_NOMEMALLOC | __GFP_NOWARN)))) {
>> +             if (max_pages > WB_LIST_INLINE)
>> +                     wb->wc_list = kmalloc_array(max_pages,
>> +                                                 sizeof(struct wc_entry *),
>> +                                                 GFP_NOIO | __GFP_NORETRY |
>> +                                                 __GFP_NOMEMALLOC |
>> +                                                 __GFP_NOWARN);
>> +             if (max_pages <= WB_LIST_INLINE || !wb->wc_list) {
>
> The rest of patch is OK - but you shouldn't duplicate the comparison
> against WB_LIST_INLINE.

I couldn't find a better way to avoid an assignment in a test... open
to suggestions! :)

-Kees

-- 
Kees Cook
Pixel Security
