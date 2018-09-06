Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452AFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D698020652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MihKNWie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D698020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeIFPlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:41:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53280 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeIFPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:41:20 -0400
Received: by mail-it0-f66.google.com with SMTP id p79-v6so14155240itp.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eQUtzab2F5p5J0hzS+43NK1LRC4wjId0Bpq0D/n7OE8=;
        b=MihKNWiesmAWUZOBS9DNoR+kr6cqqIobt7djEp08rqurqST70dbrR0u5Z+yEllMTfM
         eyYDEbfNSzopXYn4kQps9z4bJYAbxgZSYvW4JL1qy2KSCc4KnXer4jGrQ+h81sQB8z3z
         2AjFiUYp2qIh5WwlY/4q13b9+yOMUY2nYP0Z7YWN3n8UjLR1Nbr9C4V2pA1S/F/a7JHx
         fA85oIh+lyFwa8HscWiEbIxWh+Mp5RpxgGrS2tSqrkx0WH00oEw48lnO7lyFRB0FGLq2
         K5t5kGGXOD56nfGE44edQeyWUGPU1Hsb1xVCbQ/Wmx4Q5LDPaRNmvgsGTDc9weVwZNE7
         EpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eQUtzab2F5p5J0hzS+43NK1LRC4wjId0Bpq0D/n7OE8=;
        b=TPAkBnn+cFlL75vYNC6C93yGLVe1bFMspIiLDXVN9497GRvhpOt6yjNBDchix30rTR
         OOkhJn1wEwnSfDNbOh9Gq/GVCqgzWrt4AXrDySvzzPDEXkSjqQ/C+XiRQZCySmSABjxW
         u+0lJR2Lxb+jwjNnQiue5rmSK0RzxaPSneC9K5y0Q6wV7H3YPazROmFurh18r9103rXe
         WtOrS+W1OW5m8gmk6NRjXunjEsoy/v0Ne7h2kaoYWSsLJiuFxvYgyuFQFp+V60MB91He
         vxVrwTdIarzCGwbRS5ktNFBD8G14wPUVXP5aS/aJhEX/O4ZWeY0z5tKQPGO/5R2IZH/p
         mAQA==
X-Gm-Message-State: APzg51D1cfHNCJgZJJK0+L9YgSARsfSJiiKuEzBoqrBhUwmRv8Gc5ZtO
        dLM0EgFLTr5mQDxvsscGqdROHyz12txUdo65O1wMMA==
X-Google-Smtp-Source: ANB0VdbtB5Cl72G1F2KRoy/KhSv1EQN/rOfZCfw8OiuHMBrWWenQptarfbU8+rIVyospx5/9tNsf7IqdVdAvGaahbsM=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr1938778itb.95.1536231983791;
 Thu, 06 Sep 2018 04:06:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:554:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 04:06:23 -0700 (PDT)
In-Reply-To: <20180906100543.GI3592@arm.com>
References: <cover.1535462971.git.andreyknvl@google.com> <20180905141032.b1ddaab53d1b2b3bada95415@linux-foundation.org>
 <20180906100543.GI3592@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 6 Sep 2018 13:06:23 +0200
Message-ID: <CAAeHK+wStsNwh2oKv-KCG4kx5538FuDMQ6Yw2X=sK5LPrw2DZg@mail.gmail.com>
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
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Sep 6, 2018 at 12:05 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Sep 05, 2018 at 02:10:32PM -0700, Andrew Morton wrote:
>> On Wed, 29 Aug 2018 13:35:04 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>>
>> > This patchset adds a new mode to KASAN [1], which is called KHWASAN
>> > (Kernel HardWare assisted Address SANitizer).
>>
>> We're at v6 and there are no reviewed-by's or acked-by's to be seen.
>> Is that a fair commentary on what has been happening, or have people
>> been remiss in sending and gathering such things?
>
> I still have concerns about the consequences of merging this as anything
> other than a debug option [1]. Unfortunately, merging it as a debug option
> defeats the whole point, so I think we need to spend more effort on developing
> tools that can help us to find and fix the subtle bugs which will arise from
> enabling tagged pointers in the kernel.

I totally don't mind calling it a debug option. Do I need to somehow
specify it somewhere?

Why does it defeat the point? The point is to ease KASAN-like testing
on devices with limited memory.
