Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DA8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F15020852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aj8wXPUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F15020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbeGXB2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:28:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39783 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388188AbeGXB2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:28:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so417630pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Ik4vqvFWx4uxZdQU7M0tyqDzNlpH1K14DGGfZW0wfw=;
        b=aj8wXPUhkMYWc1IjXi6EKvGFcERKWFMKst0S+MRYpTl9/atpeFjASmKaKAQ+3+WVu8
         DKPi/O+H7aea5IxKNRPWf4B7OHMOakFc9NfIeX1YSllCFx/OWAXU1yanrK0DZAfn+dJ2
         lUiLSfNrNMNQCIT6gSaP61GUEMNEJjdVWPn+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=6Ik4vqvFWx4uxZdQU7M0tyqDzNlpH1K14DGGfZW0wfw=;
        b=IOYmTkVE8etQNtYa554coxdLdLz25PlEfmbyUc60vm9lre0LyE4ofDNbyf+ja8GW7K
         brshCehJPzkFMIJ5tOJKOE9Thpd7IjuQpn7ffwJ3ZlCb9xWWt2wJ6exjudGNlPz7FTYa
         6Dou0vvf8TgD6i3PO40HrYOwFW62O2lXM23I8n1c+54hcR7QqXEcnG+wzF8HKWMG501w
         KglSqBMTfguYi/1QFUQ5m6o3LzcS8CtpbmtYWZG8HOHcTqPCw3AiTavKGfS7iMJ4Hr7U
         fJ1zntVgMNJwhkX3DDqP7n7yKL3QDP84eltVX8V5x/aLyr3sOrz/DQpNNA12+Jv8iZaU
         HEOw==
X-Gm-Message-State: AOUpUlGk/uL6lmZZmYXTVmyI6+snRzhlDFmlXJBTpKkvOx42kCFyPg+y
        3QiwHm4DmsFbBJkguZdrGSSv1g==
X-Google-Smtp-Source: AAOMgpeN9tH5Pbs11LaiK0wjw170cVNM6K/P8VyqER1gD2FzuEPvC/XYhcXsD8lcYqMutr/WoXk35g==
X-Received: by 2002:a63:3046:: with SMTP id w67-v6mr13786997pgw.176.1532391902593;
        Mon, 23 Jul 2018 17:25:02 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id n26-v6sm6081686pgv.78.2018.07.23.17.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 17:25:02 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:26:31 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: linux-next: build warning after merge of the arm64 tree
Message-ID: <20180724002630.GV11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180724090545.2270d975@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724090545.2270d975@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:05:45AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the arm64 tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:

Where can I find this specific branch?

> drivers/acpi/Kconfig:6:error: recursive dependency detected!
> drivers/acpi/Kconfig:6:	symbol ACPI depends on EFI

My patch created an additional dependency like:
  menu ACPI
    ...
    depends on IA64 || X86 || (ARM64 && EFI)

> arch/x86/Kconfig:1920:	symbol EFI depends on ACPI

So I don't understand why this change makes a warning on x86_64 build.
Is this a real recursive dependency?

Thanks,
-Takahiro AKASHI

> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> 
> Introduced by commit
> 
>   5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
> 
> -- 
> Cheers,
> Stephen Rothwell


