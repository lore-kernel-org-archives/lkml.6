Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1742BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961E320C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT7NUroM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 961E320C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIYBoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:44:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40214 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeIYBob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:44:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id o2-v6so4648519wmh.5;
        Mon, 24 Sep 2018 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bu1tGZiAYWThOPGodE/1SWKaK7/sH3GquVcprXHW2no=;
        b=rT7NUroMWrUciSpYa4Vsjai2TclrLkaCwPW2jAoKfLufa25V0IHsStsWmtYPn7Vs0m
         smhF2CweRRXHOEDd1T+kI/717VOiuDbck6cEVtGHTVy/d4+0KR0JJAFRTLtVbGgwuQQX
         ggU5wuH+IiPwLkkVSLcA4GcgC/OgkxMaTx4d7YIk9/dTYHDDmyPTpegfAVGWGOssewna
         kFwyB+HAdw2N/eezgjbXHWJCnltBok4Z3k985vD3naflnMGU/gTruFV+C3hj6aQAY4q0
         XoHbAFkEO4qc33F2Cfs+T/HdVn1yq6MjW8mrhqRPb1S/c2JEcCOvSlw1kicubqINNsYj
         DbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bu1tGZiAYWThOPGodE/1SWKaK7/sH3GquVcprXHW2no=;
        b=WHt1x4GJvRfNMqKSHx1kNENj7YYtg47fbYJnnnZfY+ZObtXFuMplzme8nG9jimy0yV
         2juKEtxZ746jpW+jRbjcy4gT1Pv1F56FC9Zv1h69lr0TL69acGh8/dUHjutglzhuWZmz
         IwilSfyLLaA7euy0AWAqVFeG5q1HxQBsCvunpR+YVxnkE/a/mEEXEVfAjJOW0HLhGPUG
         h1sqGXgO5pbk1cuBphFZAW9gyuoj8mYfoNsnNZD85UUCppmWpAEHFC4OqDia1AGYOVWw
         Q1yOxYjpBuP/mAKObQuXLg00E1JK9tEGBYaF+cED9ejP8DlxKJN5h9LdHqNlGmIZlGWX
         vFQg==
X-Gm-Message-State: ABuFfogMMbJLiFw7Vy46s0v7PopYbFt/a4kGduYZLA39tvsgMOal6bvM
        jVn/v1+IjQAOGvXNvmxFYYyPfCa+NhLirQ==
X-Google-Smtp-Source: ANB0VdZGgFbMllhFdJzzPZIgQElm06GODDJgrmqvMt/+FS4+4Y8So0HXrk4j4RcNrGTXJezzHTd0RQ==
X-Received: by 2002:a1c:2384:: with SMTP id j126-v6mr6450153wmj.124.1537818042760;
        Mon, 24 Sep 2018 12:40:42 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm267027wrp.40.2018.09.24.12.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 12:40:41 -0700 (PDT)
Date:   Mon, 24 Sep 2018 12:40:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Gary R Hook <ghook@amd.com>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] crypto: ccp: Remove forward declaration
Message-ID: <20180924194040.GA17672@flashbox>
References: <20180924172615.25591-1-natechancellor@gmail.com>
 <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c9afa7-ea62-1248-1da4-381f93238627@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 07:18:23PM +0000, Gary R Hook wrote:
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
> 
> I am not a clang expert. Can you please provide a make command that 
> would explain how you precipitated this complaint?
> 

Hi Gary,

I can produce the warning with Clang 6.0 using the following set of
commands:

make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- allyesconfig
./scripts/config -d CONFIG_CPU_BIG_ENDIAN
make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
make ARCH=arm64 CC=clang CROSS_COMPILE=aarch64-linux-gnu- drivers/crypto/ccp/sp-platform.o

Nathan

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
> >   	unsigned int irq_count;
> >   };
> >   
> > -static const struct acpi_device_id sp_acpi_match[];
> > -static const struct of_device_id sp_of_match[];
> > +static const struct sp_dev_vdata dev_vdata[] = {
> > +	{
> > +		.bar = 0,
> > +#ifdef CONFIG_CRYPTO_DEV_SP_CCP
> > +		.ccp_vdata = &ccpv3_platform,
> > +#endif
> > +	},
> > +};
> > +
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id sp_acpi_match[] = {
> > +	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
> > +#endif
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id sp_of_match[] = {
> > +	{ .compatible = "amd,ccp-seattle-v1a",
> > +	  .data = (const void *)&dev_vdata[0] },
> > +	{ },
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
> > -	{
> > -		.bar = 0,
> > -#ifdef CONFIG_CRYPTO_DEV_SP_CCP
> > -		.ccp_vdata = &ccpv3_platform,
> > -#endif
> > -	},
> > -};
> > -
> > -#ifdef CONFIG_ACPI
> > -static const struct acpi_device_id sp_acpi_match[] = {
> > -	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
> > -	{ },
> > -};
> > -MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
> > -#endif
> > -
> > -#ifdef CONFIG_OF
> > -static const struct of_device_id sp_of_match[] = {
> > -	{ .compatible = "amd,ccp-seattle-v1a",
> > -	  .data = (const void *)&dev_vdata[0] },
> > -	{ },
> > -};
> > -MODULE_DEVICE_TABLE(of, sp_of_match);
> > -#endif
> > -
> >   static struct platform_driver sp_platform_driver = {
> >   	.driver = {
> >   		.name = "ccp",
> > 
> 
