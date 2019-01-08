Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48018C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A1A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRbpQ/jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfAHN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:27:35 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40854 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfAHN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:27:35 -0500
Received: by mail-io1-f65.google.com with SMTP id k2so3086964iog.7;
        Tue, 08 Jan 2019 05:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NDQFUiZkkBDgH22zIym5OK5RZCwCMqIWP8GHnsNHvA=;
        b=vRbpQ/jn4w65x2O35eUPssgrSrjaJ8iCz4re65ESKl7YbyvoEfEk4ysKHXw3tebnam
         55MD9XIodxeUeP/tafDTi43yunH6iXG5hKX2o6KZviO4uKhbaUtxg5mwYZiepNQSG4m8
         8M2ON3UNdVC/R/g+1shjn7bsVB00J97SlqjA73YMBRGvExidPxzK4xN4Dep70uXBCYzh
         /gHYd/xdLsv/95PGbnrUO8SbDAXS5hbezbRTfg9J+36Hdbh5zTXcYeskqn8RFFi/K0se
         Mt2A3+w/UyRXXGVtvlrbAYi7UTtVearZtIXqF20CaBIpVjmRh6QRcax6u46OdqudFPic
         SzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NDQFUiZkkBDgH22zIym5OK5RZCwCMqIWP8GHnsNHvA=;
        b=bwXrdiFbYDByqt3NNAkftwh48GPjQQ0MfMDoFlHf9D5+VjkEEMXxBY12is04gu2KCn
         uVPnsG9Cv5VojEdhflUuVgsfFljlLXb3zkv33C7tzYyiRIcjltUHPl7jujEiPQmAo5qW
         YKJuas4nxhB881GIUJrz769Bbl8cI2MbZbpuSSuI//b4BDjg7jjJxjg3PSIoI9VrKk31
         hThivMftCjFpPMVfChO6jzWoh+p3YcJP/MJ32wX95YIoNmpbfU6sNWV8EA3xqC3au2XE
         JXhGCq2TaCsZxKW4ViU7qqdDZdkKAteSNSlzQBb4DKFJBtCwh1ZQrA0ytwX9Aegcn4zQ
         wXtA==
X-Gm-Message-State: AJcUukeaoMXYf2OSGh3KQqN2EFVL9latSuCEdum5YF8+p3ye4N0ZQhyS
        EYuzlMaN11JRvlclmHzohWaVa+OSMd+prn/CVA==
X-Google-Smtp-Source: ALg8bN46misA3c5oLp9zKMcbjquyMfgxb716KkkTgvaJDi+CKJpxQgkwMvfjPZquhcOe2C5afCj9pZha8THldnyfVV4=
X-Received: by 2002:a6b:3f06:: with SMTP id m6mr927194ioa.117.1546954053471;
 Tue, 08 Jan 2019 05:27:33 -0800 (PST)
MIME-Version: 1.0
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com> <20190108100542.GA2216@localhost.localdomain>
In-Reply-To: <20190108100542.GA2216@localhost.localdomain>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 8 Jan 2019 21:27:22 +0800
Message-ID: <CAFgQCTu8C6DFqoUSKyKLZnL1twGr=3k+M4bgwgtcjENm+WHqJg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86_64/mm: remove bottom-up allocation style by
 pushing forward the parsing of mem hotplug info
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     x86@kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, yinghai@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 6:06 PM Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Mon, Jan 07, 2019 at 04:24:41PM +0800, Pingfan Liu wrote:
> >Background about the defect of the current bottom-up allocation style, take
> >the following scenario:
> >  |  unmovable node |     movable node                           |
> >     | kaslr-kernel |subtree of pgtable for phy<->virt |
> >
> >Although kaslr-kernel can avoid to stain the movable node. But the
> >pgtable can still stain the movable node. That is a probability problem,
> >with low probability, but still exist. This patch tries to eliminate the
> >probability. With the previous patch, at the point of init_mem_mapping(),
> >memblock allocator can work with the knowledge of acpi memory hotmovable
> >info, and avoid to stain the movable node. As a result,
> >memory_map_bottom_up() is not needed any more.
> >
>
> Hi Pingfan,
>
> Tang Chen ever tried to do this before adding 'movable_node':
> commit e8d1955258091e4c92d5a975ebd7fd8a98f5d30f
> Author: Tang Chen <tangchen@cn.fujitsu.com>
> Date:   Fri Feb 22 16:33:44 2013 -0800
>
>     acpi, memory-hotplug: parse SRAT before memblock is ready
>
> Then, Lu Yinghai tried to do the similar job, you can see:
> https://lwn.net/Articles/554854/
> for more information. Hope that can help you.
>
Thanks, It is a long thread, as my understanding, Tejun concerned
about the early parsing of ACPI consumes memory from memblock
allocator. If it is, then this should not happen in my series.
Cc Tejun and Yinghai.

Regards,
Pingfan
> Thanks,
> Chao Fan
>
> >
> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >Cc: Ingo Molnar <mingo@redhat.com>
> >Cc: Borislav Petkov <bp@alien8.de>
> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >Cc: Andy Lutomirski <luto@kernel.org>
> >Cc: Peter Zijlstra <peterz@infradead.org>
> >Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >Cc: Len Brown <lenb@kernel.org>
> >Cc: linux-kernel@vger.kernel.org
> >
> >Pingfan Liu (4):
> >  acpi: change the topo of acpi_table_upgrade()
> >  x86/setup: parse acpi to get hotplug info before init_mem_mapping()
> >  x86/mm: set allowed range for memblock allocator
> >  x86/mm: remove bottom-up allocation style for x86_64
> >
> > arch/arm64/kernel/setup.c |   2 +-
> > arch/x86/kernel/setup.c   |  17 ++++-
> > arch/x86/mm/init.c        | 154 +++++++---------------------------------------
> > arch/x86/mm/init_32.c     | 123 ++++++++++++++++++++++++++++++++++++
> > arch/x86/mm/mm_internal.h |   7 +++
> > drivers/acpi/tables.c     |   4 +-
> > include/linux/acpi.h      |   5 +-
> > 7 files changed, 172 insertions(+), 140 deletions(-)
> >
> >--
> >2.7.4
> >
> >
> >
>
>
