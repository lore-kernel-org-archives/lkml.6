Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AECBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29491218D2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNh8du/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBHUoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:44:55 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32903 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBHUoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:44:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so2098545pgu.0;
        Fri, 08 Feb 2019 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ei5g7QsUBr7vW9u/hcQrWLTPOqj3cRmHBYMwfxT7eGo=;
        b=ZNh8du/zEGsAuuNS7qyLKDJw6RB0ZhEMtzTuVPQVzHy/JDeK04OR+BLh7JRnxjoWtu
         LT4LlWocTYy0mhjrAGTvwSB10XOUcjGwVDxZXUc4FmIjq4Xm7odvcZgTSa9vt2gZGxHR
         AZHp2rOJ77pqH9bj6CsoeJS6Lca2gJD3LgrkSuJlWkCj1A6qLQdfdO2F5XorFXhW3BY3
         lK8wG10m6MO7AC+D/qHDh1niP8UWde3c2Ydl3VgECsJgQvsFiH7dKIrybhdFcxi6aGQN
         RbH2d0K23LytrwPJQGYsPCUa5DHYn7JFyjNyG83h7Yf1+B+3CEwe4Ti9s/FqcmIPCcE9
         HMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ei5g7QsUBr7vW9u/hcQrWLTPOqj3cRmHBYMwfxT7eGo=;
        b=Vr+fO41uE6XCp1eH/2boy5GusYGQCC4/P9oM/euvJaZEuFKAt93DLce6Hu6iupeqOO
         2mC1krqKvFskG/KTCcRjr+6DTRpQGUx64KhEiZsMciVPnfrRKvWnq+Ry/2HLg4Lfqu3H
         6+NiqQiI4PobGY0FOYxrgsmC8YDvoQ8/sRReZ+uVPMoRXT5gqb4lhNP+S+pWHJ3bemay
         grbM+oortac6/0k4E4B4nmuEZjTTGMlWy2s9EOWY4ECYbR/5OXxK3U/uf/OXlGwc8xRS
         F2aEWaZfwsAON7ssrogItPpdJxBVnugCKeuUPXhZnia951U5qpBudSs3ttfFHIKHnuZ6
         N97w==
X-Gm-Message-State: AHQUAuY62EdhYwO6rY6V6JhjoY1hHSqKI6ZOq1x1MybSxwckSocT9BT3
        lwRIxm4Yn2BQoRIToDLu+ac=
X-Google-Smtp-Source: AHgI3IYEoaxNcxZkreBxHIrDDyAY3FPFnfCFyiD4b0UJVXtJ6ugDfeJk7JQwqQb0yB9Apw4naz+STA==
X-Received: by 2002:a62:5007:: with SMTP id e7mr24184105pfb.92.1549658694157;
        Fri, 08 Feb 2019 12:44:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 10sm3582110pfq.146.2019.02.08.12.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:44:52 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:44:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     fanc.fnst@cn.fujitsu.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@redhat.com, thomas.lendacky@amd.com,
        yamada.masahiro@socionext.com, caoj.fnst@cn.fujitsu.com,
        jgross@suse.com, mingo@kernel.org, keescook@chromium.org,
        x86@kernel.org, hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190208204451.GA14024@roeck-us.net>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190208191024.GL674@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208191024.GL674@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 08:10:24PM +0100, Borislav Petkov wrote:
> On Fri, Feb 08, 2019 at 11:02:48AM -0800, Guenter Roeck wrote:
> > Hi,
> > 
> > On Fri, Feb 01, 2019 at 03:01:11AM -0800, tip-bot for Chao Fan wrote:
> > > Commit-ID:  3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
> > > Gitweb:     https://git.kernel.org/tip/3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
> > > Author:     Chao Fan <fanc.fnst@cn.fujitsu.com>
> > > AuthorDate: Wed, 23 Jan 2019 19:08:48 +0800
> > > Committer:  Borislav Petkov <bp@suse.de>
> > > CommitDate: Fri, 1 Feb 2019 11:52:55 +0100
> > > 
> > > x86/boot: Early parse RSDP and save it in boot_params
> > > 
> > > The RSDP is needed by KASLR so parse it early and save it in
> > > boot_params.acpi_rsdp_addr, before KASLR setup runs.
> > > 
> > > RSDP is needed by other kernel facilities so have the parsing code
> > > built-in instead of a long "depends on" line in Kconfig.
> > > 
> > >  [ bp:
> > >     - Trim commit message and comments
> > >     - Add CONFIG_ACPI dependency in the Makefile
> > >     - Move ->acpi_rsdp_addr assignment with the rest of boot_params massaging in extract_kernel().
> > >  ]
> > > 
> > 
> > This patch causes x86_64 boots with efi32 bios to crash early and hard
> > (before any console output is seen).
> > 
> > Sample qemu command line:
> > 
> > qemu-system-x86_64 -kernel arch/x86/boot/bzImage -M q35 -cpu SandyBridge \
> > 	-no-reboot -snapshot -smp 4 \
> > 	-bios OVMF-pure-efi-32.fd \
> > 	-m 1G \
> > 	-usb -device usb-storage,drive=d0 \
> > 	-drive file=rootfs.squashfs,if=none,id=d0,format=raw \
> > 	--append 'earlycon=uart8250,io,0x3f8,9600n8 root=/dev/sda rootwait panic=-1 console=ttyS0' \
> > 	-nographic
> > 
> > This is with qemu 3.1, though details other than "-bios OVMF-pure-efi-32.fd"
> > don't really matter.
> > 
> > Files used above are available from https://github.com/groeck/linux-build-test/.
> > 
> > The patch can not be reverted alone, but
> > 
> > Revert "x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only"
> > Revert "x86/boot: Parse SRAT table and count immovable memory regions"
> > Revert "x86/boot: Early parse RSDP and save it in boot_params"
> > 
> > fixes the problem.
> 
> Does it per chance at least continue booting if you return 0 and early
> from efi_get_rsdp_addr() ?
> 
Yes, the kernel boots if I comment out that function and have it return 0.

Guenter

> Chao, pls take a look.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
