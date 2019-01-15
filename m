Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDC2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4EB20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 07:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTLHNNJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfAOH2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 02:28:32 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38490 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfAOH2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 02:28:32 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so3119450ith.3;
        Mon, 14 Jan 2019 23:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti0B2+GOH1sUCCI3lKmEIHaxROwkZe+iQSCsCALUxmw=;
        b=iTLHNNJpov1e6c5j8dhFlI+XgtoGgIqdyCEc4w6GCepOHFHUsg5pNNpynFwlwvb8H7
         mCvbJ97rjNZSKJFNK0vyZoldc8/zD/kqIBjNz21JZ/WIPGAlUYke1Nx+JlS1ouE57sy1
         Q4afFRXT0TAZXtStU74WDQnikYgCVu8V/FtYg5/18q7VhRNsWYXeQUQixTRMg8VVOvrZ
         t8I1lcXx3JwEBA/plyK6aD9bn3N7WT7ewacLoyyZ4gFpEyp941PZgsYusHgBGwHToJoV
         OSmsrFuMwLzwfWOOHm6f3yErYmDMTqiySnD2YRpPhvYpS1Im0WN8LwUY0pnhpPleA0Ei
         qLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti0B2+GOH1sUCCI3lKmEIHaxROwkZe+iQSCsCALUxmw=;
        b=SsLWuvHli39KCm8dNjFBTmRBQX368PrGe9fUfAo37kLJjbfMPTnYFKzNfLYNsssxKK
         iKh9FiAOnXrq+Elce5D2djbx20/UEKrygmmhEhDMCv/2etwa7FGnkfyC9Is0G+YfbWqq
         QfoXhA9EwduoeDhQvyLSS102Ht80jI7zo/gbltm9Hvk3q9u4/qCAw6SOVwTE8mHv/JDI
         JAcL9mfonqJM3ZPaK1H20vOxKfH+FTvriSFxSjwxsP01JyyZUvVM/ftd0RG9jz8FlFoV
         /Xfe3rYpNJOY2MSEVD57vP450W/+4X9o0DL3zDwDNQPpMdTOEgVgfxr7205NEXak0bn4
         hT/g==
X-Gm-Message-State: AJcUukdJOQx4/bQ/kkZvJNzIVcTF4bARY8ZNRSMExmXnN9iXm37v2zv4
        zmSQIy1qeNNd49mcaRxqO3+9VKm0NeRWEsI7Pg==
X-Google-Smtp-Source: ALg8bN6DTPPimR34oteI/ijt0sww/halUd6Z0r/NZkQw1Wxqsp7JOKTv6I7qSU4QjHuryU7zvHEybRq8MDNlWOWXqxo=
X-Received: by 2002:a24:414c:: with SMTP id x73mr1674837ita.129.1547537311236;
 Mon, 14 Jan 2019 23:28:31 -0800 (PST)
MIME-Version: 1.0
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-3-git-send-email-kernelfans@gmail.com> <a5fe4d86-3551-7da8-caca-fdd497ace99f@intel.com>
In-Reply-To: <a5fe4d86-3551-7da8-caca-fdd497ace99f@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 15 Jan 2019 15:28:19 +0800
Message-ID: <CAFgQCTsMo9+8m9jxUK5Eax44rsY+a3TBpb4HsUrScJW3OQ18Kw@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] acpi: change the topo of acpi_table_upgrade()
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

On Tue, Jan 15, 2019 at 7:12 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 1/10/19 9:12 PM, Pingfan Liu wrote:
> > The current acpi_table_upgrade() relies on initrd_start, but this var is
>
> "var" meaning variable?
>
> Could you please go back and try to ensure you spell out all the words
> you are intending to write?  I think "topo" probably means "topology",
> but it's a really odd word to use for changing the arguments of a
> function, so I'm not sure.
>
> There are a couple more of these in this set.
>
Yes. I will do it and fix them in next version.

> > only valid after relocate_initrd(). There is requirement to extract the
> > acpi info from initrd before memblock-allocator can work(see [2/4]), hence
> > acpi_table_upgrade() need to accept the input param directly.
>
> "[2/4]"
>
> It looks like you quickly resent this set without updating the patch
> descriptions.
>
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index 61203ee..84e0a79 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -471,10 +471,8 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
> >
> >  #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
> >
> > -void __init acpi_table_upgrade(void)
> > +void __init acpi_table_upgrade(void *data, size_t size)
> >  {
> > -     void *data = (void *)initrd_start;
> > -     size_t size = initrd_end - initrd_start;
> >       int sig, no, table_nr = 0, total_offset = 0;
> >       long offset = 0;
> >       struct acpi_table_header *table;
>
> I know you are just replacing some existing variables, but we have a
> slightly higher standard for naming when you actually have to specify
> arguments to a function.  Can you please give these proper names?
>
OK, I will change it to acpi_table_upgrade(void *initrd, size_t size).

Thanks,
Pingfan
