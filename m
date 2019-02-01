Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69BAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7254C20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhYUN36w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfBAWSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:18:34 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35038 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfBAWSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:18:34 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so12256099itp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 14:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kyy0ek5GfntFjkRqcbE0N6jOjkBWQ0WDzHgq+JL9DK8=;
        b=WhYUN36wOddX/3O2nAP1OCelMJpSPoPV9K/8qIWw4ZZ18YQ5mkK7cFksKcIve/Jjny
         xEg18YCXX7va5+bsJp9jz/3WU3ac7fMbD1U6Ctl7HgcvUXHxC4tFvkuH1FyLCfrT2cVr
         WvV09nvfo/cEuEEt0SCerl71joxEMyOjknw7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kyy0ek5GfntFjkRqcbE0N6jOjkBWQ0WDzHgq+JL9DK8=;
        b=bi0dcow7bGxiyFs/M0tCQ8S6vwvMQq1wabOFRKjL+isDA7RP3r/n3HHSJIQrEI0EU9
         MN4IzIyWGDi9oByg4+/y0JPXjhO7qy900Ba0tutSyg5p+iT1DIr2HZRWqDRBOPPWZZOi
         LC3aoX406ATZzPmFqJxpBwJlPD/6YfWKeeUt2Ebn9MY9JXP+E71k3qFwlI9tHAb3AP9l
         M0G6weTQmYEVuTrI6y4gEjzEeRMVA5bGkwzrFMUeDbxpRyditxTAERbfmqAeEGO0y1Lj
         VwVovBOoOO5vexleAim/lDi0ZDHpVaa/GqOOQ/BhReYbcs4/Kk4PvDVdWIlmAoFs777Z
         f/ZQ==
X-Gm-Message-State: AHQUAuZEkkgIL9WfdE2lkXmypTjWN3jcwAJ4CoMGdtJ3gQ5kiccQhI+6
        Vb13KIzuL7r1QbyeKsps4JH4irUI8b4TamNh7QsJyQ==
X-Google-Smtp-Source: AHgI3IYztE79pcFL2PmgAPLt5NhgKbUJzcKAZwIF6GjF+MICRCLjvoJekTuDKhCUGOm5gd9192jW7Tq8JIGE0oklv7o=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr2973906itk.71.1549059513045;
 Fri, 01 Feb 2019 14:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201192001.6495-1-natechancellor@gmail.com>
In-Reply-To: <20190201192001.6495-1-natechancellor@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 1 Feb 2019 23:18:22 +0100
Message-ID: <CAKv+Gu9tcpZvMZdbD0D+EUCTbdnszv3+MHM68utLZssuMcxyZw@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: Don't expect a return value of ptdump_debugfs_register
To:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2019 at 20:21, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> As of commit e2a2e56e4082 ("arm64: dump: no need to check return value
> of debugfs_create functions") in the arm64 for-next/core branch,
> ptdump_debugfs_register does not have a return value, which causes a
> build error here:
>
> drivers/firmware/efi/arm-runtime.c:51:9: error: returning 'void' from a
> function with incompatible result type 'int'
>         return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
>
> The arm version is still awaiting acceptance [1] but in anticipation
> of that patch being merged, restructure this function to call
> ptdump_debugfs_register without expecting a return value.
>
> [1]: https://lore.kernel.org/lkml/20190122144114.9816-3-gregkh@linuxfoundation.org/
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


Catalin, Will,

Could you please apply this directly?

> ---
>  drivers/firmware/efi/arm-runtime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 23ea1ed409d1..7ae3b797caf8 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -45,10 +45,10 @@ static struct ptdump_info efi_ptdump_info = {
>
>  static int __init ptdump_init(void)
>  {
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> -               return 0;
> +       if (efi_enabled(EFI_RUNTIME_SERVICES))
> +               ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
>
> -       return ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
> +       return 0;
>  }
>  device_initcall(ptdump_init);
>
> --
> 2.20.1
>
