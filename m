Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D02BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA1720817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe4PKVxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA1720817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeK0BhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:37:19 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38234 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0BhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:37:18 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so27963494ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhKImEB7vt8t9jKKuMmRs0QM26DaLcd01ZpvBU3o9cQ=;
        b=pe4PKVxo4mjuI8PzOqkctPc/uNgZSErBvwP3DK2CCyn41n+nz9uCfDHxQlMqaCUu+/
         Rl8QjurgywWiBP7BJpUZYRftJct9L/nDhtiEjl5G0ZDG603G+RVcYu+x2C47aztduenR
         6BLhbwIP5HedcAw+pDxR6IUsEaBSoC0qjGdEYZ2ervOEL1WLhBpITAdnjeISs9LYHQ/D
         wgwCB/UEcU1FBLhP4Zz0SHUVR72oAE3GtMkoCsvqb9JrEL6o8bj14VmmVVXJGSRYSvyT
         idIXHLD9pJfJwYuaVT096aVzoZ7LPdi4CV6Q5b2PTwNVXXgahgM6IapnEBGr7GnUCU9t
         PFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhKImEB7vt8t9jKKuMmRs0QM26DaLcd01ZpvBU3o9cQ=;
        b=NUURk1coQrHeQVz3zHsoCv8X764W99ZdnPk18y5EAIWMQxHiwoQ9iHjNmswDcHWiXm
         9kfj6EKEwgHojYuPacbPCTvW14zb6eA1zfCveGLdcUftOtvhUHahSFpqrmUaIjBN5pZu
         JiFimrNaIntAl4f871ZC2ujQCn/wQhjfs7GFyb+FZgORs6ug4dDphaSBDRzYWE827cKQ
         t7bacLpcPc8wODAj7ToAPcePtFxtz/lTa52VU+hsOjl5e3+MK0qOI4bBfGJIBsXkFoXc
         8t+JxT2bTZPu+M9yfGjEUvJA7CRpxOZqLJL1iuQbQuj+goTBSSrSeoC2chnr9DLmbJ+A
         tY+w==
X-Gm-Message-State: AA+aEWZX8x0pQxQ0Ev4K5B81K/nqfUCOrf6+TN+UTt31OwpfBr5X8Qan
        lTtL7pt0DcaXFcqWlQ3eLfrg2uvglFtszHVxXhI=
X-Google-Smtp-Source: AFSGD/UQk361QfiAOZZX0k/6Tj5IAJuRiWe4BSHx8I48eyhOp+KfPTNusZR9cJocBZuhfFf0YxXwjzrEoPM1Gp4wmX0=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr2002155itk.78.1543243379171;
 Mon, 26 Nov 2018 06:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20181124145223.29208-1-tiny.windzz@gmail.com>
In-Reply-To: <20181124145223.29208-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 26 Nov 2018 22:42:37 +0800
Message-ID: <CAEExFWut2Vu0e+j1U8_1PS683DtMMi7FVD6X=LfwwE63DT7Syg@mail.gmail.com>
Subject: Re: [PATCH v2] soc: bcm: brcmstb: Don't leak device tree node reference
To:     Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, treding@nvidia.com,
        olof@lixom.net, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 10:52 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> of_find_node_by_path() acquires a reference to the node returned by it
> and that reference needs to be dropped by its caller. soc_is_brcmstb()
> doesn't do that, so fix it.
>
> [treding: slightly rewrite to avoid inline comparison]
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2:
> -update changelog
> -slightly rewrite to avoid inline comparison
> ---
>  drivers/soc/bcm/brcmstb/common.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/bcm/brcmstb/common.c b/drivers/soc/bcm/brcmstb/common.c
> index 14185451901d..bf9123f727e8 100644
> --- a/drivers/soc/bcm/brcmstb/common.c
> +++ b/drivers/soc/bcm/brcmstb/common.c
> @@ -31,13 +31,17 @@ static const struct of_device_id brcmstb_machine_match[] = {
>
>  bool soc_is_brcmstb(void)
>  {
> +       const struct of_device_id *match;
>         struct device_node *root;
>
>         root = of_find_node_by_path("/");
>         if (!root)
>                 return false;
>
> -       return of_match_node(brcmstb_machine_match, root) != NULL;
> +       match = of_match_node(brcmstb_machine_match, root);
> +       of_node_put(root);
> +
> +       return match != NULL;
>  }
>
>  u32 brcmstb_get_family_id(void)
> --
> 2.17.0
>
Hi Florian:

How about this ?

MBR,
Yangtao
