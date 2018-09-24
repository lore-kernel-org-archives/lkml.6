Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD22ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284D7208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfmKtwh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284D7208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeIYC2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:28:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37690 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeIYC2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:28:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id a18-v6so2770947pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 13:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bV0hP9Qc0ekGbCG73pKMXkUUGkTdto1wD0Jzyb8J0WU=;
        b=BfmKtwh8HHYxsub0dFnpLyWoX/gPjzKKjunNodkRiCJZsr80Po4jmr/IJD1FaSmncM
         lrRUz7mY+4COH17eFJB5fMKCIQBtKkZccvSzUbVqpu+6+sMPnSWIb/Vycoarm5MKCWbc
         YMRL6VsnyjXKlPwm/Z7CvDPgb70ks1CXXA++L66/hE7JhsqgCepOixLlXpPZmg2dMWoI
         T9WhJt8LORNDxeRfgMdLV+zJdfPzllAWYFfySt16+Ss/RrvuzC3BVyOrBfSOisgCS1dO
         +WWrdGAIBvO0xKKW1wGwgEUTUlEXo3B0c0BGd9R5nwWi6QDY9HJDcog+/gwYp9HtHLEL
         YHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV0hP9Qc0ekGbCG73pKMXkUUGkTdto1wD0Jzyb8J0WU=;
        b=ClhXBz5WJHjo8SM0p3hDJYlwXGzaJ5yD8kQ48Umwp7TvRKgzIbhxyf6BTJf40a/0t5
         Ha7o8Q7eEzWikCnbuw/DkHoGLPIwVyR7v4i6NMnFdaywf5boB69p379L4u6tEeB/YCzi
         pYBEfHRls4nFtyJRl+U4LjGzzUfbJ5uUk1PHD9EJMh7RMTB57Uxul2vOFJ5UV9f8eDMx
         CBojD5mVIHWhWOP5hUDERaC+kpbugb1y5BfV5Z2LkKIklnuanXx5A5Ovq8SL/MCqCok2
         M+Qh79ARFkwQuzk7S3WNYylLsqKcUkQuGcEkogRgilzlt0LSOHo3QQIBtg6og/YOye1+
         sdlQ==
X-Gm-Message-State: ABuFfojpBD+4OYu4DrqDcPxMeOBwu/PpAselpVsB9DU6/DNsfzHKQcuY
        k6unWo8VJ57HhB+kUgA+iBrlnGViewhksrbSraymfA==
X-Google-Smtp-Source: ACcGV62mu4xLDJvnn2K2UpsWkPneaCn1en4mftu07ZULMLXiVmiYapKgB61xgdxjxMJwhBjD/RLbq8RaaimBz7e+rGE=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr374878plf.320.1537820692127;
 Mon, 24 Sep 2018 13:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180924172615.25591-1-natechancellor@gmail.com> <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
In-Reply-To: <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 13:24:40 -0700
Message-ID: <CAKwvOdkc=OymUoszBR7+QLiOfV2T_GiQ2Oom_C=Ebz76YU_sPw@mail.gmail.com>
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

On Mon, Sep 24, 2018 at 12:18 PM Gary R Hook <ghook@amd.com> wrote:
>
> On 09/24/2018 12:26 PM, Nathan Chancellor wrote:
> > Clang emits a warning about this construct:
> >
> > drivers/crypto/ccp/sp-platform.c:36:36: warning: tentative array
> > definition assumed to have one element
> > static const struct acpi_device_id sp_acpi_match[];
> >                                     ^
> > 1 warning generated.
> >
> > Just remove the forward declarations and move the initializations up
> > so that they can be used in sp_get_of_version and sp_get_acpi_version.
>
> I'm not going to out and out object to this just yet.

Tentative array definitions need to have the correct length specified;
it should either be forward declared as the correct length, or as this
patch does, skip the forward declare and move up the definition.
Thanks for this patch Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> I am not a clang expert. Can you please provide a make command that
> would explain how you precipitated this complaint?
>
>
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >   drivers/crypto/ccp/sp-platform.c | 53 +++++++++++++++-----------------
> >   1 file changed, 25 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
> > index 71734f254fd1..b75dc7db2d4a 100644
> > --- a/drivers/crypto/ccp/sp-platform.c
> > +++ b/drivers/crypto/ccp/sp-platform.c
> > @@ -33,8 +33,31 @@ struct sp_platform {
> >       unsigned int irq_count;
> >   };
> >
> > -static const struct acpi_device_id sp_acpi_match[];
> > -static const struct of_device_id sp_of_match[];
> > +static const struct sp_dev_vdata dev_vdata[] = {
> > +     {
> > +             .bar = 0,
> > +#ifdef CONFIG_CRYPTO_DEV_SP_CCP
> > +             .ccp_vdata = &ccpv3_platform,
> > +#endif
> > +     },
> > +};
> > +
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id sp_acpi_match[] = {
> > +     { "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
> > +#endif
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id sp_of_match[] = {
> > +     { .compatible = "amd,ccp-seattle-v1a",
> > +       .data = (const void *)&dev_vdata[0] },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, sp_of_match);
> > +#endif
> >
> >   static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
> >   {
> > @@ -201,32 +224,6 @@ static int sp_platform_resume(struct platform_device *pdev)
> >   }
> >   #endif
> >
> > -static const struct sp_dev_vdata dev_vdata[] = {
> > -     {
> > -             .bar = 0,
> > -#ifdef CONFIG_CRYPTO_DEV_SP_CCP
> > -             .ccp_vdata = &ccpv3_platform,
> > -#endif
> > -     },
> > -};
> > -
> > -#ifdef CONFIG_ACPI
> > -static const struct acpi_device_id sp_acpi_match[] = {
> > -     { "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
> > -     { },
> > -};
> > -MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
> > -#endif
> > -
> > -#ifdef CONFIG_OF
> > -static const struct of_device_id sp_of_match[] = {
> > -     { .compatible = "amd,ccp-seattle-v1a",
> > -       .data = (const void *)&dev_vdata[0] },
> > -     { },
> > -};
> > -MODULE_DEVICE_TABLE(of, sp_of_match);
> > -#endif
> > -
> >   static struct platform_driver sp_platform_driver = {
> >       .driver = {
> >               .name = "ccp",
> >
>


-- 
Thanks,
~Nick Desaulniers
