Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A1C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49D7214FE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Xp7BA9RP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4otI2X5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49D7214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeF2Vof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:44:35 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43908 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeF2Voe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:44:34 -0400
Received: by mail-yw0-f195.google.com with SMTP id r19-v6so4201354ywc.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HjyWFoYzY+JFjzs+J9w352Rv4dVGDk3LBzHh8C832sM=;
        b=Xp7BA9RPzHUU0R+V7R/RDxKlJQ2NDc/PPHt791I+xw+qRKAminp9aCMvR7SraxAS1J
         nCj0mY/bQHLvBNOorXe32vILh/P5ncWSgMz1m3MODf4BJ2mygyjJwWks/7vgaCzfB5rA
         /hwZzNr3cObrqSntuzzQ1Ra/xu4TbVo1ADO2lBc0roofLwh3M+Dyto5gUaGixFdHRnGD
         aQcx2DRm9Jyr2nU+loDBn5cAYvBcrTNDc28JNQS1d2tFuiReRq44cpd8YFiwcTN9BmRp
         GXGI3k+BY0VybkgXFsSwDA2y0h3kxEE7BXAVJczJO+Ydi7j6t7Tp/lJU2jlq3QDJPmtJ
         FBjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HjyWFoYzY+JFjzs+J9w352Rv4dVGDk3LBzHh8C832sM=;
        b=K4otI2X5v6Z/LGAxc0zoJIEipuh6ee061N3GGTjpvhSVx/t/KTe6ZtWlFnc18Atuoh
         cieGJJfxWmMoHhNjZufGP7nyYc4kPTYKLYuzSBTKhndf66OuTGA06ePBWGkpUX5mApcT
         Zi9bg4VDl7z97H70FVKn4/XcPINRpfzd/P8lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HjyWFoYzY+JFjzs+J9w352Rv4dVGDk3LBzHh8C832sM=;
        b=ZlOYIYzNluuUQfJuTekgv5WY/yp50OipoOm1+xfSXDyCGyuEHkU+IEG/eGUGlEWPX0
         JfqKsevALf58S37+oQcPVqanaHaXM0XQEmedW2PHmWuVx/L25JF+z++JgYdQNS28o59Q
         AW2YHUy2h8prQamVq5/XtS6FlyPGGyErpsytPq0wFRFwfrVPiIqfA3Wvykk2jq4CIuhx
         4XgTXvZFIy63Zr/ZxynrGwUCj4Eia66JK5Fs22/APFW1Dpvx/35KvCs/AB2kuaSVi6t9
         kcm3KLANGwR+FDKOBlf0Le1FHP4mqYW+4gm+cCmXFLDK5ZooTjnV6VxgFKpkg0D04gNF
         d3yA==
X-Gm-Message-State: APt69E1D/JxwaU0IpZvU3H58Ev2AE/aA3vbhVXq6UB6skgch3+cDxcqI
        wydx/kB+BRWGmmSsGI4DXygcuSuK4i290a0Dtkbm0g==
X-Google-Smtp-Source: ADUXVKIA4/yf8a8C+A8AXw5TjDbU99cKFGLQv8PgUF/f4jJToZ0wM52LTg53nXinwky9LyVo1s80pV1ze0puEyLjF3I=
X-Received: by 2002:a25:3445:: with SMTP id b66-v6mr8787680yba.484.1530308673461;
 Fri, 29 Jun 2018 14:44:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:44:32
 -0700 (PDT)
In-Reply-To: <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
References: <20180629185339.GA37582@beast> <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Jun 2018 14:44:32 -0700
X-Google-Sender-Auth: iHLqFXhHDsl4O7Slqgxt3CVXzKw
Message-ID: <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anatolij Gustschin <agust@denx.de>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 29, 2018 at 8:53 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> switches to using a stack size large enough for the saved routine and
>> adds a sanity check.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> This seems particularly nice, not only avoids it the dynamic stack
> allocation, it
> also makes sure the new 0x500 handler doesn't overflow into the 0x600
> exception handler.
>
> It would help to explain how you arrived at that '256 byte' number in
> the changelog though.

Honestly, I just counted instructions, multiplied by 8 and rounded up
to the next nearest power of 2, and the result felt right for giving
some level of flexibility for code growth before tripping the WARN. :P

I'm happy to adjust, of course. :)

-Kees

> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

-Kees

>
>> ---
>>  arch/powerpc/platforms/52xx/mpc52xx_pm.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pm.c b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
>> index 31d3515672f3..b23da85fa73c 100644
>> --- a/arch/powerpc/platforms/52xx/mpc52xx_pm.c
>> +++ b/arch/powerpc/platforms/52xx/mpc52xx_pm.c
>> @@ -117,7 +117,10 @@ int mpc52xx_pm_enter(suspend_state_t state)
>>         u32 intr_main_mask;
>>         void __iomem * irq_0x500 = (void __iomem *)CONFIG_KERNEL_START + 0x500;
>>         unsigned long irq_0x500_stop = (unsigned long)irq_0x500 + mpc52xx_ds_cached_size;
>> -       char saved_0x500[mpc52xx_ds_cached_size];
>> +       char saved_0x500[256];
>> +
>> +       if (WARN_ON(mpc52xx_ds_cached_size > sizeof(saved_0x500)))
>> +               return -ENOMEM;
>>
>>         /* disable all interrupts in PIC */
>>         intr_main_mask = in_be32(&intr->main_mask);



-- 
Kees Cook
Pixel Security
