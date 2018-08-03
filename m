Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71112C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215082175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215082175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeHCNIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:08:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46300 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeHCNIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:08:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id l16-v6so3754627lfc.13;
        Fri, 03 Aug 2018 04:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=baywPEr86nStkcg1MLHZSaCY5j91ylNJudxw8oXDzG8=;
        b=hDXPaXzPhuVn/kjSzpcEP7D8RfAAojua90wZayXgYHkh0wILh9AvMa8hX8ZAhNBXox
         cI2oYnVaXywK62BK7PshU9iK7KkMEfY4vE+UckpfdEwofWbc7OSuwe0Kdutl8T070WeV
         xcToiZi50i4G1tBUN4tXtxvM+jNHtrW+v7PFu6idZpODuz/ppMthOzuI0oQQolKx9ONe
         7+/64j05w4/nqx5r93jQ3VZLln0+cq7uIrPv9vVQzEJt/Py+5/FNTOypNcAd4Qfsy1mN
         LnfjFNfw5cFfD/aEem/wD1q9N644AI1ggC9rFMaHOcN00U+hONLG2YzZa3APGPF32dNd
         kaSQ==
X-Gm-Message-State: AOUpUlHWzU7G2QBJzg3uZ7APSgoipGmeqXd4gGqceUT/0HmKmzHPWXNq
        /5oGAmN82k0LbJ1MNGieMFOOyhRFLjM=
X-Google-Smtp-Source: AAOMgpfPd01smVGMWS7cYrr6tfKdXSyt0/nYC+2w7cY3ffWnSl+Qma8vzs2wg+UFkC1t9iHOSfGIJA==
X-Received: by 2002:a19:4344:: with SMTP id m4-v6mr2075793lfj.111.1533294773715;
        Fri, 03 Aug 2018 04:12:53 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id j26-v6sm860188ljc.54.2018.08.03.04.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 04:12:53 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:12:50 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        eballetbo@gmail.com, linus.walleij@linaro.org,
        mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v12 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180803111250.GC20907@localhost.localdomain>
References: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
 <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 02:08:14PM +0300, Matti Vaittinen wrote:
> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I maintained Enric's Reviewed-by as only change I did to v12 was:

> +	ret = regmap_irq_get_virq(bd71837->irq_data, BD71837_INT_PWRBTN_S);
> +
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to get the IRQ\n");
> +		return ret;
> +	}
> +
> +	button.irq = ret;

instead of v11 which was:

+       button.irq = regmap_irq_get_virq(bd71837->irq_data,
+                                         BD71837_INT_PWRBTN_S);
+
+       if (button.irq < 0) {
+               dev_err(&i2c->dev, "Failed to get the IRQ\n");
+               return button.irq;
+       }

Br,
	Matti Vaittinen

