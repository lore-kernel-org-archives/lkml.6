Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934598AbeEIJQS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:16:18 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36543 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934203AbeEIJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:16:16 -0400
X-Google-Smtp-Source: AB8JxZoUROh45iLiACHk+kdbS1TY0s+6VmoTR1LgLZDF8A5mhvrZ8GxO9I2H3HGvgJOpvpFgp8gT9/3S/f8dH8hfrvw=
MIME-Version: 1.0
References: <20180508162829.7729-1-glider@google.com> <20180508214445.lnqbct6dgrhyxp4a@black.fi.intel.com>
In-Reply-To: <20180508214445.lnqbct6dgrhyxp4a@black.fi.intel.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 09 May 2018 09:16:03 +0000
Message-ID: <CAG_fn=UrQw4qRofUgHb4A_j4hbuefSwGtFMfCtYS318HWXFSFA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot/64/clang: Use fixup_pointer() to access '__supported_pte_mask'
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: dave.hansen@linux.intel.com, Ingo Molnar <mingo@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitriy Vyukov <dvyukov@google.com>, Michael Davidson <md@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w499GMG0025221

On Tue, May 8, 2018 at 11:44 PM Kirill A. Shutemov <
kirill.shutemov@linux.intel.com> wrote:

> On Tue, May 08, 2018 at 04:28:29PM +0000, Alexander Potapenko wrote:
> > @@ -196,7 +204,8 @@ unsigned long __head __startup_64(unsigned long
physaddr,
> >
> >       pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
> >       /* Filter out unsupported __PAGE_KERNEL_* bits: */
> > -     pmd_entry &= __supported_pte_mask;
> > +     mask_ptr = (pteval_t *)fixup_pointer(&__supported_pte_mask,
physaddr);

> Do we really need the cast here?
Correct, we do not.

> --
>   Kirill A. Shutemov



-- 
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Straße, 33
80636 München

Geschäftsführer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
