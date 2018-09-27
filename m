Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3137D216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3137D216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeI1C6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:58:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43756 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1C6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:58:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so3371531oie.10;
        Thu, 27 Sep 2018 13:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=REIDTKJMCaXMb9FL8bU8sBNjF0dmEAbYJU4840gj/DU=;
        b=OKWgdbRgXR6zJv7S3BP5aKvyDIiIm8v39J2FwHNSs4nioMml7JMPFpNbi2LNpSq05i
         SpUKkgfvTAz0JufWJJLw9k3Pxsh6lm5V3yHhembL6WLRxMKxRvbsMd5J4f/HAj729oFS
         hJGhKGlMTDMn9dqj7HL5Qp+IYsE7lFQIrXjVL/PAwkPefci/womVhM/U6bASs79VPvF6
         yhQ3IGxKFKBMU7pR2MHoIkvbEPwe7VZQJWp8+RpmUS+roSngCWVD/09C0+XO9XD8tp92
         ndezrlmNDQqm/KNwoDDNqMfQBkWkbEwyx1q5whib1I+HGJLVMRuDwv1ehkctO23hd89S
         Ft9g==
X-Gm-Message-State: ABuFfojZuEh7ah5Yg3H4z5SYhyDSnmXSUR8nfN/yy3XAvu9dwVQ6Mdzv
        Z0/Y63DR1O/Z4qQEUk3ClKFFFrXlCd4=
X-Google-Smtp-Source: ACcGV609ZIZbHM8eI48wr1jISbd8LH/nrEf5xVkGTAT3lrTcvqGz9s6/EHuP6jxmsVXLtw+0HNr8Bw==
X-Received: by 2002:aca:f084:: with SMTP id o126-v6mr3892016oih.21.1538080676245;
        Thu, 27 Sep 2018 13:37:56 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id v55-v6sm22298oti.50.2018.09.27.13.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:37:56 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id e17-v6so2511939oib.4;
        Thu, 27 Sep 2018 13:37:55 -0700 (PDT)
X-Received: by 2002:aca:508f:: with SMTP id e137-v6mr3940963oib.73.1538080675659;
 Thu, 27 Sep 2018 13:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com> <20180926132247.10971-7-laurentiu.tudor@nxp.com>
In-Reply-To: <20180926132247.10971-7-laurentiu.tudor@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 27 Sep 2018 15:37:44 -0500
X-Gmail-Original-Message-ID: <CADRPPNQEQs5j-AYk1VSL7GHWHemVuxDsTM05S2zth-idJOyoBw@mail.gmail.com>
Message-ID: <CADRPPNQEQs5j-AYk1VSL7GHWHemVuxDsTM05S2zth-idJOyoBw@mail.gmail.com>
Subject: Re: [PATCH v2 06/22] soc/fsl/qman_portals: defer probe after qman's probe
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Roy Pledge <roy.pledge@nxp.com>, madalin.bucur@nxp.com,
        David Miller <davem@davemloft.net>,
        Shawn Guo <shawnguo@kernel.org>, robin.murphy@arm.com,
        bharat.bhushan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 8:26 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Defer probe of qman portals after qman probing. This fixes the crash
> below, seen on NXP LS1043A SoCs:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000004
> Mem abort info:
>   ESR = 0x96000004
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> [0000000000000004] user address but active_mm is swapper
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 4.18.0-rc1-next-20180622-00200-g986f5c179185 #9
> Hardware name: LS1043A RDB Board (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO)
> pc : qman_set_sdest+0x74/0xa0
> lr : qman_portal_probe+0x22c/0x470
> sp : ffff00000803bbc0
> x29: ffff00000803bbc0 x28: 0000000000000000
> x27: ffff0000090c1b88 x26: ffff00000927cb68
> x25: ffff00000927c000 x24: ffff00000927cb60
> x23: 0000000000000000 x22: 0000000000000000
> x21: ffff0000090e9000 x20: ffff800073b5c810
> x19: ffff800027401298 x18: ffffffffffffffff
> x17: 0000000000000001 x16: 0000000000000000
> x15: ffff0000090e96c8 x14: ffff80002740138a
> x13: ffff0000090f2000 x12: 0000000000000030
> x11: ffff000008f25000 x10: 0000000000000000
> x9 : ffff80007bdfd2c0 x8 : 0000000000004000
> x7 : ffff80007393cc18 x6 : 0040000000000001
> x5 : 0000000000000000 x4 : ffffffffffffffff
> x3 : 0000000000000004 x2 : ffff00000927c900
> x1 : 0000000000000000 x0 : 0000000000000004
> Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
> Call trace:
>  qman_set_sdest+0x74/0xa0
>  platform_drv_probe+0x50/0xa8
>  driver_probe_device+0x214/0x2f8
>  __driver_attach+0xd8/0xe0
>  bus_for_each_dev+0x68/0xc8
>  driver_attach+0x20/0x28
>  bus_add_driver+0x108/0x228
>  driver_register+0x60/0x110
>  __platform_driver_register+0x40/0x48
>  qman_portal_driver_init+0x20/0x84
>  do_one_initcall+0x58/0x168
>  kernel_init_freeable+0x184/0x22c
>  kernel_init+0x10/0x108
>  ret_from_fork+0x10/0x18
> Code: f9400443 11001000 927e4800 8b000063 (b9400063)
> ---[ end trace 4f6d50489ecfb930 ]---
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

As this is part of a bug fix for v4.19, applied on soc/fsl for fix.

> ---
>  drivers/soc/fsl/qbman/qman_portal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index 6d9da3b1b5ad..eef93cab84f1 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -229,6 +229,14 @@ static int qman_portal_probe(struct platform_device *pdev)
>         int irq, cpu, err;
>         u32 val;
>
> +       err = qman_is_probed();
> +       if (!err)
> +               return -EPROBE_DEFER;
> +       if (err < 0) {
> +               dev_err(&pdev->dev, "failing probe due to qman probe error\n");
> +               return -ENODEV;
> +       }
> +
>         pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
>         if (!pcfg)
>                 return -ENOMEM;
> --
> 2.17.1
>
