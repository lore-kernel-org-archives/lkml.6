Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3465C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE4625BD4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E61NDKe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE4625BD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932155AbeGBVxC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:53:02 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40565 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeGBVxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:53:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so11941319oie.7;
        Mon, 02 Jul 2018 14:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9t2zWQSDwYkZ5t5wm7TE8QXoPa5kdwMchYj185w04vQ=;
        b=E61NDKe8lpVwSeB3HSKDGOL00xZSPWstNErKj5anGoCWo7j5PxeFkeLAtLmvrncvAR
         pKIC6T25dqE0D8msqOU3kIQRWMsOo+617ngjTSfBNSD4iHdsYjttNTSpJ9vBeJWiRw5i
         nHaMVv/vDWLoadakWp+6ESua95GTyPiBaid5bpLw34zoyn5Kn+6a1gpsWLXXL+8ZEIBP
         FrbdE492sGL4rAmF0xokJJW92088n4DVUd/P15oGnF8J2nDFfUu+NInv/KNBAMqAMwV7
         My/eyIlX+6f13kiW6JjChKbRc07/tkGPrIjqatiEOjT90u4lz9IxY92y9crdHyMdII45
         phdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9t2zWQSDwYkZ5t5wm7TE8QXoPa5kdwMchYj185w04vQ=;
        b=EvfQs3vlzrDPuRH2CLinZuG3xbO2HKK84UQhDilubh1yd4zvZDvog1moAfisu5jSAs
         EmNeVO4uBJ88UwO73hNTQRsfLKGNsWypXP42ZYASajLZgM7tvPtlAZORid7F+EaGenQM
         Kq0iPfa2wtFb2c/b/fboyKL4BDJEImSGM1ql9NDepEgVlEE0HcpTyfNkr4dwCmzAXTPN
         KKkNCjBZzmPf4Jw1uP+6kU9LPmVANg/uH/lM6LZ8S3JakEKEjTyR9XjSTXiZLoEDDAiB
         MHrUPSTBPE+rN1JgwI6q4AFcXEUNEIYteJbusbroegOpr0nYawaq2H+MxLJ6irWw4ojf
         nHNw==
X-Gm-Message-State: APt69E1CHOfgRpah/1PfSKPhioVg/riQvCojFnYblNgoDvqNEP8gGMa0
        JKXp9OqggjrOg6jJK9aZUUtazSxHlkZxhbzEKE4=
X-Google-Smtp-Source: AAOMgpfHtTohXuXi7auo6tWi5C/fW7e/UvMeKM5Ut5id4KXIIO/oYiLgB7cew8XXeBDUuc5Bjyn/sU4meOop6dGnU4k=
X-Received: by 2002:aca:ef44:: with SMTP id n65-v6mr16926083oih.120.1530568379948;
 Mon, 02 Jul 2018 14:52:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 14:52:59 -0700 (PDT)
