Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73774C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4814420651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfANTRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:17:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33002 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:17:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id i20so180894otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OM/aIfnBVafWaMBtKs+zpeHlo8uj5Rb6aKAakxLObyk=;
        b=mudmHCjtkAuoliXXVecf1901RbFR7Rmmdw2ZM/K4lcb5Mji6nL3OI/uBusd1+VYWvc
         eaZkMTOuS+YF7pJQwq0jOd19EFUI+dVN1llY3JCjeGt63jgnVXZV5rulQS2IFNKw83P0
         sszCPU4m1jaVddsgHBazzANbypmexN2P3y3wt8QbwadmLOHzVsSVXw/h6UfuntZuwLH5
         5J0tI3GKGPSu+MC16kOqmbmSK47oCGecnuYuquL92yrVXyNScky1uwrbmCgNKY1cf46N
         kdjcWup5/t3PR2+VcuZ1qhe2xndFnaOdC0RaVL5A08KlMLIAZmqnkDRZUSqS+f2az6dE
         U2Lw==
X-Gm-Message-State: AJcUukd5n6RTSEugXwg6exDH4dQd4cBXoqChOr6LRRVlxLpEu+dAZenp
        jCv2qzQVXkB8pq+kgotn2LAD7WrO
X-Google-Smtp-Source: ALg8bN7RHS43uazgEqbWhbS21qeENZgW4pUXUe5yWDP4hQZVg8c0TX3Vh6xZ2lpJ1apnU8jmvMSOJg==
X-Received: by 2002:a9d:4b15:: with SMTP id q21mr23211otf.30.1547493428313;
        Mon, 14 Jan 2019 11:17:08 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id w17sm515006otk.12.2019.01.14.11.17.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 11:17:07 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 81so166464otj.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:17:07 -0800 (PST)
X-Received: by 2002:a9d:1405:: with SMTP id h5mr16517479oth.331.1547493427615;
 Mon, 14 Jan 2019 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 14 Jan 2019 13:16:56 -0600
X-Gmail-Original-Message-ID: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Message-ID: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: fix cpu range check
To:     Bharat Bhushan <bharat.bhushan@nxp.com>
Cc:     Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 11:13 PM Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
>
> cpu_possible(cpu) will always return true when cpu parameter
> is from cpumask_next().
> Check for nr_cpu_ids rather than !cpu_possible(cpu).

There is another patch pending merge seems to cover this issue too.
Please let me know if it doesn't.

https://lore.kernel.org/patchwork/patch/1020905/

Leo
>
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  drivers/soc/fsl/dpio/dpio-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
> index e58fcc9096e8..eb369dd9e0a7 100644
> --- a/drivers/soc/fsl/dpio/dpio-driver.c
> +++ b/drivers/soc/fsl/dpio/dpio-driver.c
> @@ -133,7 +133,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
>         else
>                 next_cpu = cpumask_next(next_cpu, cpu_online_mask);
>
> -       if (!cpu_possible(next_cpu)) {
> +       if (next_cpu >= nr_cpu_ids) {
>                 dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
>                 err = -ERANGE;
>                 goto err_allocate_irqs;
> --
> 2.20.1
>
