Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09491C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE7C2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BN215eGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfBLIjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:39:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34533 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfBLIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:39:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so775324wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/CFGkCD56071w5tTLCtkzHRnwrMgXlzo1xEQY1LsUbY=;
        b=BN215eGayuz3EEfxN1zsJnJiF/Pt1zB1gVreYjWnEHXrSzSFsGxBcnWLpkp7BTqfSO
         UeT6L1eo5sdeptl/kBt1raY3S7f5LkfkyVrwMMs5JsFkYQapfJri+OyMT2XJnWzaCHDG
         qtDSMlUYQS01KaBiFXDdUukMBqDJIIXaHtA2/8yGaV8tpxQv6RZW3mlTmodKonCjDH/j
         5CMYZExXq8WEJg675TARSO687yLINvvoh+o8MCVPbH3SJxBSjxAeFvYsl98V1GS2jp4v
         QWb9FsSZ7AoNCVVpZI8Ch+S/aJbTCw6yigJRMCwpZrEcTgbQviKMtPleS3DhQ8oPVGJZ
         bjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/CFGkCD56071w5tTLCtkzHRnwrMgXlzo1xEQY1LsUbY=;
        b=iUGx1ijOZ9qPJWyAst1bJzh3cw0KA9AZlyq7RjCeBa363rDQ5e1HN3KZ1VH3jAUV9t
         C3HRjvyrKor7q5kIpb7tCRmcdmjwWRxajkPmQq1TVfwelRSctDBslmf/qVbm/qAs19Hy
         7O8Is2gozPJT+kgdPwMooD6ryLf7/AOXsQWWfL6Kw5BkmSFD8Kc9eqgA75R+2u1WgCnA
         DC9/Ww9cQZcbriNK5HSexCfQ2JY570YOzmCbzOXYxdvyYgsqZgqC2sIoKJcaDFQRR78C
         7OgET4dNnN44MkmkoTNa/K/xMTmC/RLnNJxdFIskQPYbkT0JLgJ3vSL0R8yR0saDOhb0
         TTIQ==
X-Gm-Message-State: AHQUAuYl7h5wgwslukOccYsjwDbL2JGMUMyIMKVrY0bXJLIy/6a42Mci
        tpihcooEoFs4eI7bFk5Wj5zKRA==
X-Google-Smtp-Source: AHgI3IaGkXV7IhB6ImNUpYobiGovJzb8Dti6VV46TOkA3j7Bj2qVfHmu32gOP/vF2NFP+d5o3dAXIA==
X-Received: by 2002:a7b:c112:: with SMTP id w18mr2000852wmi.28.1549960759345;
        Tue, 12 Feb 2019 00:39:19 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id g25sm1497023wmh.25.2019.02.12.00.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:39:18 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:39:16 +0000
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
Subject: Re: [PATCH v2 05/11] mfd: pm8xxx: disassociate old virq if hwirq
 mapping already exists
Message-ID: <20190212083916.GV20638@dell>
References: <20190208021631.30252-1-masneyb@onstation.org>
 <20190208021631.30252-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208021631.30252-6-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Brian Masney wrote:

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
> 
> This change was tested on an APQ8060 DragonBoard.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v1:
> - None
> 
>  drivers/mfd/qcom-pm8xxx.c | 6 ++++++
>  1 file changed, 6 insertions(+)

For Linus:
  
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
