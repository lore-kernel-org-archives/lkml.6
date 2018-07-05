Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C9C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0F22419C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok1uE2Ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0F22419C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeGECci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:32:38 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42452 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeGECcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:32:35 -0400
Received: by mail-io0-f193.google.com with SMTP id r24-v6so6316631ioh.9;
        Wed, 04 Jul 2018 19:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEN44L0WpcaoMtnBt/HKS3cdaZtZh9S3j+gpjnm+Fc0=;
        b=ok1uE2Uea6HURBK3INWnxeIT8wksJUedxleVs8JOaNAEMbIfZmclQW2Id5xe/ouO6s
         LadAZvqCb5kmaxHzROmpw03yM38LFQqRfYNl1YHC9L0qtb6oyVUkF34W4GtgPthsA2od
         JkgrNQNLDxzz6X61ME6VK24TyCHOsx1ic8kpEiaHK9BMN0ouPmoUQ/fpyHBq6p665dUC
         IjopS2OG/upCaFgr6t0GMgRZho1Ky9DTkAiYUW80EPadk8bjoj5oNh6rtMf/3TzLZTa9
         r55fBaGb5WNMebCW465psEO2U6SgDd/1TuiVO9VhPiJq28xvaoN9y2EAP82QVjFfornI
         uqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEN44L0WpcaoMtnBt/HKS3cdaZtZh9S3j+gpjnm+Fc0=;
        b=dnf/Lm7mrYa4c8zZdK3nKhmc84IWYXEf3/d3NF0lJaKCLaqqC/5iVZ3+Aa0LN4Vf+h
         ioElhwYYY+42UDzjbIgXOabD0zNVTxGyxOQfQRsCgMd5Cgfhf7GH4nH5SXZHaAmZyScq
         FweHL5Yn6sr3/xcPbf+7DY2j/hsU6JAC/cAX+Bny0W5TitL99zvs/80WHQvKtNFyO2cD
         50PmPyLkS2Ir9SH0VHrcPNXFhiWimRQ7dsuSJrxNx9bl1X/T5dxisoTiDe7vGbJVhB87
         DH72qNiLfSUXGS3jgRLqtGvjoHBCNXtfeZUM584D4v8nPNx0Y/QIZ22w/C2yBRI2uApT
         UEFw==
X-Gm-Message-State: AOUpUlGurpo8ILTTe8BBPZ1rBtjNNDTvxIkpPu9aFx1dnHlVseE+Vsj7
        xcgkkatarmsM4blFE/g3RtEirgnuGZ99NVr+cw==
X-Google-Smtp-Source: AAOMgpdfo3sN2OY1hglXUcFMI07OwVjCtljG/xrwLc0NzVjmK5DmWaZ58Ch5TD883f2lUC4fgp+rtgLTFcNEfbaWIHI=
X-Received: by 2002:a6b:1e91:: with SMTP id e139-v6mr3546673ioe.36.1530757955212;
 Wed, 04 Jul 2018 19:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <3375966.ydPZj5TMVj@aspire.rjw.lan> <CAFgQCTtu7jaUfWV4xq8CfWb7vuS5=+HuNpNxeMm9UawoUZ2CBg@mail.gmail.com>
 <2842715.a5PfnD4e6X@aspire.rjw.lan>
In-Reply-To: <2842715.a5PfnD4e6X@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 5 Jul 2018 10:32:23 +0800
Message-ID: <CAFgQCTvZ8yGjrbxhYB4=Nxx+-JZC6BAUXCZ-DFz4wAh-Q8UjLw@mail.gmail.com>
Subject: Re: [PATCHv3 3/4] drivers/base: clean up the usage of devices_kset_move_last()
To:     rjw@rjwysocki.net
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 6:18 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 4, 2018 6:40:09 AM CEST Pingfan Liu wrote:
> > On Tue, Jul 3, 2018 at 10:28 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Tuesday, July 3, 2018 8:50:41 AM CEST Pingfan Liu wrote:
> > > > Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
> > > > correct device's shutdown order"). So later we can revert it safely.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > > Cc: Dave Young <dyoung@redhat.com>
> > > > Cc: linux-pci@vger.kernel.org
> > > > Cc: linuxppc-dev@lists.ozlabs.org
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > ---
> > > >  drivers/base/core.c | 7 -------
> > > >  1 file changed, 7 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 684b994..db3deb8 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
> > > >  {
> > > >       struct device_link *link;
> > > >
> > > > -     /*
> > > > -      * Devices that have not been registered yet will be put to the ends
> > > > -      * of the lists during the registration, so skip them here.
> > > > -      */
> > > > -     if (device_is_registered(dev))
> > > > -             devices_kset_move_last(dev);
> > > > -
> > > >       if (device_pm_initialized(dev))
> > > >               device_pm_move_last(dev);
> > >
> > > You can't do this.
> > >
> > > If you do it, that will break power management in some situations.
> > >
> > Could you shed light on it? I had a quick browsing of pm code, but it
> > is a big function, and I got lost in it.
> > If the above code causes failure, then does it imply that the seq in
> > devices_kset should be the same as dpm_list?
>
> Generally, yes it should.
>
> > But in device_shutdown(), it only intersect with pm by
> > pm_runtime_get_noresume(dev) and pm_runtime_barrier(dev). How do these
> > function affect the seq in dpm_list?
>
> They are not related to dpm_list directly.
>
> However, if you shut down a supplier device before its consumer and that
> involves power management, then the consumer shutdown may fail and lock up
> the system
>
Ah, get your point. The patch in this series "[PATCHv3 2/4]
drivers/base: utilize device tree info to shutdown devices" still obey
the shutdown order "parent<-child" and "supplier<-consumer". It just
utilizes device-tree info to achieve this, since it turns out not easy
to maintain such order in devices_kset. As I described in the commit
log of [2/4], it needs two nested recursion, and should consider the
breakage of devices_kset's spinlock.

> I asked you elsewhere to clearly describe the problem you are trying to
> address.  Please do that in the first place.
>
OK, I will reply your question in [0/4]

Thanks,
Pingfan
