Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2012C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80EF20868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547762757;
	bh=mieT8utJ1c7Ii977udBFHpJFA4gsN5u3DiUVlKnYU9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wQ3V22RbRneT8xrhNZjFjSw014gXIHkxnhnMo31ECDfG42H6sQUWjvJ/urEGp27mF
	 1N1oSI5DQNU58vUfDeQQJ9Vyqc+Vu6PC4YyOKrmgrs4T/JSWDILZM0tsTk+RxmjMMN
	 zajttpIFWDeSzAPKVx+dg/gCcSyo3jvHKjMLykbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfAQWF4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:05:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47006 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfAQWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:05:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so12563098otm.13;
        Thu, 17 Jan 2019 14:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2P9pw3BKSBunFJh4fgaBf2DidUkRMXl+X71JWADWDfc=;
        b=qQ7JkxLnj07qIga0JuNhGEvGqG0FrJ6yzJNUfIWGh71J0RKoMZte+vNVaG8AzGKteW
         t/pVJw2MoS8dOqS92mZcCimTuAfzmABtk/lBk3zEsvcDjcgbudWNyn1csFlYuNsqBOKm
         9qv1TmRk5BSzcP/6gQyPi2NSjYICYN6/8Y9Khmjfamzi6rpF2OrgR85tB6o8beoK5YJo
         YZl/o9dzbEtgPpZiWaB88EpHa8cBwR7lnXj9KoPwTKqdtgAGYMNOPdIj76VMVWOgmfzO
         Wkuf8k6mIFJ/7F06mYPss41Dm1U27z5ZNEKUll+RiEm1A2oGrSlWF9ySQtaGl1nCLJkF
         1vow==
X-Gm-Message-State: AJcUukeAoyQ3hU0L9/MMaCwe7FpciT5WmqqG1hpdZmZ/LuAXukNtJJ2V
        Euvj2UutwS5BxCf+g3oX029gLK+kagzHTK9db7M=
X-Google-Smtp-Source: ALg8bN72AsPtg/mONon3ITE1vMKXOes+20lrBXXkw9ygF3FoskV1YVPNSA1EQx6I3PZLAQ6fId/ANthCkb4MaRl6Mu4=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr9600354otn.200.1547762754347;
 Thu, 17 Jan 2019 14:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20190117161722.3945-1-okaya@kernel.org> <20190117163722.GE5023@zn.tnic>
 <c0fa174a-2e7b-2ef2-4913-167934c68c06@kernel.org> <20190117215631.GF5023@zn.tnic>
In-Reply-To: <20190117215631.GF5023@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 23:05:43 +0100
Message-ID: <CAJZ5v0hHFASeJb8z8QwQkh-tCs409pnaywtWcqLP5K5ZDGhTsw@mail.gmail.com>
Subject: Re: [for-next][PATCH] x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI
 is enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sinan Kaya <okaya@kernel.org>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:56 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 17, 2019 at 11:42:39AM -0500, Sinan Kaya wrote:
> > On 1/17/2019 11:37 AM, Borislav Petkov wrote:
> > > Also, I see a lot of build failures when doing randconfig builds for the
> > > stuff in drivers/platform/x86/Kconfig. Is someone picking those up too?
> >
> > Can you share the build failures you are seeing?
>
> Here are three configs which fail.
>
> They have in common:
>
> # CONFIG_PCI is not set
>
> As a tip for the future - always build the default
> def/allno/yes/modconfig targets and as many randconfigs as possible when
> changing Kconfig dependencies. I've learned that the hard way.
>
> Here are the build failures:
>
> arch/x86/kernel/ftrace.c:668:23: warning: ‘ftrace_jmp_replace’ defined but not used [-Wunused-function]
> drivers/platform/x86/intel_ips.c: In function ‘ips_probe’:
> drivers/platform/x86/intel_ips.c:1463:2: error: implicit declaration of function ‘pcim_enable_device’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c:1525:2: error: implicit declaration of function ‘pci_alloc_irq_vectors’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c:1525:41: error: ‘PCI_IRQ_LEGACY’ undeclared (first use in this function)
> drivers/platform/x86/intel_ips.c:1525:41: note: each undeclared identifier is reported only once for each function it appears in
> drivers/platform/x86/intel_ips.c:1529:2: error: implicit declaration of function ‘pci_irq_vector’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c:1592:2: error: implicit declaration of function ‘pci_free_irq_vectors’ [-Werror=implicit-function-declaration]
> drivers/platform/x86/intel_ips.c: At top level:
> drivers/platform/x86/intel_ips.c:1636:1: warning: data definition has no type or storage class [enabled by default]
> drivers/platform/x86/intel_ips.c:1636:1: error: type defaults to ‘int’ in declaration of ‘module_pci_driver’ [-Werror=implicit-int]
> drivers/platform/x86/intel_ips.c:1636:1: warning: parameter names (without types) in function declaration [enabled by default]
> drivers/platform/x86/intel_ips.c:1629:26: warning: ‘ips_pci_driver’ defined but not used [-Wunused-variable]
> make[3]: *** [drivers/platform/x86/intel_ips.o] Error 1
> make[2]: *** [drivers/platform/x86] Error 2
>
> drivers/platform/x86/apple-gmux.c: In function ‘gmux_probe’:
> drivers/platform/x86/apple-gmux.c:746:22: error: ‘pci_bus_type’ undeclared (first use in this function)
> drivers/platform/x86/apple-gmux.c:746:22: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [drivers/platform/x86/apple-gmux.o] Error 1
>
> drivers/platform/x86/intel_pmc_ipc.c: In function ‘ipc_pci_probe’:
> drivers/platform/x86/intel_pmc_ipc.c:520:2: error: implicit declaration of function ‘pcim_enable_device’ [-Werror=implicit-function-declaration]
> make[3]: *** [drivers/platform/x86/intel_pmc_ipc.o] Error 1
>
> You get the idea...

I have patches for intel_ips and intel_pmc_ipc queued up (will be
pushed for -rc3), plus some others.  apple-gmux is a new one.
