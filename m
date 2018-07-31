Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD82FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74552208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXgFt3uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74552208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeGaFmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:42:12 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35793 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeGaFmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:42:12 -0400
Received: by mail-ua0-f193.google.com with SMTP id q12-v6so9366879ual.2;
        Mon, 30 Jul 2018 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kQR8GsVqrqzv+OibNj/iF6+WKazJsHAJ6bt4XIhAKJY=;
        b=IXgFt3uUCJkBTr4sxYD7570icc7doVnncqhhuuwEOHHykmP6nAibz1MYZMvOUvZ/M7
         lzNQ4oD/7U+0PooBnHHDKCFbm35TNI/bLxfV97XSPed6SQxsdlqkXKVkHayI5RdlrGej
         m1BNsEg4ngWquNsXZri1wm0CsK7il9Ck9vJ9/PZ4jB+hNarMZyiv3Kn4iTCQ+trhWWTp
         eVX3QajSdR/pGS+9a2/O2FK+g2ypJs2ob82LZ26GZ70TBoaoiVNWecISWDE/Cb0f/scm
         8JPwxHpgnEYZc7ZpjHiSXKzUzudxhenLJQaFtN5cJciSAIAzo/jJQo/h6XvLXQl1Bby0
         kdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kQR8GsVqrqzv+OibNj/iF6+WKazJsHAJ6bt4XIhAKJY=;
        b=Psn34mgSpeXkcFPFiJKa5bbOtPtzuzCj12rQHilwNPqKE7xz8a0l4v8lT9Gr8gwAEy
         Kwffma+zdoAV+wyOpUAhyQQVQEYC7BV4o18/87rIt+4/t7phJyHReE35HpCvUgO0K3kS
         Sc1SHLu4j8ew08wMRwfPwGasYsMc0dOQ+g8rfD6HXKfk+bMaNrMBKmyslGJpuzOsfp33
         uOYauyJm11U6FWLitqvGpydHi5Ud5sRdVAZcluFUjhexxsoEkHKofAGYN9FWliIZD65j
         +yb8uz91XKFghFscgidM3y/pVFPzsatOJP44FI8BO9leealMZIeuUakIwQ/gQAjHdkh+
         c56Q==
X-Gm-Message-State: AOUpUlE4k6I9L86pjgdDBuLdKUTvtkp/vLL2+vXer62ELIA4WAPHpQP/
        PuJlSC0hNOcj83eL1ibAykNv8SgQx4uWSyQbrXudEX+y
X-Google-Smtp-Source: AAOMgpfXH43nd2/Wi629kTn7lJB7K+BGR5uZI65qlb7uuIe//xYvh/fe4r1e1IghGyDxXHsUn3Vaz05cad7J3uNtrdk=
X-Received: by 2002:ab0:10cc:: with SMTP id x12-v6mr13992380uab.55.1533009838760;
 Mon, 30 Jul 2018 21:03:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7f52:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 21:03:18
 -0700 (PDT)
In-Reply-To: <20180731020629.GB22311@joelaf.mtv.corp.google.com>
References: <CAADnVQL4twmGF3d26TgLsQJvnqLnM0F6hqL_42DSs95OuZ1y9A@mail.gmail.com>
 <20180731020122.GA22311@joelaf.mtv.corp.google.com> <20180731020629.GB22311@joelaf.mtv.corp.google.com>
From:   Y Song <ys114321@gmail.com>
Date:   Mon, 30 Jul 2018 21:03:18 -0700
Message-ID: <CAH3MdRU5nn5g0bexrLWU3-UrxSJfrVF0-A2v2VJGAeBDKY=+Zg@mail.gmail.com>
Subject: Re: [PATCH v2] Add BPF_SYNCHRONIZE_MAPS bpf(2) command
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 7:06 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Mon, Jul 30, 2018 at 07:01:22PM -0700, Joel Fernandes wrote:
>> On Sun, Jul 29, 2018 at 06:51:18PM +0300, Alexei Starovoitov wrote:
>> > On Thu, Jul 26, 2018 at 7:51 PM, Daniel Colascione <dancol@google.com> wrote:
>> > > BPF_SYNCHRONIZE_MAPS waits for the release of any references to a BPF
>> > > map made by a BPF program that is running at the time the
>> > > BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command is
>> > > to provide a means for userspace to replace a BPF map with another,
>> > > newer version, then ensure that no component is still using the "old"
>> > > map before manipulating the "old" map in some way.
>> > >
>> > > Signed-off-by: Daniel Colascione <dancol@google.com>
>> > > ---
>> > >  include/uapi/linux/bpf.h |  9 +++++++++
>> > >  kernel/bpf/syscall.c     | 13 +++++++++++++
>> > >  2 files changed, 22 insertions(+)
>> > >
>> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> > > index b7db3261c62d..5b27e9117d3e 100644
>> > > --- a/include/uapi/linux/bpf.h
>> > > +++ b/include/uapi/linux/bpf.h
>> > > @@ -75,6 +75,14 @@ struct bpf_lpm_trie_key {
>> > >         __u8    data[0];        /* Arbitrary size */
>> > >  };
>> > >
>> > > +/* BPF_SYNCHRONIZE_MAPS waits for the release of any references to a
>> > > + * BPF map made by a BPF program that is running at the time the
>> > > + * BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command
>> >
>> > that doesn't sound right to me.
>> > such command won't wait for the release of the references.
>> > in case of map-in-map the program does not hold
>> > the references to inner map (only to outer map).
>>
>> I didn't follow this completely.
>>
>> The userspace program is using the inner map per your description of the
>
> Sorry just to correct myself, here I meant "The kernel eBPF program is using
> the inner map on multiple CPUs" instead of "userspace".
>
> thanks,
>
> - Joel
>
>
>
>
>
>> algorithm for using map-in-map to solve the race conditions that this patch
>> is trying to address:
>>
>> If you don't mind, I copy-pasted it below from your netdev post:
>>
>> if you use map-in-map you don't need extra boolean map.
>> 0. bpf prog can do
>>    inner_map = lookup(map_in_map, key=0);
>>    lookup(inner_map, your_real_key);
>> 1. user space writes into map_in_map[0] <- FD of new map
>> 2. some cpus are using old inner map and some a new
>> 3. user space does sys_membarrier(CMD_GLOBAL) which will do synchronize_sched()
>>    which in CONFIG_PREEMPT_NONE=y servers is the same as synchronize_rcu()
>>    which will guarantee that progs finished.
>> 4. scan old inner map
>>
>> In step 2, as you mentioned there are CPUs using different inner maps. So
>> could you clarify how the synchronize_rcu mechanism will even work if you're
>> now saying "program does not hold references to the inner maps"?

The program only held references to the outer maps, and the outer map
held references to the inner maps. The user space program can add/remove
the inner map for a particular outer map while the prog <-> outer-map
relationship is not changed.

>>
>> Thanks!
>>
>> - Joel
>>
