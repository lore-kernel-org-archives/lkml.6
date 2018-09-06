Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A9BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4178D2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RulWN5Ht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4178D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeIFVQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:16:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40862 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeIFVQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:16:22 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so5235453plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wlm/2akOmDOzhTREznTfzxeoJoyseVDGJ+1+AmvoRyY=;
        b=RulWN5Ht+7LcJ8/lhC+x66AC1p2+Sdh9TRenJZU2RXb7Uz9sJH6056WB1FusLaeoua
         yjVQojqBkMTRSyROlkNEzUJ1ojtfIPvV2Cc8YTzT+mSv78EX7KjS1gpuzcSCGdpNDlfn
         npXdPjl+rOTmpyGeGFKZNkYSK/RyJjfQ9TUK72x5UvQJ1LkSZK4Q1a5V5eFCluVP/HWC
         RVI948DNvInDhYAhX7+VTubyx2VETbuJE2pXHoDMIbtDERQcGN+BROqr9s3PtaSSOulI
         r3QLcjCXuH6+R3W4VdUgqdq/csaEtqFOk4DL1KbiaJgMOhVjJdThC/1wMI3SmeLHbjVW
         uxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wlm/2akOmDOzhTREznTfzxeoJoyseVDGJ+1+AmvoRyY=;
        b=kYjpBx96MrBM17pXm/Yt0A6gdlp/ba7LLcgoXLGtCm5dw2G90nDp9xeT9W+Xw1DbyD
         RG0nTAS+uLimquBZdSiOHjnm43mV9//wzF/sILyAnunnRkUZt5RQJdYwcDzOVXXVVeR8
         Lwy4uVF21WuoM8H7oQrPMK60RJ8mKZDUnYYhFSWQoNkFa7PyAvyLFjcPw55725qMalmY
         MWmuP1DsSGkzy0fH431WxwLOh4yQN1iroaCj6IQZGp4NbQX2rZeBnAXi/WHN2hYr+WiD
         j+OXgmh2Cb250A2+Jc8etBcNLvnr4d9TtZZjlrrPxrYJoQQep5B/FkP+tWUGtAcTeWeG
         PN9w==
X-Gm-Message-State: APzg51BrLauBdH+iVA5KDUMou9OyNHh8JyIK0cMehToxG86uj2J7eWEc
        MBU9A8NuhVwJGtcI/jrkVZmzmAd+Nu2mZTc5rksCuA==
X-Google-Smtp-Source: ANB0VdZfoSUVlwPQDyCjVZaxSIoPBUA4dlbYZQxP3qJleOzOPzqe5h3IhO1JJfVZHedh3c69bFsJBjIijEmE+9ZRb0M=
X-Received: by 2002:a17:902:7102:: with SMTP id a2-v6mr3534422pll.217.1536252003143;
 Thu, 06 Sep 2018 09:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1535462971.git.andreyknvl@google.com> <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
 <20180906100543.GI3592@arm.com> <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
In-Reply-To: <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 6 Sep 2018 09:39:51 -0700
Message-ID: <CAKwvOdk=F=kja-ZznrifTO8EASmPF0CoTPWbFxpMqLk-_KGEEQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] khwasan: kernel hardware assisted address sanitizer
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 4:06 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Sep 6, 2018 at 12:05 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Sep 05, 2018 at 02:10:32PM -0700, Andrew Morton wrote:
> >> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
> >>
> >> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
> >> > (Kernel HardWare assisted Address SANitizer).
> >>
> >> We're at v6 and there are no reviewed-by's or acked-by's to be seen.
> >> Is that a fair commentary on what has been happening, or have people
> >> been remiss in sending and gathering such things?
> >
> > I still have concerns about the consequences of merging this as anything
> > other than a debug option [1]. Unfortunately, merging it as a debug option
> > defeats the whole point, so I think we need to spend more effort on developing
> > tools that can help us to find and fix the subtle bugs which will arise from
> > enabling tagged pointers in the kernel.
>
> I totally don't mind calling it a debug option. Do I need to somehow
> specify it somewhere?
>
> Why does it defeat the point? The point is to ease KASAN-like testing
> on devices with limited memory.

I don't disagree with using it strictly for debug.  When I say I want
the series for Pixel phones, I should have been clearer that my intent
is for a limited pool of internal testers to walk around with KHWASAN
enabled devices; not general end users.  It's hard enough today to get
anyone to test KASAN/ASAN on their "daily driver" due to the memory
usage and resulting performance.

We don't ship KASAN or KUBSAN on by default to end users (nor plan
to); it's used strictly for fuzzing through syzkaller (or by brave
"dogfooders" on the internal kernel teams).  KHWASAN would let these
dogfooders go from being brave to fearless.

-- 
Thanks,
~Nick Desaulniers
