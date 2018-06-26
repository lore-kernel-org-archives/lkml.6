Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA244C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F84126ABD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaC3d+M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F84126ABD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934164AbeFZSxU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:53:20 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46503 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933266AbeFZSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:53:19 -0400
Received: by mail-vk0-f68.google.com with SMTP id b134-v6so10651439vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sgO3y5y8ILyYqtUhal+y5a6Q/m8hk5bFpFO0IKwHBbA=;
        b=eaC3d+M1Ct939uFn5MNpnIiKvLJZP2QVuiQH+q79PcF1jabRLuvw9nXQ3Nbnk9R2oR
         +PWI2QNAzZLRhEMUGh1kkGImjwqOkROJkVsaj1hbICP0tk81SLIgBMbfG46S5RgUCdA2
         h/yJ4Oj8oY8RPw5811MCEuV3OqZ6o+d6hQFFRPh4T/iukcYTQLRFeKks2VlNgpvvzcuP
         3r8W+nUea4tBinF/DEl2zxru1wDFmZkSHEg1mfgMVgWjl2FB09n7vMRH5e8GbS5cuz0J
         yxwz8GWbYbMXfwtQWr7VElGjoCAsFlN6OjFhR6hz1lEOT4pMtQ4pc2EhLHBDakXa0wdo
         ARkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sgO3y5y8ILyYqtUhal+y5a6Q/m8hk5bFpFO0IKwHBbA=;
        b=kTsXfuoje4v/ybIcw6iARRagJ/+QXyzjKdOeCT550Oe+2st3sBfz6f4tJrREolpU1S
         pk4pVnDSaRjaMQUPMt+GIw+RjD19PUEXrMt3Ch7aQJOfJQzIZXt2tbWhNgE0CtVUGwsd
         +oY3KWTwac8//wA3oHXFNlzA0ptW8kd/ZPcTdmi/0l8dglOV9hPCIZWVlxkm9BmPn09N
         3qbqfUek3nsaAVMECreBdhc+OMirh8/LzokxKEE/ide25Yp5kZ/I8zmfbN4ZoHsUNct1
         xGEVtqk3bpEncH3+KIYxy7buT4E1FK3bFIjCYsymVaKhlZWXZOhgB0N729t+aXi3c+ib
         qVFA==
X-Gm-Message-State: APt69E2TyieSA3pD897axgzhxb+dw2mpAnyS2CjgxNBeGrF4OPt4nlCu
        n4F2kpjkJxFsGmHRaXfmc+ziUOJI8cwBHslp/N4=
X-Google-Smtp-Source: AAOMgpdGkFEsnzy9M4IU15vf3iv9bjVDFMMc1Z903whLlDYHSERpFSzBXSPEf+ncIZs8WBZ1h87nm0ZpS/zZFEIpizI=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr1733478vkd.187.1530039198813;
 Tue, 26 Jun 2018 11:53:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 11:53:18
 -0700 (PDT)
In-Reply-To: <20180625105952.3756-2-mark.rutland@arm.com>
References: <20180625105952.3756-1-mark.rutland@arm.com> <20180625105952.3756-2-mark.rutland@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 21:53:18 +0300
Message-ID: <CAHp75Vdsu2LQtPdjaxfYhc3qT6gOe7bdGQKB==52W-WpORp-WQ@mail.gmail.com>
Subject: Re: [PATCHv2 01/11] atomic/tty: Fix up atomic abuse in ldsem
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:59 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> working after making the atomic_long interface type safe.
>
> Needing casts is bad form, which made me look at the code. There are no
> ld_semaphore::count users outside of these functions so there is no
> reason why it can not be an atomic_long_t in the first place, obviating
> the need for this cast.
>
> That also ensures the loads use atomic_long_read(), which implies (at
> least) READ_ONCE() in order to guarantee single-copy-atomic loads.
>
> When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> very thin (the only difference is not changing *old on success, which
> most callers don't seem to care about).
>
> So rework the whole thing to use atomic_long_t and its accessors
> directly.
>
> While there, fixup all the horrible comment styles.


> -               ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
> +               atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);

I suppose it's simple atomic_long_add() here?

Good fix!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
