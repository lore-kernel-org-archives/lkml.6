Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304BAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E4120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3FUmOli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E4120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbeJaVvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:51:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46008 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbeJaVvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:51:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id d135so8337318qkc.12;
        Wed, 31 Oct 2018 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lEWLbS0T/h/I3R4Mu9GptRpVDLfdRFtQIrzSW3pSAZg=;
        b=s3FUmOli4jKnoKYjYLEun/RLT/Pq85smhehxaoGwsiSgz9cTrfZEeB1FYzQw+prLEB
         ZaeBv3bQ1kBeCbDKEwTS1A5za5+9k91GAJUSp5I4W3hcj/rhCBcyNO+2+Etxonw7Y5TS
         ZA5pO9lvUXNOZp3+rT7dxoi3H06bni0v3MFaAYg9YH66fkdnqvgMnajHgFITXWJM8yu+
         EoA8HEwwYgIbBUJLZM2azn7D+vu0YpoWf1Wf2SGiyhNCeV7PoQz8rF7vIs7bg0EjfS7H
         Bal7WWHMRHhXliVejuUD369QR6g3hT20CWH2Qmw3Vrllw0xe1JYF9eKBxpmdzBxp4v2C
         MPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lEWLbS0T/h/I3R4Mu9GptRpVDLfdRFtQIrzSW3pSAZg=;
        b=ajvJ1MKE8DNrr9VFi5QPHHeMR5WdWWiPQrbCIhFB+iCp1cG/POerZCUEH5mgjO11G5
         kDtz2xp8mSWKlQ+yzN/FvAyu/uDumEbRDVuMopEgvTDOD6jRKQ0VF0fcUQMDPsXeCizu
         YJPUQRuR2qkMiH3VvUkPAC0MgDGcYMr7ycs4ZSEKSAO3k3n6T/j9MgA8nTy9nvRzefVu
         vQE7wYWVlQWUKsEkquDUG4k9bkJB8E0iCHXRDeNk0vG+o82kzOBxaZSK3GsmZlwGrkSW
         iDMggrYiCXvXSOm2p9uVrFckj/U6HHiZeUufVX7AtqKFUDmAmXF9akidKhcoPrdC0Tdp
         zjfw==
X-Gm-Message-State: AGRZ1gJ1U1Bv26z6SXmUmh37Zjq5bmBVsA4oAsngMMHVuKjqyEtgLXDx
        xKwC2MKDC8mbB3fmojocdSh3w13B3wM5J4aG648ugIYHwhY=
X-Google-Smtp-Source: AJdET5fsJJ1T+qs5i/yQzx6XQZaYMyiuSXuNgd5aV/DvxDlJr7RTq2tAEQ8c/5i4tKRpbmnGSclV0M4d1NYZw/yOlrY=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr2278089qkf.33.1540990429546;
 Wed, 31 Oct 2018 05:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn> <1540993041-25611-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540993041-25611-4-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Oct 2018 14:53:38 +0200
Message-ID: <CAHp75VeQD7xEUyR=Vwk78R3Ld2OfBzL=mkKQF9YLO0nKJyJ6zA@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] misc/pvpanic: add support to get pvpanic device
 info by FDT
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

On Wed, Oct 31, 2018 at 7:27 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> By default, when ACPI tables and FDT coexist for ARM64,
> current kernel takes precedence over FDT to get device information.
> Virt machine in qemu provides both FDT and ACPI table. This patch
> increases the way to get information through FDT.

> @@ -3,15 +3,18 @@

>   *  Copyright (C) 2013 Fujitsu.
> + *  Copyright (C) 2018 ZTE.

> +#include <linux/acpi.h>
...
> -#include <linux/acpi.h>

> -       { "", 0 },
> +       { "", 0 }

These changes regarding to style should go in a separate patch.

>  #include <linux/module.h>
> -#include <linux/init.h>

This one also in a separate patch.

So, the one should be split to three AFAICS.

-- 
With Best Regards,
Andy Shevchenko
