Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C9120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsuhSkHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C9120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeKFUko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 15:40:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46004 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFUko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 15:40:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id l9-v6so2088424qtj.12;
        Tue, 06 Nov 2018 03:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=83IN5G0ix7r+IaBQDu0omdTI0gPN8wWLp3vequMbwng=;
        b=OsuhSkHuvC3vdQOTqnJFu6lIQjUKnjOAXzfgrj+vwtUlsdwphhZ9yKMAjl8Bp/3Qyy
         6loHY6jtxpAwDqzlShwU97bKSPmH24Shl3jXurfDNwD4Meq9zxUswOGutkI+3neZOCM7
         U/cb+gYg0axzKwnD5dFDU7pXo4roZtQ9ezpu36wZVZe42FzSOmQlN8We+jk3RjXzLS3Z
         Pa7l6ElXgP6Q4DZ29OUmJzmh9I29zyMMMZda0Pp0V/eVNTJssmkjjH7+kmgDcQSVZKZU
         hr44a1g9a++rh3MPa217Z+lQHsfG1bVvdkQPgCQfxxDEdssAsIvQjpDg+8cWEuhqmbYC
         t3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=83IN5G0ix7r+IaBQDu0omdTI0gPN8wWLp3vequMbwng=;
        b=aD0qkvYq4g+RmAVHh/9yFaM27fP0u4IzHQszASi5ltA4gmky1OnsRjDQOA9YkkGIWX
         I8Xzw2c7iYxmRd1KFHeJL6qALPnswHwURP1f4LZlRwq6y8jQf44h2H5SSp8vhyREaWop
         hgtGi2W/A8PD0x6jp1d9lHfCeyYz0Giz9IVDF1QaaBeyUXry0Q+32YCt7dJUr5oCnZ3O
         ijJi8ip7vj/UwkfgRidbQ21H/isWmJJ3fffs8sZqDeIf4BjKtsJkdwwhFTFL+AH8nA77
         O3mN6xFahSoGm8CophSxhom3s0Ln01R/jIRe1kQXWwWIMuxINZJbS+TLfC2HP46zgjLs
         Fkjw==
X-Gm-Message-State: AGRZ1gJjklEPrqw6WbuAEFoq44jJGLOKktP7KKNnFcJeqcCLHczWForu
        zU5AD3zBdz8G56WwN3e/hr6rbG0/c9fuJ6vgjRo=
X-Google-Smtp-Source: AJdET5eKsiK8/N5Jtx3N76PVzXbkmg9xSz0jcMDF5dDPkNyi9qIiILgW17vWcbsvkWF25EdCxw8Q5zjbm5L87E5upEw=
X-Received: by 2002:ac8:410a:: with SMTP id q10-v6mr23883842qtl.96.1541502961142;
 Tue, 06 Nov 2018 03:16:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 03:16:00 -0800 (PST)
In-Reply-To: <1541387810-24867-2-git-send-email-zhang.chunyan@linaro.org>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org> <1541387810-24867-2-git-send-email-zhang.chunyan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Nov 2018 12:16:00 +0100
X-Google-Sender-Auth: LOJufIe7PeLQOTYFgDX6v6sjRb4
Message-ID: <CAK8P3a2aUjLsP70zSjkavR4-mkV9iEVCw96Vces4N15Dno8SHw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] mmc: sdhci: add support for using external DMA devices
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> Some standard SD host controller can support both external dma
> controllers as well as ADMA in which the controller acts as
> DMA master.
>
> Currently the generic SDHCI code supports ADMA/SDMA integrated into
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine meaning that custom code is
> needed for any systems that use a generic DMA controller with SDHCI.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Looks good to me overall, but I think I found one small bug:


> +	dma->rx_chan = dma_request_chan(mmc->parent, "rx");
> +	if (IS_ERR(dma->rx_chan)) {
> +		ret = PTR_ERR(dma->rx_chan);
> +		if (ret == -EPROBE_DEFER && dma->tx_chan)
> +			dma_release_channel(dma->tx_chan);
> +
> +		dma->rx_chan = NULL;
> +		pr_warn("Failed to request RX DMA channel.\n");
> +	}

The error handling looks wrong here: if you get EPROBE_DEFER,
you want to skip the warning message. If you get any other error code,
you want the warning message and also the dma_release_channel()
which should be unconditional here.

        Arnd
