Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dq9eLTNQGlseTwAAmS7hNA
	; Fri, 08 Jun 2018 09:46:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B097D606FA; Fri,  8 Jun 2018 09:46:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqOQ+KMQ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 26DC160275;
	Fri,  8 Jun 2018 09:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26DC160275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeFHJqg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:46:36 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45534 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeFHJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:46:34 -0400
Received: by mail-vk0-f66.google.com with SMTP id l64-v6so276611vkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 02:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e6l+t2DZNypTgVxmJymBDSwL4PUZB99UvmgYw4D4wts=;
        b=mqOQ+KMQoJZn+81eGAQ73JBpMCrQgJS7lEah5RVp5r/ntcaMWpxmp949WL4QrHxcA2
         MPRB0nfGP0mAjA7cDHdX22HCHjpaz1t+aRwBcLTXvMm6aJtQMFEVfaOOXbT0i84UvQkQ
         QxoHaQiOehO33Vk9ZaAXvEPE/yIKQ8W43sw4sh9VcOoA98xFeZ+/5p15laOM9tjas+G7
         QCvs9zOdUhDCVH+v/IGxp8TTP8EANssdYKfeuYVWQUT1XGMhvQ+teo504oznBaYGhqJ0
         yBMXVUVos2/FixShCRc1D0exMrJmDOyWXnGLys0fO7lC41JFbpT+DQqPSxdmfZ1qV42A
         9pzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e6l+t2DZNypTgVxmJymBDSwL4PUZB99UvmgYw4D4wts=;
        b=liWB8H0+i48upUMJV0w7r7uhTQgt0e62cA5GKCY8zmxNZBAczF7+/UPUk7JB9wjjOb
         UawrGH6aX1I+SbZ47CH6LeWL2mx3dIQzhC1HqVGGnIKy3e3cajcXKnrMTPhW/izHKQwJ
         dPqHouN2SAsoq5gy42NbFH91QeU4c3SJjmDGj/TdO1xqK4UeX83N4If3BmCoO5v6LnbR
         GyTyVRk278Fkx2t4xcTk+OqLU+c4uW2G8ZlnMOas/0OIkdlZQgpE+m6gYsgwaTeNDpwc
         FCN1QfW1AC83E9B7XmlEhOm1Pb3GoEowDagp9f30ibqxEne0utvuDjfS/YAEDhKWAQfd
         z5ig==
X-Gm-Message-State: APt69E3Syhsx8+t9Dz3KjE/z/k8Yx3K+s3lvJWIwiVQ4GoJ3dq/AUYrf
        MvV4epHsagqoZVv2w077pSvkZ2jUU65fPsC+7ntGMA==
X-Google-Smtp-Source: ADUXVKI99dYGaIsRA8FDjHn2jlpE+TamwH/3Hsx2QSoJMxJtR986U4lgv0uhqdaMspc7hiy7pXH/548p1u9hoCJWN9c=
X-Received: by 2002:a1f:954c:: with SMTP id x73-v6mr3388658vkd.129.1528451193548;
 Fri, 08 Jun 2018 02:46:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 02:46:32 -0700 (PDT)
In-Reply-To: <0fa30e13-c16f-95d8-d1ef-fd45e7a99888@linaro.org>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz> <d9ecdf72-7500-66d4-0360-231218cccbb4@linaro.org>
 <20180608080437.n2b5nv73d3kp6yhb@pathway.suse.cz> <0fa30e13-c16f-95d8-d1ef-fd45e7a99888@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Jun 2018 12:46:32 +0300
Message-ID: <CAHp75Vc5_+Kxsvgws9Oq-hOgbQ8-ocxeKa4AuhC0uJ0oKsu+BA@mail.gmail.com>
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 12:07 PM, Thierry Escande
<thierry.escande@linaro.org> wrote:

> But as I type I realize it's not necessary. I will simply enclose the call
> to wait_for_random_bytes() by #if IS_MODULE() #endif so it gets called only
> if built as a module, which is how run_kselftest.sh wants it... If
> test_printf is compiled built-in and the crng is not yet initialized the
> test will fail anyway so there is no need to add an extra check.

Unfortunately I can't support this as is.
We have environments where crng will be ready minutes after the boot.
It's unacceptable.

So, we need to have means to not delay test for so long.

-- 
With Best Regards,
Andy Shevchenko
