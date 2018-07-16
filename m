Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F07ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12232075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JJTUF+Nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12232075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeGPOk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:40:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37043 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeGPOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:40:56 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so21536730itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ifd6FACa1oqyOiNPBHG0MWueg09zbV1i74QE3bbEbF4=;
        b=JJTUF+Nn8szVP6a20e43btq3CIrU5YmmMxEYue3SqAEFL4tETXEw8PzRH+erJ4wuUr
         EraYOKpxiVXg69qwTCc2EMkS/+fKHQAW4ZoBqaC4+rebkO1Q3uCGvXe7NwMpCLBZoHMJ
         MHf9Zl5MLRpHoZXpGBfIQKcnwbSD/cLWO57opp1L+RK15pYdx1MJwXbgIHlxfkEaJDDI
         HYAC0UFekUhX5YvabcOhnPc9k96TW7XtrT7U48slpnXbXb8bh2p8Q0FM6K5jj8+j66Th
         et34si3tLM+mXhKESdFHWu0wrczvmJm0nBgn2py+OdaS0WFU8CWB7QGifG9Yy250OMu0
         gsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ifd6FACa1oqyOiNPBHG0MWueg09zbV1i74QE3bbEbF4=;
        b=uETciGTbOSPaW3/YvkHccjLhZjvx2Xg1Qhel4uX6+1NNcoS/Lb6IfykdBsIn3xlsE9
         TdKItqATCRnDVzwzdOFFu4bsM3ejIzAfKjH59jfCKeK871FkUHyWaS8sUNkeZOFrbcYt
         Dj3b72LbqXkkJ1wWlUy3Z27Tx1JKFDehBkX1MNuX0UG7oB/Qrc9my+JkJoLY1A4zEVTQ
         p6lrbQ6PNJMOrLLKz0/h9BKPBdnn27jK+nkVVU2TfhMyVqSA1LEE20/SOco2cXIdsCLI
         mMKa3G463Do/Zj9jCCM1Yor7p0YskXu4d5c7yVVjH/eTZqNcA4g4yWl+txH3AnhxBvoZ
         WhGg==
X-Gm-Message-State: AOUpUlGn3tendVf0ossLBvnhFbWnBMsyHFrg5i3y2CwX077GsCgvvQGt
        JJYqL83UsipzD3eYHS1Rww+WFZ9qUAYYNMbqNV4PVeJ/
X-Google-Smtp-Source: AAOMgpezsLp+efC/CS4eHgHg26ASyIz9uRHTD9qlc2ro5v1Nzt8+EQQgCn9iZeIakO1aowODhyqfJdqS//4ebnbjebI=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr12724880itg.141.1531750397970;
 Mon, 16 Jul 2018 07:13:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 07:13:17
 -0700 (PDT)
In-Reply-To: <CACRpkdaWGwhJ1D683R+7TV0JsUg-pNYZ2xm_0+16O2NgnBo+4g@mail.gmail.com>
References: <20180716083424.11157-1-brgl@bgdev.pl> <20180716083424.11157-2-brgl@bgdev.pl>
 <CACRpkdaWGwhJ1D683R+7TV0JsUg-pNYZ2xm_0+16O2NgnBo+4g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jul 2018 16:13:17 +0200
Message-ID: <CAMRc=MeZX0r1khVBY72_XgyUfW=GLFG-=hUuqZHWYgCRwFkUrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: don't allow userspace to set values of input lines
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-16 15:40 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Jul 16, 2018 at 10:34 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>> User space can currently both read and set values of input lines using
>> the character device. This was not allowed by the old sysfs interface
>> nor is it a correct behavior.
>>
>> Check the first descriptor in the set for the OUT flag when asked to
>> set values and return -EPERM if the line is input.
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Patch applied! Thanks for fixing this.
>

Thanks. Do you think we should Cc stable on that one?

Bart
