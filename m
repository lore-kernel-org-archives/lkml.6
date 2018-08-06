Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1323C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4521A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1NGZ7La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B4521A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbeHFVX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:23:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43474 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHFVX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:23:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id f135-v6so9843254lfg.10;
        Mon, 06 Aug 2018 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MCqkddW20BiM+UXWc3srSpNPGW/CfsKtquCEeX/I6og=;
        b=R1NGZ7LaN5vAAszy4D8smq6JE5y4+9m5oBxZi+HYmlTUBI/o4cQAakYf/4gBIZmlp+
         17FjW1B7xbyutLxwl3bSocKdQ2s44z4t3/4P0BfVOhOKG7Xr37XiCca87OYvMi/mRvXD
         hHYz0jNW5Zc8iDuXc0gID1fAbcJQIXAVr2YlMHMjANFCw218S6R9kBhb2m7Smv/3f0TK
         UlNJB7lq3wHyNIWteus6lVlicldL7b5SttCsF/T25G7AHkgYPsCKg3CXxil66yF0S20q
         DlCqwMTYhHqZbkrF57YcKX8DzaRb2cvhEBB511eZM+7BAV24ts3ubWfZSkMWl2zMa12G
         OVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MCqkddW20BiM+UXWc3srSpNPGW/CfsKtquCEeX/I6og=;
        b=BEGcZiDKkBB3iRRvUpx7mx/mGCR5eyUhq91AcEQmHDinMQN/2SMOoq3vSCXApIebjw
         mjjTw7QTzPMl76gC/vlC+SnGbwoq3LjiSn1aAt9YmBvQ4E8hNQf8SGpv79XFwySyEiBf
         MzXyHwlVPOOe37uU/dnrfNGj4RGzOWi0q/T5V4eLxr1VnBHTxVCXpbn2lu+dTvdjWZX0
         WGp00x/LrpPxV0+fY2X/R8mJurgdzIHpltp4iAbZYG8Z0t/zXoNUvF7bp8gHlHlvezQt
         e21J80XoOhSSWp1rC/Gfsy/bQGltVCDMkgom6rULm96blMEPHxg72Li2jl/xIL9YUpB9
         z0ZQ==
X-Gm-Message-State: AOUpUlF2m4MxNF+pB765LBLJVOrP45tiRWA/+OaM1dIcG9rdEuS1DkI9
        tN+ncuJ0EIny2ui8JeINnVsAZJgHJC8PTCQIU7o=
X-Google-Smtp-Source: AAOMgpcpW6yvubcxgpf0DoKTKBOB3ZhfpIz/8Tte2EL314Y/0ilGkiMkIHDGn/EITURIveULKaz/8AW0U5mkhi2xuKI=
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr12751973lfe.148.1533582774647;
 Mon, 06 Aug 2018 12:12:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:108f:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 12:12:53 -0700 (PDT)
In-Reply-To: <20180803150945.GC9297@kroah.com>
References: <cover.1529507994.git.andreyknvl@google.com> <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <CAAeHK+wJbbCZd+-X=9oeJgsqQJiq8h+Aagz3SQMPaAzCD+pvFw@mail.gmail.com>
 <CAAeHK+yWF05XoU+0iuJoXAL3cWgdtxbeLoBz169yP12W4LkcQw@mail.gmail.com>
 <20180801174256.5mbyf33eszml4nmu@armageddon.cambridge.arm.com>
 <CAAeHK+zb7vcehuX9=oxLUJVJr1ZcgmRTODQz7wsPy+rJb=3kbQ@mail.gmail.com>
 <CAAeHK+xTxPhfbVTNxcbsx7VdwQ21Bt-vo2ZU1tEM1_JX7uKnng@mail.gmail.com> <20180803150945.GC9297@kroah.com>
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Mon, 6 Aug 2018 21:12:53 +0200
X-Google-Sender-Auth: Bnb4bh24P_Z-3CdvbYtH75v_C4s
Message-ID: <CAExDi1T=s1ASPz6wMbV-G+Wiq8u9zu9cFztaCQ1kDy_TDQkXvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        linux-kselftest@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 5:09 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Aug 03, 2018 at 04:59:18PM +0200, Andrey Konovalov wrote:
>> On Thu, Aug 2, 2018 at 5:00 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> > On Wed, Aug 1, 2018 at 7:42 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> On Mon, Jul 16, 2018 at 01:25:59PM +0200, Andrey Konovalov wrote:
>> >>> On Thu, Jun 28, 2018 at 9:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> >>> So the checker reports ~100 different places where a __user pointer
>> >>> being casted. I've looked through them and found 3 places where we
>> >>> need to add untagging. Source code lines below come from 4.18-rc2+
>> >>> (6f0d349d).
>> >> [...]
>> >>> I'll add the 3 patches with fixes to v5 of this patchset.
>> >>
>> >> Thanks for investigating. You can fix those three places in your code
>> >
>> > OK, will do.
>> >
>> >> but I was rather looking for a way to check such casting in the future
>> >> for newly added code. While for the khwasan we can assume it's a debug
>> >> option, the tagged user pointers are ABI and we need to keep it stable.
>> >>
>> >> We could we actually add some macros for explicit conversion between
>> >> __user ptr and long and silence the warning there (I guess this would
>> >> work better for sparse). We can then detect new ptr to long casts as
>> >> they appear. I just hope that's not too intrusive.
>> >>
>> >> (I haven't tried the sparse patch yet, hopefully sometime this week)
>> >
>> > Haven't look at that sparse patch yet myself, but sounds doable.
>> > Should these macros go into this patchset or should they go
>> > separately?
>>
>> Started looking at this. When I run sparse with default checks enabled
>> (make C=1) I get countless warnings. Does anybody actually use it?
>
> Try using a more up-to-date version of sparse.  Odds are you are using
> an old one, there is a newer version in a different branch on kernel.org
> somewhere...
>
> greg k-h
>

Quoting Linus in [1]:

Honestly, I'd like to just encourage people to get the sparse update
from Luc Van Oostenryck instead.

For a while there it looked like Chris Li would just pull from Luc,
and we'd have timely releases, but that really doesn't seem to have
ended up happening after all. So right now it's probably just best to
get Luc's tree instead from

    https://github.com/lucvoo/sparse-dev

which also ends up fixing a lot of other issues.

[1] https://lore.kernel.org/lkml/CA+55aFzYEnZR2GZLR-DwpONjMNYGYoDy+6AWLCVNayWiaZuqoA@mail.gmail.com/T/#u
