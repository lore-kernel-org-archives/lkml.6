Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E9FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C28F2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C28F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeK1P0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:26:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37242 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1P0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:26:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id e5-v6so22166327lja.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 20:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aRQCrnv9tErOURhtejgLhD0px/O+ADs2oK1CAhVURk=;
        b=Ysrr1AMC7WcAOisEftd0rDWtRVxq+pama6QdQLkE6a+HH1JjCYxu5SJxwdnmlpJad3
         3fNy3QFp7cSDmEhOGbsw5nvFxvqELr8OfFPViQeQKGKKyMC7PQgUYWET/3xCUv2FUsew
         8/w/ENenQciztPpTeAke8aGn1/C2+BxbAV3M7l3THgaZAMjK6IcCkllGVetBvv75hI4p
         L5p1bS1NFlxdK8ZgP21nRmfaj6dsGa+x8dVLpoF5H7I+IzownRt80s45NzIpa7cs1Kqc
         SSG+c32A2KvY2YmZ4V+MXO82FXUPU9Z4wB0bsySARoq8kzrRKVfUjJFwWYDjV8hhFq8V
         4x2Q==
X-Gm-Message-State: AA+aEWYDYkHaMljmreRPOsRULQg7v50fPIbdPdq2ldgKdx5kNPWun+Pp
        h+e2+s7KFpqLGPV5W5IQ08GdSpGQr3UvQqPGcZQ36Q==
X-Google-Smtp-Source: AFSGD/XsZC5yDBpf16KtC3viBiYJR+Vh18VgOasqA3ogMll0tX9kCzFMDMXQwmIDilW8HeaLcB+zMRsIh1kZ1mPEzVs=
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr5492137ljj.98.1543379196798;
 Tue, 27 Nov 2018 20:26:36 -0800 (PST)
MIME-Version: 1.0
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic> <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
 <20181127232916.GG1824@MiWiFi-R3L-srv> <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
 <20181128015754.GI1824@MiWiFi-R3L-srv>
In-Reply-To: <20181128015754.GI1824@MiWiFi-R3L-srv>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 28 Nov 2018 09:56:24 +0530
Message-ID: <CACi5LpM23rZQVe-bDirfNEODwe-zZDo0VyTFUG_969mgisL+gA@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     Baoquan He <bhe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>, x86@kernel.org,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 7:27 AM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/27/18 at 04:39pm, Kees Cook wrote:
> > >> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > >> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> > >> >> --- a/arch/x86/kernel/machine_kexec_64.c
> > >> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> > >> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> > >> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> > >> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> > >> >>                       pgtable_l5_enabled());
> > >> >> +#ifdef CONFIG_RANDOMIZE_BASE
> >
> > Okay, gotcha. In that case, shouldn't this be CONFIG_RANDOMIZE_MEMORY?
>
> And yes, if we only care about KASLR, it should be
> CONFIG_RANDOMIZE_MEMORY, but not CONFIG_RANDOMIZE_BASE.
>

Have you tried building the changes with 'make allmodconfig' with all
the different CONFIG options you have suggested so far?
