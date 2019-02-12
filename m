Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEBDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB4218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viFIGc2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfBLIUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:20:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfBLIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:20:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id w17so1577575wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BUxHh2rdaTfguXFkRs8NHl4QIWJXp8EQE23alHMZDOA=;
        b=viFIGc2XbXyJRI24ClcGL77Ik9/Qw/E1t+Qgi1pcROdXq9V/tSLsZ9emyIc04mRb7r
         gjMc/mzbQEbSSTcNeMmgTo1bsrvTNPQDw5KIjFi93zShBZQubTM6XCCuiWLUFZZRdYhp
         G1HZIL4HPCAX34JX7/hgtwcbk/bXFFHqVdoi8o7MSnOrTsgh7mLSlUl0OtGe0TSsvJYW
         FbaQCfgTKCgz2XSJTRsJPs0Gz0U+8tV08jZuFVDCT5ldUPaMZEGIq488Mm8835wjX9kj
         dhbxjbNm07uK9Qj28P3IJrlsN/9Vry8MGuydCn/rSZd6OzvMcPXi+LlBZybrfg8zv6/a
         XFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BUxHh2rdaTfguXFkRs8NHl4QIWJXp8EQE23alHMZDOA=;
        b=jAEPddhvZJhwdXyorwdAwrX2Z5AErFEIxAd55sRGpVRY8qXwAcuAPevOYfHj1gM0Vq
         is3NOk2yUMJ9iUpjR34b/d2tKHn4V2C/HbHqa5LErAh4GjaKdzQFQ2/WypcvQbJH0RsO
         C1dxaUO204AtYIMQocGHxa9xueRpS0pmDInxtIK+8oloFpvq69sTufjttlSATNr0sN+I
         tSYecqWJhCmNE8hy1Umr32XSYoFMrL4Ym6cJq/aBJZQolmBDgk1n2NZkC/q6hcdOfIFE
         ZJsmzyrxnoyadI+F652GWohUk+JdJCG/dBHEAQ+gzPlgXp4nS9u1tEiQELwSH1wWFedv
         aMoQ==
X-Gm-Message-State: AHQUAuYGP9r5tbDH3y0tZ4gF9KsgRoPLfYfeMuszXUl1fQwl7y7Hye5Z
        lM8HEynZsteQpWvZXJNQiYrWZw==
X-Google-Smtp-Source: AHgI3IZ9RvMaJL2Do16Mi+fq98NyGTaSPtQs7+4XOsz/1czjablrUwq4BXgcizjRAwjVbldG86l0hA==
X-Received: by 2002:a5d:5585:: with SMTP id i5mr1929070wrv.239.1549959637522;
        Tue, 12 Feb 2019 00:20:37 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id m4sm2423908wmi.3.2019.02.12.00.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:20:36 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:20:35 +0000
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
Subject: Re: [PATCH v2 11/11] mfd: pm8xxx: revert "disassociate old virq if
 hwirq mapping already exists"
Message-ID: <20190212082035.GQ20638@dell>
References: <20190208021631.30252-1-masneyb@onstation.org>
 <20190208021631.30252-12-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208021631.30252-12-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Brian Masney wrote:

> Now that ssbi-gpio is a proper hierarchical IRQ chip, and all in-tree
> users of device tree have been updated, we can now drop the hack that
> was introduced to disassociate the old Linux virq if a hwirq mapping
> already exists. That patch was introduced to not break git bisect for
> any existing boards.
> 
> This change was tested on an APQ8060 DragonBoard.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v1:
> - None
> 
>  drivers/mfd/qcom-pm8xxx.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> index 2f99a98ccee5..8eb2528793f9 100644
> --- a/drivers/mfd/qcom-pm8xxx.c
> +++ b/drivers/mfd/qcom-pm8xxx.c
> @@ -380,12 +380,6 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
>  				  struct irq_domain *domain, unsigned int irq,
>  				  irq_hw_number_t hwirq, unsigned int type)
>  {
> -	unsigned int old_virq;
> -
> -	old_virq = irq_find_mapping(domain, hwirq);
> -	if (old_virq)
> -		irq_domain_disassociate(domain, old_virq);
> -

For Linus:
  
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
