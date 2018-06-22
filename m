Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F9AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8712323EDB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pav+RG8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8712323EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeFVIPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:15:41 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45596 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeFVIPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:15:21 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so2629934pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdGGzmNFwMQTK1h99xVYphZ/gyRnzF4BbgNbujmEW7w=;
        b=pav+RG8veXvk3rONzV36rcE8/C6MQm20+eNJ1dOXB++c6KW8JDEP4mLYz9fus+KZs7
         B0Ra61UlpljIslpKxWMDUoHy1RVHSjzQu22ZzokG6gEuAO0I06fhh3xPG4011qln8XeD
         SJpeGx7J/LcI58uBofoGYENZVYFQU51ckZKnudbCAWw6QSHq16klOG01QiqkZCAYV8jA
         acviJnetcP9v0DOxGZ7CPX4XI0tuYMN48L1VwDW6bjHW40inCuUvLOb6GVJGl7L7nhHF
         2bsFJAMaUuuEmRjwg2yu0OU6yT6ZdUYTGVrr0dg2yCLfOvJaNl21DBYqxaUfrB/O2IFC
         Fk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XdGGzmNFwMQTK1h99xVYphZ/gyRnzF4BbgNbujmEW7w=;
        b=RU5Vrk12XLreZeW+XsiqOGdZjsiNgm3BapjlATqk2YF3hYpYA7WePn7bH7MslouTGH
         Xz3Gb8F1vdJYBctRGKblN3dIYSCsVZFujUp+6ClE1sBB7vEoHxRnEofxH8Ar57K2hMwR
         C8rKdhZvr1LfDcRwepQdOxKyK21ZgGulP8iADWWd50OuXarc72wEgIkqdX2XF2U4O692
         tllGZOsphEzZtl3vFls+aI/wJJv1ctxPhVt7gj7AGHluLc6QuxfXgnYrO377WjqWarOq
         grpCoUSVI2Yg5TgyDeQkgzzC90o7eA6iqKNJ/ycndCRGgudGzrhpjSFNUxM3mjAJmeKM
         QxUA==
X-Gm-Message-State: APt69E3eKvXKBx3RZyPJNGGcuqPbaWM5xjkBVSVUQj9UY9YrvkDOtK4u
        5WSyfGo7f8Hd5dFKmDAcQMc=
X-Google-Smtp-Source: ADUXVKKmmF3YB0BnpjIfK2MAihW3VKvLoJP5S8ihbZVZZKKJL7FogYikKkpCQkmbTW0b03Mfkr8zDA==
X-Received: by 2002:a62:e117:: with SMTP id q23-v6mr662929pfh.75.1529655320885;
        Fri, 22 Jun 2018 01:15:20 -0700 (PDT)
Received: from toy ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id v26-v6sm10516004pfn.105.2018.06.22.01.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 01:15:20 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:15:11 +0800
From:   Jun Yao <yaojun8558363@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/1] arm64/mm: move
 {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata section
Message-ID: <20180622081511.GA11076@toy>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180620085755.20045-1-yaojun8558363@gmail.com>
 <20180620085755.20045-2-yaojun8558363@gmail.com>
 <CAKv+Gu8_=uTJFDXr0GpGMc=9WZ9tbz305CE6i=qbnqRB=suRVA@mail.gmail.com>
 <20180621025141.GB11276@toy>
 <CAKv+Gu_3Cfuq-qQuRHkYCB2uTPOK=KVeVh4OKmtu2MDYwfOtTA@mail.gmail.com>
 <70ebe6d7-0745-5606-ae89-8a7b2fb62008@arm.com>
 <CAKv+Gu-t5ErL89J=sxeVRYzDNrB1Ejdj+XOggAMWk-gY7ewsOg@mail.gmail.com>
 <67a238a8-e4db-6bf1-6da5-62ca9536191f@arm.com>
 <CAKv+Gu8=jxY0qfMk53L8p5+x8HoE1DRy7W_p42ji9omGBc6QSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8=jxY0qfMk53L8p5+x8HoE1DRy7W_p42ji9omGBc6QSA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, Jun 21, 2018 at 07:27:01PM +0200, Ard Biesheuvel wrote:
> On 21 June 2018 at 19:04, James Morse <james.morse@arm.com> wrote:
> > On 21/06/18 10:29, Ard Biesheuvel wrote:
> >> On 21 June 2018 at 10:59, James Morse <james.morse@arm.com> wrote:
> >>> On 21/06/18 07:39, Ard Biesheuvel wrote:
> >>>> On 21 June 2018 at 04:51, Jun Yao <yaojun8558363@gmail.com> wrote:
> >>>>> On Wed, Jun 20, 2018 at 12:09:49PM +0200, Ard Biesheuvel wrote:
> >>>>>> As for swapper_pg_dir, it would indeed be nice if we could keep those
> >>>>>> mappings read-only most of the time, but I'm not sure how useful this
> >>>>>> is if we apply it to the root level only.
> >>>>>
> >>>>> The purpose of it is to make 'KSMA' harder, where an single arbitrary
> >>>>> write is used to add a block mapping to the page-tables, giving the
> >>>>> attacker full access to kernel memory. That's why we just apply it to
> >>>>> the root level only. If the attacker can arbitrary write multiple times,
> >>>>> I think it's hard to defend.
> >>>>
> >>>> So the assumption is that the root level is more easy to find?
> >>>> Otherwise, I'm not sure I understand why being able to write a level 0
> >>>> entry is so harmful, given that we don't have block mappings at that
> >>>> level.
> >>>
> >>> I think this thing assumes 3-level page tables with 39bit VA.
> >
> >> The attack, you mean? Because this code is unlikely to build with that
> >> configuration, given that __pgd_populate() BUILD_BUG()s in that case.
> >
> > Yes, the attack. (I struggle to think of it as an 'attack' because you already
> > have arbitrary write...)
> >
> 
> OK, so in that case, you can abuse your single arbitrary write to map
> an entire 1 GB block of memory with arbitrary permissions, allowing
> userland to take control of the contents, right? And if you know the
> virtual and physical addresses of swapper_pg_dir, you can make sure
> this block covers the entire kernel, allowing the attacker to
> manipulate all core kernel code and statically allocated data
> structures.
> 
> What I don't understand about this patch is how it is sufficient to
> only remap swapper_pg_dir r/w for updates on kernels that use 4 level
> paging.
> 

Sorry, It's my mistake.

To my best knowledge, to defend 'KSMA', we need to handle these
configurations:

1. ARM64_4K_PAGES && ARM64_VA_BITS_39 (PGTABLE_LEVELS = 3, 1GB block)
2. ARM64_16K_PAGES && ARM64_VA_BITS_36 (PGTABLE_LEVELS = 2, 32MB block)
3. ARM64_64K_PAGES && ARM64_VA_BITS_42 (PGTABLE_LEVELS = 2, 512MB block)

If these configurations are selected, we move {idmap_pg_dir,
tramp_pg_dir, reserved_ttbr0, swapper_pg_dir} to .rodata section(avoid
modifying tramp_(un)map_kernel), and remap swapper_pg_dir r/w for updates.
If these configurations are not selected, we just keep them as they are.

Do you think this is okay?
