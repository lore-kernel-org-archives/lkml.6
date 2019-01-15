Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7819AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4F820578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeOEIrMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfAOHGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:06:23 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51518 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfAOHGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:06:23 -0500
Received: by mail-it1-f195.google.com with SMTP id w18so3572928ite.1;
        Mon, 14 Jan 2019 23:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBxTO+ik6S90VjvwhhQyOAyNkKinjn9P/JvduBA/t5Y=;
        b=jeOEIrMpgXi3/B7EW3lgvfCoRqTBFVzmSrBIFt2tpkk7CsLQC3esSVpvE24X0hK4uB
         osXXGM7O5q6Yu2NWuL6D/ZZ77ErZREpHtlOsSYWeisH5EGVdQ4CXm96ZKK54ibyXBy5N
         MPwG4FR9UT821u6+5z+QP70w3L7rtVYdT5LrwkWNMYeSKkH/lRplKQA2yfk2m9lhU/qk
         zGoOpERnzuOf9XOAkLe9KQGPCuOd98lgGz0Jb6mQQRW9Ot54eyTc5J2t01YluhmiVns5
         gUIE+OUsCABCvScUTdpBOaV2mqvTn1b5w4P7TMu9mrbacZReD2PS2NHVofzR58dR/MlV
         Dp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBxTO+ik6S90VjvwhhQyOAyNkKinjn9P/JvduBA/t5Y=;
        b=CvSG1i/1BxqsQvibIjJY2Zz6Y7u2ogCq9l2fooqtylJa9GlUT9VPxb5yCNJERjJEjI
         5UxE2YehzMHXT1NqUUWslw9ztR7vL1qjKfQIppbfvg0D58V/jWmUcn6nBTvnTPHI8BmB
         mkiLK5jeBSMELwCfgn9a61P6kGtAgMFioNVM983BTxUct/lESp64Xi8dByMqb4ID8RfB
         NRFaSMQZ/DSd22G/k4XdYPfW2CudRavQ57odwLeV+/zXhRasfJpLTOw6ORWh0V2hIK5Q
         dZSIoRzhvPkfDbafkdpJoMt1LiX/cEsiFiGUbPaD8fbCg/RzTRixqDlwmYk+8AQyF+1c
         lTZA==
X-Gm-Message-State: AJcUukfxuWpQFlI4IqWNfo2KOPek15VjqgbzlN0umUhHDahD5lv2p7fd
        yIEXPTlHYapPgZKTqogBUX6RXJM5pCn+WKtsUg==
X-Google-Smtp-Source: ALg8bN6nciu4jZVlb6o0NjOSQGyRSzWVuL2vBfcarEjVevsygaYd+FFSzu/F/XJJlih/Jj0QBVK449+HgxJ5/dlokAQ=
X-Received: by 2002:a24:3282:: with SMTP id j124mr1700100ita.173.1547535982120;
 Mon, 14 Jan 2019 23:06:22 -0800 (PST)
MIME-Version: 1.0
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-2-git-send-email-kernelfans@gmail.com> <96233c0c-940d-8d7c-b3be-d8863c026996@intel.com>
In-Reply-To: <96233c0c-940d-8d7c-b3be-d8863c026996@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 15 Jan 2019 15:06:10 +0800
Message-ID: <CAFgQCTsV13JSH_S2kSQGeUa3K0s_n4LeGqhrHwBEW9DWeCWgcA@mail.gmail.com>
Subject: Re: [PATCHv2 1/7] x86/mm: concentrate the code to memblock allocator enabled
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 7:07 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/10/19 9:12 PM, Pingfan Liu wrote:
> > This patch identifies the point where memblock alloc start. It has no
> > functional.
>
> It has no functional ... what?  Effects?
>
During re-organize the code, it takes me a long time to figure out why
memblock_set_bottom_up(true) is added here, and how far can it be
deferred. And finally, I realize that it only takes effect after
e820__memblock_setup(), the point where memblock allocator can work.
So I concentrate the related code, and hope this patch can classify
this truth.

> > -     memblock_set_current_limit(ISA_END_ADDRESS);
> > -     e820__memblock_setup();
> > -
> >       reserve_bios_regions();
> >
> >       if (efi_enabled(EFI_MEMMAP)) {
> > @@ -1113,6 +1087,8 @@ void __init setup_arch(char **cmdline_p)
> >               efi_reserve_boot_services();
> >       }
> >
> > +     memblock_set_current_limit(0, ISA_END_ADDRESS, false);
> > +     e820__memblock_setup();
>
> It looks like you changed the arguments passed to
> memblock_set_current_limit().  How can this even compile?  Did you mean
> that this patch is not functional?
>
Sorry that during rebasing, merge trivial fix by mistake. I will build
against each patch.

Best regards,
Pingfan
