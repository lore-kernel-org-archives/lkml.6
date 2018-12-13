Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4418C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E112086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8fHVDKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E112086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbeLMQXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:23:11 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46792 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:23:11 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so2486735edt.13;
        Thu, 13 Dec 2018 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biFtWIouHeCmptld8RVPX2GxDksaLA98OTNXtdMOMs4=;
        b=U8fHVDKD6RqtM+HsGaU4cvJtgA9haCGxlU2N961lZbSm7gkRoGj+eQ18F8MnhZlISe
         rnJo7uFXf4y0knNofDed0LZ3jAj9msr1zOzdTytqDnmI90055I9OH/+8wxZ4ZBzWiTVO
         RjB7ZLxHMiGounA+WjZTOqyOvXG04exAEtjBNcx2m+RrbMIVd2PLP3z2f7wrbkTLiqO5
         zgZEBc/93dW+W46Y6C0fct9qMWzWuiegipsM13aAvTkilfUBEQ/PE0c1YuoHY3/l0ELJ
         3rt5cyp9edjNRa9NMI5WJRa1kqZI+7IrxzsxmBQbAYCiUGaewUOCdKZ2RpUn/VaoHP7l
         SYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biFtWIouHeCmptld8RVPX2GxDksaLA98OTNXtdMOMs4=;
        b=K24SFQEmTr0PcFVu6HHZ2ER9lXVv8JFhANe3o+MiM4GT9QTZFGoQ8K2veputCS0JC3
         z8BBU881C0L0rz88ZzI1dnjmFHqyfdzSZxXNS0GxBPMyCI53ng1LUpfk4tbW9F7YJqz6
         7hawuU7qvxqW1p3s93tPzRlCmFZNyBk9zgouktXY0MWCMX76IpKeDr1IhsXqaaCAKs8n
         iczw8M9dlVNqqEZC1kRwUxVC1zn4kSU0N3MnlGSp41goJB9/pr/j+jJz6foxX10eRmUR
         l1MKYu6hauTYqEZtUQIA3A9BdFt0FS8jnxnfwvOSW5n/aPB1/URIpvKIIg83D6EbXZ40
         z+PA==
X-Gm-Message-State: AA+aEWYMgx1BE90XsjP6/rfmHktkD1L+5nuWOAQQh5Qk8/iDr/L7Ub6v
        DoI4Vl2FL14iOHl6og3PT9SNM2YYOPlXx8WxHvo=
X-Google-Smtp-Source: AFSGD/W5af5RWJYvaBalAKI66xaG1YFc52LJRTwXGHbkKqAht2Fjk/+Nzkh/oqcC4PXp8bnpRWwmrrnmXlUvdMict+I=
X-Received: by 2002:a50:a125:: with SMTP id 34mr23133661edj.175.1544718188302;
 Thu, 13 Dec 2018 08:23:08 -0800 (PST)
MIME-Version: 1.0
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 13 Dec 2018 18:22:54 +0200
Message-ID: <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ dependant
To:     abel.vesa@nxp.com
Cc:     shawnguo@kernel.org, sboyd@kernel.org, aisheng.dong@nxp.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>, kernel@pengutronix.de,
        olof@lixom.net, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        l.stach@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

> --- a/drivers/clk/imx/Makefile
> +++ b/drivers/clk/imx/Makefile
> @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
>  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
>  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
>  obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> -obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
>  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> +
> +obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o

Nit: Do we want to keep CONFIG_ sorted?
