Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7B5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F1B2172F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1AMGKM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F1B2172F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967865AbeF1S0p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:26:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45871 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966553AbeF1S0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:26:41 -0400
Received: by mail-io0-f195.google.com with SMTP id l25-v6so6121692ioh.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VsLJ6wrLOa63ri0/5rzsT9yRxAaEoRgvfy8CXVui3iI=;
        b=J1AMGKM7+4CUJ6Yl0FH1lD2y+iHzHzK9YmY2eXX3FOaxVsMZGTcQeJ5r6r9y5ZMjOV
         yXkrAMer47WguRF8+wFmtTXomPwX6Q21fc6OxICHerAPZ4dCcS/WFfS/fq5NLwgDlqKD
         0hbc4AE8+QllsxJNOl20OpDJdDYYCJCGjK8YTJUVqR9YrnDVVtU70YeGzDDRSIYj5Gdo
         pceNWHxtxc6f/Lpo+vCRKkxVREM29jb9Vp0FArBcVd50xhlBS5eAyK35D/labpDK3dxn
         aFU6OcOJlR1C0C5i5dnnjHsELngw3b3jcBpXKx3+/DkP/q7+CSniH9L006uhLLt460Ex
         i6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VsLJ6wrLOa63ri0/5rzsT9yRxAaEoRgvfy8CXVui3iI=;
        b=NiIv8RZ7VxaZ+Wu1sKmpteR8A7uZZu7PHc6kn1S1fgO7+S49DmYFDtWbtFUi5ZcAfM
         yKLlVIrMksUb53NvJ7+9iLXtExFt4oOJE7AJmi7BMVyeuV3dembmmwil7NV866rsjc/g
         19/Q10mWkkmizpw3EFrV1d+OkfLWXI1+4pAeC89b1wa98bwXgyujdQYkB3Bdrqc0SDi+
         u4Ll7Gjqjnw8bQix45oU/o793pTuXTBfXdZfqs7bSHICZRVlG4pgNhKCxjgI8s7KzGR5
         dJSpWIJhZOpygrYFXn5jQzF163yQKz8Xmh79Yz37rxMur1/ovwOGfOBiTneYBUc3Snrn
         OCnw==
X-Gm-Message-State: APt69E1vIpFUmLrN569WIVdmQvlp6u1nRisLdRKt4v2kKUWvP2554AtM
        ptBR5sOfKRcwnlJ/X8RZqokrYcDsErsbTfKXzG0Szw==
X-Google-Smtp-Source: AAOMgpeq1bK4ryMCDJ16SKJE3RI918BnRv9JcrdWjUIDbmiqyPE98wf0GLs+I3vohvZWmRU3368WgSOQUWNqTJ8Ab64=
X-Received: by 2002:a6b:5002:: with SMTP id e2-v6mr9944633iob.31.1530210400677;
 Thu, 28 Jun 2018 11:26:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:9082:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 11:26:39
 -0700 (PDT)
In-Reply-To: <20180627181138.14c9b66e13b8778506205f89@linux-foundation.org>
References: <cover.1530018818.git.andreyknvl@google.com> <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
 <CAN=P9pivApAo76Kjc0TUDE0kvJn0pET=47xU6e=ioZV2VqO0Rg@mail.gmail.com>
 <CAEZpscCcP6=O_OCqSwW8Y6u9Ee99SzWN+hRcgpP2tK=OEBFnNw@mail.gmail.com> <20180627181138.14c9b66e13b8778506205f89@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 28 Jun 2018 20:26:39 +0200
Message-ID: <CAAeHK+wg35W6D3Cat7w8kqV+9fB6dKmnCUuUrZP_tz5=vKk+0Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address sanitizer
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vishwath Mohan <vishwath@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 3:11 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 27 Jun 2018 17:59:00 -0700 Vishwath Mohan <vishwath@google.com> wrote:
>> Yeah, I can confirm that it's an issue. Like Kostya mentioned, I don't have
>> data on-hand, but anecdotally both ASAN and KASAN have proven problematic
>> to enable for environments that don't tolerate the increased memory
>> pressure well. This includes,
>> (a) Low-memory form factors - Wear, TV, Things, lower-tier phones like Go
>> (c) Connected components like Pixel's visual core
>> <https://www.blog.google/products/pixel/pixel-visual-core-image-processing-and-machine-learning-pixel-2/>
>>
>>
>> These are both places I'd love to have a low(er) memory footprint option at
>> my disposal.
>
> Thanks.
>
> It really is important that such information be captured in the
> changelogs.  In as much detail as can be mustered.

I'll add it to the changelog in v5. Thanks!