In-Reply-To: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Jul 2018 23:52:59 +0200
X-Google-Sender-Auth: 8D6gwFTFUIDKA2OqDdk_tmUhTWs
Message-ID: <CAJZ5v0h5+O8xf_EqRPfdvtjQ7BvxLp8veaxB-7WsD8wq7RUFpA@mail.gmail.com>
Subject: Re: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:41 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
> I'm experiencing two problems with commit 5088814a6e931 which is "ACPICA:
> AML parser: attempt to continue loading table after error"
>
> The first is this boot failure on a thunderX2:
>
> [   10.770098] ACPI Error: Ignore error and continue table load
> (20180531/psobject-604)
>     [   10.777926] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
>     [   10.786809] Mem abort info:
>     [   10.789623]   ESR = 0x96000004
>     [   10.792702]   Exception class = DABT (current EL), IL = 32 bits
>     [   10.798682]   SET = 0, FnV = 0
>     [   10.801760]   EA = 0, S1PTW = 0
>     [   10.804925] Data abort info:
>     [   10.807827]   ISV = 0, ISS = 0x00000004
>     [   10.811698]   CM = 0, WnR = 0
>     [   10.814689] [0000000000000000] user address but active_mm is swapper
>     [   10.821108] Internal error: Oops: 96000004 [#1] SMP
>     [   10.826032] Modules linked in:
>     [   10.829113] CPU: 30 PID: 1 Comm: swapper/0 Not tainted
> 4.18.0-rc3PPTT4k+ #53
>     [   10.836234] Hardware name: Default string Cavium ThunderX2/Default
> string, BIOS L50_5.13_1.0.0 05/16/2018
>     [   10.845905] pstate: 00400009 (nzcv daif +PAN -UAO)
>     [   10.850746] pc : acpi_ps_peek_opcode+0x1c/0x40
>     [   10.855231] lr : acpi_ps_create_op+0x54/0x278
>     [   10.859627] sp : ffff000009a8ba30
>     [   10.862969] x29: ffff000009a8ba30 x28: 0000000054445353
>     [   10.868334] x27: 0000000000004008 x26: 0000000000000000
>     [   10.873698] x25: ffff000009767f23 x24: ffff000008d59000
>     [   10.879063] x23: ffff802672799030 x22: ffff000009a8bb28
>     [   10.884427] x21: 0000000000000000 x20: ffff000008d59000
>     [   10.889791] x19: ffff802672799030 x18: ffffffffffffffff
>     [   10.895155] x17: 0000000000000013 x16: 0000000000000000
>     [   10.900519] x15: ffff000008d59708 x14: 2d7463656a626f73
>     [   10.905883] x13: 702f313335303831 x12: 3032282064616f6c
>     [   10.911246] x11: 20656c6261742065 x10: 756e69746e6f6320
>     [   10.916610] x9 : 0000000000000058 x8 : ffff000008570998
>     [   10.921974] x7 : 203a726f72724520 x6 : 0000000000000334
>     [   10.927338] x5 : 0000000000000012 x4 : 0000000000000000
>     [   10.932701] x3 : 0000000000000000 x2 : ffff000009a8bb28
>     [   10.938065] x1 : 0000000000000000 x0 : ffff000008505790
>     [   10.943430] Process swapper/0 (pid: 1, stack limit =
> 0x(____ptrval____))
>     [   10.950199] Call trace:
>     [   10.952663]  acpi_ps_peek_opcode+0x1c/0x40
>     [   10.956797]  acpi_ps_create_op+0x54/0x278
>     [   10.960842]  acpi_ps_parse_loop+0x1b4/0x6c8
>     [   10.965063]  acpi_ps_parse_aml+0xe0/0x2b4
>     [   10.969108]  acpi_ps_execute_table+0xa0/0x104
>     [   10.973505]  acpi_ns_execute_table+0x120/0x194
>     [   10.977989]  acpi_ns_parse_table+0x34/0x68
>     [   10.982122]  acpi_ns_load_table+0x4c/0xbc
>     [   10.986169]  acpi_tb_load_namespace+0x1d4/0x240
>     [   10.990744]  acpi_load_tables+0x50/0xbc
>     [   10.994614]  acpi_init+0xb8/0x374
>     [   10.997959]  do_one_initcall+0x54/0x208
>     [   11.001829]  kernel_init_freeable+0x224/0x300
>     [   11.006229]  kernel_init+0x18/0x118
>     [   11.009747]  ret_from_fork+0x10/0x18
>     [   11.013354] Code: aa0003f3 aa1e03e0 d503201f f9400661 (39400020)
>     [   11.019535] ---[ end trace 2bd8068593cf8acc ]---
>     [   11.024195] Kernel panic - not syncing: Fatal exception
>     [   11.029488] SMP: stopping secondary CPUs
>     [   11.033480] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Which does appear to be the result of some bad data in the table, but it was
> working with 4.17, and reverting this commit solves the problem.

But this commit fixes another regression which was more widespread.

Apparently, we can't work around all of the errors in the tables out
there at the same time. :-/

> Also the messages now newly being prefixed with '\n' are slightly corrupted
> like:
>
> "3ACPI BIOS Error (bug):"
>
> because the KERN_XXX macro is being encoded after the CR which keeps it from
> being processed correctly.

Yes, that's a known issue which should be fixed in -rc4.

Thanks,
Rafael
