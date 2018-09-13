Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D80C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E760A2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="TU8g4LYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E760A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeIMIrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:47:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45636 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeIMIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:47:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so4032024wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCkuYAvKkOjNGctc1hjDg1xcv9RCzj1FR/40nidz/Dg=;
        b=TU8g4LYcoEtcMZVTBPqpFNCRNTegRvNxwWx84IfKRuJnYHI5MqMzPMSV08q7sniC8x
         jKQZBuIiz2iBwdxtE/yIfvVwWBgWazr4nKHLHszPGQqUDge9OLQO5j/VwicadeA5YwJZ
         t3OWkEty5nLqoKKt7f1QEcXwvj/TNtpTcXZScfQhu0ZjpVdj/FtHgfzD9MpLt8zocNI0
         IBgTrYPB6fwNOvTXnqwZhOLobiRdcffSrYxQZJG3mSEVfSRHMjSlWV7/N5AOyCt0rFor
         5CnVEAlnom7C3zhOOf7yOGnXy6CKvVdIZR549M2x9M5b8cqc5MWThbDFTNHwi6aG0Ddm
         pDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCkuYAvKkOjNGctc1hjDg1xcv9RCzj1FR/40nidz/Dg=;
        b=opVPtryfH8N9cKh9sj8i2Pl5GiWxmbgKsdnQ8lWwx83oR/3FVl4ZcqI31pYC6tbe26
         sjdwXkMumjpRhow0sbC/Wap8QBwAcsrUELVcotmCgxTSJy6HFKSh9sS1QaC+U4lRAX0X
         XtyKa5aUVy2Nftqkp4uaTptpdQVTOX5FDfo4D2OTRXWQEjqGYR+7+H54v4DDZoK4yJyt
         I+3rQJ3VNRp+TyLn/o1z04MOI8hccq1irb1j2u4FRL7KuBNcMUX6nmyRUCFj5mnmjLWe
         eZSrRamtSLrdFIAN0kAE4blEDKFFWjjZ6jbF0wKiHsRaJwJ/TFMBe1Wcj0wR6CHJl9qc
         sL+A==
X-Gm-Message-State: APzg51AyGQV1RKzvpJ6KOIbA/bK5AWXDMt+Mv9K6YPV0YqYIzeJDR0cJ
        5xwbGIpAdmplRo5dZi+zgiMuRORz9syGBG7KDuvVBA==
X-Google-Smtp-Source: ANB0VdaYVlANVBA1oAQhaQiUi9fVqBLXrmyP3PIHOi7wSGaj0o7SYObdpeqKrcZ2isT9iZNm5iXj2OVgpHX+0yFshcU=
X-Received: by 2002:a5d:6b8d:: with SMTP id n13-v6mr3782971wrx.149.1536809972745;
 Wed, 12 Sep 2018 20:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180912143822.21948-1-anup@brainfault.org> <72961c71-c4e4-7990-da64-a7f1613f2e1c@wdc.com>
In-Reply-To: <72961c71-c4e4-7990-da64-a7f1613f2e1c@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 13 Sep 2018 09:09:21 +0530
Message-ID: <CAAhSdy3Ayy50XnAZk6Fu2Rk6pmMT2YN6KoN9voBg+RW1dUqajg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Show CPU ID and Hart ID separately in /proc/cpuinfo
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:17 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 9/12/18 7:38 AM, Anup Patel wrote:
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
> >   arch/riscv/kernel/cpu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
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
> >
>
> The extra hart information will not be parsed by lscpu which will make
> the cpu information inconsistent between lscpu & /proc/cpuinfo.
>
> Should we patch lscpu as well to show correct hart id as well ?

Yes, we should certainly patch lscpu to parse CPU ID and
HART ID differently.

Regards,
Anup
