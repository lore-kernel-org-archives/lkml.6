Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9748AC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377092098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4MR43tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377092098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeIYDst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:48:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45406 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeIYDss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:48:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id t70-v6so5076220pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 14:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grA2cicWCG5l4/SBt01ynilvSGTJ06kX8fsbGHrd7ss=;
        b=D4MR43tJfgO4kh/JXIyTUmLBIaKvBtk9y/aFlzSLa7ZYy8VAo9MDxrYmHkSwZG7Dm3
         BVTY8968F5iQW2GqzrnzCrv4Wa05n5aw511wLrDXUOkTdzDweNHl/Dfs8G0cHqpDSDYb
         5zDJNOOxqY7p6NqrNKXAC28xAWexlRVkFcR3eZODj5GFmoBfrsVPzonviN11+vQ87yR0
         L59buxi1E202K10k23R4hkRf/vl26tIXY8aiqTBMytlN/Zpq6WOx28+7XJnJbJgHY3Gv
         2nHx5tEqldECMecxz4xxdKRv5E9QY0UDjaT9tT3sD7yMBTWhmQaNl4wKjTqstajc6mVC
         LfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grA2cicWCG5l4/SBt01ynilvSGTJ06kX8fsbGHrd7ss=;
        b=q5D89/gOjfliSSPbWqX4+wbwDZiL4skNoceO4HvY8Qnw/khyb0X1l0fqLHnpW7uRwj
         IBGLHUVy2F5CbkEr1RoAZeAfpGBhPYVQlev13uxZlX38LX2yZ1o9uDKfp8ipcSt6VI22
         ++Ke9fIVg9aMsAocl9LXwQPzUva4EzPFhtjIjRi/HjwwuzBx4clKDOtQoWXApGt6DSai
         HzoXpeAM1P9UbbfcWzH27sBJzhXw3Epleabr6kLKlFVkvFv7NaHetYaRfPiI0CcNxw5H
         ITttpewHxMVveAwVvIBa/RrcXzZf2Xj+tedjFpr790zZTE7UNXeON/T5jjIOn/td6d34
         Kg4Q==
X-Gm-Message-State: ABuFfoi8HbMDAbE+qP3+6GLFcQj6dxqiDcNRgZokTLgvmB9VtBosW3QC
        uo+LojQLA7GaWMli+coZeHXzBeHwcKpb2lG8ckRDXw==
X-Google-Smtp-Source: ACcGV62WLHiP2g2VVJWFyZk/ZvmTZxKhoGNU8j2oYqjnZTO5p0RqA7FWglRDUq2As8+EU8k7TOdk6U4B9YU1eaadkxI=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr576897plf.320.1537825471615;
 Mon, 24 Sep 2018 14:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180924172615.25591-1-natechancellor@gmail.com>
 <33c9afa7-ea62-1248-1da4-381f93238627@amd.com> <CAKwvOdkc=OymUoszBR7+QLiOfV2T_GiQ2Oom_C=Ebz76YU_sPw@mail.gmail.com>
 <a0640c0d-6186-01d5-fa56-74be64f9895a@amd.com>
In-Reply-To: <a0640c0d-6186-01d5-fa56-74be64f9895a@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 14:44:20 -0700
Message-ID: <CAKwvOdkf4pBpoLSHiWg0CZfnmCzMvUAT_Zsc4QFOUk9No5qGrA@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
To:     ghook@amd.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas.Lendacky@amd.com, Gary.Hook@amd.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 2:27 PM Gary R Hook <ghook@amd.com> wrote:
>
> On 09/24/2018 03:24 PM, Nick Desaulniers wrote:
> > On Mon, Sep 24, 2018 at 12:18 PM Gary R Hook <ghook@amd.com> wrote:
> >>
> >> On 09/24/2018 12:26 PM, Nathan Chancellor wrote:
> >>> Clang emits a warning about this construct:
> >>>
> >>> drivers/crypto/ccp/sp-platform.c:36:36: warning: tentative array
> >>> definition assumed to have one element
> >>> static const struct acpi_device_id sp_acpi_match[];
> >>>                                      ^
> >>> 1 warning generated.
> >>>
> >>> Just remove the forward declarations and move the initializations up
> >>> so that they can be used in sp_get_of_version and sp_get_acpi_version.
> >>
> >> I'm not going to out and out object to this just yet.
> >
> > Tentative array definitions need to have the correct length specified;
> > it should either be forward declared as the correct length, or as this
> > patch does, skip the forward declare and move up the definition.
> > Thanks for this patch Nathan.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>
> Checked my C99, and using both static and [] to create a declaration

