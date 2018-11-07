Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F087C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7132086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bim5TCzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7132086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeKHBZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:25:03 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46634 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731003AbeKHBZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:25:03 -0500
Received: by mail-io1-f65.google.com with SMTP id y22-v6so12202770ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r0hsUc/Y3dg24sUOd7ZU4XXfNPD3yxr0cD2ixuSzCTk=;
        b=bim5TCzioM6nFCP6fgSo1w9HlhHshXAy/IVqr91YnmvXKhGLLiqwa2lf2V9qiMsFxl
         sRsVyp8NYKPvXAfHbCTuNYa+Od1eRQEO0PQccmJa6GayE91A4wTaL1cFCab+vRljbmQS
         onOKhXJmTW6Rhti4bbKDwODeH5N45z6tyImb1346ZA05eDy6ha0pwuVaRrFxpFd0Krx9
         stoPbTmiaTvmx7L+2wkGAxatNSl9qBquiy4NS+isOE5NbqXXIaXPNfg1gmiQfQcPaztf
         fzPWahXT+zHpF5HBk0+oBreyz8zlhyKh57qvoymVLXJbZYKgnEUnnMzPCH/G0GpcI5+o
         gZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r0hsUc/Y3dg24sUOd7ZU4XXfNPD3yxr0cD2ixuSzCTk=;
        b=KZx/tVOj/3dIlfiK3+b1eJlkZ0r0g1S3PQ+DBB1SdQfZU6PJtf0NRynJPCSaq4PY9X
         kiAU/FDsfvJ9eTsLz318H8xQPSWKE6LXiCJnIzxw0kmLWyADCH9yNZ3M/XQ+/Qy6fI+T
         vtCht9QPTkA/lo+boWsQF8wlr3W2/GjuFX3MQTfwpZ8zW85fjByzyMx9UnDRc3/cYp7p
         NoWAuPr/y09WZ13FSrpUuPIc6ONhLQNX7x2sQitrU1+cu/L9rrVeX8RZCY3RNKLU3IDm
         kx+vOJsOoIJCQogRYUOgIvosZ/nZ4cFNxFLme3jvVlaFeuVynK4jzFr+L2wHWIiMJEab
         3SaA==
X-Gm-Message-State: AGRZ1gLYymZyLwMrlIqsveHH6of3dr2ug/xHeUusaCymxR1E/lh/+7IR
        TvmzJR5EKzyKHnbEVXuAQ0Er82t44CGOnXyRnSRyMA==
X-Google-Smtp-Source: AJdET5froMxZ4TaaLQ5afnq6CVknCjJ+UbwtBGo0zabMdOg7g+8s5Q63Bz3taexy+gjAZepqZFkd73P2HcUDmNLi9wA=
X-Received: by 2002:a6b:c60e:: with SMTP id w14-v6mr628492iof.192.1541606046522;
 Wed, 07 Nov 2018 07:54:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:1846:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 07:54:05 -0800 (PST)
In-Reply-To: <20181107153456.GE2623@brain-police>
References: <cover.1541525354.git.andreyknvl@google.com> <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
 <20181107145922.GD2623@brain-police> <CAAeHK+zNgv9WxRpf7N3gmsLYGL6oUALAnyerMzeYZUz1LhoUuA@mail.gmail.com>
 <20181107153456.GE2623@brain-police>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 7 Nov 2018 16:54:05 +0100
Message-ID: <CAAeHK+zupkT2s8o3p7GmxLn2N7idJihBG=asuEBF6v6TheGo_A@mail.gmail.com>
Subject: Re: [PATCH v10 00/22] kasan: add software tag-based mode for arm64
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
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

On Wed, Nov 7, 2018 at 4:34 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Nov 07, 2018 at 04:11:35PM +0100, Andrey Konovalov wrote:
>> On Wed, Nov 7, 2018 at 3:59 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Wed, Nov 07, 2018 at 03:56:03PM +0100, Andrey Konovalov wrote:
>> >> On Tue, Nov 6, 2018 at 6:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> >> > This patchset adds a new software tag-based mode to KASAN [1].
>> >> > (Initially this mode was called KHWASAN, but it got renamed,
>> >> >  see the naming rationale at the end of this section).
>> >>
>> >> [...]
>> >>
>> >> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> >> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> >> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>> >>
>> >> Hi Andrew,
>> >>
>> >> This patchset has now been reviewed-by KASAN maintainers. Could you
>> >> take a look and consider taking this into the -mm tree?
>> >
>> > I would much prefer to take the arm64 parts (which still need to be reviewed
>> > by Catalin afaict) via the arm64 tree, so please can you split those out
>> > separately?
>>
>> Which parts do you mean exactly, which patches? I don't think it makes
>> sense to split this patchset, as one part won't function without the
>> other.
>
> I would like the patches that touch code under arch/arm64/ to be reviewed by
> somebody from the arm64 community. Since the core parts have already been
> reviewed, I was suggesting that you could split them out so that they are
> not blocked by the architecture code. Is it not possible to preserve the
> existing KASAN behaviour for arm64 with the core parts merged? I figured it
> must be, since you're not touching any other architectures here and they
> assumedly continue to function correctly.
>
> However, if you'd rather keep everything together, please can we give it a
> couple of weeks so we can at least get the architecture bits reviewed? Most
> people are out at LPC next week (and I'm at another conference this week).
>
> Will
