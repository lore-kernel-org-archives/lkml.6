Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF74ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70592151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfS6c1az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70592151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbeITAdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:33:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37121 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732194AbeITAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:33:08 -0400
Received: by mail-io1-f65.google.com with SMTP id v14-v6so5364954iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5jqb3O74LNDHRJQZbYQ7ykrAUCRLRrTDLvyZBQX5gZ0=;
        b=vfS6c1azvMHRNNsdwm98F9Z9gpII+RJsziOKkavjMjf25PaM95w51Md/jVsrLREyjv
         g2vB/zQRNnwDsGaJJ/jDExICclW0EFQ8YVb8cShLKGEwUy2PrkumkNjX8Q/132hRZA/Y
         XJdzujus0CUn3OopkRZFDG4uOfVR1gMRPS4IGdnew7RCDaa5BkNPUPlrTKQcUyriAixh
         /4tpT2dVXFA6piOUFUwXv29LvrBdvmcIo21bF/5euTJuMwHgnA6iqQvlzOdwvo7PZ3Wu
         KpFxrQXgLKMkZlILyGAiq2LStmmu70qOCCII5Rf4EPhknT9tu6G/BtonreHrzkgIDq1Z
         TtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5jqb3O74LNDHRJQZbYQ7ykrAUCRLRrTDLvyZBQX5gZ0=;
        b=ao9NMbUb5wAps7VbHsY9My17g0O+86mbaOaCfude2XbjdO6MhTsb/K/P6Q3ellgrp9
         sZi0nGcDDDQ4x96SxJMs0iCImyzfos5Jnjvlp2S+gqHP2UAYSb+ZSljZpuSpxcLhIu9o
         +i5VON8LDeGB4R6xbKqb7fsLX+P5M0Bi0J2iVajxBa2SDZWEihlfW1Ym6bpxw51hbtjX
         n9/2o+7LziLrhoFJ+7J22WgAq7QV/S+9EUhGqkaikzkhFIgsGgwg3juQMpWmTI/INzlD
         ihiyIjZNgAP28Q+t/MCqZHsLL70TBUaFdcLUJSLDwRzB/5j0CRI5jKKPMqzzE6tl4UEw
         jRtg==
X-Gm-Message-State: APzg51BPucgAkPytz+NgVWE7bfL35vlAxXdiuh2PfqAYCtepqzIqaO9Z
        /RQShbjIsqjvoso7roT9L+CJVF45HdydolzDNfhswQ==
X-Google-Smtp-Source: ANB0Vda/iOdRo/765W3FtKGgdBxNWv2Jb43v+T7nmuMQM2hBgOlGUiRRt8FqZV59hPwuYEs3LwyZnuJW4wJpYUwq4I4=
X-Received: by 2002:a6b:2147:: with SMTP id h68-v6mr29966004ioh.192.1537383233221;
 Wed, 19 Sep 2018 11:53:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 11:53:52
 -0700 (PDT)
In-Reply-To: <20180914152825.GC6236@arm.com>
References: <cover.1535462971.git.andreyknvl@google.com> <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
 <20180906100543.GI3592@arm.com> <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
 <20180914152825.GC6236@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 19 Sep 2018 20:53:52 +0200
Message-ID: <CAAeHK+x1MO4Q+11No8prngHCspy36EoPVv01SvQBsyuOYCKUcQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] khwasan: kernel hardware assisted address sanitizer
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
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

On Fri, Sep 14, 2018 at 5:28 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Sep 06, 2018 at 01:06:23PM +0200, Andrey Konovalov wrote:
>> On Thu, Sep 6, 2018 at 12:05 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Wed, Sep 05, 2018 at 02:10:32PM -0700, Andrew Morton wrote:
>> >> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>> >>
>> >> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
>> >> > (Kernel HardWare assisted Address SANitizer).
>> >>
>> >> We're at v6 and there are no reviewed-by's or acked-by's to be seen.
>> >> Is that a fair commentary on what has been happening, or have people
>> >> been remiss in sending and gathering such things?
>> >
>> > I still have concerns about the consequences of merging this as anything
>> > other than a debug option [1]. Unfortunately, merging it as a debug option
>> > defeats the whole point, so I think we need to spend more effort on developing
>> > tools that can help us to find and fix the subtle bugs which will arise from
>> > enabling tagged pointers in the kernel.
>>
>> I totally don't mind calling it a debug option. Do I need to somehow
>> specify it somewhere?
>
> Ok, sorry, I completely misunderstood you earlier on then! For some reason
> I thought you wanted this on by default.
>
> In which case, I'm ok with the overall idea as long as we make the caveats
> clear in the Kconfig text. In particular, that enabling this option may
> introduce problems relating to pointer casting and comparison, but can
> offer better coverage and lower memory consumption than a fully
> software-based KASAN solution.

Great! I'll explicitly call it debug feature and mention the caveats
in v7. Thanks!
