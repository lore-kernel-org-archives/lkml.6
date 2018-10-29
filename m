Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F090C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EB720827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfHxO2Ot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EB720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeJ2TSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:18:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46042 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2TSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:18:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id d135so3489127qkc.12;
        Mon, 29 Oct 2018 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CSGizkzi5iU9+GuXPFOlvyYv0nHhp0jBIHqz4f/REdc=;
        b=bfHxO2Ot6WNaxE8sOnLj8lIZILKI850gPn2az72FkcKYMp7KaV356+Cwz/UddUVZMM
         nRaPCDZa6Kvlx8xtY++hswsgfG9vCQ6olE3vv+3zzavW0Z4i/4yCBRZ/yPa3m4oNN1gQ
         jaOasR8wjYQ0IG1hMVap7XnyUD28Kido1rPUSS/6wdKXZ7OGKfmMAobHCGSHjG0HumhW
         7et5bHINbsh2NgwmKSoVZs0zRfFLNmbRzf/c1gCogeyCvul/UdVwuvFItQG5Hj1ReTNx
         I1HHJF2SjAMBf7senNv2j4+eG2KLmy/ZI4aiYGRCJdoOAHhgNk9M5vTfL7Mb6uEVThvG
         bT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CSGizkzi5iU9+GuXPFOlvyYv0nHhp0jBIHqz4f/REdc=;
        b=bRbLI8aJuLk06JpQmQ4EYpiaKi6H5I90WnVUR9Jhdni8/KeGBWEtKVdDSnAyYLSRvg
         1n2gWyUvy/dPIT9AyE634cqysuKQEedG45/6vnRTFwLO+2XdhmIAeKksp/atE2n7ezJw
         J1Bn95IM5FOunB1XVCgBC0fmm9jKvdpdIxe2rVuYO5hfdA8Wcka4dfnwMSSjJqCAErDK
         ZdDQw6OYdYKrqmwPil+cWo7ffj51wcxisPP6aLrGqnTuKUD5OI5k6zSPqlpIXfvfXMc8
         hTaXzwk1LygbEdMRolrYOgg10sRQEduNJ8Hz1wZcI6ra5w8hIra9toL4I9ort61M4dqa
         EYRg==
X-Gm-Message-State: AGRZ1gIZ57vgJSPm50lskTD0okKniAmghimKu2gVMzbAcbBLRQLZSs3l
        6/ZBi+ze440KYlnwYwGO+RaqNUg/8PPKqSbFg9E=
X-Google-Smtp-Source: AJdET5cLMHFbtrS4OUgIYlLMpNkgey06AxIE8wD7hsd+9j4OnlEiouPoflkC6mtfK3aJK0FQXu2dfyVhnyLnvd6coQU=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr11295093qkf.33.1540809034553;
 Mon, 29 Oct 2018 03:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <1540812743-1825-1-git-send-email-peng.hao2@zte.com.cn> <1540812743-1825-3-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540812743-1825-3-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 12:30:23 +0200
Message-ID: <CAHp75VfxyNSCcDL=ZnDOipnKBQYAms7_BGRmMdEbCAb184ujuA@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 5:22 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> this can be used standalone. Add MMIO support to the pvpanic driver.

>  pvpanic_walk_resources(struct acpi_resource *res, void *context)
>  {
> +       struct acpi_resource_fixed_memory32 *fixmem32;
> +
>         switch (res->type) {
>         case ACPI_RESOURCE_TYPE_END_TAG:
>                 return AE_OK;
>
>         case ACPI_RESOURCE_TYPE_IO:
> -               port = res->data.io.minimum;
> +               base = (void __iomem *) ioport_map(res->data.io.minimum, 1);
> +               return AE_OK;
> +
> +       case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +               fixmem32 = &res->data.fixed_memory32;
> +               base = ioremap(fixmem32->address, fixmem32->address_length);
>                 return AE_OK;

Ouch. Sorry, I forgot to look at this previously.

This should be converted to use
acpi_dev_resource_io()
acpi_dev_resource_memory()

-- 
With Best Regards,
Andy Shevchenko
