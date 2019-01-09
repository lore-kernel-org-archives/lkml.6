Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AFFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBFC206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib67pvNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfAICox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:44:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35111 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfAICox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:44:53 -0500
Received: by mail-io1-f68.google.com with SMTP id f4so4893487ion.2;
        Tue, 08 Jan 2019 18:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRjulQIsmhIGP7n7waI04kAZq8TswAP7nqzQMoRdwOg=;
        b=Ib67pvNzAWRMavjYxxRZiWI8wAj9PJg4lW9AYTwWN+8zVTjcgHjFdI5EGwP+ORrw7v
         UuDRVr9EXgTpfSZmoNih4yTyfC8fBZMmQusb41TCvssZug4zcmruSgiMdNvJd4ZiPFJ4
         c8aNkvayB9Jt8i4+5zBEbP/HY1uEDYZe/Dxy7KpSZBhUv627l/j1BiYb7kaCeoua+Phm
         QykXIi4OVZkNcxGIwgcuZrdr8AAGBUlxi1EhZ4p8tK5eqVAPX9YMhp4VaGJm3RXmBXEg
         3SZIbcz6DFgXwO44bDu0MAGKl44Q6y+BkBzCCy2dLaqnr8AbEph7OPUNM95jorRZTV5c
         mRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRjulQIsmhIGP7n7waI04kAZq8TswAP7nqzQMoRdwOg=;
        b=FKCzfI/jfkuWPsye/po6NqFok0sTg0sQWWnBcNTm4S6rfZ0xYr5rxsZwPJR2+uata4
         6REi4Lkvrb4TCGPkFOgP9JSdQIfquuPpUv0JpytCdBX16S+wX7uPifXgOoW/SI/2vawJ
         0Jr9yvf9zmZfHAXt64UBvCiFhpBcDE4QnlKl0NRzWI4DAAn6R9Wtl0RcLX+xNGa7NHUc
         0JdYfNyJZS/GJWkeLdm1rjamyEkWbtKXcXRu1WuUCYWpiQhwtPXE7r5XVfnKZgcKaCWh
         hlXBDXaMM4lf2649Wd5vrJZgJiB0iAVx1KIUZ+IXgjbmKhQOnAmB3x3C9alV+QLB6EhZ
         6ilw==
X-Gm-Message-State: AJcUukeC553z+KhDB2NQV8iuBS1FpU4eMxMlD7JBIRRxV1wueOkInYzK
        I4gY97g7tC2nvf10fEbNb/Tb5xWNe9fsDeDLDQ==
X-Google-Smtp-Source: ALg8bN4b72n0sJ5ocPz7l0hM6o/8Vn/YxLcuT8Hywu+t6tL9JwxsScrwLSH3R2no11CYXctXZzeo3URyxtM8O0F0+UE=
X-Received: by 2002:a6b:39c6:: with SMTP id g189mr2561261ioa.255.1547001892684;
 Tue, 08 Jan 2019 18:44:52 -0800 (PST)
MIME-Version: 1.0
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
 <1546849485-27933-5-git-send-email-kernelfans@gmail.com> <57ca63ef-ac5b-edd7-710b-f7ee698207c9@intel.com>
 <CAFgQCTudfQDAzKGYLAo_TuoEaEExzGn018mRewQ_LZvZbVDU+A@mail.gmail.com> <7706aaac-c00b-8a11-a7a1-cb95b5a01581@intel.com>
In-Reply-To: <7706aaac-c00b-8a11-a7a1-cb95b5a01581@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 9 Jan 2019 10:44:41 +0800
Message-ID: <CAFgQCTtaNteN37hpDOmjR7Cjoqaza0suxE9EOfdpDW3DbAsrcw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] x86/mm: remove bottom-up allocation style for x86_64
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:33 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/7/19 10:13 PM, Pingfan Liu wrote:
> > On Tue, Jan 8, 2019 at 1:42 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >> Why is this 0x100000 open-coded?  Why is this needed *now*?
> >>
> >
> > Memory under 1MB should be used by BIOS. For x86_64, after
> > e820__memblock_setup(), the memblock allocator has already been ready
> > to work. But there are two factors to in order to
> > set_alloc_range(0x100000, end). The major one is to be compatible with
> > x86_32, please refer to alloc_low_pages->memblock_find_in_range() uses
> > [min_pfn_mapped, max_pfn_mapped] to limit the range, which is ready to
> > be allocated from. The minor one is to prevent unexpected allocation
> > from memblock allocator through allow_low_pages() at very early stage.
>
> Wow, that's a ton of critical information which was neither commented
> upon or referenced in the changelog.  Can you fix this up in the next
> version, please?

Sure.

Thanks,
Pingfan
