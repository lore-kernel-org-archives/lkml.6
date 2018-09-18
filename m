Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFCBC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EF42150E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0uNsreN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EF42150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeIRWmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:42:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50185 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbeIRWmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:42:54 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so4338180ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pUKdOE3Y16h6545zaISUxKO9AusnuLo4zm5dn+P7adE=;
        b=C0uNsreNAMljFxjNIys+dCasy4mqL6VgTLuydxYwxb066BXxAiZscXj+AFbzomIbsu
         m9bczDEEE07ZNmYj7GaHnzYEFZeeM6qeilHPnkzNq8KqMnNJNLHC0VzsfFmmjoQaECiE
         UtUk2GB0FyHFvKKYGwfqbJrEKZk9HqNH0Owbt3tqGua2TplKRrGSBwv7S5HSd+TeE8DR
         EjaiDgQiNvKyemuiH1P5sf7KPRWW+qqOTzgMBuofUd6yLZ3o43Hs8QWmsdIw1tkUa+J1
         kmZ4gbgLZxW7JiBmONHre5OPejBQPX4GjwTrxaOvZW51atc7sjTMGP2dfPV7CoyjNzr2
         JRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pUKdOE3Y16h6545zaISUxKO9AusnuLo4zm5dn+P7adE=;
        b=q994gbdgTigwPAZFxKo110cqNXYSnTzKbndNICTgAKSafZ679eVBjQ5AZ6GC28Nzr+
         6WyheAmhoAsc686PWA/ouMBq3dQy2cmHgBEg0gHH8ZnhRMqkCQkwsYwjo/scbw8DgaPe
         czBzbJRsaQy3ptfSNuczizbGnyJ2W8x9fYslZ1oi5kDZwTL/CzcqUUPT5Y0g2gggYYGG
         gAuPFHgSQCXiRFYybLrlrLdLIRvi7NlC5a1jMDi9JkN+ErQ19sSs+4/eAb9LjdoBiDUZ
         ix6duRX3rgHWAtKwNXLhk2TUxj+UFMk1eTSCr9iIPU/16s0bdylOdu3FQ41y49BE5a/n
         Gffg==
X-Gm-Message-State: APzg51CrVhCzUp2KlzVB5+bkU9rdJVc1+kpqpAO4Od4TGZh3ElEnai3K
        TAKNNSD6mxdY2kXDRd7MvP+87K65ytZ6lyo3am547A==
X-Google-Smtp-Source: ANB0VdYVAEeWxZzFwgNruJ8fgTBcMGjdKxGatm1f24qFQHg4mPHEPk93xmFXw+rRSvSQp/4IthRz1nC0MUZEng8uj8E=
X-Received: by 2002:a02:9962:: with SMTP id d31-v6mr28144620jak.1.1537290562857;
 Tue, 18 Sep 2018 10:09:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 10:09:22
 -0700 (PDT)
In-Reply-To: <CACT4Y+aJ36LGLG=TVOGQoJ+fB4Xc9CjdxAs8KZpUm3AsNEoHFw@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <19d757c2cafc277f0143a8ac34e179061f3487f5.1535462971.git.andreyknvl@google.com>
 <CACT4Y+aJ36LGLG=TVOGQoJ+fB4Xc9CjdxAs8KZpUm3AsNEoHFw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 18 Sep 2018 19:09:22 +0200
Message-ID: <CAAeHK+xBX4X0oxhjOrjJfwdqcvU80VPhUsi38mEczzHRb01Wew@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] khwasan, arm64: untag virt address in
 __kimg_to_phys and _virt_addr_is_linear
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-sparse@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
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

On Wed, Sep 12, 2018 at 6:33 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>> +#ifdef CONFIG_KASAN_HW
>> +#define KASAN_TAG_SHIFTED(tag)         ((unsigned long)(tag) << 56)
>> +#define KASAN_SET_TAG(addr, tag)       (((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
>> +                                               KASAN_TAG_SHIFTED(tag))
>> +#define KASAN_RESET_TAG(addr)          KASAN_SET_TAG(addr, 0xff)
>> +#endif
>> +
>
>
> Wouldn't it be better to
> #define KASAN_RESET_TAG(addr) addr
> when CONFIG_KASAN_HW is not enabled, and then not duplicate the macros
> below? That's what we do in kasan.h for all hooks.
> I see that a subsequent patch duplicates yet another macro in this
> file. While we could use:
>
> #define __kimg_to_phys(addr)   (KASAN_RESET_TAG(addr) - kimage_voffset)
>
> with and without kasan. Duplicating them increases risk that somebody
> will change only the non-kasan version but forget kasan version.

Will do in v7.
