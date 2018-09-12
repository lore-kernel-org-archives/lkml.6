Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6930C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A724204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoP/l3Ki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A724204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeILGMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:12:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33494 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:12:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so433298edv.0;
        Tue, 11 Sep 2018 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SLUGZl6FcB8AgD8guKEt1+pQeVwLJeMyasvJ1yrIbMA=;
        b=FoP/l3KicSp1VFheurOnGQqK4gsxvQDqlt9QMmfZ40D+CpeYoPOtmH1bMydXyrspfb
         0NCO5aic+xKhaoriSyhFrXKaGVGjSN9bde4/Ki5Anf4SxajFkYCC+X+q6aMBg3XoPBUH
         ZHhZWlxXIpwKmAFQdORuTsFTF5Q6/r8HFVdCEcfnKjviBI4cNJFuH5gX3pdv+HbFN3kj
         GA7EsJzm3rd9/3bpaqzUgFgELN6oXVETZB4hllQgInzI0cJ/kfuQtpjrXIrLejnwwTwO
         hdpkOti//MIeo8KcTyBr9DexqC9Kux72ObVaNv0RYSbfu+qHFzdjRzd7GvD1EWrb+vRr
         Mhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SLUGZl6FcB8AgD8guKEt1+pQeVwLJeMyasvJ1yrIbMA=;
        b=pEga7wwYK8QdzuWPSOPDkS3vq8YpApcXZGf3H6EX6cAIncoFhlELXxS3EPXPMs2rLN
         szFHcSy33fZBJaVHADhrxi5jx6l/LZ/TdF4oVH7Bp6BZs0yK09/gXng1HTSrcs+GygYa
         olvmZDRMdKB8OWu2RN6Ux7N8jopNaAQ/6bz4u6d06KAHIq2WuHQeZXRsFzsaxZnL9Acj
         QslyD+hWU5znFKNFYINZvqALjSr25EdQsWVzHWis04dbJ77IVdLXucIfiZfTbtRBPxIF
         ETlca2QxpDdkee8uJpJOf4r9Dktvv1W8DaBy14c1mRuK3RBpqzWZfNDEdye56FeW9G1O
         +kMg==
X-Gm-Message-State: APzg51AJOOw993jGRns6pL7G7T02iY6trH7DBTmH66CzFdMEomK5xcon
        Fv4eMlfTWmZ4RbZRrYCQlqA=
X-Google-Smtp-Source: ANB0VdZuyUWVPSgfMiJnL5fSP5n67+nIWk/RjeKIKuwN7dteaynyAZg/dSAC3LpdJoQc8nL4avDmPg==
X-Received: by 2002:a50:de8e:: with SMTP id c14-v6mr30112621edl.196.1536714611060;
        Tue, 11 Sep 2018 18:10:11 -0700 (PDT)
Received: from darwi-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id b9-v6sm12608222edk.62.2018.09.11.18.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 18:10:10 -0700 (PDT)
Date:   Wed, 12 Sep 2018 01:10:03 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     matthias.bgg@gmail.com, andy.gross@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, bjorn.andersson@linaro.org,
        sean.wang@mediatek.com, m.szyprowski@samsung.com,
        michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v3 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Message-ID: <20180912011003.GA14928@darwi-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536701697-23949-4-git-send-email-jollys@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[ Thanks a lot for upstreaming this.. ]

On Tue, Sep 11, 2018 at 02:34:57PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
>
> Add ZynqMP PM driver. PM driver provides power management
> support for ZynqMP.
>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---

[...]

