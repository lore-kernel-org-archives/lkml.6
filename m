Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45759C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B4020844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8yMSU2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfBAJZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:25:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37072 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfBAJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:25:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so5397124wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5BHiWeTDUNSL18hGBX5Mfkf/7Iu4EOhYqcJPYWPRgIs=;
        b=M8yMSU2yDBWMVggAj+lvvRt6Z/zDb1O0hDsDoUwqVVuaMwv+/gy6Go5GBE5+3ulmw2
         NE+Br96DJMsNxuj7VkmdX8VcA9OYYkdxW6ilDj6DJERhTkyLjwOkirflXMd0plzlP1cd
         DcXCZVTYDoQoadqll+W7EaSaPT42imO1KJZJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5BHiWeTDUNSL18hGBX5Mfkf/7Iu4EOhYqcJPYWPRgIs=;
        b=dc6DtP20KTkTuVuNVGj3lZxCyqtYuFHMgxxQYPRkHMPcMZuIvieRGQhduxw1BCa+ZH
         XZ0IUrB8c4t8/7eDkb7JWrU8rhhAidr4EklkMfksqjDkjqsvb7iWf7eCgY2xCDHlEaFs
         sf0IECcfZZvGBa76p7DmVYmAaQN2qspIe3JlF3Zobk3bKoxldtm39flvsfWtf1LXvT6O
         4SPjTE0W2z4M0Ok8+2kacMv+XCOu2t0aDEvmWDzK/hFz56IkJf3oaVs2rfMMghUeOkGS
         zdbH6LwfxyJGwzsGSWv5nm9/VxZ2JF22OPObSpp/4PF0b2NiXAOjBomK91WlFjB/7JBv
         QYjQ==
X-Gm-Message-State: AHQUAubU/8HYGrrOGuYDVolZFTbavkLq/c9wWcyOXnXWoYZSQb5kTCAK
        IHxQ1umgFYTP5lj3IimHfzwhzQ==
X-Google-Smtp-Source: AHgI3IarhmkmdTfrXC1LmcQh0dZrELeWoJVXF3K2MmgiY/zD2dehHlbi4p0dvc8qy3W2flUi/Mdg9g==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr1564977wmd.103.1549013148155;
        Fri, 01 Feb 2019 01:25:48 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id w6sm1921669wme.46.2019.02.01.01.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 01:25:47 -0800 (PST)
Date:   Fri, 1 Feb 2019 09:25:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Move linux/pm.h to the local header
Message-ID: <20190201092545.GH783@dell>
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

I don't agree with this.  File which use various headers should
explicitly include them.  Inheriting header files is non-optimal.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 1 -
>  drivers/mfd/intel-lpss-pci.c  | 1 -
>  drivers/mfd/intel-lpss.h      | 2 ++
>  3 files changed, 2 insertions(+), 2 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
