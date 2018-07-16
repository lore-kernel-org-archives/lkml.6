Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D389ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5FF208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMa7qeXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5FF208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeGPRIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:08:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33066 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeGPRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:08:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so23676328wrp.0;
        Mon, 16 Jul 2018 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=401ZSD5NNSKBCcfDmLLQE09i7/NmYzXE/XpPlG6jR4I=;
        b=cMa7qeXsjvmhYL1UpktcgAq5v8wCreIKkm7D6AxfsaekCfOVzjSEZbXJxh5MgiWmKc
         U7gqJDFE+zDwmvyYnL6gwdjy5IrovMgvRm22OUDW8O5GSjoiaEURstnUm2IbLrJ3Esp/
         dBd6HG/2jcI66Jv4VIGHMke1ua1uS74mcWA5C0H8TZiGMjmTNzOUHMZvcpyy5lIL4fd1
         8EakyINV5zmplPd+Dd+f4yJBje0b24SR6NaBsQaokrWGVlyOj0vPy7YBd1wmDbXAJArr
         Uo6rQMmI1dqxkk8XEQSqi+w85VxYh9mJSNNo8gAr0dUljJxROXKAt25a0pOxOLP+5/vN
         lJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=401ZSD5NNSKBCcfDmLLQE09i7/NmYzXE/XpPlG6jR4I=;
        b=ixlMXwJy7ZpCqNgAJd+RJUy+l+iEbrIhtRUy+WepP1RO5iQgdMyWr91mZmyf7pjALf
         3ylKQVaM5yPcwBu314z8t9KKY1qqdyx0+5bKJTn9heSBDuuWu+lK/NIGWMATr29/j0hd
         6cCQTMBBw3B305qbpyx5fxLehmoMiKK0AExfi/JkHCv+B8PTiia4FDIQa8LtI3IHp+wI
         eVDuAJVyHpJEQFofkG8c3p911waJBOhI0Wu/5l/NJ33tJxsu/TG72GRQAGWqOvHwx93H
         Q95alee7h0vqcvFa5OHqjhGDIx8cIzO9xuwF38HCJzYnW+92Gtcwg7vLNAoJYwPBTohG
         F4OA==
X-Gm-Message-State: AOUpUlFIQL8aSjh+4fphumNMU31bYaf3gsjP4v3YKJcAGLkHM3ZBrUSD
        h2mWPPQo9irMQsOgG6or3UQ=
X-Google-Smtp-Source: AAOMgpdoTTJgK1c0V8nr+LX+4nXDiZ6jUucofZT/WbhOz5Sb1oc1TTEjyG5jjdGFu7fsRsSrUNDBIA==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr12509506wrr.236.1531759236365;
        Mon, 16 Jul 2018 09:40:36 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 189-v6sm19845352wmd.17.2018.07.16.09.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 09:40:35 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:40:33 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.17 00/67] 4.17.7-stable review
Message-ID: <20180716164033.GA4286@flashbox>
References: <20180716073443.294323458@linuxfoundation.org>
 <20180716163338.GD12065@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716163338.GD12065@roeck-us.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:33:38AM -0700, Guenter Roeck wrote:
> On Mon, Jul 16, 2018 at 09:34:29AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.17.7 release.
> > There are 67 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Jul 18 07:34:11 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 134 pass: 134 fail: 0
> Qemu test results:
> 	total: 171 pass: 159 fail: 12
> Failed tests: 
> 	i386:Broadwell:q35:defconfig:smp:rootfs 
> 	i386:Skylake-Client:q35:defconfig:smp:rootfs 
> 	i386:SandyBridge:q35:defconfig:smp:rootfs
> 	i386:Haswell:pc:defconfig:smp:rootfs 
> 	i386:Nehalem:q35:defconfig:smp:rootfs 
> 	i386:phenom:pc:defconfig:smp:rootfs 
> 	i386:Opteron_G5:q35:defconfig:smp:initrd 
> 	i386:Westmere:q35:defconfig:smp:initrd 
> 	i386:core2duo:q35:defconfig:nosmp:rootfs 
> 	i386:Conroe:pc:defconfig:nosmp:rootfs 
> 	i386:Opteron_G1:pc:defconfig:nosmp:initrd
> 	i386:n270:q35:defconfig:nosmp:rootfs
> 
> All 32-bit i386 boot tests crash.
> 
> [    0.000000] BUG: unable to handle kernel NULL pointer dereference at 00000000
> [    0.000000] *pde = 00000000 
> [    0.000000] Oops: 0002 [#1] SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.7-rc1+ #1
> [    0.000000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/24
> [    0.000000] EIP: zero_resv_unavail+0x9b/0x103
> [    0.000000] EFLAGS: 00200002 CPU: 0
> [    0.000000] EAX: 00000000 EBX: 00000000 ECX: 00000008 EDX: 00000000
> [    0.000000] ESI: c6bc5e90 EDI: 00000000 EBP: c6bc5eac ESP: c6bc5e80
> [    0.000000]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
> [    0.000000] CR0: 80050033 CR2: 00000000 CR3: 06d67000 CR4: 00040690
> [    0.000000] Call Trace:
> [    0.000000]  free_area_init_nodes+0x407/0x44c
> [    0.000000]  zone_sizes_init+0x45/0x5c
> [    0.000000]  paging_init+0xac/0xaf
> [    0.000000]  native_pagetable_init+0xc6/0xce
> [    0.000000]  setup_arch+0x9c6/0xb18
> [    0.000000]  start_kernel+0x4f/0x3d2
> [    0.000000]  ? idt_setup_early_handler+0x2b/0x3e
> [    0.000000]  i386_start_kernel+0x95/0x99
> [    0.000000]  startup_32_smp+0x164/0x168
> 
> Guenter

I think this is caused by 3e3eda67092b ("mm: zero available pages before
memmap init"). A fix for it was posted to the mailing list this morning:
https://lore.kernel.org/lkml/20180716151630.770-1-pasha.tatashin@oracle.com/

Cheers,
Nathan
