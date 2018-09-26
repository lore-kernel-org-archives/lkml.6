Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648CDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBCF214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuEMa1Yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBCF214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeIZRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:22:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34192 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeIZRWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:22:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id x23-v6so16739863qtr.1;
        Wed, 26 Sep 2018 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIwuoD/6ZATAjCm1T2y1bym8r09ogf7eaEIwz1Q4Bic=;
        b=SuEMa1Yb6X0R7S4OTkhOgYpDpjLlKw4Xs3llNqflMk/kD4TbPR1uQJtPBVxPtB/QNB
         YoPcw0NJWTAdAQgf3jtTjkz+OGmncfO5aIH/QI/AyttfwGBXmM/VCl7xSTPkuobCcgbJ
         /IWSkZXGHzhqdV1ZSoQfriCrw7tDxkhgIFz2aQckHi0KkQIoqx8gn9fd5W6mXlIcx3rC
         hcEYw/LJOw9tTnyIs8Z6DUbd/jNWNy1BIEWoXKBtK7GbHvK5bdM73nbuBVzEpFNujd5H
         la96v5JwJ5TM6E+N9FX0Y78rc6JuzJx8CZHh1si5Ts9kIWCFN61a1SyNkcgJgdVvVwAJ
         fuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIwuoD/6ZATAjCm1T2y1bym8r09ogf7eaEIwz1Q4Bic=;
        b=uX6+0ybHqcoAT8A6gsko3eMiP+u82q8FG1iXPcCd9HolEERSCyhzoe/QE20F8d/8tT
         GjYvon+hs1ZfEV5SyXVufwIYcNllowqB/1znnbuXYxzr9zf7pOTF6odVcHiy2c8u4Kyg
         EIhL8iJ1tGbpPIFEUhyOvqs0bBdsDMUPJOWPb/FqGb66PoSyDJmGPYNXRok08M1Gmb8g
         +X+ndNUsI47qigx2sTg7AjAJLGjeNJL77MwuoQ3dTVNVu8zUAuw1CXL7kYdN//qp1S+B
         wZXmPyVYA/4VmqJnFk9fweUJSrI8+yCAcDWgWm5y42gegbgdBMp30S5iZwpKVKEHFids
         Ov8g==
X-Gm-Message-State: ABuFfoir7j9ApXLa7/wy34zSCQhu2ax4RV7wby942OOrcg1DoYrzj/kg
        ciBy/jPdc57Se/MqjxFe5tcmc5XjlsjWU8j2aAdzp2lx
X-Google-Smtp-Source: ACcGV60hi9jHVQ/geIvztnvIyHwj8RUgoxrzn/cKIJu0ZmV3ePdcf27aB2tFjY26rGJZpgHKrCjlpuo2vBAo/rBd0SM=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr4079208qtk.187.1537960176919;
 Wed, 26 Sep 2018 04:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180921014421.30804-1-paul.gortmaker@windriver.com> <f401b6fed813afb86f5442c7707bf9fb@piie.net>
In-Reply-To: <f401b6fed813afb86f5442c7707bf9fb@piie.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 14:09:25 +0300
Message-ID: <CAHp75Vd3L2BQX02NQVM=ZTMkv4WpM=AXXVMyG0Cyc0SjjUU55g@mail.gmail.com>
Subject: Re: [PATCH 0/6] platform/x86: acerhdf: new BIOS string, better
 modparam handling
To:     peter@piie.net
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 9:20 AM Peter Feuerer <peter@piie.net> wrote:
>
> Hi,
>
> 21. September 2018 03:45, "Paul Gortmaker" <paul.gortmaker@windriver.com> schrieb:
>
> > I came across this older netbook over the xmas holidays, and noticed the
> > acerhdf driver wouldn't load. Turns out the BIOS string was too new,
> > and not listed in the driver. There were module params for overrides,
> > but I found their use isn't quite clear without reading the source.
> >
> > Here I clarify some of the module parameter usage, and then add the new
> > BIOS string, so they won't be needed for this particular platform. Some
> > probe code is also shifted out to be __init to reduce the driver size a
> > bit. Further details can be found in the respective commit logs.
> >
> > Since it was months ago when I created these patches, I retested on top
> > of tree to ensure things still work, as can be seen below.
>
> Thanks a lot for your work and this set of changes.  This improves quality.
> I reviewed all 6 patches.
>
> Reviewed-by: Peter Feuerer <peter@piie.net>
>
> Please also add CC: Boris Petkov <bp@suse.de> for review.

Shall I wait for Boris'  tags?

>
> [...]
>
> --
> kind regards,
> --peter;



-- 
With Best Regards,
Andy Shevchenko
