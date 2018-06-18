Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5FAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC39F208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhVFWarO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC39F208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030459AbeFRImr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:42:47 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38164 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030381AbeFRImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:42:42 -0400
Received: by mail-vk0-f67.google.com with SMTP id b77-v6so9032332vkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xzvdQYgdNWHHjI8T37oud0RsOEOFaDbifXIxHBrg7w=;
        b=uhVFWarOoOAz+iINtowHerOcXH2f/upfezFEmEh1/a9J7WvmYgNwGRXbQqwv/mzF+I
         wCJy4hqBc9goeiM0xUEWSMOQMt0fPxtv+DeeTIknRj11UyF9Wm0MgqOJvtNYBnO0XmlG
         fEqoGwvAyK1yk3CorZ+TQLMFxHzcg3sI6bvIVVqZPn9puYSMlE7CFg52Y9ucwkMrhoEk
         c11bbpz3L5KK0a/Kjij2qNBPICtzYnwyRN0BTCkZIIyqr9mG0MzeuXBgQysHbVQEh6ws
         xcTnuNur190VlxhVVXSQvjnAFrBX7S7Y78ISPL3+2TYuHK3sMPTQddKDl2s8juD1z7eJ
         NMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xzvdQYgdNWHHjI8T37oud0RsOEOFaDbifXIxHBrg7w=;
        b=gXxFGC2ij1ZIvxEH4ArppneHXMu1XiQeHLmVwSTPJHOGpstgIOKiNGhjY5l3f1M6Or
         6X5exNuFKFsFtUJOUlffKtDsI4Un3HSgfyjG1zY5Bn9Mk1jodgqnKmFtbMhMFOrLKQpA
         jl3F4rC1AY+opKUmYRVdhihDuZXJsWkW4zq3W7BFsGy2heEPMstLiRRYMOtZiOgMP1SC
         zvgxmcvV0vrcUAUheOl/yUl1+fBzsIIJ8ImqAJ5B2GSOiCsyBFo5Wpt8UxRGxYP+3S3P
         tcjo75X4jUsU7WrC1DoVrAtc0Z7CtLuaFb2J4BNdaBH+na7ZwCCHt2+nb1e3gPWnsO/C
         CDeQ==
X-Gm-Message-State: APt69E0o5MMd9MQ2BCQUSg1vi7Ee+eKl745u+EcbI/7gH8u27jYjw+7W
        I/KdZBExns0uKU4jXFZL8Ymfj2xb+p+sYfYJ9Lw=
X-Google-Smtp-Source: ADUXVKIrLEq4ttVZLOYw4GMjEqFHeUBox3OB+ESOnd5nNhgSY+/MPKUBAEUzuIIbvPjuSyQ02NkC2ymqeY2rr44cU9M=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr6953686vkd.161.1529311361997;
 Mon, 18 Jun 2018 01:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180615174204.30581-1-pasha.tatashin@oracle.com> <20180615174204.30581-4-pasha.tatashin@oracle.com>
In-Reply-To: <20180615174204.30581-4-pasha.tatashin@oracle.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 11:42:30 +0300
Message-ID: <CAHp75VdRxpSYJE17bjGvRAjCq5vjf23L=HT5oA6OhPSCzJJ0FA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] x86/time: read_boot_clock64() implementation
To:     pasha.tatashin@oracle.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 8:48 PM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> read_boot_clock64() returns time of when system was started. Now, that
> early boot clock is going to be available on x86 it is possible to
> implement x86 specific version of read_boot_clock64() that takes advantage
> of this new feature.

> +void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
> +{
> +       u64 ns_boot = sched_clock_cpu(smp_processor_id());
> +       bool valid_clock;
> +       u64 ns_now;
> +
> +       ns_now = timespec64_to_ns(now);
> +       valid_clock = ns_boot && timespec64_valid_strict(now) &&
> +                       (ns_now > ns_boot);
> +

> +       if (!valid_clock)
> +               *ts = (struct timespec64){0, 0};
> +       else
> +               *ts = ns_to_timespec64(ns_now - ns_boot);



> +}


--
With Best Regards,
Andy Shevchenko
