Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79572C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4550E20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fG4IV6MF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fG4IV6MF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfAPXNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:13:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:58194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfAPXNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:13:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D1EC560300; Wed, 16 Jan 2019 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547680409;
        bh=wTvtcTx2T3WpJnVZtD3SM4QmaapVWUXKKXneT2PKIeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fG4IV6MFqa/xyaws1ijMEIZHtf9h3WZKWX4FdfAQiaWwiVUI45kruzfxbwbW2gCsw
         aGQ2yJVxyi3/aK6GXHATaZm9/ZoeHal6UlO8193F4lkctWI8RB903Uip8xVk63eWP6
         XwTwbVjzhrH5ZS5+HkLAqKes4ZuPGCbt/HtWS1NM=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C03B96053B;
        Wed, 16 Jan 2019 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547680409;
        bh=wTvtcTx2T3WpJnVZtD3SM4QmaapVWUXKKXneT2PKIeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fG4IV6MFqa/xyaws1ijMEIZHtf9h3WZKWX4FdfAQiaWwiVUI45kruzfxbwbW2gCsw
         aGQ2yJVxyi3/aK6GXHATaZm9/ZoeHal6UlO8193F4lkctWI8RB903Uip8xVk63eWP6
         XwTwbVjzhrH5ZS5+HkLAqKes4ZuPGCbt/HtWS1NM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C03B96053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 16 Jan 2019 16:13:28 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH 5/7] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
Message-ID: <20190116231328.GA20369@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org>
 <20181219221105.3004-6-ilina@codeaurora.org>
 <154533621302.79149.15228907259643696166@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <154533621302.79149.15228907259643696166@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2018 at 13:03 -0700, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-12-19 14:11:03)
>> +
>> +static int msm_gpio_domain_alloc(struct irq_domain *domain, unsigned int virq,
>> +                                unsigned int nr_irqs, void *arg)
>> +{
>> +       int ret;
>> +       irq_hw_number_t hwirq;
>> +       struct gpio_chip *gc = domain->host_data;
>> +       struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>> +       struct irq_fwspec *fwspec = arg;
>> +       struct qcom_irq_fwspec parent = { };
>> +       unsigned int type;
>> +
>> +       ret = msm_gpio_domain_translate(domain, fwspec, &hwirq, &type);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
>> +                                           &pctrl->irq_chip, gc);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (!domain->parent)
>> +               return 0;
>> +
>> +       parent.fwspec.fwnode      = domain->parent->fwnode;
>> +       parent.fwspec.param_count = 2;
>> +       parent.fwspec.param[0]    = hwirq;
>> +       parent.fwspec.param[1]    = type;
>> +
>> +       ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (parent.mask)
>> +               set_bit(hwirq, pctrl->wakeup_masked_irqs);
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * TODO: Get rid of this and push it into gpiochip_to_irq()
>
>Hmm.. yeah we need to do this still. I think we can have a generic two
>cell function similar to irq_domain_xlate_twocell() that does the fwspec
>creation and uses some of the things that we pass to
>gpiochip_irqchip_add(), like the default level type. This existing
>function is not good to have, so there's work to do to get rid of this.
>

>I was also thinking that maybe we can make the alloc function above take
>a struct gpio_irq_fwspec structure that tells the alloc function what
>gpiochip the irq is for. That would mean that we need to change the
>gpio_to_irq() function below to be generic and stuff the chip inside the
>fwspec wrapper structure:
>
>	struct gpio_irq_fwspec {
>		struct irq_fwspec fwspec;
>		struct gpio_chip *chip;
>		unsigned int offset;
>	};
>
>but I seem to recall that was not working for some reason.
>
I was thinking about this. If I understand you correctly, we want to
generalize the .translate and .alloc functions. We could move the
.translate to generic however, the alloc would still need to be specific
for the parent.mask. But we can do this without the gpio_irq_fwspec. I
presume you suggest this structure so we could pass the hwirq and type
to the .alloc function. but we have that in the fwspec. What am I
missing?

>> + */
>> +static int msm_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       struct irq_fwspec fwspec;
>> +
>> +       fwspec.fwnode = of_node_to_fwnode(chip->of_node);
>> +       fwspec.param[0] = offset;
>> +       fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
>> +       fwspec.param_count = 2;
>> +
>> +       return irq_create_fwspec_mapping(&fwspec);
>> +}
>> +
>> +static const struct irq_domain_ops msm_gpio_domain_ops = {
>> +       .translate = msm_gpio_domain_translate,
>> +       .alloc     = msm_gpio_domain_alloc,
>> +       .free      = irq_domain_free_irqs_top,
>> +};
>> +
