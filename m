Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC4D2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eRQrYEd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC4D2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbeGMHc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:32:58 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53029 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeGMHc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:32:57 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so10292660itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tw6o3y8jOMTNae/2xDolKoa/G8I0YuBgSRMvs6OLqDQ=;
        b=eRQrYEd0XEXgq/WVFcO9LtnAJ1TCDKmB0kYEcm11RBzjZROBMTRhFK+39SXapBcayL
         OPlYA5yce/ewJZd4o0x/yLuilt8eFRIPSHd42wFRftseX6tepJkjMhCVHCnYRdtqNVlG
         rTTZImyThoecFoEf0FacGSl9MaVd25TDjWFi5Fbfn5f1Oi1pUw3gMEoVXRtIPHCtwE7D
         CB/rcPkLOguyylad7TIWftcuYSaddS3XdmRephTUBoGVWyOpr1lNtomD4F0gfOLv+o51
         64WDh+M1j5vYjnC1GESU+6TT5YYDg1bXXowfBrGoroRNisZ3DoT3bOp/X0MbLJ0wwa8u
         Ak6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tw6o3y8jOMTNae/2xDolKoa/G8I0YuBgSRMvs6OLqDQ=;
        b=g3KkO6pKMvrwI64Gdhyh56ID7msBCQxFnYGY/JlDG7hQn7rbnYQt97ICyiM9oq09pW
         QaYksniJhn6ZoumIYwvWCau9ATp7Whc5y4ZKsSbWkhjQ4H/Va61TsxMcbIZrkgsKvSwM
         OZNzX0V6V4IkJyrgT84KIX3voRzd6nbXE6URXQoXLpnsEOUHMSAhtOoyWa6IUPzTtJyd
         h9I6kIOshC++Cc7Z6Y+3XbJHnAnDW24is3x5/1rfc2B3NrSOx7w5FBwmFAzul0y7/xc9
         q/yKtSWjHRlJsuD/MvFGDfLy80wQ5oowXLYWaQZuOqvE4Xnt3V5uUuCnq+1oHMcU4eSs
         43Sw==
X-Gm-Message-State: AOUpUlHEQDAvRjVG5+9EVa5IjGBuUMH4EKRWYXD39P0OH0B1y6O+7AMD
        gHJ3x98h3but9D8dBJZEteGH3qcd3McW/0PIOgtHkA==
X-Google-Smtp-Source: AAOMgpf4ylqjjPoLiwfRajkunjyo8xNoX+4zTBNVx/gz/BHI7dQMzgp6mNVH+k8LHansYWdNqPamvyhVXX+voUaZylY=
X-Received: by 2002:a24:b555:: with SMTP id j21-v6mr3925244iti.125.1531466377764;
 Fri, 13 Jul 2018 00:19:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 00:19:37
 -0700 (PDT)
In-Reply-To: <CACRpkdaKQ_Lg=t3DLsvXQNLwi=BYugqNGyssEM9Hn2Ss5r-kQw@mail.gmail.com>
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com> <CACRpkdaKQ_Lg=t3DLsvXQNLwi=BYugqNGyssEM9Hn2Ss5r-kQw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Jul 2018 09:19:37 +0200
Message-ID: <CAMRc=McQdbZbd3GDdgi6paKFUXSJTb_3nRG3npzMQs=FEwN2ew@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add power management support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-13 9:11 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> On Tue, Jul 10, 2018 at 9:53 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
>> GPIO registers could lose context on some i.MX SoCs,
>> like on i.MX7D, when enter LPSR mode, the whole SoC
>> will be powered off except LPSR domain, GPIO banks
>> will lose context in this case, need to restore
>> the context after resume from LPSR mode.
>>
>> This patch adds GPIO save/restore for those necessary
>> registers, and put the save/restore operations in noirq
>> suspend/resume phase, since GPIO is fundamental module
>> which could be used by other peripherals' resume phase.
>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>
> Hoping for some review on this before applying...
> Fabio? Bartosz?
>
> Yours,
> Linus Walleij

I'm not familiar with these SoCs but the code looks good and clean to me.

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
