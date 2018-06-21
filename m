Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C2C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA520874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSLOf90z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFA520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeFUCYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:24:49 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38091 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754097AbeFUCYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:24:47 -0400
Received: by mail-vk0-f66.google.com with SMTP id b77-v6so958868vkb.5;
        Wed, 20 Jun 2018 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/QWf8dGAiHtRqnP8KyhpTkbXYak9DT/HadRaAiDTG9A=;
        b=tSLOf90zLyr3MiUObmlyayJb+/Engp4FJYFg/tIvSQnImWKvhqCzJ38yDcBiDHMYsU
         X+mpNXRRGaTjlgRRNM6Z57xZkAiHCgsbV2+6HfRhJl6FSkMh9UZqjTFq4CCmF/luU96J
         hPKcMcwb+oQPmV1KaJmu4VZ3fXMIRNqZ9u3oamHURoGDDqwYOG1/qOFpmyhneb+ePI2w
         NpZj9+qV/dlF6O2txfM6uFtacQqg4YCwtb9/elSlDxDJ6QxY9aKCiiyZ21awkEvvUomJ
         cPPunx0sqPcQW9Fdb8Awuh+PaSVCIQe4ndJi7RvzwPOWbxyASeRWO5Und0Vj8UcVRLdY
         1z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/QWf8dGAiHtRqnP8KyhpTkbXYak9DT/HadRaAiDTG9A=;
        b=umO6QIoEdnXKr/t30rCgUECEpFC7MPusFVifkQMQUFgFzUT8ZwZdCGiJNqMClVVNaM
         rJJcjrTPH6nft102sh8K7IINksx/+rwwNgquOaq9GAyZnH4NfgP2JAXoM9oJP4cUl088
         f+EcgDABI4Lo0gxmkk/Y2a+0hg6awnLZx45k/djucQGIbLGsqWfqnhKRR7dyR4qtD0Ni
         lu333+JXZnpA5H77PWjUnHw3uEX7Du3fA1PcUbjvtgCGWPFlukUPY1cPUAMdiUKTCShl
         VA73fn/IF3s2NbSalbCYoANZcWTf1SsXNeSLYK9VE/9xnfEMPCBoWPXPQZ5ixxB9IQrP
         QxdA==
X-Gm-Message-State: APt69E1wyTnTipnnlyRlebvvFVDFDyKAAUZeY8RJYk3xtPMdXjWp2nNv
        GiHJHyEKpzD7+buIlod2jxR3tpltEj7aaJ3Sisg=
X-Google-Smtp-Source: ADUXVKIOOcCcFDtGfqb8tAOqFYxSrcETCgERiCRkpIXsRMpZp9vVL+lK42Ej07LnDCx+jiukd4/cM4KKQFQIczN9JQc=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr13889674vkd.15.1529547886966;
 Wed, 20 Jun 2018 19:24:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 19:24:46
 -0700 (PDT)
In-Reply-To: <29324e04-e6c3-188c-a7fa-0363305b6455@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
 <80339b72-902f-a74e-6ad2-28744c7760cb@huawei.com> <CAHp75VdvpxZCuGmFV0r9nUdO1u7=eurDFZur7Q=ZO0kMC6D0rw@mail.gmail.com>
 <29324e04-e6c3-188c-a7fa-0363305b6455@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jun 2018 05:24:46 +0300
Message-ID: <CAHp75VcvYr1PWxoSMpNXRxpAwxRKam9iwj7fH9_uZPojNCreGQ@mail.gmail.com>
Subject: Re: [PATCH v4 21/21] sparc64: use match_string() helper
To:     Yisheng Xie <xieyisheng1@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        sparclinux@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 4:39 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
>
> As Andy's suggestion, this patch add string literal instead of NULL
> for crypto in array of hwcaps and make an additional condition after
> match_string() in all users of it.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  arch/sparc/kernel/setup_64.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index 7944b3c..6fa0c78 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c
> @@ -401,8 +401,7 @@ void __init start_early_boot(void)
>          */
>         "mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
>         "ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
> -       "ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
> -       "adp",
> +       "ima", "cspare", "pause", "cbcond", "crypto", "adp",
>  };
>
>  static const char *crypto_hwcaps[] = {
> @@ -418,7 +417,7 @@ void cpucap_info(struct seq_file *m)
>         seq_puts(m, "cpucaps\t\t: ");
>         for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
>                 unsigned long bit = 1UL << i;
> -               if (hwcaps[i] && (caps & bit)) {
> +               if ((caps & bit) && bit != HWCAP_SPARC_CRYPTO) {
>                         seq_printf(m, "%s%s",
>                                    printed ? "," : "", hwcaps[i]);
>                         printed++;
> @@ -472,7 +471,7 @@ static void __init report_hwcaps(unsigned long caps)
>
>         for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
>                 unsigned long bit = 1UL << i;
> -               if (hwcaps[i] && (caps & bit))
> +               if ((caps & bit) && bit != HWCAP_SPARC_CRYPTO)
>                         report_one_hwcap(&printed, hwcaps[i]);
>         }
>         if (caps & HWCAP_SPARC_CRYPTO)
> @@ -504,18 +503,13 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
>         while (len) {
>                 int i, plen;
>
> -               for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
> -                       unsigned long bit = 1UL << i;
> +               i = match_string(hwcaps, ARRAY_SIZE(hwcaps), prop);
> +               if (i >= 0)
> +                       caps |= 1UL << i;
>
> -                       if (hwcaps[i] && !strcmp(prop, hwcaps[i])) {
> -                               caps |= bit;
> -                               break;
> -                       }
> -               }
> -               for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
> -                       if (!strcmp(prop, crypto_hwcaps[i]))
> -                               caps |= HWCAP_SPARC_CRYPTO;
> -               }
> +               i = match_string(crypto_hwcaps, ARRAY_SIZE(crypto_hwcaps), prop);
> +               if (i >= 0)
> +                       caps |= HWCAP_SPARC_CRYPTO;
>
>                 plen = strlen(prop) + 1;
>                 prop += plen;
> --
> 1.7.12.4
>
>



-- 
With Best Regards,
Andy Shevchenko
