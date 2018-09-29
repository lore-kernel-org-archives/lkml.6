Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7978EC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216A2206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwjN+05u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216A2206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeI2MvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:51:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37827 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeI2MvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:51:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so6523987lfa.4;
        Fri, 28 Sep 2018 23:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBxV963YowKNHBSl/NMunB8Ge7rssnhPBxcoJQdXyRU=;
        b=CwjN+05uapvlb3cgn6isD2zWTtMymnpU2c+g6xANRjSY+tQVjSQzhJvOsxv394YGm5
         mB8cl1vzx5P0wJKN3SkhImQmBvhIB2eZcinyoJisrrlKyf/YQbQXQVw+TyOlbWNRRIly
         vtKoeerqvUPZK1LGDZwbsTJBB4e3XMzxlx9yKBAPHmsvXz3hH6qMGKAlF+nnqFsfV+vS
         mG82YKYKNjkKbwIu2iR0VyipxiSclCEfNDb5bnfzrzfC3wSGv8EkrypCQQ2A9dTaWh5y
         DIObBLUieuLss3cP8u+t7erCNcrHLFEobuWn1jQPZBvtiGafCb1tyhUpZ4QQ08BJT9nQ
         AgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBxV963YowKNHBSl/NMunB8Ge7rssnhPBxcoJQdXyRU=;
        b=ddLb2VCKkPE/8ype3NJmrc4pKfP23iREFtT58uoZx5Jl84Nv9bCOGRKiO+syrN2Y3N
         lnG4A+PBq+fbKZycUtIfpo4JSReN58nrLR0zFHXO4DZmm6024Wc6Ul7RYdjnVSrVbWa1
         VYWe+asOk/zEI8MuksZNxOdyhQrjQqEi1k3APY0AjbeRjuOWFU7UEE2KdAjzd1aE2hZp
         +TlpviwwAYqiSLxTGim1oqyhnpf5WFkC5/ZHlniaJMCjJeUvXqGsqqGzVKZAWHo9hhWI
         R5e5i2nkXf0rVFUsOnRW3KnkCeV2h2iP4m6YJ7d6g6V/kSstYTLfWmYHPV74GsZiKj0k
         l4LA==
X-Gm-Message-State: ABuFfojsXCnI30b3QjeNIxwrbtJivyuHgztppDLvd29j4c9Ojw1rzYQE
        Y3RH/ISGoLtEBUv7Lu3JkvOauV7uj3mdY6KTals=
X-Google-Smtp-Source: ACcGV60rNLp2EJgkBRfkLgeTGpe4RUQi4ecpprCXVeIg0z0jS3N7TPaigdyClT0fycG0vTonb2BFVQ/CvQJrhzdi+48=
X-Received: by 2002:a19:dd8a:: with SMTP id w10-v6mr874571lfi.97.1538202229888;
 Fri, 28 Sep 2018 23:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org> <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
In-Reply-To: <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Sat, 29 Sep 2018 08:23:32 +0200
Message-ID: <CAPybu_3v6Y1Bs1+WQKFfdNmAFdBN6VJTDiCG1ApNVM2AWt4vjA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     timur@kernel.org
Cc:     jhugo@codeaurora.org, swboyd@chromium.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timur

In fact  gpiochip_init_valid_mask is called some lines after in the
same function. We could reorder the function. Would that work for you?

The driver breaking is upstream? Is it possible to access the hardware?

Thanks

[Sorry for the two html mails in a row, I did not try to work with my
phone before :) ]
On Fri, Sep 28, 2018 at 9:23 PM Timur Tabi <timur@kernel.org> wrote:
>
> On Fri, Sep 28, 2018 at 2:14 PM Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> > Nack.  Causes a XPU violation to the GPIO config registers.
>
> That doesn't surprise me at all.
>
> I believe that the problem is that gpiochip_line_is_valid() is being
> called before gpiochip_irqchip_init_valid_mask() is called, which
> means that gpiochip_line_is_valid() always returns true.



-- 
Ricardo Ribalda
