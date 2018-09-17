Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333C4ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D231A214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktm7yXBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D231A214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeIQN7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbeIQN7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:59:39 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32685214C5;
        Mon, 17 Sep 2018 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537173196;
        bh=o0eFfszP9XkyenL4n/Hq4csmafg4rf3AjxTbCYSxC0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ktm7yXBRulTF4bXxIW/dmBiBAQiYyL0KPSWgGMqlhhg05/oUqMq5aSzbQ6OYSE4gG
         IL5IlNwMMnutKQrlArs+xz622UxpBNxtflEmEyUxbqLcCBpkEHvOrqEB5aDXYfMq7E
         JXLS3j2ePD3gOci7kAnbU1q7RYWInyGHX9zlx62Q=
Received: by mail-wr1-f43.google.com with SMTP id k5-v6so16305962wre.10;
        Mon, 17 Sep 2018 01:33:16 -0700 (PDT)
X-Gm-Message-State: APzg51AiB6mU9Jn2qNqVQ7MG4awgn/qrRllU69iO7efbyTA9ay45qbYe
        3gcqk/+JN871XlO+yzY42wJpCfzZxC0xWX4BkdQ=
X-Google-Smtp-Source: ANB0VdboPmEqUAE+R0STUw1tY9h5+oZTknBfqB2uZaTf6mh6L0ezji/Q7IOk0uJ9Zuwj/i/RC3nbMo/BLcXN8oTcDAU=
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr16128742wre.115.1537173194591;
 Mon, 17 Sep 2018 01:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180907215446.15160-1-sed@free.fr> <b97d7ccc921572ca5d783584eea1de04341ab02f.camel@perches.com>
 <4cf38559-b00d-ede4-def5-7cd832d8a506@free.fr>
In-Reply-To: <4cf38559-b00d-ede4-def5-7cd832d8a506@free.fr>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 17 Sep 2018 10:33:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdvDrWOEkj3kEJ2KhHqp7NVmLeMTVdwB8suH8PWQXf-Pg@mail.gmail.com>
Message-ID: <CAJKOXPdvDrWOEkj3kEJ2KhHqp7NVmLeMTVdwB8suH8PWQXf-Pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ARM: s3c24xx: formatting cleanup in mach-mini2440.c
To:     sed@free.fr
Cc:     joe@perches.com, kgene@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 at 22:24, Cedric Roux <sed@free.fr> wrote:
>
> Hi,
>
> On 09/12/2018 09:21 PM, Joe Perches wrote:
> > On Fri, 2018-09-07 at 23:54 +0200, Cedric Roux wrote:
> >> Running:
> >>     scripts/checkpatch.pl -f arch/arm/mach-s3c24xx/mach-mini2440.c
> >> revealed several errors and warnings.
> >>
> >> They were all removed, except one which is an #if 0 around the declaration
> >> of a gpio pin. This needs some more investigation and I prefer to let it
> >> here. This is not some dead code.
> > []
> >> diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
> > []
> >> @@ -674,17 +680,17 @@ static void __init mini2440_init(void)
> >>              mini2440_fb_info.displays =
> >>                      &mini2440_lcd_cfg[features.lcd_index];
> >>
> >> -            printk(KERN_INFO "MINI2440: LCD");
> >> +            pr_info("MINI2440: LCD");
> >
> > OK
> >
> >>              for (li = 0; li < ARRAY_SIZE(mini2440_lcd_cfg); li++)
> >>                      if (li == features.lcd_index)
> >> -                            printk(" [%d:%dx%d]", li,
> >> +                            pr_info(" [%d:%dx%d]", li,
> >>                                      mini2440_lcd_cfg[li].width,
> >>                                      mini2440_lcd_cfg[li].height);
> >
> > pr_cont
> >
> >>                      else
> >> -                            printk(" %d:%dx%d", li,
> >> +                            pr_info(" %d:%dx%d", li,
> >
> > pr_cont
> >
> >>                                      mini2440_lcd_cfg[li].width,
> >>                                      mini2440_lcd_cfg[li].height);
> >> -            printk("\n");
> >> +            pr_info("\n");
> >
> > pr_cont
> >
> > So only the first printk should use pr_info().
> > The subsequent printk uses should use pr_cont()
>
> at this point, I don't know what to do.
>
> Should I resubmit the patches? Or is it in the hands of
> Krzysztof (krzk@kernel.org)? I would say a git rebase -i
> is enough to edit the patch and this rebase is obviously
> not to be done by me, but I don't know the process.

Can you send a incremental fix for this, restoring the original
continued printks?

Best regards,
Krzysztof
