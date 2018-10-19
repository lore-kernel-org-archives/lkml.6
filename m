Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E31ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B97E21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="J77oYX2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B97E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeJSRBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:01:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37613 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeJSRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:01:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so37451354qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=30Ghk9S+Db/4MNlRoFa8BA0GRxVmoKsIYXlEULrFnDI=;
        b=J77oYX2nDTUDTDwklDe43wQQL+Qz3/lzSYHS8zwLFYvoPQBJc1+VU0WPwc51M8aoU2
         4hSsDGJz6AgcTNoZEgZLL8QRxbbPhMfqgOHu3RZ5FpLibBz+yx0q8jnU4DVwMmJASK3B
         MPs+waRFRyyl+6ONjbVLLC03z+5rn90W+MgBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=30Ghk9S+Db/4MNlRoFa8BA0GRxVmoKsIYXlEULrFnDI=;
        b=ZO5Hx7Xnb6T8H8AXi9MPaLSd/UGpSUCaLC4I5lonVHkBP3Vqtn1cOmHWV2tj7sZJ2s
         yS8tA0k92xc5aO/77QwUKV14s4Qaw2ZyzntyX/+00p4nNDe1qJ08T0G21qbat4mSUoMK
         ZoXloVC3hXZF+OcRvzp1Teh7L8C2B55zc4SV0Tf43ofiXnlacJli1UF9pNQD/5mTgDi/
         ZhZMzW6BpBAjSNBULop7ArT7x3lwUNaw2nhbbfiyy/74hAfg1mjJZ+eySc4b66Z8opKA
         BxkBsHBo4rtXILoiEL8nQMpOCn5I69zgiaDZd8vG4ScuhKpMUznujPmNVEITH/ZJfJqo
         3/0w==
X-Gm-Message-State: ABuFfojwla5qddBnfDBlEwR4faU7a7VyA3BebT9jVG7s5C5Vpun5Or3B
        Gk8qT5qQKJ4oRDVlF77liJBgtBmV7cBHGXhVcyFI5Q==
X-Google-Smtp-Source: ACcGV6352bIxmJWACI/xxZRj8tQuQqg2hBmIPoDFNPVRQM3Kr8u70H0VSB3otfxKH1B1nErQIZjAZ4xRtp7VwN+MNDg=
X-Received: by 2002:aed:2791:: with SMTP id a17-v6mr32021609qtd.303.1539939384762;
 Fri, 19 Oct 2018 01:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com> <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
 <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com> <c72a23ea-efea-4c0e-d397-623d6ac16ebb@roeck-us.net>
 <c43669b7-1074-714c-fb22-81685826b3ad@amd.com> <74078dc6-ef08-586b-fd58-51eb2c0b5060@roeck-us.net>
 <BN6PR12MB1809E1A07CD1B5B0F41273EBF7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <c6880c5b-e259-4923-8d5a-80c620563398@amd.com> <20181008174628.GB11442@roeck-us.net>
 <4a1faa3b-8c42-b742-9b55-9d2711f7ecc1@amd.com> <20181019085308.GY31561@phenom.ffwll.local>
In-Reply-To: <20181019085308.GY31561@phenom.ffwll.local>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 19 Oct 2018 10:56:13 +0200
Message-ID: <CAKMK7uHg-o6CUREz+egJVPwAeHB_rF229vKkqFENxAZRjdGcZg@mail.gmail.com>
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        "Peres, Martin" <martin.peres@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 10:53 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Oct 08, 2018 at 06:13:56PM +0000, Koenig, Christian wrote:
> > Am 08.10.2018 um 19:46 schrieb Guenter Roeck:
> > > On Mon, Oct 08, 2018 at 05:22:24PM +0000, Koenig, Christian wrote:
> > >> Am 08.10.2018 um 17:57 schrieb Deucher, Alexander:
> > >>>>>> One thing I found missing in the discussion was the reference to the
> > >>>>>> C standard.
> > >>>>>> The C99 standard states in section 6.7.8 (Initialization) clause 19:
> > >>>>>> "... all
> > >>>>>> subobjects that are not initialized explicitly shall be initialized
> > >>>>>> implicitly the same as objects that have static storage duration".
> > >>>>>> Clause 21 makes further reference to partial initialization,
> > >>>>>> suggesting the same. Various online resources, including the gcc
> > >>>>>> documentation, all state the same. I don't find any reference to a
> > >>>>>> partial initialization which would leave members of a structure
> > >>>>>> undefined. It would be interesting for me to understand how and why
> > >>>>>> this does not apply here.
> > >>>>>>
> > >>>>>> In this context, it is interesting that the other 48 instances of the
> > >>>>>> { { 0 } } initialization in the same driver don't raise similar
> > >>>>>> concerns, nor seemed to have caused any operational problems.
> > >>>>> Feel free to provide patches to replace those with memset().
> > >>>>>
> > >>>> Not me. As I see it, the problem, if it exists, would be a violation of the C
> > >>>> standard. I don't believe hacking around bad C compilers. I would rather
> > >>>> blacklist such compilers.
> > >> Well then you would need to blacklist basically all gcc variants of the
> > >> last decade or so.
> > >>
> > >> Initializing only known members of structures is a perfectly valid
> > >> optimization and well known issue when you then compare the structure
> > >> with memcpy() or use the bytes for hashing or something similar.
> > >>
> > > Isn't that about padding ? That is a completely different issue.
> >
> > Correct, yes. But that is the reason why I recommend using memset() for
> > zero initialization.
> >
> > See we don't know the inner layout of the structure, could be another
> > structure or an union.
> >
> > If it's a structure everything is fine because if you initialize one
> > structure member all other get their default type (whatever that means),
> > but if it's an union.....
> >
> > Not sure if compilers still react allergic to that, but its the status
> > I've learned the hard way when the C99 standard came out and it still
> > seems like people are working around that so I recommend everybody to
> > stick with memset().
>
> Went boom:
>
> https://bugs.freedesktop.org/show_bug.cgi?id=108490
>
> Can we revert?
>
> Also, can we properly igt this so that intel-gfx-ci could test this before
> it's all fireworks?

Please disregard this reply, that was the wrong thread.

Sorry, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
