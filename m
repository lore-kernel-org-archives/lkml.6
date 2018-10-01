Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11FBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2522089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6P5EWlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2522089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeJAUOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:14:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42443 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeJAUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:14:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so12136918lje.9;
        Mon, 01 Oct 2018 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YlhXQlBfFrS1GswyvfK6gOSMeLSgznzuLSZ56hKfLY=;
        b=p6P5EWlcSWUldYCoZI6+sDMECOk8u5C/k3ihUvfo/oVTFsFCWhXEF5ouMVmRUmIlyg
         c771ZlTHA3rAHaOvkDj4lN/VkkZzZxey0xCejNgCc/hCXizjz/ymJQ3+KMVcLn9/NcPP
         hiba/uB8byuqkDpalyzK6n+jci890D+kiPMO+OEBhBqcGF37fQ4Y6Y8d7Vuh+TtM+SbC
         57vDD/48112orUwpSA8kSr5+ERR5G7P57XfdPuANmtWUbxDlFCPrwCay3uDrI7i6RCTK
         8EawTOqH5GDoGvgGcTs5a9yj52OD/udTMpjWnAo/jPOFMYsRgnvQswbr/Yh7lJ9fwu8S
         V3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YlhXQlBfFrS1GswyvfK6gOSMeLSgznzuLSZ56hKfLY=;
        b=LU8Aa3wJocHb4NkLShA6OGQMsfuaVhuTDiO9AaLHWOZQ7jfNynXd8xzU8pX9f4K3Nr
         8XVSXuLABXZ7gl16b4m4qtxg1PRgo550w59OrdxGjXSGQqpOFRxiY63G5n8ANr1Jo/SO
         cHNF0RkkHww9ZRxMWSXPWgsGKTVw6GCM3nC1L9osQtWLg3GT/ZtHuuyjTDu/OKW+qnKg
         iEMVps4XPoudElkh6mwT3R66CaYRC86NJQ9An3+WiDYdJRtxgohHxWiex/j8gAePMjmK
         +tk0Dz7Ft4JgkDFdKwdl3ZMYi3x4b1ko7ov/TCjNu1qXvXvoPV83gsA8FbuvErmKqS94
         0pFA==
X-Gm-Message-State: ABuFfogFFKyF9WG/fQJOycDkIKSgyb/s1n/K0Fv06hKMAmCTm+nOQBwn
        ahWx7Kw3/CO+L1WQSvGSPUbTULAgNVBDO85zy+w=
X-Google-Smtp-Source: ACcGV60JkdwwdIbOKHut7AvUvF2LxZOv0FYx18/B7Yc/hOY+ipuLG8WBzzh1QmLUhlfQXW42GMrCJiqk9p8QbLn9fJY=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr6362740lji.140.1538400999420;
 Mon, 01 Oct 2018 06:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org> <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com> <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
In-Reply-To: <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Mon, 1 Oct 2018 15:36:22 +0200
Message-ID: <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Timur Tabi <timur@kernel.org>, Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus
On Mon, Oct 1, 2018 at 1:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Sep 28, 2018 at 9:30 PM Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
>
> > How do we proceed from here? Can you fix your driver somehow to
> > init the valid mask before enabling the gpio?
>
> Just include a hunk to the qcom driver reordering this call
> at the same time. No need to make it separate patches,
> it need to be tested together anyways.
>
> I guess just switch the order of these two:
>
>         ret = gpiochip_add_data(&pctrl->chip, pctrl);
>         if (ret) {
>                 dev_err(pctrl->dev, "Failed register gpiochip\n");
>                 return ret;
>         }
>
>         ret = msm_gpio_init_valid_mask(chip, pctrl);
>         if (ret) {
>                 dev_err(pctrl->dev, "Failed to setup irq valid bits\n");
>                 gpiochip_remove(&pctrl->chip);
>                 return ret;
>         }
>

the problem is that valid_mask is not a long/integer, is a struct that
needs to be malloced, and is malloc at gpiochip_add_data :(

Maybe we need a callback from the driver to init that mask just after
the allocation?

A fast grep shows that the only driver using need_valid_mask (not for
irq) is msm:

ricardo@neopili:~/curro/kernel-upstream$ git grep "need_valid_mask ="
| grep -v irq
drivers/gpio/gpiolib.c: gpiochip->need_valid_mask = true;
drivers/pinctrl/intel/pinctrl-cherryview.c: bool need_valid_mask =
!dmi_check_system(chv_no_valid_mask);
drivers/pinctrl/qcom/pinctrl-msm.c: chip->need_valid_mask =
msm_gpio_needs_valid_mask(pctrl);

so hacking something in the driver might not be a terrible idea.



Also

> > Do we need to make more severe changes on the core?
>
> Don't think so.
>
> Yours,
> Linus Walleij



-- 
Ricardo Ribalda
