Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C096C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDE620855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJ5tiIEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfAUNBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:01:53 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37917 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfAUNBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:01:52 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so12532149vsa.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcXKw3tln6cCIZGWmfJGYgvfvIKxnArHOSuU7Sy6vk4=;
        b=jJ5tiIEwojgea0IMirl4ZZ2klzafv8OxfUSpJSUMA2+BMCbOQyQecwk0VDwy6DfASW
         7Nu900FJaDGI5mLgsoYmGbUotiuMCj0qKvOUa6lkXPFOdsfa1KY6iNSOkdmtPW20UjEW
         0EOg0r8AYjpCWyYuiTIW9MigEFbWzq/MhmsSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcXKw3tln6cCIZGWmfJGYgvfvIKxnArHOSuU7Sy6vk4=;
        b=UJLRO+9RdKQKJ+qjIYohscYlmeU5Aa2jODblGj7nOM/hIMKFGDSaLuCdDmCJkwnQMz
         4nO91ZS7IJl/qtKThKIdrrXjb+J9F1WytTzZNDaFTH5zFIu+EMOeyNjqUl2FTZz2Y61v
         n7QJgIzoy2CI5sMidPMaerGykpoKjUORByRtOZplj7Qgy/5EKGTdnrZsLEBh/YWJzH5c
         E4N+Dsu47iUFXIVoV+5EgWfGGO717DLFWjbujb4diV4LmP3qb85V9n1AJak6w7xQUCHq
         uJM+Uotn40V/vvq4y6/9aWL0MJjKGmi0myzpPf+KJwOzZnrcctMgo3m2E4kZolbDGrNT
         /kcQ==
X-Gm-Message-State: AJcUukfSFCjjPFNlej3jzi7jSAMHEU9c5JsVOJET5erhiQ9DzbaHB5X3
        q5/S3TSJt6JPrWmyVEx5vrpEt854SyFUUFE2BswAOQ==
X-Google-Smtp-Source: ALg8bN7KPWGvFKB1VM6/Q6NVeLs952Cy8JgKYM9wr6XXv2/phFh3Ifgw5WR4JL0+A9HpJJahVYgK9TO4ie7/0x4HpMg=
X-Received: by 2002:a67:7614:: with SMTP id r20mr11902024vsc.89.1548075711380;
 Mon, 21 Jan 2019 05:01:51 -0800 (PST)
MIME-Version: 1.0
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-5-git-send-email-sumit.garg@linaro.org> <20190121103026.GB15590@kroah.com>
 <CAKv+Gu9xT87twvnfvnxZqZ-Yj-Xmw5+2wkw6yCRhF7iuz+y-TA@mail.gmail.com> <20190121104651.GA27442@kroah.com>
In-Reply-To: <20190121104651.GA27442@kroah.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Jan 2019 18:31:40 +0530
Message-ID: <CAFA6WYNi9Thbnaq8TZbyh=dOzXLSKA3MtTLnDYM-=2fFcoKzYA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] hwrng: add OP-TEE based rng driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mpm@selenic.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 16:16, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 21, 2019 at 11:43:14AM +0100, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 11:30, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jan 21, 2019 at 02:59:19PM +0530, Sumit Garg wrote:
> > > > --- /dev/null
> > > > +++ b/drivers/char/hw_random/optee-rng.c
> > > > @@ -0,0 +1,272 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > >
> > > Nice, but:
> > >
> > > <snip>
> > >
> > > > +MODULE_LICENSE("GPL");
> > >
> > > This string means "GPL2+", you need "GPLv2" here instead.
> > >
> >
> > I think you need a space there: "GPL v2" or it doesn't get picked up
> > correctly (or at least, it didn't use to)
>
> Sorry, yes, see I even got it wrong :)
>
> The correct strings are in include/linux/module.h
>

Ok will correct license as:

+MODULE_LICENSE("GPL v2");

-Sumit
