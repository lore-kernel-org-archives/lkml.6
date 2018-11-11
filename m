Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2765CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D904C20839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+95XI51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D904C20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbeKLJng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:43:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44871 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732794AbeKLJng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 04:43:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id n12so10614351qkh.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWdii/qb7BbkZTajBj1HFhh81B1/sytT4jLGty0/AQ4=;
        b=P+95XI51NTK0orYCAypZgCjmq8DZwcVvzEgmVhQPV9do2Vvr6T0yvo9rCgyml8a8VN
         dvgFV7OhVZKKpbRwluJR/fWpjpcVwoc5ooo25CBTqssNitrWHazNWmKFTLLRosdnXOKZ
         7JCdePW4zYcd5IK3N+zbQrUCXdQcpVYvcvRGd5eszm7zBm1AZsgd58TU1fj038ERAP7B
         hzK9IOIf6qA7Mu1hNjig2JVtoTu0NCKsjgUM+jdh6XtG1YT9VptzgKxVpzyjzBMTXE2F
         jl+iSqor6DYVSKfLTxK9JTvvjBl/hmt4sJiYKAY4hFFAHj/P49GPGTtZpyqlLsYE+K4F
         B6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWdii/qb7BbkZTajBj1HFhh81B1/sytT4jLGty0/AQ4=;
        b=kHnIk2V64QlD85HcUXLDpeEkd4cT6ORQjZ1x/AmVjfb6ECMRnu7nR6GY7CMd5f8eSa
         7TCaDoS0XLQATc4iNn8RtFKkY3PT+fPJ04DELYbaOe14wkPjZN2EY5FGweC/GHHN0w66
         PkU6mTPxfxSgvgJDUrNy4H227+JdFu1ftG3AXVJ2u9BCzhwaAKi5BAMDqnKkUedU4OwK
         sYm1BZfe9detZf6ldQ2Io56wthAErHHgkq58MsFQJy7UrqqnRtEx0CeR4eqMwuPV/ziH
         5qMVxtEwCbprWQJxfc7CHh4RixyCyk3toV5Zj/3Iw3wFwXzkOeoXRY0xy+DfRXJZXbBq
         Y07w==
X-Gm-Message-State: AGRZ1gKUHNqEKltsNGj3kITAQRPmI9jH8xGunNzetXxWkOAX5JbcvVub
        P+402pp6N31fpSYi3i+JnbCvdbBJRdEWWoJ781c=
X-Google-Smtp-Source: AJdET5cc8EDP0wOBrGWBg0k1GTZ0DGyeldbep/wwWw7adxtdr+ABi8u5dSnVaLxiWZIfv4/wizy5jQLk4J64GCkqKBM=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr17450613qvh.136.1541980393742;
 Sun, 11 Nov 2018 15:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VfwKbzLNrxWRhoGW3aLN1PLWhx7sXWMgyFw2kS+4KZcuQ@mail.gmail.com> <CABGGisw-eid3Cq0HRu_Bw720JVy56jDCiSNyOY2s-JU6X5wRWg@mail.gmail.com>
In-Reply-To: <CABGGisw-eid3Cq0HRu_Bw720JVy56jDCiSNyOY2s-JU6X5wRWg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Nov 2018 01:53:02 +0200
Message-ID: <CAHp75VeKqijzEiP5Kf0+Xoem_3QByZL3aF9c4bbzF68_E=1uWA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>, grant.likely@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 9:26 PM Rob Herring <robh@kernel.org> wrote:
> On Sun, Nov 11, 2018 at 7:04 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

> > I seems Grant's mail delivery bounces messages. I delibirately reduced
> > the Cc list for sake of ping Grant in case it would pass.
>
> That would be because he is not at Linaro anymore. Added his ARM account.

Thanks!

> > On Sat, Nov 10, 2018 at 8:12 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Consider the following scenario.
> > >
> > > There are two independent devices coupled together by functional dependencies:
> > >  - USB OTG (dwc3-pci)
> > >  - extcon (tested with extcon-intel-mrfld, not yet in upstream)
> > >
> > > Each of the driver services a corresponding device is built as a module. In the
> > > Buildroot environment the modules are probed by alphabetical ordering of their
> > > modaliases. The latter comes to the case when USB OTG driver will be probed
> > > first followed by extcon one.
> > >
> > > So, if the platform anticipates extcon device to be appeared, in the above case
> > > we will get deferred probe of USB OTG, because of ordering.
> > >
> > > Now, a cherry on top of the cake, the deferred probing list contains
> > > the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
> > > values in the local_trigger_count and deferred_trigger_count are not the same,
> > > and thus provokes deferred probe triggering again and again.
> > >
> > > ...
> > > [   20.678332] platform dwc3.0.auto: Retrying from deferred list
> > > [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > > [   20.701254] platform dwc3.0.auto: Added to deferred list
> > > [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
> > > [   20.713732] platform dwc3.0.auto: Retrying from deferred list
> > > [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > > [   20.736540] platform dwc3.0.auto: Added to deferred list
> > > [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
> > > [   20.748991] platform dwc3.0.auto: Retrying from deferred list
> > > [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > > [   20.771914] platform dwc3.0.auto: Added to deferred list
> > > [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
> > > ...
> > >
> > > Deeper investigation shows the culprit commit 58b116bce136
> > > ("drivercore: deferral race condition fix") which was dedicated to fix some
> > > other issue while bringing a regression.
> > >
> > > This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
> > > we will have better solution.
>
> How is behavior that's been there for 4.5 years a regression? Aren't
> we going to break Davinci that this commit was supposed to fix? What
> else could be relying on current behavior?

I guess we are purerly on a side of luck. I don't remember people
build usb and extcon as modules
and using Buildroot, or anything that probes modules let's say,in
"arbitrary" way.
(That is one of the reason why I didn't dare to put Fixes tag there).
Nevertheless, I have actual issue. I'm all ears to know about another
possibility
how to fix the issue on my side.

-- 
With Best Regards,
Andy Shevchenko
