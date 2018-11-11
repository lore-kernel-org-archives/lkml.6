Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3071EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE46214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="alIXFYdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE46214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeKLFQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725725AbeKLFQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:16:07 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51BAD214DB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 19:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541964403;
        bh=X10YEJkC8D15qhUL9Ww7BEAr07FvgseH/o7dM7LZqno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=alIXFYdd/OQ2khf42mYQbOZpUE6xQKsZPSywZQUVZvTRczkw0TSKrVmjoT7Mw3CFp
         +mpKiHHKZ+7ePQhZf8UjbJ97o6f8TeYN1LsCDkoKWXvgYsc0UArgnD4/z06chzfneF
         lAa1bVXimjmlXikuGu/Bwx2m5fpiYwjd2wrT7Zi4=
Received: by mail-wr1-f52.google.com with SMTP id o15-v6so7020672wrv.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 11:26:43 -0800 (PST)
X-Gm-Message-State: AGRZ1gKFK4ZhMBLdvhDpkP1vsk0iwPigfnYSa9cTMf393gjfCPvvEghM
        /AJIMCzv0MJM2NO2hQzlpqlQiWwKzs34EHhT2dwbzg==
X-Google-Smtp-Source: AJdET5fo15kfDtR4opQa6G6wEsOGoIo9KbArby5L2oUbv/p95wEfRgr2/GqHHpXVzvpfDHfAYTwwGMA8z6uCIjg2Ixk=
X-Received: by 2002:a5d:410d:: with SMTP id l13-v6mr14834309wrp.61.1541964401798;
 Sun, 11 Nov 2018 11:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com> <CAHp75VfwKbzLNrxWRhoGW3aLN1PLWhx7sXWMgyFw2kS+4KZcuQ@mail.gmail.com>
In-Reply-To: <CAHp75VfwKbzLNrxWRhoGW3aLN1PLWhx7sXWMgyFw2kS+4KZcuQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sun, 11 Nov 2018 13:26:30 -0600
X-Gmail-Original-Message-ID: <CABGGisw-eid3Cq0HRu_Bw720JVy56jDCiSNyOY2s-JU6X5wRWg@mail.gmail.com>
Message-ID: <CABGGisw-eid3Cq0HRu_Bw720JVy56jDCiSNyOY2s-JU6X5wRWg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] drivercore: Revert "deferral race condition fix"
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, peter.ujfalusi@ti.com,
        a.hajda@samsung.com, Grant Likely <grant.likely@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 7:04 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> I seems Grant's mail delivery bounces messages. I delibirately reduced
> the Cc list for sake of ping Grant in case it would pass.

That would be because he is not at Linaro anymore. Added his ARM account.

> On Sat, Nov 10, 2018 at 8:12 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Consider the following scenario.
> >
> > There are two independent devices coupled together by functional dependencies:
> >  - USB OTG (dwc3-pci)
> >  - extcon (tested with extcon-intel-mrfld, not yet in upstream)
> >
> > Each of the driver services a corresponding device is built as a module. In the
> > Buildroot environment the modules are probed by alphabetical ordering of their
> > modaliases. The latter comes to the case when USB OTG driver will be probed
> > first followed by extcon one.
> >
> > So, if the platform anticipates extcon device to be appeared, in the above case
> > we will get deferred probe of USB OTG, because of ordering.
> >
> > Now, a cherry on top of the cake, the deferred probing list contains
> > the only two modules, i.e. USB OTG and extcon. Due to above circumstances,
> > values in the local_trigger_count and deferred_trigger_count are not the same,
> > and thus provokes deferred probe triggering again and again.
> >
> > ...
> > [   20.678332] platform dwc3.0.auto: Retrying from deferred list
> > [   20.694743] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > [   20.701254] platform dwc3.0.auto: Added to deferred list
> > [   20.706620] platform dwc3.0.auto: driver_deferred_probe_add_trigger 1 2
> > [   20.713732] platform dwc3.0.auto: Retrying from deferred list
> > [   20.730035] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > [   20.736540] platform dwc3.0.auto: Added to deferred list
> > [   20.741889] platform dwc3.0.auto: driver_deferred_probe_add_trigger 3 4
> > [   20.748991] platform dwc3.0.auto: Retrying from deferred list
> > [   20.765416] platform dwc3.0.auto: Driver dwc3 requests probe deferral
> > [   20.771914] platform dwc3.0.auto: Added to deferred list
> > [   20.777279] platform dwc3.0.auto: driver_deferred_probe_add_trigger 5 6
> > ...
> >
> > Deeper investigation shows the culprit commit 58b116bce136
> > ("drivercore: deferral race condition fix") which was dedicated to fix some
> > other issue while bringing a regression.
> >
> > This reverts commit 58b116bce13612e5aa6fcd49ecbd4cf8bb59e835 for good until
> > we will have better solution.

How is behavior that's been there for 4.5 years a regression? Aren't
we going to break Davinci that this commit was supposed to fix? What
else could be relying on current behavior?

Rob
