Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E9D3C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A766208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CstXkL48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A766208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754726AbeFNH6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:58:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46513 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752795AbeFNH6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:58:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so5295881wrp.13;
        Thu, 14 Jun 2018 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dHZRoPHZOud8EpX7tT5aX1IoTSv7u5WgCz3AlZ3sjOE=;
        b=CstXkL48iah7cd/XcxX/GJeRmByPwJAcDPTOdQirJ3YXUoftBNNxmMU6zW3MwYr51z
         Bl9mAE07SsOxbAYTWq3Lrm3aLCyJjIglbV3VwXps/fV3x7pg/w8xgPHlVfuuILpaNNFX
         OnDiF4cVuh4Epx226b2JBT8p+SsbD8goHB5IMGG/DGoKCA0+JEcJ8HQuqC4f8bPN4CLA
         eAbdMGujglTazwT1215J2v+l1c96mSyOn+TiMKYidahsUwxGEzuxU7SI2lW1sU3/Wt0h
         FhRNSr/8RhmlnxVfTACkP8Puiz15yIOEaZkIaZkcRQzTpYrIut2jLiEjnW8TrAUFZFGt
         CBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dHZRoPHZOud8EpX7tT5aX1IoTSv7u5WgCz3AlZ3sjOE=;
        b=ePoeorvqar2rBCzFreU6I9pWDlzwf4wtVZc3i1VA4JC4mme1HfbJbUjIej/V9B8C0I
         AnHfNIrRpeaCuG+8Hn6LajtDNwEWovfL+CyN92VwOg4knzGTMi7mEFomDotnbjjWrzw0
         yKUbZeADI3DE277J2XsTxcYtmNYf4QszSTQw9ehYXthBwZxXoLvkCMyqre0itiskZiWa
         f5jPImOJsTfFGqWLb/Usc5N1TmUJXgv8ARcv+TddBJ3JgPo8EjOvJW2XluUssl63kqvO
         cxSkcgODHu9nZMxAFJfdS+Ymk41kwdcuEVzhiMqdC90iXpJ+Cg5x4HUggT7kBFVWuv6/
         xJuw==
X-Gm-Message-State: APt69E09EGXmUEc28A1mV3X3laZxLv/oLNlYRMM7VHOD+9r5BTKai8Ux
        W3RQ/FZdVv0VrNr6ot6isewZpTJizLo7KgTzVww=
X-Google-Smtp-Source: ADUXVKKruPOGa/i+zvh5FUuou7/ClkkQ6WPuLoTEmggufseHDHDaXyXTlxLIHMEUL/FubJguzgA0TeGHSCWY/LnOZ90=
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr1175163wrr.105.1528963129845;
 Thu, 14 Jun 2018 00:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:8271:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 00:58:49
 -0700 (PDT)
