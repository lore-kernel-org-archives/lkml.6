Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84311C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD62184D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545601708;
	bh=s2vP+naoPGbRsAj34gvXYe7u7OX6pZMCDIQ1cvQwqxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ISDcviz+vGQF9rTDkMG9basyFF7We/kAZ8wQ4IdK/5DRbth0umCLHPxzhisqIC4Gl
	 ptk7JtH1cX9LhZtwxK7ZtvboDcYa8JUeaUwrhDWqoque7Lvvxq/Zmiua0v17oPnq2r
	 8opR4G5Pbxm7E1gEun/O1V/C2HKqalwKsk+sSbeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbeLWVs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 16:48:27 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33056 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 16:48:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so9673260otl.0;
        Sun, 23 Dec 2018 13:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGBdpK86Qxky4Z/5g5H3hOXeBkXXfBH38JO5h9uIdG8=;
        b=PSw4+3Xf5qKmDrYLHYV0osWtrd/uDJXAaJnSBIDAXurGybkcBunNrEtjb0rYj7ta0s
         psnGpR3Rrgv+lormTlOnlXObzmo5F5ekFFtDLtg4xJW+sOHSqsmKV8T5MIOItpgATr8/
         V1HWdk15w6D7UHMyyhBWjSlkhEZhSqvik/l/l/Nmdgoj2ufcVQPjpXGUtNtI8ujXO0m+
         LNkNw1LIGTSqwd2HFzBbgavjbWGspAzKRl1e9BThLY9Qm00rDwU65b63x22ZG132dGXP
         jtKatH7L5LPFRJkpcF385QU2HQo3X5eLOzy3/0ObTheq2uUR+EO4lPRE//xBvCzKMz73
         vqtw==
X-Gm-Message-State: AJcUukevyM/TCQ7UL8dNAiwBS0LEcK5qTzNsL0pJqwQNLMuWIMcMCNcd
        /6PrN7FbaS+AM67Ybu4pjRJk133CpRNfgJCtFI0=
X-Google-Smtp-Source: ALg8bN6c75Hg9fMSTbBkaB5dwwjr9kDPxglp5Ln3VIzsLZB5EiGYIPiOQJal8CyZzVrX2+lH+BRQvtDzZQuTvX6NQTE=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr7627088oti.258.1545601706058;
 Sun, 23 Dec 2018 13:48:26 -0800 (PST)
MIME-Version: 1.0
References: <20181222090720.19234-1-okaya@kernel.org> <20181222090720.19234-8-okaya@kernel.org>
In-Reply-To: <20181222090720.19234-8-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 23 Dec 2018 22:48:11 +0100
Message-ID: <CAJZ5v0j6Z42pk16fFGpQz+xvU-gVnarkoafcWJuQPWY=X532YQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] drivers: thermal: Hide PCI driver when
 CONFIG_PCI is unset
To:     okaya@kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        sumeet.r.pawnikar@intel.com, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 6:49 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> This driver is both a platform and PCI driver. Hide PCI specific pieces
> when CONFIG_PCI is unset.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  .../intel/int340x_thermal/processor_thermal_device.c      | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 284cf2c5a8fd..b84a475a1162 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -374,6 +374,7 @@ static int int3401_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PCI
>  static irqreturn_t proc_thermal_pci_msi_irq(int irq, void *devid)
>  {
>         struct proc_thermal_device *proc_priv;
> @@ -482,6 +483,7 @@ static struct pci_driver proc_thermal_pci_driver = {
>         .remove         = proc_thermal_pci_remove,
>         .id_table       = proc_thermal_pci_ids,
>  };
> +#endif
>
>  static const struct acpi_device_id int3401_device_ids[] = {
>         {"INT3401", 0},
> @@ -505,16 +507,18 @@ static int __init proc_thermal_init(void)
>         ret = platform_driver_register(&int3401_driver);
>         if (ret)
>                 return ret;
> -
> +#ifdef CONFIG_PCI
>         ret = pci_register_driver(&proc_thermal_pci_driver);
> -
> +#endif
>         return ret;
>  }
>
>  static void __exit proc_thermal_exit(void)
>  {
>         platform_driver_unregister(&int3401_driver);
> +#ifdef CONFIG_PCI
>         pci_unregister_driver(&proc_thermal_pci_driver);
> +#endif
>  }
>
>  module_init(proc_thermal_init);

Can you actually test this driver with your new #ifdef stuff and with
CONFIG_PCI unset?

Have you really test it in that configuration?

If not, you shouldn't even post this patch.

Please make the driver depend on PCI.
