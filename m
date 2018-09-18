Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8799C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA642133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR08xJCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA642133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbeISB5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:57:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35483 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeISB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:57:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so3035029edq.2;
        Tue, 18 Sep 2018 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2b/c6Kmx71m7oph9UIXHdHh8joRXZhYblADsrrAJHU=;
        b=sR08xJCu+OmuLX5Yi+llnVKZWsm6+dPuktnMyusyjH+DYYxy6Alq3TnqSV5od47lKS
         9ya2qeOonAUWdl8TD7BdtBW5d/pJTqvyy3dHcAcVR0uH5IBXXQsViWrIoh/ifH6ufLQ3
         /4w8iniVzZ8UCZztxIQ//tgf0JZPBWZWdRp0XizBBMMuSNQ/CQiWc0OMaOXLeW3iScJ/
         65VzkTWAX+IIYhsDCACquic4ey3FbV4IFoJ/TfZ5ULeVwjgR7HbSahj585Asjp0+wEy+
         IGPb8Mn8GMhGSwXqrkNzMXLF+HlhTXISBpTH/U+PpSFFHLQ2bHuVXTv4YVz8dGHOPo0t
         IgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2b/c6Kmx71m7oph9UIXHdHh8joRXZhYblADsrrAJHU=;
        b=ogljozjjgkpcbHS223hK65TsrANRsenfmqYPs9dzxBTg4mgqo9ov3zybpi2SSuQmmO
         vm83sLsPz2RRzprPP8/95TOPh2wTwG4UEhADvjmucnbjdo2imwL9oCsIoeFWQuTvt3oZ
         c+8kB30qAk6pEsdLhLrgqawRAMelZ3T4BCT++zh4gvmLB28n9ADdKnoqQdpxxeXHPap5
         TdG2pl5MyjWazDbGa339Pej60QsflrbC9+i63CIYcO2v/F6ZGX1OW3nqUqq7VHdI53ya
         cIRqMukgQ1SMXTrJbkY/ms0PcSOUjEwF/0RCxuq4FmlVkh+0aVUjAARe5ukNzUwi2xWV
         ROoA==
X-Gm-Message-State: APzg51BJlr62YM+Rhft/ZpuYO4SMM1k/K22xlsqj0Vl6siXhezUMap4M
        o8m8O7I5zupYUs3Snoc+Vi2+Dw52sKNvdyLl+WI=
X-Google-Smtp-Source: ANB0VdYZcHKqobT8Az6N6BIAGGPc8CXLWLiYYE3N/lypvppUgtdTbZfctuZEI05SC7U7SufnNQzil8RmiEBO2dq6a54=
X-Received: by 2002:a50:cd07:: with SMTP id z7-v6mr54316159edi.60.1537302201680;
 Tue, 18 Sep 2018 13:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180918151235.4284275f@canb.auug.org.au> <0dc91212-54e8-d2f0-a4e3-30a468c20b8d@infradead.org>
 <a1129d67-97e3-8f10-c938-0de72fee9377@iogearbox.net> <CAF=yD-Kv7ig9UEo8Ci3eZOV=spa9cbGA5Mfa5Too8TgUzVA3fA@mail.gmail.com>
In-Reply-To: <CAF=yD-Kv7ig9UEo8Ci3eZOV=spa9cbGA5Mfa5Too8TgUzVA3fA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 18 Sep 2018 16:22:45 -0400
Message-ID: <CAF=yD-KHzRR1MrDGkQ0d+qC-0_-arVoKBLKze3iwX=HweMYCFw@mail.gmail.com>
Subject: Re: linux-next: Tree for Sep 18 (kernel/bpf/syscall)
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     rdunlap@infradead.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:28 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Tue, Sep 18, 2018 at 11:44 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > [ Cc Petar and Willem ]
> >
> > On 09/18/2018 05:37 PM, Randy Dunlap wrote:
> > > On 9/17/18 10:12 PM, Stephen Rothwell wrote:
> > >> Hi all,
> > >>
> > >> Changes since 20180913:
> > >
> > > on i386 or x86_64: (in 6 of 20 randconfigs)
> > >
> > > kernel/bpf/syscall.o: In function `__x64_sys_bpf':
> > > syscall.c:(.text+0x3278): undefined reference to `skb_flow_dissector_bpf_prog_attach'
> > > syscall.c:(.text+0x3310): undefined reference to `skb_flow_dissector_bpf_prog_detach'
> > > kernel/bpf/syscall.o:(.rodata+0x3f0): undefined reference to `flow_dissector_prog_ops'
> > > kernel/bpf/verifier.o:(.rodata+0x250): undefined reference to `flow_dissector_verifier_ops'
> > >
> > > Full randconfig file is attached.
> >
> > Looks like we need a wrapper for these, config had:
> >
> > # CONFIG_NET is not set
>
> Thanks for forwarding the report.
>
> For the functions, I think we can use a similar static inline stub as
> used e.g., for bpf_map_offload_map_alloc.
>
> The _ops references are from a macro that includes linux/bpf_types.h,
> so indeed a CONFIG looks needed.
>
> I need to look it over before I send out, but tentative patch:

Sent http://patchwork.ozlabs.org/patch/971280/
