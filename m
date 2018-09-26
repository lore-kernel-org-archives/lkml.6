Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDDFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E8E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4ufWlAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E8E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeIZUJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:09:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39060 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeIZUJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:09:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id b19-v6so15710016qkc.6;
        Wed, 26 Sep 2018 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XiFz7wwjBZ6h4wPYBynF2BS+AWI2Y0Fn4TZoyf2mL0=;
        b=J4ufWlAdh0G+EalcWi/FWXYWFRvprt6xQUkRIDkrkxOuJikemyPIfxeJvZ1+nxvj2C
         2WPc6Le/G5JsdW2wDg6EMdN7v2pznlRSMkBV3TdFDSPZhdi0toWv5/Sx00Xg52A7+3nh
         Fnbl/PrpUGBwZFh3bgTefimNhbDWzzx+XTC7jdcZ9qdzYdoKZxcp+zg4t5U9OH6VxgWk
         me7ZwHjB3dIJV2dIV0x0wvFqWQtDA3rbt+JKBS8AT2DIQSeOO1eP5yWUv+Efw7XEI0j3
         ub9+X1gij6NAE/4Eq31sBGTnMMTyChK+vVTAUzsXlNFO9rgfUl8ymnojb7qdy33g2XS2
         hcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XiFz7wwjBZ6h4wPYBynF2BS+AWI2Y0Fn4TZoyf2mL0=;
        b=NwZ8mcLo7nwnpAN4Mls0/WFQT36bNceNsPA5Q7mkyPlXRcmTYCF6oaBB3k7LxiGfhE
         SiLZTstR2AC40S9HOdQUAU+RuGDFec3XgXGrRFfhc+FybALjrrQT+oPlgBbtRFVasvF7
         P4rtP+0CCXqLdXfrNLfzjibFdHjv/r3qGjdKoQPFetkFj15fD8mf17uQl1BJ6LP7qAfn
         vukj9q20TqWhIZ2lIQOvCuoSdqJOpgRvKR2F3mKuiSjw+1KR4gOgTCNrbTfFsvkt/N9z
         GymQiG9e0ABV4dZNlJH60Q/yZ07tAmFraMMKPydD/xegItpLi1H01yZUlyOLVHR9jTrL
         WQvQ==
X-Gm-Message-State: ABuFfohGo8/W8VG141geL+S1/FiAz60Tm0gGToEBoaAe4PekkddSr4g/
        UsfjjXJ5d353shHuLJsJA4bUJXMcj6dA5LZ2WBlk7bvQivw=
X-Google-Smtp-Source: ACcGV63CI6eyMYw6nhC6Nndzp4DXy9weVt/k3X823JgCKM8bmOstnaYAqHtPAavaAvM7p1I9LyBs9skYmvWvjTwWmys=
X-Received: by 2002:a37:6e01:: with SMTP id j1-v6mr4365100qkc.70.1537970210483;
 Wed, 26 Sep 2018 06:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com> <20180903180415.31575-4-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20180903180415.31575-4-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 16:56:39 +0300
Message-ID: <CAHp75VcE+BY=8aKEGqzkDBVazLGtwNNCa1CYCKGirS1vBLVXPg@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/x86: intel_telemetry: report debugfs failure
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        matt.turner@intel.com, "Brown, Len" <len.brown@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> On some Goldmont based systems such as ASRock J3455M the BIOS may not
> enable the IPC1 device that provides access to the PMC and PUNIT. In
> such scenarios, the ioss and pss resources from the platform device can

IOSS
PSS

> not be obtained and result in a invalid telemetry_plt_config.

What is telemetry_plt_config?

> This is also applicable to the platforms where the BIOS supports IPC1
> device under debug configurations but IPC1 is disabled by user or the
> policy.
>
> This change allows user to know the reason for not seeing entries under
> /sys/kernel/debug/telemetry/* when there is no apparent failure at boot.
>
> Cc: Matt Turner <matt.turner@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@intel.com>
>

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198779
>
There should be not a blank line.

> Acked-by: Matt Turner <matt.turner@intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

> +exit:
> +       pr_debug(pr_fmt(DRIVER_NAME) " Failed\n");

Completely useless.

Device core does it in generic way.

-- 
With Best Regards,
Andy Shevchenko
