Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F7FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7372020989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCKaptuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfA3NbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:31:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfA3NbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:31:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so26028913wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lwbDzXRQdXpPR+7TWLLCsWm0lBZYEQ3mNZju6vofjdI=;
        b=YCKaptuLnG4tsOsgBC6135pTG7cApJ1LnRJI6bcf3dQg5buf87RiQ+XLPqq0H1t4Bj
         XN1GTH8mDpmePBDFNZf6YX25SRZkhjQVN+XZZ7BWFIjMbooAGYQKbGhiEmIpPaqqDvem
         KIshrrYB4Fp7GvCelDeVlJk2dOdoo0AnmEbSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lwbDzXRQdXpPR+7TWLLCsWm0lBZYEQ3mNZju6vofjdI=;
        b=P7TDa2bT7HKj5PooubsL1q1EFC4Vd5A6+vYcgBK2h9GBgz2evKVr4Y05xp2aRLClE1
         aRkGBjQ7GUa8YZxas2Pj1KuqoKs6kaoU4TAqh/8TjuLQ0MHKIvdHfkDiIz08E5qL4yWU
         9p4sT6g6kozTVAfRVZq26ip05DxoAR+qTCmGk10qux/s10xoDmhVRFe+FxWOvRuSusMa
         ikqJSVnFJiB5STc+8nAa882o2kGIr6m90USjE01lXJnRMR9CcL+4haJjCkO3cj6FgXTv
         Vvos1GxoaE/98njwc42SHyOZuMTBMRy1ujBu5cCU8N5SZ1LZTzSnL77uUIiUmgRLvhlF
         /bhg==
X-Gm-Message-State: AJcUuke5vOPdLBu/b1JBT6xtOTWgFsuieOaHq/ChzOXybv9dKbS5Ofk/
        csKn7wTFOb3/+CymOVPYrXFy5g==
X-Google-Smtp-Source: ALg8bN4bTykX+Xh0scbqtBE7iil9MGWqU3XR3OgbMCsDTtFBA0k3ZSOZp6orxu2CoXFJVKO9MTfJSw==
X-Received: by 2002:adf:f785:: with SMTP id q5mr31722545wrp.9.1548855079052;
        Wed, 30 Jan 2019 05:31:19 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id m4sm6163751wmi.3.2019.01.30.05.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:31:18 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:31:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/9] mfd: pm8xxx: disassociate old virq if hwirq mapping
 already exists
Message-ID: <20190130133116.GF4701@dell>
References: <20190125162302.14036-1-masneyb@onstation.org>
 <20190125162302.14036-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190125162302.14036-5-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

On Fri, 25 Jan 2019, Brian Masney wrote:

> Check to see if the hwirq is already associated with another virq on
> this IRQ domain. If so, then disassociate it before associating the
> hwirq with the new virq.
> 
> This is a temporary hack that is needed in order to not break git
> bisect for existing boards. The next patch in this series converts
> ssbi-gpio to be a hierarchical IRQ chip, then there are several patches
> to update all of the device tree files, and finally this patch will be
> reverted within the same patch series.
> 
> IRQs for ssbi-gpio are all initially setup without an IRQ hierarchy
> this driver is probed due to the interrupts property in device tree.
> Once ssbi-gpio is converted to be a hierarchical IRQ chip in the next
> patch, existing users of gpio[d]_to_irq() will call pmic_gpio_to_irq(),
> and that will use the new IRQ chip code in ssbi-gpio that sets up the
> IRQ in an IRQ hierarchy. The hwirq is now associated with two Linux
> virqs and interrupts will not work as expected. This patch corrects
> that issue.

I guess that's okay.  Would quite like a second opinion though.

> This change was not tested on any actual hardware, however the same
> change was made to spmi-pmic-arb.c and tested on a LG Nexus 5
> (hammerhead) phone.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/mfd/qcom-pm8xxx.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index a976890c4019..97b931465601 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -387,6 +387,11 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
>  				  irq_hw_number_t hwirq, unsigned int type)
>  {
>  	irq_flow_handler_t handler;
> +	unsigned int old_virq;
> +
> +	old_virq = irq_find_mapping(domain, hwirq);
> +	if (old_virq)
> +		irq_domain_disassociate(domain, old_virq);
>  
>  	if (type & IRQ_TYPE_EDGE_BOTH)
>  		handler = handle_edge_irq;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