In-Reply-To: <20180523144621.GB25143@pd.tnic>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com> <20180523144621.GB25143@pd.tnic>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 14 Jun 2018 09:58:49 +0200
Message-ID: <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
Subject: Re: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
To:     Borislav Petkov <bp@suse.de>
Cc:     Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, felix@feldspaten.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 4:46 PM, Borislav Petkov <bp@suse.de> wrote:
> + Tom and Brijesh.
>
> On Mon, May 21, 2018 at 10:12:53AM -0500, Janakarajan Natarajan wrote:
>> Use Kconfig imply 'option' when specifying SEV CRYPTO dependencies.
>>
>> Example configuration:
>> .
>> .
>> CONFIG_CRYPTO_DEV_CCP=y
>> CONFIG_CRYPTO_DEV_CCP_DD=m
>> CONFIG_CRYPTO_DEV_SP_CCP=y
>> CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
>> CONFIG_CRYPTO_DEV_SP_PSP=y
>> .
>> .
>> CONFIG_KVM_AMD=y
>> CONFIG_KVM_AMD_SEV=y
>> .
>> .
>>
>> When the CRYPTO_DEV_SP_DD is m, KVM_AMD set to y produces compile time
>> errors.
>>
>> Since KVM_AMD_SEV depends on KVM_AMD and CRYPTO_DEV_CCP_DD, the
>> issue can be prevented by using 'imply' Kconfig option when specifying
>> the CRYPTO dependencies.
>>
>> Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for SEV")
>>
>> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
>> ---
>>  arch/x86/kvm/Kconfig | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>> index 92fd433..d9b16b7 100644
>> --- a/arch/x86/kvm/Kconfig
>> +++ b/arch/x86/kvm/Kconfig
>> @@ -85,7 +85,9 @@ config KVM_AMD_SEV
>>       def_bool y
>>       bool "AMD Secure Encrypted Virtualization (SEV) support"
>>       depends on KVM_AMD && X86_64
>> -     depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
>> +     imply CRYPTO_DEV_CCP
>> +     imply CRYPTO_DEV_CCP_DD
>> +     imply CRYPTO_DEV_SP_PSP
>>       ---help---
>>       Provides support for launching Encrypted VMs on AMD processors.
>
> Well, this solves the build issue but I just created a config:
>
> $ grep -E "(KVM|PSP)" .config | grep -v '#'
> CONFIG_HAVE_KVM=y
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQFD=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_HAVE_KVM_EVENTFD=y
> CONFIG_KVM_MMIO=y
> CONFIG_KVM_ASYNC_PF=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
> CONFIG_KVM_VFIO=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_KVM_COMPAT=y
> CONFIG_HAVE_KVM_IRQ_BYPASS=y
> CONFIG_KVM=y
> CONFIG_KVM_AMD=m
>
> which builds but the PSP functionality is not there. And I don't think
> this is serving the user: she should be able to select what she wants
> and get the required functionality added and not have build errors with
> any possible configuration.
>
> Now, looking at the security processor Kconfig stuff, it is somewhat
> confusing but maybe I didn't look at it long enough. A couple of points:
>
> config CRYPTO_DEV_CCP_DD
>         tristate "Secure Processor device driver"
>
> If this is going to be the top-level menu item for the SP, call that
>
>  CRYPTO_DEV_SP
>
> to mean, this is the security processor. CCP_DD is confusing because you
> have CRYPTO_DEV_SP_CCP which is the crypto coprocessor support.
>
> And "DD" for device driver is a pure tautology - most of the Kconfig
> items are device drivers :)
>
> Then,
>
>  config KVM_AMD_SEV
>         def_bool y
>         bool "AMD Secure Encrypted Virtualization (SEV) support"
>         depends on KVM_AMD && X86_64
>         depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
>
> that last line is pulling the required functionality for SEV but - and
> I *think* we have talked about this before - having a hierarchical
> dependency should make this a lot clearer and fix the build issues along
> the way.
>
> Because, IMHO, KVM_AMD_SEV should depend only on CRYPTO_DEV_SP_PSP -
> i.e., the PSP device because SEV needs the PSP, right?
>
> Now, the PSP device *itself* should depend on whatever it needs to
> function properly, CRYPTO_DEV_CCP_DD I guess.
>
> But SEV should not depend on CRYPTO_DEV_CCP - which is the top-level
> Kconfig item - that should be expressed implicitly through the
> dependency chain where PSP ends up depending on it.
>
> So that you have one-hop deps:
>
> KVM_SEV -> PSP -> CCP -> ...
>
> IOW, a config item, say PSP - if enabled - should make sure it
> selects/depends on everything it needs to function. The upper level
> item KVM_SEV - which selects/depends on that config item shouldn't
> be responsible for making sure the correct items for PSP's proper
> functioning are enabled - that's PSP's item's job.
>
> Makes sense?
>
> Maybe I'm missing something but applying this simple logic would prevent
> such Kconfig build issues and make the whole dependency chain almost
> trivial.
>
> Thx.

*kind ping*

Felix just reported me that build failure too.

-- 
Thanks,
//richard