Note that the kernel uses gnu89, which is ISO C90 + gnu extensions (IIUC).

> (because it's really a definition) apparently isn't valid. I should have
> known that. Since I'm old school...
>
> Acked-by: Gary R Hook <gary.hook@amd.com>
>
>
> >
> >>
> >> I am not a clang expert. Can you please provide a make command that
> >> would explain how you precipitated this complaint?
> >>
> >>
> >>> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> >>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >>> ---
> >>>    drivers/crypto/ccp/sp-platform.c | 53 +++++++++++++++-----------------
> >>>    1 file changed, 25 insertions(+), 28 deletions(-)
> >>>
> >>> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
> >>> index 71734f254fd1..b75dc7db2d4a 100644
> >>> --- a/drivers/crypto/ccp/sp-platform.c
> >>> +++ b/drivers/crypto/ccp/sp-platform.c
> >>> @@ -33,8 +33,31 @@ struct sp_platform {
> >>>        unsigned int irq_count;
> >>>    };
> >>>
> >>> -static const struct acpi_device_id sp_acpi_match[];
> >>> -static const struct of_device_id sp_of_match[];
> >>> +static const struct sp_dev_vdata dev_vdata[] = {
> >>> +     {
> >>> +             .bar = 0,
> >>> +#ifdef CONFIG_CRYPTO_DEV_SP_CCP
> >>> +             .ccp_vdata = &ccpv3_platform,
> >>> +#endif
> >>> +     },
> >>> +};
> >>> +
> >>> +#ifdef CONFIG_ACPI
> >>> +static const struct acpi_device_id sp_acpi_match[] = {
> >>> +     { "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
> >>> +     { },
> >>> +};
> >>> +MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
> >>> +#endif
> >>> +
> >>> +#ifdef CONFIG_OF
> >>> +static const struct of_device_id sp_of_match[] = {
> >>> +     { .compatible = "amd,ccp-seattle-v1a",
> >>> +       .data = (const void *)&dev_vdata[0] },
> >>> +     { },
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, sp_of_match);
> >>> +#endif
> >>>
> >>>    static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
> >>>    {
> >>> @@ -201,32 +224,6 @@ static int sp_platform_resume(struct platform_device *pdev)
> >>>    }
> >>>    #endif
> >>>
> >>> -static const struct sp_dev_vdata dev_vdata[] = {
> >>> -     {
> >>> -             .bar = 0,
> >>> -#ifdef CONFIG_CRYPTO_DEV_SP_CCP
> >>> -             .ccp_vdata = &ccpv3_platform,
> >>> -#endif
> >>> -     },
> >>> -};
> >>> -
> >>> -#ifdef CONFIG_ACPI
> >>> -static const struct acpi_device_id sp_acpi_match[] = {
> >>> -     { "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
> >>> -     { },
> >>> -};
> >>> -MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
> >>> -#endif
> >>> -
> >>> -#ifdef CONFIG_OF
> >>> -static const struct of_device_id sp_of_match[] = {
> >>> -     { .compatible = "amd,ccp-seattle-v1a",
> >>> -       .data = (const void *)&dev_vdata[0] },
> >>> -     { },
> >>> -};
> >>> -MODULE_DEVICE_TABLE(of, sp_of_match);
> >>> -#endif
> >>> -
> >>>    static struct platform_driver sp_platform_driver = {
> >>>        .driver = {
> >>>                .name = "ccp",
> >>>
> >>
> >
> >
>


-- 
Thanks,
~Nick Desaulniers
