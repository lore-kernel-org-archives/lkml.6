Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC2DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67892081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GecJQaPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67892081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbeKHAmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:42:23 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:51112 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeKHAmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:42:22 -0500
Received: by mail-it1-f194.google.com with SMTP id k206-v6so23315594ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gSaho8qIaLLkIJAcf1Eztz8xA4nVJAZfCUbb2rWlRZg=;
        b=GecJQaPByED/rwO2pbLIzqWjDjp9TZYHw5ZtpvYkqu4vN9B0NSOZSPRFPRF59AnTjP
         OI54EddeN1XnPFKKNNNe2neZtGTjQLrXkj9z3/KsjuPp52N5Z+qumgCXbFR7c7FWxyoN
         cy4rL/b1BnyMmKOkDch6yRCpLCl/HIv3j4w7PWHaCI+144o1Cznoe8AalGzFs+WtoYer
         bxWb4j8KIWe2ZUxOGJwjcCmfyi3/75E8eBm9TDyBhxZhdYtBz76qNcvfO4fmWSF5elWC
         IlxJYanmyv2rJP3TTv114ZNAwTBaE2mO81NLkAnmGTqGTYnW15qgs1ZHJrO8Ftq7raP+
         4zDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gSaho8qIaLLkIJAcf1Eztz8xA4nVJAZfCUbb2rWlRZg=;
        b=iXsxT+is3gT0W5tmauk6v2T4LORO5WR9v6XY9Z01C2cn0w2nqZalfiu7TJdRNZ8FwJ
         cGIwMys5E92nxtOqgfIZa91G6p8i703S1GQB3zgoZgBSbNrSvHi2omBCD/fTw+2h3SZP
         UnVUuJWX+FgW+TNst/LbnKYEFAsBWMjhRWdkzh/lNCfNjwGJVkmszSGkqW7HEaL85TMX
         ENUjnip8oAjh7O0NrxUmQkiZVJY2wa9jN+8eCs1O0mC0fe+YklGSvaJCiVeDrd1c/i6J
         XL/posH6/fcRRoRvT810aRyHXB4MUzMI/fSemT7VSYGf5f1/pRcNvQSgSTtiQxJX4OCO
         dDog==
X-Gm-Message-State: AGRZ1gIDv61HDxTcO6XX9MmKnYEjd2QblukbeuTnHUMXo+UJ3d2xqZ34
        nE3EPI/Mkas5g2cscntjMc8h6dvN4D5Ls6M73DDaCQ==
X-Google-Smtp-Source: AJdET5cc9hEkTiDH0SiNzeHJYMfVQRFSBHTdyQiNuOemZl3ds2+2P/SoAYGAEU7ghh/nN8XSVI89mNHwRxgW7RZ+Y2Y=
X-Received: by 2002:a24:dac7:: with SMTP id z190-v6mr471675itg.87.1541603496061;
 Wed, 07 Nov 2018 07:11:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:1846:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 07:11:35 -0800 (PST)
In-Reply-To: <20181107145922.GD2623@brain-police>
References: <cover.1541525354.git.andreyknvl@google.com> <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
 <20181107145922.GD2623@brain-police>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Nov 2018 16:11:35 +0100
Message-ID: <CAAeHK+zNgv9WxRpf7N3gmsLYGL6oUALAnyerMzeYZUz1LhoUuA@mail.gmail.com>
Subject: Re: [PATCH v10 00/22] kasan: add software tag-based mode for arm64
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
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
        kasan-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 3:59 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Nov 07, 2018 at 03:56:03PM +0100, Andrey Konovalov wrote:
>> On Tue, Nov 6, 2018 at 6:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> > This patchset adds a new software tag-based mode to KASAN [1].
>> > (Initially this mode was called KHWASAN, but it got renamed,
>> >  see the naming rationale at the end of this section).
>>
>> [...]
>>
>> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>
>> Hi Andrew,
>>
>> This patchset has now been reviewed-by KASAN maintainers. Could you
>> take a look and consider taking this into the -mm tree?
>
> I would much prefer to take the arm64 parts (which still need to be reviewed
> by Catalin afaict) via the arm64 tree, so please can you split those out
> separately?

Which parts do you mean exactly, which patches? I don't think it makes
sense to split this patchset, as one part won't function without the
other.
