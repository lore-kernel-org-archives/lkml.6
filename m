Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EA7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A665620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A665620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbeLEUnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:43:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34738 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:43:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id h25so18807713oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 12:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtfdFOrHLEdBRRSKnZ3mtxk3yR28RHuLiNsARcqEx70=;
        b=qIJOMeyAjwK4ny9cRniRFVBmghUOr6xEwo8ITBRHeZrMBgoENOPYS2ikR87C26hFvv
         u/jbqJIB4RnRIspV5S9SCdmgt7F+5p8WnHlDbXp5J8XJuY1qChzmsodFWSjvzhUifxJZ
         JqgU5+t39/xFhygPw8d7yzocTxeYB3u6FCcCOskEKiZcuNegP6Trju7XArJmO1BVTFj1
         jH99I+UAq/Qt5o3KuOnF/fBWgakxcE64nnEAR6jiS/S1jM6CggrtH5pebwQolh7s/t47
         iAYFf9iPS9TcWYK3kEzRufoIG2+r444fkoKWaOzAjvpzk4SwSZavyZBnFw5xe0egpIuS
         OtSA==
X-Gm-Message-State: AA+aEWYqvdXkzGtSWKkFdNgNdF2q1UWKWPdYRz4i0BbNOBKWQd4AKxMA
        urNgWyOmU6JaOgOIB/hiazQ2eCnVj+0=
X-Google-Smtp-Source: AFSGD/V3dtLe+QxJfnXj3/VFj2A/IclycMI24FegBnd8v2dvpbezQ4OZfSZzZcSLUUk6DsMDUqNiRA==
X-Received: by 2002:aca:7c5:: with SMTP id 188mr14913341oih.313.1544042587742;
        Wed, 05 Dec 2018 12:43:07 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id h7sm8321309otb.45.2018.12.05.12.43.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:43:07 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id x23so18770337oix.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 12:43:06 -0800 (PST)
X-Received: by 2002:aca:654a:: with SMTP id j10mr15212756oiw.301.1544042586603;
 Wed, 05 Dec 2018 12:43:06 -0800 (PST)
MIME-Version: 1.0
References: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 5 Dec 2018 14:42:55 -0600
X-Gmail-Original-Message-ID: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
Message-ID: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
To:     hofrat@osadl.org
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 3:07 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
>
> devm_kstrdup() may return NULL if internal allocation failed.
> soc_dev_attr.machine  should be checked (although its only use
> in pr_info() would be safe even with a NULL). Therefor
> in the unlikely case of allocation failure, fsl_guts_probe() returns
> -ENOMEM as this allocating failing is an indication of something
> more serious going wrong at system level.
>
> As  machine  is from the device tree which I assume to be RO - if
> that assumption is always correct - a better alternative would be
> to use devm_kstrdup_const() here. That would then simply copy the
> reference to the RO data and not perform any allocation at all.

I think your assumption is correct.  Do you want to send a new and
better version?  :)

>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
> ---
>
> Problem located by experimental coccinelle script
>
> Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)
>
> Patch is against 4.20-rc4 (localversion-next is next-20181130)
>
>  drivers/soc/fsl/guts.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..a0c751b 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
>         if (of_property_read_string(root, "model", &machine))
>                 of_property_read_string_index(root, "compatible", 0, &machine);
>         of_node_put(root);
> -       if (machine)
> +       if (machine) {
>                 soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
> +               if (!soc_dev_attr.machine)
> +                       return -ENOMEM;
> +       }
>
>         svr = fsl_guts_get_svr();
>         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> --
> 2.1.4
>
