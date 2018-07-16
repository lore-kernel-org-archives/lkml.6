Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7CBECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB82920647
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3ildcLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB82920647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPP5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:57:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37482 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeGPP5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:57:44 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so21951207itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zIenD44khob/6JStWiqv5fGyAtotdvdBsyMlyX7RnNY=;
        b=F3ildcLqUk7r2C0OF/vmYIUd7OQVZLIaznrWdvNSoHsAwfzTFDpEQa6pXFz7jQ7JNp
         QfRfPgWNTYC9CK7vs1zKXzkhjwCIqb5GfM6laRP1YuziQyy473rgAjlv7mIglbjqGTbn
         DM1f6ouQqN9fbgdRaZO3c+EPwRaKDzKb4qRm0jbUr91rjBRklEU3Pb55K6aHPinHo+7s
         2bC42kp7kOht6MrRqNjrZyaxTKweVhKx+WymVlZGsJgfWbHTUPNCxy8paS74Q2gdroPC
         ss9EK5Tv/TIkM+FuTjH6zJxh7tSi7PCjC7U4G0PFOZ8R8CwpiNnQSo4T7lhNnRghx24e
         QS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zIenD44khob/6JStWiqv5fGyAtotdvdBsyMlyX7RnNY=;
        b=QQUj7zYNpS3QE6kFVvc1do6rf5fC3WsWIafDnvcPmuYC+2hcDI8KSnq6icUqwtaxVl
         5PRkLRRA7xRWD51tL3T3SlLuf30BheD1k315zScpMQp0iNnMvZEtkaFR2VZnVYKMD5sj
         A16J3r7sJfxcIN8MBR4HHaXsAlYp8PAlt2sgnE2KF3OdF7noMR4VYnFU/4GKGkSPBhM7
         Wj27r/zWw+Q1VSEMT0dQW4AcDCA4wGhnyulcTSkuMu+TLUmqYkLI4hmmauKwD9Vc8zYz
         PL6PG7aNuJUWpV3fn6/AZouvMvjIQRnd/ggavG5++vjcsJVix1p2Og6vxkCx8L8hwmgG
         I1fw==
X-Gm-Message-State: AOUpUlG9k/wjMFiDWdfPH96fleXm4F09E7BowZh6T2THDMUD3ItQtzLN
        g5v5MBSmvoOYYa12drKfqH4MRjX1ZhXfocRFNvikxQ==
X-Google-Smtp-Source: AAOMgpdootPMIc9x7xz+7wibuc7XB8S63OqmNml9KVyL3p+5nuCy2d/GYOH9MXvXDJR9KGcT/iXlAUBEeZeQ5e0fRIM=
X-Received: by 2002:a24:130c:: with SMTP id 12-v6mr13601410itz.35.1531754988095;
 Mon, 16 Jul 2018 08:29:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 08:29:47
 -0700 (PDT)
In-Reply-To: <20180714181815.GA199777@joelaf.mtv.corp.google.com>
References: <951478560.1636.1531083278064.JavaMail.zimbra@efficios.com>
 <20180709210944.quulirpmv3ydytk7@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuet+pjqM8zghmXYdA9f10bsYOzMuSQhSYXG5wbrNmFEqpQ@mail.gmail.com>
 <20180709221005.sintsjkle4xpkcyk@ast-mbp.dhcp.thefacebook.com>
 <CAKOZuetaKNaJVWcu10ZcsiXiK4X+-2z3eFaz1pF8DSxdQ_mEnQ@mail.gmail.com>
 <20180709223439.uc2a6hyic35inwye@ast-mbp.dhcp.thefacebook.com>
 <CAMOXUJ=QmkjTqbWqPRxb=R7f6EpsHBkDQ4MhrSD=VPiDTj7RiA@mail.gmail.com>
 <20180710235252.mioihpgtu4n3syaq@ast-mbp.dhcp.thefacebook.com>
 <CAKD1Yr07uxpd95oGAE7QxfrS_qWuiLcUmy7nsEsC0CzVhV2-rg@mail.gmail.com>
 <20180711034017.o2ehf27tv5hpl3td@ast-mbp.dhcp.thefacebook.com> <20180714181815.GA199777@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 16 Jul 2018 08:29:47 -0700
Message-ID: <CAKOZuetwbE2HSa7vfVoVYwSqfz0ZcNWO93Y=pcJ-q4uEWHSuNg@mail.gmail.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 11:18 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Tue, Jul 10, 2018 at 08:40:19PM -0700, Alexei Starovoitov wrote:
> [..]
>> > The kernel program might do:
>> >
>> > =====
>> > const int current_map_key = 1;
>> > void *current_map = bpf_map_lookup_elem(outer_map, &current_map_key);
>> >
>> > int stats_key = 42;
>> > uint64_t *stats_value = bpf_map_lookup_elem(current_map, &stats_key);
>> > __sync_fetch_and_add(&stats_value, 1);
>> > =====
>> >
>> > If a userspace does:
>> >
>> > 1. Write new fd to outer_map[1].
>> > 2. Call BPF_SYNC_MAP_ACCESS.
>> > 3. Start deleting everything in the old map.
>> >
>> > How can we guarantee that the __sync_fetch_and_add will not add to the
>> > old map?
>>
>> without any changes to the kernel sys_membarrier will work.
>> And that's what folks use already.
>> BPF_SYNC_MAP_ACCESS implemented via synchronize_rcu() will work
>> as well whether in the current implementation where rcu_lock/unlock
>> is done outside of the program and in the future when
>> rcu_lock/unlock are called by the program itself.
>
> Cool Alexei and Lorenzo, sounds great to me. Daniel want to send a follow up
> patch with BPF_SYNC_MAP_ACCESS changes then?

Will do. Mind if I just mine this thread for the doc comment?
