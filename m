Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61644C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E975224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0nZI6MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E975224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbeKMLeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:34:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38740 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKMLeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:34:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id q186-v6so9359244ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 17:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jcqal1Ij8XZjgmjiD+PRXTqgn4mseCDDcj0QyHCQnLE=;
        b=Y0nZI6MYDgHimcC8J88pDmZxZtjpYCemYP4qB4gyKUym373osSQmProoFqPuy/MRWW
         8iB/0RlGqrrOEGMy08eQHSthRAuqi3fdl7I6lBtW+8XxUunw08QSEkOA69I7iOHxE3Us
         4kChT9O0jXIVGC+lGXQ5tInl7dReoArLY/jz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jcqal1Ij8XZjgmjiD+PRXTqgn4mseCDDcj0QyHCQnLE=;
        b=Xr2TnFUSSIQKrhJUACNOZzMGTyAoWjgKuta0BqgbDsw8KCJe5orVpHiVk9ScRjxtk9
         PGqKOBlQqUjrM7pT9M2fLv209v3VB/EYNvdR0qIPdmFWic4zPjvRJ77dtERCXfP15jBe
         /rnnfU8N6vJxJJVwr+ia293SqlT5DPYHwbHn+lAqqSV0nz4NkCg78bQqAOMxP4TlYyJ8
         bJMoySkXjROQ2iZpm6Lx/E9HD5zt3g/E4cbHqwX/ziAzxyWFGAwLl/TTl7Zy3VutXnAE
         y23tPIya1cK29pgGjJ096o6LKZyGeKiH3RcRBNcpdBdZqxGmKv3MujdZqnAOOURNIOBU
         P4PA==
X-Gm-Message-State: AGRZ1gKC0roM0TtEl7XrBGyhlJbdXbog9kT+RqcN/FrX4TUpbOLeAfq9
        ZZqSdCbd4gMzjA/i/dKYGr0NfExLgFhACWhd9QfU9Ae5Siyveg==
X-Google-Smtp-Source: AJdET5c4tWK+9zthf1w3mYBpynTAevQG5MVmgbVZku3zfPqo9hpigEwcr1iYcUIYNpWC0m7VWyK+AcR/026TFcZaW28=
X-Received: by 2002:a2e:2f1b:: with SMTP id v27-v6mr1931358ljv.31.1542073129318;
 Mon, 12 Nov 2018 17:38:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:95ca:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 17:38:48
 -0800 (PST)
In-Reply-To: <3736c0f9-9f2c-bc74-22c2-677c42a2a630@infradead.org>
References: <3736c0f9-9f2c-bc74-22c2-677c42a2a630@infradead.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 13 Nov 2018 09:38:48 +0800
Message-ID: <CAMz4kuKwvSOV4vU7_iVoyigdkMRDYMoNLLuiCFs33=E7br4wDw@mail.gmail.com>
Subject: Re: [PATCH -next] power/supply: fix sc27xx_fuel_gauge build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 13 November 2018 at 01:06, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build errors when FUEL_GUAGE_SC27XX is enabled but IIO is either
> not enabled or IIO=m and FUEL_GUAGE_SC27XX=y.
>
> ld: drivers/power/supply/sc27xx_fuel_gauge.o: in function `sc27xx_fgu_get_temp':
> sc27xx_fuel_gauge.c:(.text+0x1d2): undefined reference to `iio_read_channel_processed'
> ld: drivers/power/supply/sc27xx_fuel_gauge.o: in function `sc27xx_fgu_probe':
> sc27xx_fuel_gauge.c:(.text+0x97f): undefined reference to `devm_iio_channel_get'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---

Thanks for fixing this issue.
Acked-by: Baolin Wang <baolin.wang@linaro.org>

>  drivers/power/supply/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20181112.orig/drivers/power/supply/Kconfig
> +++ linux-next-20181112/drivers/power/supply/Kconfig
> @@ -655,6 +655,7 @@ config CHARGER_SC2731
>  config FUEL_GAUGE_SC27XX
>         tristate "Spreadtrum SC27XX fuel gauge driver"
>         depends on MFD_SC27XX_PMIC || COMPILE_TEST
> +       depends on IIO
>         help
>          Say Y here to enable support for fuel gauge with SC27XX
>          PMIC chips.
>
>



-- 
Baolin Wang
Best Regards
