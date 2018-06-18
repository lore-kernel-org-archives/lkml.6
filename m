Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2489CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C652F20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0L9XqVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C652F20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936834AbeFRXSw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:18:52 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38501 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934807AbeFRXSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:18:50 -0400
Received: by mail-vk0-f68.google.com with SMTP id b77-v6so10591864vkb.5;
        Mon, 18 Jun 2018 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jy+h40C7dggu3pV2v4jLVnODDyvO2+jkraS+VhVrIig=;
        b=r0L9XqVl/PniDXUd+KhYbCJjuEePark+2AWEMStn9Y9IfjkSa/YGOtxoocowPeo+s4
         BSvMB4TpRpn+bGXd+2MEfFFds5OXSOC6i9nW5ka7wvqRNI1Yud80wcBpwZ9QFG0behYh
         wAIzPlhRlkv1pZIjq6Aj+TbHzD135CVxohvRV5vR1weYrU1BbYK2aep6/fOwaf6Mt4kD
         3Ip4FtF6F0URW3NOqahYlwKW8o4DUimgihGi99o5UPetS+HON6XuuiHJMNoocxGU6Ivr
         EKoNbshHX8KfsWkMCb1SnveWYwz6+FQImDUdbEw71bvqs+fCnhPG7YjHeFMyP7Ph7JDH
         C4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jy+h40C7dggu3pV2v4jLVnODDyvO2+jkraS+VhVrIig=;
        b=qZM/RTt6LBC6pNx4zEcYtF8UF1M98EIhroYA+HfEFbvO7+r2/jnpgkvdN+Paf4Y1eD
         QMsLY6tan29iRdDcI4HbfqUOCFy7z+9lbC7hLMjx/95Xi+yYJjJ6aQYbW2xvmsQdbSS1
         rsKDOC+NhaK9+SZ6+kHCfDXQ1ykUc5WeDIcIdBcXPKhtMTowEyTo9+h4HBt9bQFzEBt9
         gp7p9QkYu0EzYoNWzd9G1pOakyMasv3LyHrImgwNCVyPnx4Qfa3qVEXv5EssXCO8Q7Av
         i7gMX+eXamG/tr99jR6v3IOPghRO/Yo4WZyHcgVAgalX/i0074e83s0heEAUJZ0fMc9f
         HeBw==
X-Gm-Message-State: APt69E2vBs4C+rZrSaHf9svqAi0+nHjSGrIbsQYxrTGdPdQ/P5j2bt6x
        Vd84/tALBUnYn824ueySIzMOXCStnwcbqrMk0sTygFj8
X-Google-Smtp-Source: ADUXVKIFM1DWKVPHOL9ooo4e3OnRWVtPgYHznLN+6xM+AvXz8nXyIag+lqdjxCOyzJfpxr9+9Dza6j4G26nl8G1P7qc=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr8288770vkd.15.1529363929334;
 Mon, 18 Jun 2018 16:18:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 16:18:48
 -0700 (PDT)
In-Reply-To: <20180618161056.e52efd0e8bd36211e60705a2@linux-foundation.org>
References: <20180618131003.88110-1-andriy.shevchenko@linux.intel.com>
 <20180618131003.88110-4-andriy.shevchenko@linux.intel.com>
 <20180618141404.68124daab97bd0f3a3051544@linux-foundation.org>
 <CAKdAkRTHOORds7aEauv4rp3_=PnGi=Nv-VS3-nAb9MztJPKG=Q@mail.gmail.com> <20180618161056.e52efd0e8bd36211e60705a2@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 02:18:48 +0300
Message-ID: <CAHp75VcQWO36SVmYOJQyVo8uCoA2Wec_CWw2sjRyCd73TfCpTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        agk@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        shli@kernel.org, linux-raid@vger.kernel.org,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 2:10 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 18 Jun 2018 15:01:43 -0700 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> > > +unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
>> > > +{
>> > > +     return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), flags);
>> > > +}
>> > > +EXPORT_SYMBOL(bitmap_alloc);
>> > > +
>> > > +unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags)
>> > > +{
>> > > +     return bitmap_alloc(nbits, flags | __GFP_ZERO);
>> > > +}
>> > > +EXPORT_SYMBOL(bitmap_zalloc);
>> > > +
>> > > +void bitmap_free(const unsigned long *bitmap)
>> > > +{
>> > > +     kfree(bitmap);
>> > > +}
>> > > +EXPORT_SYMBOL(bitmap_free);
>> > > +
>> >
>> > I suggest these functions are small and simple enough to justify
>> > inlining them.
>> >
>>
>> We can't as we end up including bitmap.h (by the way of cpumask.h)
>> form slab.h, so we gen circular dependency.
>
> That info should have been in the changelog,

I put it in cover letter, though it perhaps better to have in commit
message itself.

> and probably a code
> comment.

This is done in header file. You meant C-file?


>> Maybe if we removed memcg
>> stuff from slab.h so we do not need to include workqueue.h...
>
> Or move the basic slab API stuff out of slab.h into a new header.  Or
> create a new, standalone work_struct.h - that looks pretty simple.

Latter one seems requires least effort without potentially breaking things.
I take it as your suggestion, though I would still give a glance if it
is possible to split exactly memcg part out of slab.

-- 
With Best Regards,
Andy Shevchenko
