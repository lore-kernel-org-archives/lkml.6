Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0556DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A249321522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7fQIHpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A249321522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbeISXGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:06:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32791 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbeISXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:06:49 -0400
Received: by mail-it0-f68.google.com with SMTP id j198-v6so17801525ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zAosuzFSpruYcMp8zUqTs2t8IQKgTVloTJphmeIs/9o=;
        b=R7fQIHpdaDdk17IrN2krX5/Em5oNcRlfDMSVm5KpaRumV8yQFydW+obAcKAzL0yHkn
         mTcfyY9y4guxIn+XZAYU9k/jS/Bv2zpNlRpy0jhfIfW6E34qizowW1LOwfH7aVuIyU2o
         0rWuSIb3s40GrBTvzdC+YbUTQBst9nWsY9Tyzc9KqAHBDCVDmBGb+IMbbRBQKFayAlQu
         PCWaK3dqdPcKjL047OXFJmB9wstf6MWp28nXp/Pom4tkQQZkM4yrh3Wiq2ov4+7qrvHw
         MXtJ3uaN+T1cSdq9jXtC4LO6oB95GToAbpis2eQNXIo4JPyMRRT/GtZuK68elS7Ix0+s
         aArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zAosuzFSpruYcMp8zUqTs2t8IQKgTVloTJphmeIs/9o=;
        b=KYzlBmKWz+QWNsNaw3AIlzWE2NARnBbtmShGgF4EYxt3GtvRZWWV0Cv8SpKKsz7sVN
         ZeQd7maprNHpAFYqd6JS6equj4DhuIrD4sLqNCxbfRcrSXB1pTIsT6B0r7rc3NhlJ2kt
         4tNAVW5xonzqF5el06svqfadxfibh8797gx1s4+u1h5sQZ50So6jlE2xahRJ6KeX5kCJ
         RzG6ZW7V7PQJeZZLmSeAne4GjYHlwGZhp75o80xm31hIj4ZFaCT2wZSY5j1V7iikK6A/
         uxRuzv0/8TKvgCdG2bg7BlKupTxLotErK1K3DwpN7ake8HBE67RDavNj3pbGmJ95P7Mv
         Aimg==
X-Gm-Message-State: APzg51ASyg8YO/T8Yig2VcYVXsWT1iRUHVLYaqDkBQyxZmmUPtDha2WR
        mYu7tcT8h319NmemKi1hQZ86TVhqNigiA/719Xk2lA==
X-Google-Smtp-Source: ANB0VdYbecamHVnbOHoY535blocy3fTBUCqVTTqorA+jTUDqqll4w3qD3zZeO0T2FxugUdGpzhYVttXIF/5W3W/MOyw=
X-Received: by 2002:a24:5f92:: with SMTP id r140-v6mr21149663itb.95.1537378073201;
 Wed, 19 Sep 2018 10:27:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:c54e:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 10:27:52
 -0700 (PDT)
In-Reply-To: <CACT4Y+Z4zLSBdXGtk-6nH64UpOVA8s5TJZSpokAqEu4pE8LpCA@mail.gmail.com>
References: <cover.1535462971.git.andreyknvl@google.com> <b4ba65afa55f2fdfd2856fb03c5aba99c7a8bdd7.1535462971.git.andreyknvl@google.com>
 <CACT4Y+Z4zLSBdXGtk-6nH64UpOVA8s5TJZSpokAqEu4pE8LpCA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 19 Sep 2018 19:27:52 +0200
Message-ID: <CAAeHK+ySaS_jUe_wNQ192kE4bUgZUOMdSyQeRp5Tx2nCD41vBQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/18] khwasan, arm64: adjust shadow size for CONFIG_KASAN_HW
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

On Wed, Sep 12, 2018 at 4:54 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Wed, Aug 29, 2018 at 1:35 PM, Andrey Konovalov <andreyknvl@google.com> wrote:

>>  /*
>> - * KASAN requires 1/8th of the kernel virtual address space for the shadow
>> - * region. KASAN can bloat the stack significantly, so double the (minimum)
>> - * stack size when KASAN is in use.
>> + * KASAN and KHWASAN require 1/8th and 1/16th of the kernel virtual address
>
>
> I am somewhat confused by the terminology.
> "KASAN" is not actually "CONFIG_KASAN" below, it is actually
> "CONFIG_KASAN_GENERIC". While "KHWASAN" translates to "KASAN_HW" few
> lines later.
> I think we need some consistent terminology for comments and config
> names until it's too late.
>

As per offline discussion will rename in v7.
