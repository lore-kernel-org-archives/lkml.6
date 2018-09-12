Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09975C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9305F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhCc3ql3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9305F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeIMEUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:20:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37348 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeIMEUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:20:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so1741215pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+O0xyODcRdhQFpn8cQrhty2ZyEZa/RQwfHf7NrOScm4=;
        b=JhCc3ql3Hz4ZgQIlSDFEmv5wLr4uULl4lzv6zbWVo7WhYtg6fLaUr7TJqXWY1iNt/I
         Z/zz4+colP0NDQQr7KzMQ3y9gFcADWJLNuoRJuoe7VUjXhIKYx8wFq5UmPK3xA4bRuFm
         8EjC9xhafAMVGO5oJwkS4jPOAkXW51D1g7kPaWAgVLDnkB9T1pLxLT9waEqJQTFc1i5n
         lKvQA4UOhSk5nuSNUt9MxO5QdI3s39CwWVhtBNAYbpLhgqvMr6LFPVoOSjQJno65MmYd
         S8gqB0/rt5MFdhFYqtJLkVyocnZ+xuz+SI93W82FtCLeH/wCOLruiKJW7ZQ+ttXXsKe2
         XjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+O0xyODcRdhQFpn8cQrhty2ZyEZa/RQwfHf7NrOScm4=;
        b=Aloz6PyOgDWsYKq4oZjOinBdA1VgNRbZ+GDwgX4DypLWxjTeEkrTR2+/B3/qpjRWuS
         pbrX1Lq6ORmxwJCZIu+jlRb6P9ZP6Dy4CH9nZ31DEALhzKf3EABr2LpVDPE2jmaxiVBY
         mGKVoucxD2P0In+I0lA15RytcphuwxEpUWgGOLJ2PLjZwBjKQZPA9rkNL5YsBDZEfkAX
         to4W66OFXOmQQpFzTMUyKx447kufbokauDNc1roQqb+1dImP8xVnW5GFDH9eCm/YB49k
         okiLWK301OgPO09LH5U4HaGBwZd2pTPHOx3hfHiElJHUOVnC1WwPPx2Es1ojijefGPZG
         gdog==
X-Gm-Message-State: APzg51D/RYKF7pIhFQX4o77JnJDcBacTNEbrdWrjzzx0PLu/X+Bc0TwK
        WTGJMe0VDqo3FWKBh4jMPKT/XqPruZ5jy/GdZBijGQ==
X-Google-Smtp-Source: ANB0VdY77GmJcedAamd4CHedH67fBkKCf0ySd+rjpvidxOlyC5hshOt4G+ps1O3rRFhC/0Rd9/ewRYNmsv9HEdmXyL0=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr4660744pfi.174.1536794029808;
 Wed, 12 Sep 2018 16:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180912002559.1853-1-natechancellor@gmail.com>
 <CAKwvOdkMg_1JxVNhKrUM0CZxF6nQo8c5h7t4zu4RP2xEXyQdKQ@mail.gmail.com> <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
In-Reply-To: <CAGL0aWeYARfArmSJwXemE_QdGeRwnfE-CKh+DaRY8jwEF0SU5w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Sep 2018 16:13:38 -0700
Message-ID: <CAKwvOdkSy74TKqASdMtWwHKOeAVQn+mEfv0Fi8q+-35dGjXtHA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
To:     Richard Smith <richardsmith@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 1:24 PM Richard Smith <richardsmith@google.com> wro=
te:
>
> On Wed, Sep 12, 2018 at 10:38 AM Nick Desaulniers <ndesaulniers@google.co=
m> wrote:
>>
>> On Tue, Sep 11, 2018 at 5:26 PM Nathan Chancellor
>> <natechancellor@gmail.com> wrote:
>> >
>> > Clang warns if there are missing braces around a subobject
>> > initializer.
>> >
>> > drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
>> > around initialization of subobject [-Wmissing-braces]
>> >                 struct amdgpu_task_info task_info =3D { 0 };
>> >                                                       ^
>> >                                                       {}
>> > 1 warning generated.
>> >
>> > drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
>> > around initialization of subobject [-Wmissing-braces]
>> >                 struct amdgpu_task_info task_info =3D { 0 };
>> >                                                       ^
>> >                                                       {}
>> > 1 warning generated.
>> >
>> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v8_0.c
>> > index 9333109b210d..968cc1b8cdff 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> > @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amd=
gpu_device *adev,
>> >                 gmc_v8_0_set_fault_enable_default(adev, false);
>> >
>> >         if (printk_ratelimit()) {
>> > -               struct amdgpu_task_info task_info =3D { 0 };
>> > +               struct amdgpu_task_info task_info =3D { { 0 } };
>>
>> Hi Nathan,
>> Thanks for this patch.  I discussed this syntax with our language
>> lawyers.  Turns out, this is not quite correct, as you're now saying
>> "initialize the first subobject to zero, but not the rest of the
>> object."  -Wmissing-field-initializers would highlight this, but it's
>> not part of -Wall.  It would be more correct to zero initialize the
>> full struct, including all of its subobjects with `=3D {};`.
>
>
> Sorry, I think I've caused some confusion here.
>
> Elements with an omitted initializer get implicitly zero-initialized. In =
C++, it's idiomatic to write `=3D {}` to perform aggregate zero-initializat=
ion, but in C, that's invalid because at least one initializer is syntactic=
ally required within the braces. As a result, `=3D {0}` is an idiomatic way=
 to perform zero-initialization of an aggregate in C.

That doesn't seem to be the case:
https://godbolt.org/z/TZzfo6 shouldn't Clang warn in the case of bar()?

> Clang intends to suppress the -Wmissing-braces in that case; if the warni=
ng is still being produced in a recent version of Clang, that's a bug. Howe=
ver, the warning suppression was added between Clang 5 and Clang 6, so it's=
 very plausible that the compiler being used here is simply older than the =
warning fix.
>
> (Long story short: the change here seems fine, but should be unnecessary =
as of Clang 6.)

The warning was identified from clang-8 ToT synced yesterday.

--=20
Thanks,
~Nick Desaulniers
