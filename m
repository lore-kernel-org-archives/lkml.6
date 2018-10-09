Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5ABC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB668214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1BZ3zSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB668214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJISx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:53:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37120 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeJISx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:53:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id d14-v6so1144006qto.4;
        Tue, 09 Oct 2018 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJHFms5ykf3vy0eQiksSolAsjPGzj1aMI4qfklwX4yI=;
        b=q1BZ3zSS/STls3DHeN0w6MaTbH9yRC1SkG7Z6r3YkQmiXHT1ByIoQUe6EnxDA5ozc4
         s2l6g0kGoirhe3g2csCQXsMu5fT+bZmksf6E+0l7iv83ALC/Y1TTKPBKi/8iO7PDk5hb
         SB9DAkn4E1mc2uMr4u9doFnmxjvAAqkOeJaOby990jqhqal+8R93CIeDtMlYJ7w48piH
         sXaOcUXbD1H9A3M/G5U3DIPYYA34HWSYsaDSWKmCQArAsuFvE/zdEStYRYuWa/iGswOD
         MvX9RSK/92sRTYSuehpB/HMOXJYTM3CH7xqMCDFXC+l8sRVbP3eLzm2sCDGASQKVrGLK
         QJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJHFms5ykf3vy0eQiksSolAsjPGzj1aMI4qfklwX4yI=;
        b=G/nyWpB3GUtjM3fkupX11mNPiLyfTiP5be7MlF/necth+2LtFfUrElzxsSADxvBO1Q
         LP1hWt/rcoSCpNWx1Lkx4L/wrRn5yqMo2iJ3rxLn0oE/kkbNQEIdeL7TvHKvcpIODv+D
         Ro7zHLAz7zcR5+FFir0OCXsIZFFEpAojf4CZbGcB8aOt9E1n11njaThPcGfHtIxDIzXf
         2OoYFjeSPHBFnRShFfM+WtO5/hgc4nhJMfVgARiVG91raXQ5DWYHfmIlz5DSSD2bpuoD
         W/r/zEz1pTz8MDTy0au+oPZF8/ObiXG2rXygmi4Hvwhz7SZaCQPdR0iTlDs8301Ssu8V
         4nLg==
X-Gm-Message-State: ABuFfojuasX78nchzQFv0weFqigM3o+Tvuuw2MY1fli1VSXebwjJLOg/
        Ri7PWIRiqjk/Z0i17NkzVEL1qyGQR347aj8QvKsFFodr
X-Google-Smtp-Source: ACcGV603FopLQAC0kOKT5UOlIYhmK7Qg1EU2DX6+HutUWBUYt/acfrRZO622rx7yGXXVjTsNfbMg5sDjWRfr77KpOKo=
X-Received: by 2002:a0c:819c:: with SMTP id 28mr7453994qvd.7.1539085042599;
 Tue, 09 Oct 2018 04:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181008144303.23878-1-rajneesh.bhardwaj@linux.intel.com>
In-Reply-To: <20181008144303.23878-1-rajneesh.bhardwaj@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Oct 2018 14:37:11 +0300
Message-ID: <CAHp75VfNsasf-hpiubrfw=x+iVjBOOcY=uj6dB97iVpkoT6K=w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: intel_telemetry: Update maintainers info
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:44 PM Rajneesh Bhardwaj
<rajneesh.bhardwaj@linux.intel.com> wrote:
>
> Add myself and David as the new maintainers for Intel Telemetry driver.
>

There is no explanation why.
(Like previous one left the company, and / or you are doing set of the
drivers related to PMC where telemetry is part of, etc)

> Signed-off-by: Box, David E <david.e.box@linux.intel.com>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 22065048d89d..f33ebd1b8034 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7530,7 +7530,8 @@ F:        arch/x86/crypto/sha*-mb/
>  F:     crypto/mcryptd.c
>
>  INTEL TELEMETRY DRIVER
> -M:     Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
> +M:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
> +M:     Box, David E <david.e.box@linux.intel.com>
>  L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
>  F:     arch/x86/include/asm/intel_telemetry.h
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
