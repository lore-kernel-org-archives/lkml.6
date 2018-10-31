Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63700C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BCD2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFBFeYB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BCD2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeJaODu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:03:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37184 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeJaODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:03:50 -0400
Received: by mail-io1-f68.google.com with SMTP id k17-v6so8805582ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=al38zN158vEK+UMiRUUX5xYRuCANomIVDi6OaGoVjWs=;
        b=rFBFeYB5eM8UvoifhgSNVuM9d5ryIuG+fbx6dMamTEdJvxX8kxj0umyin+jpkx8n+f
         /bg+HJTexliEOkw3+jTrgXhkSQJRSOC2oA5+HbFzqlSqR7y4MIgKTKGnaVNoxEDC12mE
         btAzJXeBzSKJ7Hi51kaNnb09gKk4UOlSAHoR54oR32amb2pJdcGJaDWKuYyPOtaN0f52
         ESAlpqzNCweLiBveWlOD6h4TO3XFiNtYRdTIjV+0tTRwswoVKT7tVIT8uxK8UYRpcW+5
         c73JNIIOYM4S09uwLFi30q/wqyqGWQ+NmRMhFmENLRp58vXQQDvdDTzD6xDo34I3C9pb
         vt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=al38zN158vEK+UMiRUUX5xYRuCANomIVDi6OaGoVjWs=;
        b=VYaKzW6Oe/9WYv4NUf49DukEKQuACIhc+ld79GCzPyrmbmVqTtkZdk0U2OdLZFZOoc
         zWl14RtzK6H0idfbUyN2FCnywc3EsbVypL0s9HiIbGsnzDwHIjs6L++CDD3fjeYcKC6n
         uCe7IuAM6Cll9ANMsgcTKRswTcvC3iDCB8tbjtaISbrqjXB0tO4KbWqsGJv8BZUvnyxY
         yDQ+eGqYlU9M1bbJ2gqcVxk6schMcxPpvxcPUTS1qwMgovp0vSmwBepClbyQWGfaYGnB
         PhcMVY+WzEIwHAi++Ixg77kOYHJZOIo8R4DpkrReaZ22/oiiG1kE71CdBBD3k/Bois7Q
         YlAg==
X-Gm-Message-State: AGRZ1gKA0Le+Nqoysi6qboKsIuyfxj4y7kxDI0SkVSVh48DmDZ2IiGpW
        IevdkJRAgNOvdSP6Nh6ZRC4DlyJymuJEqpFXUWLN0A==
X-Google-Smtp-Source: AJdET5cId2PXgceyy3RB8DAHdrnuNjGCBGVK1Es5DnrIXMbnbUT1oWVAPN8jRx030HvuLmYNiU7EAJe9SixyS/qAxvc=
X-Received: by 2002:a6b:b450:: with SMTP id d77-v6mr1051979iof.15.1540962440110;
 Tue, 30 Oct 2018 22:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181017213012.233957-1-kunyi@google.com> <20181017213012.233957-3-kunyi@google.com>
 <CACRpkdbS_aOpFORVnK3QJUsF1p-mVxtMas-q6fOp7emTx281Lg@mail.gmail.com>
In-Reply-To: <CACRpkdbS_aOpFORVnK3QJUsF1p-mVxtMas-q6fOp7emTx281Lg@mail.gmail.com>
From:   Kun Yi <kunyi@google.com>
Date:   Tue, 30 Oct 2018 22:06:52 -0700
Message-ID: <CAGMNF6VMLqRwVb=+-qU=nC9hW-idV-fLrnHFL9_xv7Ajha17og@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: pinctrl-npcm7xx: Set BGPIOF_VOLATILE_REG
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, tmaimon77@gmail.com,
        linux-kernel@vger.kernel.org, avifishman70@gmail.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 5:08 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Oct 17, 2018 at 11:30 PM Kun Yi <kunyi@google.com> wrote:
>
> > Indicate that the pins are both controlled by the pinctrl driver and the
> > generic GPIO driver, thus GPIO driver should read the register value
> > before updating, instead of using the stored shadow register values.
> >
> > Signed-off-by: Kun Yi <kunyi@google.com>
>
> This is quite a rough measure, if we instead use regmap-mmio
> we can exercise fine control over what register are volatile and
> not instead of saying that all of them or some of them are.

Thanks for your review Linus! I don't have time to rewrite using
regmap-mmio at the moment though. I have discussed with the driver
author and we will first patch the pinctrl driver by making the
pinctrl functions use the gpio-mmio accessors instead of directly reg
read/writes. When I have time I will look into your suggestion to
improve the driver.

>
> Yours,
> Linus Walleij

-- 
Regards,
Kun
