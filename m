Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /bRHLZI0GlsiWwAAmS7hNA
	; Fri, 08 Jun 2018 07:53:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6ED0D608BF; Fri,  8 Jun 2018 07:53:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNuk9nMw"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E2FAA6074D;
	Fri,  8 Jun 2018 07:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2FAA6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeFHHxK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:53:10 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39547 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeFHHxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:53:09 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so1338325itp.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7PtRDVlp3H2L9x5DaS+accd1t+LIKe3m3sq9FeDiVaM=;
        b=UNuk9nMweNL3RNTeLeD1IQFRcWCV9T/N5z2ntU1Tr7lVHmo2VC1yAGS3KpCToYvvk3
         SaG1z3gBcNQiK5m2MsWMIpGTKeBOX2eEZZvkG8+GVKjX7+lif/eHgRRuRkTkMNQRVB82
         MnCKC6TCWLJPBvJwQBgH4VkYAejue3AXH4Y0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7PtRDVlp3H2L9x5DaS+accd1t+LIKe3m3sq9FeDiVaM=;
        b=m0A+INIWZ+3QRNgP1y+/A2vIDd6e+JJTwEQrdlJEv8PeOxgdeBLmUGnSHDPwVvUINU
         +GY3Yj/ahfjEdNDpK8I9BrU/VFRv4j67oNnWYQh98gjkshM20lOAhvjZBDe0vFSK2FmB
         szvrFrcSIOWjLVQxbmWV1+LC7jEUbibLwbqRymvYgGR0qBhkfDg3Rb6AJHFeMjwCC5SJ
         Mr+HkgZqZhDroNgvJiHSw7fObwkUCjfMGQyFnuNuxZ1XHNFPPLkIegspLlF5Eo9cpLBa
         YMb6dXnPqsEejhShaNWxwij62etdV+9nds+Yz7wdnTtlnGqSj0Aed9jNXqwnEvSVQ+Qo
         lNLA==
X-Gm-Message-State: APt69E3IK1b/gq9wiftKboEA0xLak1Ttn1FDZvkpYhlvJpO6ZT0FjJaO
        uDPMl+mcUFe9Cu++Jib1ctDxhkJ+BVGiyPCU6eDL6g==
X-Google-Smtp-Source: ADUXVKIH4WfdFWEHz3+oR4ZCgqcfcmV971yIeu54/T/ryr7zIzUFEAjlG3KDImu2QGINDFQoHxya2HlfMjdXc/i8aug=
X-Received: by 2002:a24:f444:: with SMTP id u4-v6mr826487iti.132.1528444388417;
 Fri, 08 Jun 2018 00:53:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:53:07 -0700 (PDT)
In-Reply-To: <20180530212514.346474-1-arnd@arndb.de>
References: <20180530212514.346474-1-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Jun 2018 09:53:07 +0200
Message-ID: <CACRpkdYzniSdUxbDrdKDaWuwH9iWNrEBGB6fJgGkiJTMh8nVhQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: pxa, regulator: fix building ezx e680
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The reference to camera_supply_gpiod_table was added in the wrong function,
> as observed from this randconfig build failure:
>
> arch/arm/mach-pxa/ezx.c: In function 'e680_init':
> arch/arm/mach-pxa/ezx.c:905:26: error: 'camera_supply_gpiod_table' undeclared (first use in this function)
>   gpiod_add_lookup_table(&camera_supply_gpiod_table);
>
> Fixes: 6059577cb28d ("regulator: fixed: Convert to use GPIO descriptor only")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have folded this into my patch as we are deferring this
change to the next kernel cycle.

Yours,
Linus Walleij