> +static irqreturn_t zynqmp_pm_isr(int irq, void *data)
> +{
> +	u32 payload[CB_PAYLOAD_SIZE];
> +
> +	zynqmp_pm_get_callback_data(payload);
> +
> +	/* First element is callback API ID, others are callback arguments */
> +	if (payload[0] == PM_INIT_SUSPEND_CB) {
> +		if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
> +			goto done;
> +
> +		/* Copy callback arguments into work's structure */
> +		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
> +		       sizeof(zynqmp_pm_init_suspend_work->args));
> +
> +		queue_work(system_unbound_wq,
> +			   &zynqmp_pm_init_suspend_work->callback_work);

We already have devm_request_threaded_irq() which can does this
automatically for us.

Use that method to register the ISR instead, then if there's more
work to do, just do the memcpy and return IRQ_WAKE_THREAD.

> +	}
> +
> +done:
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * zynqmp_pm_init_suspend_work_fn() - Initialize suspend
> + * @work:	Pointer to work_struct
> + *
> + * Bottom-half of PM callback IRQ handler.
> + */
> +static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
> +{
> +	struct zynqmp_pm_work_struct *pm_work =
> +		container_of(work, struct zynqmp_pm_work_struct, callback_work);
> +
> +	if (pm_work->args[0] == ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {

we_really_seem_to_love_long_40_col_names_for_some_reason

> +		orderly_poweroff(true);
> +	} else if (pm_work->args[0] ==
> +		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {

Ditto

[...]

> +/**
> + * zynqmp_pm_sysfs_init() - Initialize PM driver sysfs interface
> + * @dev:	Pointer to device structure
> + *
> + * Return: 0 on success, negative error code otherwise
> + */
> +static int zynqmp_pm_sysfs_init(struct device *dev)
> +{
> +	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr);
> +}
> +

Sysfs file is created in platform driver's probe(), but is not
removed anywhere in the code.

What happens if this is built as a module? Am I missing something
obvious?

Moreover, what's the wisdom of creating a one-liner function with
a huge six-line comment that:

    a) _purely_ wraps sysfs_create_file(); no extra logic
    b) is called only once
    c) and not passed as a function pointer anywhere

IMO Such one-liner translators obfuscate the code and review
process with no apparent gain..

> +/**
> + * zynqmp_pm_probe() - Probe existence of the PMU Firmware
> + *		       and initialize debugfs interface
> + *
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * Return: Returns 0 on success, negative error code otherwise
> + */

Again, huge 8-line comment that provide no value.

If anyone wants to know what a platform driver probe() does, he
or she better check the primary references at:

    - Documentation/driver-model/platform.txt
    - include/linux/platform_device.h

and not the comment above..

> +static int zynqmp_pm_probe(struct platform_device *pdev)
> +{
> +	int ret, irq;
> +	u32 pm_api_version;
> +
> +	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
> +		return -ENXIO;
> +
> +	eemi_ops->init_finalize();
> +	eemi_ops->get_api_version(&pm_api_version);
> +
> +	/* Check PM API version number */
> +	if (pm_api_version < ZYNQMP_PM_VERSION)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0)
> +		return -ENXIO;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, zynqmp_pm_isr, IRQF_SHARED,
> +			       dev_name(&pdev->dev), pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request_irq '%d' failed with %d\n",
> +			irq, ret);
> +		return ret;
> +	}
> +
> +	zynqmp_pm_init_suspend_work =
> +		devm_kzalloc(&pdev->dev, sizeof(struct zynqmp_pm_work_struct),
> +			     GFP_KERNEL);
> +	if (!zynqmp_pm_init_suspend_work)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
> +		  zynqmp_pm_init_suspend_work_fn);
> +

Let's use devm_request_threaded_irq(). Then we can completely
remove the work_struct, INIT_WORK(), and queuue_work() bits.

> +	ret = zynqmp_pm_sysfs_init(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
> +		return ret;
> +	}
> +
> +	return ret;

Just return 0 please. BTW ret was declared without initialization.

> +}
> +
> +static const struct of_device_id pm_of_match[] = {
> +	{ .compatible = "xlnx,zynqmp-power", },
> +	{ /* end of table */ },
> +};
> +MODULE_DEVICE_TABLE(of, pm_of_match);
> +
> +static struct platform_driver zynqmp_pm_platform_driver = {
> +	.probe = zynqmp_pm_probe,
> +	.driver = {
> +		.name = "zynqmp_power",
> +		.of_match_table = pm_of_match,
> +	},
> +};

.remove with a basic sysfs_remove_file() is needed.

Thanks,

--
Darwi
http://darwish.chasingpointers.com
