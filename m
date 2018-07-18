Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACBEECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C136B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xaptum-com.20150623.gappssmtp.com header.i=@xaptum-com.20150623.gappssmtp.com header.b="kCqen7+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C136B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xaptum.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbeGRDSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:18:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46160 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731304AbeGRDSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:18:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so3015974wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 19:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xaptum-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hGCO4ukNoxtsWsd6lxiW7iaIu/DyNa4l5pFV9kMh5kE=;
        b=kCqen7+VEnkjUOrahU+Q4htWtX/Mwi3uy9fS8pldN1q6An0RsiM5ivjSfaf7nyZ6iu
         bXxANumM6MtLyz26pYEDg9U8YI59hCnrqdpmbwdAFn6IJW5KfP3SghpaFEeRKhw7EJF3
         1aJEaplj6Opa4qJpwm9JjsWx29IdhsvABVPSjbVXuscaGeSCzI29qlXrHHbzlW+IrcYE
         PRkzTTyEfQfZ0yUnFsdy/00MVof8CkKIn7wqh1ct0YwgEJtttm34sOb9ZE6660lpI4Hd
         EWXWZfyrpAYO1yEblPgEaN75y8kikDyLCSrhsQjS/0Js2o1zUQ8cQlGfCNHNENqF3xZK
         cP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hGCO4ukNoxtsWsd6lxiW7iaIu/DyNa4l5pFV9kMh5kE=;
        b=Vcss67XXFitwcD3/dj4KE0GcD7KyaIdNiidf5oUE8+9IZZzNRuMrlTAK09PfyEevhg
         yzEALGbiELLHj/lU00SkjTiAlXVqgqoiN2xFkkEpvWp+haqnQGNu7ResgPifrO5kmY3x
         QsW5KgV8x7BeBzb+UKNKDgWJUroc3zziGJTpWgWkk8+gMlJTDpehY+gVlt8zp4VHArhd
         GmxPx1+dj955bwsBwd0VjFlkFbQCkFDmTvbnXzZf4Uss8PIk5xKC4eS73EAN/49ZcZwL
         sdsrMjRk2oVE6Hkbz1ORbz/ioXqvAoUoAgbbzGPUwU+w0UWKA/+i6SINzxiVQ5jYRjZZ
         MZ+A==
X-Gm-Message-State: AOUpUlFPxEkyL6pY591Uh5hk9sQioCOWzG9CLnNiJFKLPGeGSXaoE1UW
        4pJJV1LQZLX5sWSqPjDUupR+nBXUhXoik2HeistlBw==
X-Google-Smtp-Source: AAOMgpc+ZBtu5XuD5PmBjpSCMnRBqGRpBd0KHscptRSDcRcSbv47t9OZmRr0tJKMPwKbRHwSM+XGiLZOSBZ7GKrZINQ=
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr3072012wrc.88.1531881793551;
 Tue, 17 Jul 2018 19:43:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:3d8b:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 19:43:12
 -0700 (PDT)
In-Reply-To: <CAKNRAJV8Jb=n=cZTmkAUVLwYv5778ykACd7ZUhYA7rfa0Wu3zw@mail.gmail.com>
References: <20180608065438.110109-1-louiscollard@chromium.org>
 <20180618180712.GB20697@linux.intel.com> <20180618193306.GF6805@ziepe.ca>
 <20180621162101.GB11859@linux.intel.com> <CAKNRAJVJD5b388iwhoOBVC5V-x=wV2YTZHJ+mRrBWv3H-pbNFg@mail.gmail.com>
 <CAAi9uDuxS7G+DaHskGJXnvigsdzXrW64J6zy-dgQCXJvv8be3g@mail.gmail.com> <CAKNRAJV8Jb=n=cZTmkAUVLwYv5778ykACd7ZUhYA7rfa0Wu3zw@mail.gmail.com>
From:   "David R. Bild" <david.bild@xaptum.com>
Date:   Tue, 17 Jul 2018 22:43:12 -0400
Message-ID: <CAAi9uDt063WYqNSX9dSCtRybd2a2Ad-0q2s8xvOst6qq3O4wPg@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add module parameter for hwrng quality.
To:     Louis Collard <louiscollard@chromium.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 2:54 AM, Louis Collard <louiscollard@chromium.org> wrote:
> On Fri, Jun 29, 2018 at 9:03 PM, David R. Bild <david.bild@xaptum.com> wrote:
>> As a point of clarification (and correct me if I'm wrong), the TPM is
>> always ready used to seed the rng. It just doesn't update the entropy
>> pool estimate.
>
> Good point.
>
>>
>> So, perhaps the default value for the TPM hwrng quality should be
>> non-zero (in addition to the module param that lets users override
>> it)?
>
> That makes sense to me, however I can imagine that some users would
> prefer to not have the TPM enabled as an ongoing source of entropy by
> default.

Fair enough.

> Following on from your previous point - perhaps we can just make a
> small change to how the initial seeding is done: maybe we can replace
> the call to crng_slow_load (via add_early_randomness and
> add_device_randomness) with a call (indirectly) to crng_fast_load. (We
> might also need to increase the amount of data read at this point.)
>
> This would update crng_init_cnt and crng_init, and calls to getrandom
> [without GRND_RANDOM] would not block.

Interesting.

add_hwgenereator_randomness() will call crng_fast_load(), regardless
of entropy estimate/quality, if crng_init is 0.  So initializing
crng_init from the hwrng, regardless of quality, is already the
intent.

But hw_random only calls add_hwgenerator_randomness() if
current_quality > 0, via the hwrng_fillfn() kthread.

All that to say, I agree.  add_early_randomness() should (indirectly)
call crng_fast_load(), like add_hwgenerator_randomness() does.

> This obviously doesn't solve the issue if there are blocking calls on
> boot that are querying random rather than urandom; I don't believe
> that would be a problem for our use case though.
>

It wouldn't be a problem for our use case either.

Best,
David
