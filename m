Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80563C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E19F20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELl1vi5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E19F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeJBOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:20:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41632 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeJBOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:20:10 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so1321805iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIFVwKcegaKlBtuId7khisMMeBY0nBOFH9sAxDM8maU=;
        b=ELl1vi5Aqjbi4A05jc39T+3r1R1JQg0yHXF3hwHqDfjqS/TQlSqBztVgtyEGjDHbZk
         mTeeL+1MYbKGg/Nl47XGJZ2yzPnlBwbbmuqSG5BNOjz8wToPZnp5CheAZJrPI2IaPu4d
         INktiDBFuRCMn4oezdAYtwurbkNandYksAm9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIFVwKcegaKlBtuId7khisMMeBY0nBOFH9sAxDM8maU=;
        b=rcA8lXkGhD2Yj2Ci5dVssvjTZYGHysx9N1v1AFIOTv8t1kyVWXqOx1yMg/KNyhSBob
         JCb/jpf6ACacEaKtON0BVkSiEAcZ/Xk/gewDTaoQGhzB2RllMIxMFWAsqVB+xaD7SAkn
         lWKigaKiG1SUQUQu47xSx2w3CPCLKr8iBLYT8eZ0PpzjR+0YgPUKy/wxK+6mnapGu0dI
         5vXhTSdhC8c9aAKgM3Y6Oq/GksXJ9TJBa4RkXg2Ew1ceEP6kUxgZmQ+Ai7QyFcNFd0Q+
         bLvgB5BIe1R5uY+R/lcqfsh5VhJQDOtZNnxFEoa/7Y9sh/nLKK0VwWSBgxdVAuv2HO/v
         9m/w==
X-Gm-Message-State: ABuFfohBUTlvT4GBjmOIRjB2NDAPFEPYkp0iNo2rHXWzF3BF4ojM/ehL
        oLRb1Iz0ibvrSZJjMnNEUZwRaZqCULD34E+14ZBMJA==
X-Google-Smtp-Source: ACcGV62RGouVTdzi2g1juztcoS6SY0xMr51pVmCeDgWONMZ5x231uYeGl5MTXk/3v16XNIhshJAhWRQQZg7mAdHFSMo=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr8851843ioa.277.1538465897665;
 Tue, 02 Oct 2018 00:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org> <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com> <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
 <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com>
 <CACRpkdaN5G4ephY+6BPLRF+aUrO4-sPa+2erRYrwTGwPBwu8fw@mail.gmail.com> <CAPybu_33WNiCdkwgNtkiTP2PL+9ai85Z2LiMB6yqNZrV5JdmXw@mail.gmail.com>
In-Reply-To: <CAPybu_33WNiCdkwgNtkiTP2PL+9ai85Z2LiMB6yqNZrV5JdmXw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Oct 2018 09:38:05 +0200
Message-ID: <CACRpkdaccTSqpKQeUc1c6UEMo+fZmB+w0BQJL--gubrLMmKSgw@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     timur@kernel.org, jhugo@codeaurora.org,
        Stephen Boyd <swboyd@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 9:15 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> On Mon, Oct 1, 2018 at 11:20 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > gpiochip_add_data() doesn't allocate anything, it
> > just adds a already allocated (or static!) gpio_chip
> > to the gpiolib subsystem.
>
> Take a look to gpiochip_add_data_with_key()
>   ->gpiochip_init_valid_mask()
>        -> gpiochip->valid_mask = gpiochip_allocate_mask(gpiochip);

Aha I see...

> > In fact I think it is wrong to set up the mask after
> > calling gpiolob_add_data(), because of exactly the
> > type of problem you're seeing.
>
> I agree, and I believe that the cleaner way would be to add a function
> pointer that replaces:
>
> gpiochip_allocate_mask()
>   bitmap_fill(p, chip->ngpio);
>
> with a proper initalization from the driver

OK

> But as today the only driver that seems to be using valid_mask is msm,
> so perhaps a hack is something better and then when we have a second
> driver that requires it we figure out the real requirements. But it is
> definately your decision ;)

I would just add some exported function to gpiolib to do what you
need so you can set up the valid_mask before calling
gpiochip_add*.

Yours,
Linus Walleij
