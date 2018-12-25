Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88359C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F97921773
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545729246;
	bh=hSynMHtpDQG2Q7zvURE8q2PVW426y4TL+3C8eZ50y0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lKksmgakcYkCczSpllmRogtbvYXYqcJF44LhJlsaUd6z601wSxkTNf/iMkoW6pZ9w
	 /1dDvIpRyyJ4tIXeEW8U0vsTZstvKtUG7To/sVxgOr+9J3lfEeRA/uwU6UD2ELv6ti
	 G1rMRmMMR84UCxCOGilT5mFoNcs1Mb78foswxUj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeLYJOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 04:14:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45269 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeLYJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 04:14:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so11205151oie.12;
        Tue, 25 Dec 2018 01:14:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/k4Xq6eNqUpeSx/AmWDFL+gX4X7eSI4DfqGto/llcA=;
        b=jBrlrCldBRt5Igphwd97DbDCYfGP7gTAFWIXk+Bp85ScbolLoeFodi74yYrXSZgAfz
         e2zENORMKfJDgCplu8ks43qp4J4GGnpm+bG0vJEo1q9hWqs2WbGAEBZB9s2CH+5CcjGx
         PlO58CdmV3ETpAV3xzmGP04tejb8sB8f6pk0UTQEqiorAdIoW+gVk9HrBQbnAApzbpKM
         gh47PFCZ1VSQcvmklXJN4BelRPgntJuxZD59XtA5GrpWqsG+hzHYn1OsTfWYvycn5PWt
         0BZ0NaxgPqAlLfXtiKFR/kW4mXE4iT4fPxLpyt46CqRVYusKBtfXZKXRI02Jh5I0qiOR
         6dCA==
X-Gm-Message-State: AA+aEWY6s9bbY/7IDcTs5J+WPbMn0uRZF0n3xdhHUuc2dMuRrvauS5W9
        8bcRDOzg2REJflcooIrM4dPuC77Sz84TNI79JRw=
X-Google-Smtp-Source: AFSGD/Xe5/thS6Zjp9lAlqANYKSUluSP/lI6Sc3asDxu0tPifo8flVaPDER4uOvEd9AV1NTEbhB5loYwZ2Ti1eCl4UA=
X-Received: by 2002:a54:4195:: with SMTP id 21mr10157358oiy.76.1545729242477;
 Tue, 25 Dec 2018 01:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-11-okaya@kernel.org>
In-Reply-To: <20181223232521.11320-11-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Dec 2018 10:13:49 +0100
Message-ID: <CAJZ5v0is-DSV15AxRyNG93vazzQsY_8vM6crzgZXeEmhTyQBVQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] x86: select IOSF_MBI only when CONFIG_PCI is set
To:     okaya@kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 12:25 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Need CONFIG_PCI to be set in order to be able to use IOSF_MBI
> functionality.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

The subject and changelog here don't match the changes below.  Please fix.

> ---
>  arch/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index cc4f0c6ee1ed..322a58ababb0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -617,7 +617,7 @@ config X86_INTEL_QUARK
>
>  config X86_INTEL_LPSS
>         bool "Intel Low Power Subsystem Support"
> -       depends on X86 && ACPI
> +       depends on X86 && ACPI && PCI
>         select COMMON_CLK
>         select PINCTRL
>         select IOSF_MBI
> --
> 2.19.0
>
