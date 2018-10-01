Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE4AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BE32089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdNYCvfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BE32089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbeJASby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:31:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34452 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbeJASbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:31:53 -0400
Received: by mail-io1-f65.google.com with SMTP id k19-v6so3482044iom.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/fCu1aTIk+sQtR6OFUAdIW0f90T1WXx0PmJEW47Kuw=;
        b=RdNYCvfcsoPxHVjWw8KSSasCIVI6mn7kUVsnWz5LGmGbs1F6ojWtx7137myeoJqAAF
         tgoGViI1zFTN+dEZ/gb5RMAnlKFDG/quRIiruMt74Y1cPAJhPjz+zdsDGdOBNUYgqw/z
         sRrJDfTtsxFx2Op/ucxszdJndpDLxjwVifgVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/fCu1aTIk+sQtR6OFUAdIW0f90T1WXx0PmJEW47Kuw=;
        b=HZ9zGXkxLgHaHsoEkJJyBrwMrkqrRy/U0oeRvYpbHw6+KZfjje2oyWJAoLOnE43CFI
         zfM2H/yJTFLwlfMKLetVfz1o8l2bij9O8bKRcMICX+ZTiHNE++lysYqY2PvArSbTHVvv
         K4QkQasuORNhJGG0gf8talb2XGYEoKB9UMrCvCyS3nZE92uVanZWhTWtJJk7LUyZ+ItK
         dJFlhgp6KPSaTh+K3orXsv+yr04Q44+AdMt6uhZ+lykHay0p48CRtobtIzmuUv7mNL1C
         e77aWcTrkURtY3Q74vUVvV4lbOWjJaj/0xHpumEsUlLEOYXz8np85pnYaHzG2vDdN0+K
         sVbg==
X-Gm-Message-State: ABuFfogOwreLvVL+wo4yQUrzEgjKVfB3j5wmBu5nBm1Damr2r8kAW6Qd
        +qvJPKgZZMuHdcC1QunVXCraHs35DMfdm0UY13iBaQ==
X-Google-Smtp-Source: ACcGV60O66UToQLhXqJMEMuM0Tqi9WB5jkAqFdT4VuU7XwjtZWJBVJPMSj/KHbBZHrkrXtiI/3GWcsxDyXlL2QAnVCI=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr6132868ioa.277.1538394867585;
 Mon, 01 Oct 2018 04:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org> <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com>
In-Reply-To: <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Oct 2018 13:54:15 +0200
Message-ID: <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
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

On Fri, Sep 28, 2018 at 9:30 PM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:

> How do we proceed from here? Can you fix your driver somehow to
> init the valid mask before enabling the gpio?

Just include a hunk to the qcom driver reordering this call
at the same time. No need to make it separate patches,
it need to be tested together anyways.

I guess just switch the order of these two:

        ret = gpiochip_add_data(&pctrl->chip, pctrl);
        if (ret) {
                dev_err(pctrl->dev, "Failed register gpiochip\n");
                return ret;
        }

        ret = msm_gpio_init_valid_mask(chip, pctrl);
        if (ret) {
                dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
                gpiochip_remove(&pctrl->chip);
                return ret;
        }

> Do we need to make more severe changes on the core?

Don't think so.

Yours,
Linus Walleij
