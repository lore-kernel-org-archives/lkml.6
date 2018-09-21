Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5220EECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA87021476
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA87021476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeIVEGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:06:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43068 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbeIVEGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:06:17 -0400
Received: by mail-ot1-f66.google.com with SMTP id e21-v6so1750855otk.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2q0g1bEaRz4965hDl67/tqVEScnmVm7qq0Snr4u7eM=;
        b=TKbcFQHcBe5STTQHUQNAdpnQYJwjFW2Y6Qotu/KjXYGAbNDt47SsXz/vLUfuNX4k87
         vgORJWRlkyXpR2eczuwtAMNKrHm7yYcPZGVqNKGSn+LZsPeqj/G4SAk57cFG8CfqQPu8
         E3Dqq7EECR2U4HdYrRn+64Rn6oPukTCe69JHxdrF+f4H4vJuxQSMPc4HikCd3shUAPk3
         p9p8l5j2108uDPR4x6yd7VX6/XsLy1fg5MDOfyw/LuHw6KxKLCJSoE23DmHEDfQqUCPL
         tiegWduwgx+nas+lEsjMKN8ylO3X4TG1U7QPpe5/PzpomthkdUROXWLVsVihg1iYgxDO
         TccA==
X-Gm-Message-State: APzg51Bs9BrcZ5HnSbMW1rv+vwpbG2gT3g+DoXOa7m7Uwdhyo3iPywcr
        2EGo8kAHKONa4PNY4hkXVIzQJ3gKlD8=
X-Google-Smtp-Source: ANB0VdYWxbA29ik+dEqIlZDFzmdx6r8wAB8YLy5TcvtCtNTBVSpCaKEs3q48X0JdyE2IDpjWwB8cLw==
X-Received: by 2002:a9d:3cf7:: with SMTP id t52-v6mr7818103otf.201.1537568125730;
        Fri, 21 Sep 2018 15:15:25 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id a144-v6sm9996257oii.30.2018.09.21.15.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:15:25 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id q4-v6so1353331otf.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:15:25 -0700 (PDT)
X-Received: by 2002:a9d:52a4:: with SMTP id f36-v6mr25526161oth.355.1537568125095;
 Fri, 21 Sep 2018 15:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com> <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-2-git-send-email-madalin.bucur@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 21 Sep 2018 17:15:13 -0500
X-Gmail-Original-Message-ID: <CADRPPNQMK8sNYU23nvAdF3T_gx=VruM1ZKAcwNg6HuW6hz+Ezw@mail.gmail.com>
Message-ID: <CADRPPNQMK8sNYU23nvAdF3T_gx=VruM1ZKAcwNg6HuW6hz+Ezw@mail.gmail.com>
Subject: Re: [PATCH 1/4] soc/fsl/qbman: Check if CPU is offline when
 initializing portals
To:     madalin.bucur@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Wood <oss@buserror.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:09 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> From: Roy Pledge <roy.pledge@nxp.com>
>
> If the affine portal for a specific CPU is offline at boot time
> affine its interrupt to CPU 0. If the CPU is later brought online
> the hotplug handler will correctly adjust the affinity.

Although this does provide better compatibility with cpu hotplug, we
still have a problem.  You are assuming the CPU0 is always online
which is not the case for arm64.  How about not setting the affinity
and let the system decide if the dedicated CPU is offline?

>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman.c | 17 +++++++++++++----
>  drivers/soc/fsl/qbman/qman.c | 18 +++++++++++++-----
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
> index f9485cedc648..2e6e682bf16b 100644
> --- a/drivers/soc/fsl/qbman/bman.c
> +++ b/drivers/soc/fsl/qbman/bman.c
> @@ -562,10 +562,19 @@ static int bman_create_portal(struct bman_portal *portal,
>                 dev_err(c->dev, "request_irq() failed\n");
>                 goto fail_irq;
>         }
> -       if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
> -           irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> -               dev_err(c->dev, "irq_set_affinity() failed\n");
> -               goto fail_affinity;
> +       if (cpu_online(c->cpu) && c->cpu != -1 &&
> +           irq_can_set_affinity(c->irq)) {
> +               if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> +                       dev_err(c->dev, "irq_set_affinity() failed %d\n",
> +                               c->cpu);
> +                       goto fail_affinity;
> +               }
> +       } else {
> +               /* CPU is offline, direct IRQ to CPU 0 */
> +               if (irq_set_affinity(c->irq, cpumask_of(0))) {
> +                       dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
> +                       goto fail_affinity;
> +               }
>         }
>
>         /* Need RCR to be empty before continuing */
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index ecb22749df0b..7dbcb475a59c 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -935,7 +935,6 @@ static inline int qm_mc_result_timeout(struct qm_portal *portal,
>                         break;
>                 udelay(1);
>         } while (--timeout);
> -
>         return timeout;
>  }
>
> @@ -1210,10 +1209,19 @@ static int qman_create_portal(struct qman_portal *portal,
>                 dev_err(c->dev, "request_irq() failed\n");
>                 goto fail_irq;
>         }
> -       if (c->cpu != -1 && irq_can_set_affinity(c->irq) &&
> -           irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> -               dev_err(c->dev, "irq_set_affinity() failed\n");
> -               goto fail_affinity;
> +       if (cpu_online(c->cpu) && c->cpu != -1 &&
> +           irq_can_set_affinity(c->irq)) {
> +               if (irq_set_affinity(c->irq, cpumask_of(c->cpu))) {
> +                       dev_err(c->dev, "irq_set_affinity() failed %d\n",
> +                               c->cpu);
> +                       goto fail_affinity;
> +               }
> +       } else {
> +               /* CPU is offline, direct IRQ to CPU 0 */
> +               if (irq_set_affinity(c->irq, cpumask_of(0))) {
> +                       dev_err(c->dev, "irq_set_affinity() cpu 0 failed\n");
> +                       goto fail_affinity;
> +               }
>         }
>
>         /* Need EQCR to be empty before continuing */
> --
> 2.1.0
>
