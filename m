Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD30620675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHsY48d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfBLItz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:49:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55245 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfBLItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:49:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so1984582wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZaqGFsP2Fj4gI246V5TlxB5rbyGGcaN1FumYNNQbU+0=;
        b=KHsY48d0wBerQ0dgDf21YVvqe6bp493PFwz6KbxXmLQGNGgTohDhWM/2XImDEbMOnL
         W5juOrt8VqX4N6btQ3cGvVADa86nmq5KyyxYdh+YQgdR4/Yl9+VA5+Te7XP9BtfpnpBT
         vWlEjuShCdZYP6bWca7TDG6wiywk2K3/SniYFYc998qULF51vyy36U74WwZPl168or79
         Z36+ldmlllTp7MOu7VvRAgY5Nn2LUnJb0DROZ6/5ng+ujxOnXsLIr2rc7kkk3pG+FJkF
         y3SpTgTB+lOXlWzOgvgOyrQ4tYfI+0GU+iXVhFZED0itBDnWRW87M3t1mgI9QvDtr3XX
         pm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZaqGFsP2Fj4gI246V5TlxB5rbyGGcaN1FumYNNQbU+0=;
        b=cSkVN5sQXbwxIm8Oey+ae2ek9CXrfK7lmzJcdFbermqEZHmDOf2278ja4M5dnEeh3n
         UnFPKEjTzFvub4ZK3lyTDqPyG5ASZnCIMizHBUNxrVhFLnVx2hqkMffKQgvlnyo3q9pu
         plFOhwBDNApKxlbv3ByZKKxZqtGGx4M1nbYWI+vokHuMIKM2zp7cYZmS0K7ChMyvQHU9
         XpjuCkCgZlYu1RsfQa1oamb0UAaDuQy10P2bYRyxb90Smuas+11Ux/sAc5F46D3LmlO7
         HNe3UNcjJsFtCZ2cSn7T9oXmM0awrRS5V7kDcskSRRXLiBM0IWrl5fd2CS33+tgaTjyt
         TeGg==
X-Gm-Message-State: AHQUAuax8Ly3yG28+Ffc4+Gkya0KW35+WTgvIrbkFUu70WxEPilrSJNX
        cYn5fC+oet12GXQV8BG4KGO0+5Q3Lxc=
X-Google-Smtp-Source: AHgI3IYid/MUJe90jLpMKwc+Spv1+LAWZrznQr/PUGWU27cqH4cZoV5DVt9MzN6w/0n9dKiC7OZ+3A==
X-Received: by 2002:a1c:47:: with SMTP id 68mr1832188wma.89.1549961393780;
        Tue, 12 Feb 2019 00:49:53 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id t63sm1582309wmt.8.2019.02.12.00.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:49:53 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:49:51 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Move linux/pm.h to the local header
Message-ID: <20190212084951.GY20638@dell>
References: <20190124180328.76533-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124180328.76533-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Andy Shevchenko wrote:

> We now using a common macro for PM operations in Intel LPSS driver,
> and, since that macro relies on the definition and macro from linux/pm.h
> header file, it's logical to include it directly in intel-lpss.h.
> Otherwise it's a bit fragile and requires a proper ordering
> of header inclusion in C files.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 1 -
>  drivers/mfd/intel-lpss-pci.c  | 1 -
>  drivers/mfd/intel-lpss.h      | 2 ++
>  3 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
