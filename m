Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60012C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69EF206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="X+HY5Ft5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69EF206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeI2MkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:40:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39720 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeI2MkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:40:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so4034496wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29jDzSXlXoffgt2mMIY4dV6BM8lRkIziSF82pMVMEUI=;
        b=X+HY5Ft5iJaK0ZTUxP+aceQUKNO/Y1AdprsmKMDrmGYY3DmZ6BIKQn7tZN93/7piOC
         YNkh9/XQjZHBUBS98iXRFnblDKAnUQOeced4giytTsSjIu51dG7MaDSz82UoAn8XC5Tm
         yeAYv3NeZ7REQwEM4jHvSLnRZ/RzWvXwvCETCXvgSxjqa9kQ9Kqt1ctx3cORjw7Cwba5
         Wl07ONSXkhVEJEe5o1NZnhdWXqdSoUzM0gwDGlpo+6tfWN7TfIT4mqhdsb7kz8UKyJwp
         RUZe4uxJHcRpUBQ+k8z8T2elU0K2MbuvfwJAt06y23KBwPsE096PtWMmRCVQV1K1OAED
         5dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29jDzSXlXoffgt2mMIY4dV6BM8lRkIziSF82pMVMEUI=;
        b=EM/lU0WHRRBZk4I1VyezGoh9hagcJbhgMS7/ze89QPwjGzIh4o2S8nhffXnEjMbVmC
         pMCChyNHFxqZRbIlV/SDsG5Gw5fMvxaoaUTbRpfs4S6XJfH9M/UgUubVTfOFfNyNTNb3
         pkZH12o7z7/W+NvtATURrGyO4OewWufcgbJdUVOUZ+lWLcuDTPYn2eWnOa4KL1IpVN6K
         57d7rknx48VRitGn56vggHZITzohtq5Hzsl2i77WvKC+m/9Omj1SD0Wm+j+vE3p6oxJy
         zOMekHXlSnnaAT4KdSd/I4w7ML2A7eoRQxBWd/uqED4Fur80XfdbD10+SLlR1KdO8QMc
         +uAQ==
X-Gm-Message-State: ABuFfogAYgSzQ//d0z+eO8dYj4lGm/EThnxUJNWwBC8MVGM99Q8CMExm
        OK9j9nxTki8uwrMRIM1Cp/5e84oY8ux6fLHzv8+cqg==
X-Google-Smtp-Source: ACcGV63seKW84U6HmityIPpYOaCw3LFOUKpPjVpDhbo8qpRwSHMESAdEb+Nc7CMM3mi/N2b3lmBlAQvlDvmhVdwgNFA=
X-Received: by 2002:a1c:3383:: with SMTP id z125-v6mr3183079wmz.56.1538201577553;
 Fri, 28 Sep 2018 23:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180912143822.21948-1-anup@brainfault.org> <mhng-f8bcf381-8d26-4082-876a-781fe87ee721@palmer-si-x1c4>
In-Reply-To: <mhng-f8bcf381-8d26-4082-876a-781fe87ee721@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 29 Sep 2018 11:42:47 +0530
Message-ID: <CAAhSdy2gC15j9zW+_rjBQzofGyhBjcNVWSYCbBtrAmQtDogBqA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 7:16 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 12 Sep 2018 07:38:22 PDT (-0700), anup@brainfault.org wrote:
> > Currently, /proc/cpuinfo show logical CPU ID as Hart ID which
> > is in-correct. This patch shows CPU ID and Hart ID separately
> > in /proc/cpuinfo using cpuid_to_hardid_map().
> >
> > With this patch, contents of /proc/cpuinfo looks as follows:
> > cpu   : 0
> > hart  : 1
> > isa   : rv64imafdcsu
> > mmu   : sv48
> >
> > cpu   : 1
> > hart  : 0
> > isa   : rv64imafdcsu
> > mmu   : sv48
> >
> > cpu   : 2
> > hart  : 3
> > isa   : rv64imafdcsu
> > mmu   : sv48
> >
> > cpu   : 3
> > hart  : 2
> > isa   : rv64imafdcsu
> > mmu   : sv48
> >
> > Signed-off-by: Anup Patel <anup@brainfault.org>
> > ---
> >  arch/riscv/kernel/cpu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index f0f0ec2737b7..7c1342e242e6 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -87,7 +87,8 @@ static int c_show(struct seq_file *m, void *v)
> >                                                  NULL);
> >       const char *compat, *isa, *mmu;
> >
> > -     seq_printf(m, "hart\t: %lu\n", cpu_id);
> > +     seq_printf(m, "cpu\t: %lu\n", cpu_id);
> > +     seq_printf(m, "hart\t: %lu\n", cpuid_to_hardid_map(cpu_id));
> >       if (!of_property_read_string(node, "riscv,isa", &isa)
> >           && isa[0] == 'r'
> >           && isa[1] == 'v')
>
> I like this, but it doesn't appear to apply.  Do you mind sending something
> against Linus' master?  Then I should be able to sort it out.
>

This patch is requires cpuid_to_hardid_map() added by Atish's
patchset so I have requested Atish to make this patch part of
his v6 patchset.

Thanks,
Anup
