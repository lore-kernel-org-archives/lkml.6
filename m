Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDDAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742EC20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+7jlmBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742EC20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbeKVSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:55:17 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50637 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731445AbeKVSzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:55:17 -0500
Received: by mail-it1-f195.google.com with SMTP id a185so12963266itc.0;
        Thu, 22 Nov 2018 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vyXNPxu8L8ze5U2HEzq2fbQLiBW4MGAl72blE9d0FWA=;
        b=D+7jlmBf9kAEAc9x9awDOBbl7qs9NNTHOYv1DsKk/NBkA3/aYi60vIihX0GyCxJN0Q
         QxYXyiGxj9+GQE0ZwG42SuF3McvT2OKZ4OQzNyeBgRvjoBTn1+K8vqhe6O+XGKlsyQ04
         yBJdbMZwNgV+rQqy52/c+g0ojf0Z/v2xWlM94RAGklag7bnvlsyPZLXJdSO6rsm87loA
         qYhcprHycJb+u6culAa0FFDJVX5+BKwYd7GuJw7CyrnnimVMqIbXlq1WVaV0+lF3vm3R
         qrPi47nbCjLMGICyhMAzNGS6HcuYPlQ5Ip47LOQYgA5xf3CtON54dm2KSjtYGlqjV50Z
         JCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vyXNPxu8L8ze5U2HEzq2fbQLiBW4MGAl72blE9d0FWA=;
        b=VGnZawXgS+V0cMxZwPJDb3BctOBqnIk5FLojq2ujB7ST+aDkFP9a+AqISmcK7vHj2d
         boRXGGzyp9Gm3wfnTsrvEMxgJ2E5hWn1YLcGnJMlpc+f8VOGOxJ4yrmDTuIu3Nu6FzIl
         cuhe5T/dbQz/BU245mWWebQB7ofMpUH9DDIRBMhA7A02pyhpIp4rk41csMqBqxjleCk0
         NI/dyQYU28YiAgK2sy6GsCrppuSjAcq/136VJhf6D7lh/d5XDVrBUrz/HPqehuEpCeqx
         kD+S9r/hpQnfq60zTb1w8pf5kZMyeKWzDttS5qtBijAVyerb97C7ZpWoqxRriJKjIj0w
         SOfg==
X-Gm-Message-State: AA+aEWY0EDJOV3Fhkfnhg61/3MV4ojGnQ4RaGC1Qs40Yp/oKB2BLWaRr
        p5xyVzK/bzxZFszwrf/M+fJ8JYt1bZX3BWkkPIw=
X-Google-Smtp-Source: AFSGD/WbNUODZyWlnoLchbGnqUw+LOSScHFHuwY78IlyM6MxKigRoNeIZt68czvehQBRVMSUcbbWALjlr+N9p69Zud0=
X-Received: by 2002:a02:6c90:: with SMTP id w138mr8534428jab.60.1542874615379;
 Thu, 22 Nov 2018 00:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20181122075244.3909-1-natechancellor@gmail.com>
In-Reply-To: <20181122075244.3909-1-natechancellor@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 22 Nov 2018 16:16:07 +0800
Message-ID: <CAEExFWuEQ3G-U_-MwovgKFwMGcX3xxdXkkxG1J-xCBNDuUWPCw@mail.gmail.com>
Subject: Re: [PATCH] soc/tegra: Fix terminating condition
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 3:53 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/soc/tegra/common.c:27:16: error: address of array
> 'match->compatible' will always evaluate to 'true'
> [-Werror,-Wpointer-bool-conversion]
>         while (match->compatible) {
>         ~~~~~  ~~~~~~~^~~~~~~~~~
> 1 error generated.
>
> Whoops, we have an infinite loop and QEMU no longer boots...
>
> https://travis-ci.com/ClangBuiltLinux/continuous-integration/jobs/1602429=
18
>
> Check that the first character of the string isn't null so that the loop
> properly terminates.
>
> Fixes: c57eff9503a5 ("soc/tegra: refactor soc_is_tegra()")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index 8a538b968fe9..54627ca957e8 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -24,7 +24,7 @@ bool soc_is_tegra(void)
>  {
>         const struct of_device_id *match =3D tegra_machine_match;
>
> -       while (match->compatible) {
> +       while (match->compatible[0]) {
How about this?
            while (*match->compatible) {
=EF=BC=9A-=EF=BC=89
Acked-by: Yangtao Li <tiny.windzz@gmail.com>
>                 if (of_machine_is_compatible(match->compatible))
>                         return true;
>
> --
> 2.20.0.rc1
>
