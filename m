Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4301FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 04:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EC02086E
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 04:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UNt8tGLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EC02086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeGOErQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 00:47:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39056 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeGOErP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 00:47:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so12565644wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 21:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OObvl9YHFDf56+yHYi/GcQGih1Kzx7x91kF95IH8A0=;
        b=UNt8tGLk4+riZ4+ns8OFQBi64HlSLpUUjRI51/NFgYHlU+LDG4krU+60tO1pQ+0j4w
         dg64ARhT24KnGq5jyygT0v4/rugg1LjyNkQbbVUSBBQdZnsvh6g01s7Gfr0KTjlV67RY
         AN0PmwEtP762CPFuVpO00AVLrEb2KrUXsfVpbGPAVI4ElMj4val5FXAYOUF2mmKQh6di
         /dE6P0OlXah4NbG84KhpreOgfmt7VZ+Xcsdak84SkGSUPjkBI3rJ+Rxs/d9NK7ysjvNT
         xTDOp2F3gdizwR4x8xiYDb/heTR1p/mlDpw3Hmbm1+tBnTIa8s4kpUIjA8XCUBIQki2I
         IskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OObvl9YHFDf56+yHYi/GcQGih1Kzx7x91kF95IH8A0=;
        b=fSZrPeMEVzedV/I1/gJsIIxqU92P8NnnHEQI/A7ARm6dBA4KYYtpu6p22+KAU4PJWJ
         j6xxK8qT0l2wSQXX9IJ9E5nTGCIxEHTeYcebT9ND1rIGGCrfcAWPNOR4D53fke4tZHf5
         b6Nll9rgilogEQ7xWcGDCfsXZppQCC6FGHb0PX+8XBhqLx7xV1Oln5JtYVNbfmOr2ATB
         AQGbbUPyWVD69E/2dnWP0hPOTIlufm625JFLvO8c8KYD2M6ZooueVfvO5TElSGyjz8S3
         FlpQO4OJVfnA+7m/nHxT0Ex4zz9W2HEbbnRp2Kr/poORSn75lp39o27hRQmZbP8CP/BQ
         F1oQ==
X-Gm-Message-State: AOUpUlFoVwnaTSMm2fyzkG2SqaDjyOp0dSDqcfcdJGsklHkqQuq2xAHI
        Ul/92/f9NG1XXARAocDSeyPQ9wHWEjyEDF6eQqLSqQ==
X-Google-Smtp-Source: AAOMgpc+XqAxYD6S4gvYd2vaMaGxWHRVYQHQIlRlwvm7VZW7/iTWNkEMSfavpdfBhDaCaVTLdQLLHyapcrWTWd2JPeY=
X-Received: by 2002:a1c:63d4:: with SMTP id x203-v6mr6839811wmb.9.1531628744144;
 Sat, 14 Jul 2018 21:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
 <CALvZod57QFRVQ7kM4LSNQJACQ+dGC_otJkqK-5+i-0b53Zq5aA@mail.gmail.com> <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com>
In-Reply-To: <CALOAHbDV73+X-y7V2Z4nX1C7uCY6yzBPTPZhEvTpN3f7_qWwUw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 14 Jul 2018 21:25:31 -0700
Message-ID: <CALvZod5d37v8fv=VCFLa7g+ntPvaT-h8jRQw1+iry2dxb=yXxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg in softirq
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 7:10 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Sat, Jul 14, 2018 at 11:38 PM, Shakeel Butt <shakeelb@google.com> wrote:
> > On Sat, Jul 14, 2018 at 1:32 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >>
> >> try_charge maybe executed in packet receive path, which is in interrupt
> >> context.
> >> In this situation, the 'current' is the interrupted task, which may has
> >> no relation to the rx softirq, So it is nonsense to use 'current'.
> >>
> >
> > Have you actually seen this occurring?
>
> Hi Shakeel,
>
> I'm trying to produce this issue, but haven't find it occur yet.
>
> > I am not very familiar with the
> > network code but I can think of two ways try_charge() can be called
> > from network code. Either through kmem charging or through
> > mem_cgroup_charge_skmem() and both locations correctly handle
> > interrupt context.
> >
>
> Why do you say that mem_cgroup_charge_skmem() correctly hanle
> interrupt context ?
>
> Let me show you why mem_cgroup_charge_skmem isn't hanling interrupt
> context correctly.
>
> mem_cgroup_charge_skmem() is calling  try_charge() twice.
> The first one is with GFP_NOWAIT as the gfp_mask, and the second one
> is with  (GFP_NOWAIT |  __GFP_NOFAIL) as the gfp_mask.
>
> If page_counter_try_charge() failes at the first time, -ENOMEM is returned.
> Then mem_cgroup_charge_skmem() will call try_charge() once more with
> __GFP_NOFAIL set, and this time if If page_counter_try_charge() failes
> again the '
> force' label in  try_charge() will be executed and 0 is returned.
>
> No matter what, the 'current' will be used and touched, that is
> meaning mem_cgroup_charge_skmem() isn't hanling the interrupt context
> correctly.
>

Hi Yafang,

If you check mem_cgroup_charge_skmem(), the memcg passed is not
'current' but is from the sock object i.e. sk->sk_memcg for which the
network buffer is allocated for.

If the network buffers is allocated through kmem interface, the
charging is bypassed altogether (through memcg_kmem_bypass()) for
interrupt context.

regards,
Shakeel
