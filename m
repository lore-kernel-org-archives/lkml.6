Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9490C23E08
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFqTTwWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9490C23E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeGFNwf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:52:35 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53913 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbeGFNwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:52:33 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so16611908itd.3;
        Fri, 06 Jul 2018 06:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YcRxyO8sFuy48wOtxwRJroAuu7HbYnRtYNlb9lqTVA=;
        b=AFqTTwWDEQIKIG0eAikbF8He5Unh+4wEexNsSvUkgFArUdnzJbeNdNBvfsssB7a2L5
         qYxHwAZzvCfqkD8zaT9oBB8d1wWPpUS7SYMJG8NUOQrkqepViWygMRTA+gpAyS3fkaqh
         /HZKpOpw+Rno5o4A2Cu64nJbRFebjFxYxIcPYIHYCyzi8laWdOgoJD7ErdoUIlDZ6Ob3
         6JnYbRkxKSSEz9fSu6BEz92h/KhzJBaLfCqbBbtzgIroq1+Oax/nEcL2fo1u2A7p4UsZ
         9MNAwfkIyR+zbnpWcXJvBLIat/QkpomoljldLXjigopkgXyduvULjG39Ov/guy9O1X/Z
         Ux4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YcRxyO8sFuy48wOtxwRJroAuu7HbYnRtYNlb9lqTVA=;
        b=Qciud7PG2a/N8OqNMoFjdhWkfWMvqPB+aJryAdYQd27i8pwHcmD6lZEkbOK4KRQksl
         RR82qTmo+1MzJgWAqktEOwmJXedI89f/dM0g0KJF4LU3osEoYgEBPFiDBLkee/OQoAND
         3CHskP23H00lrR1hVlwp9cNdzKYRSmv+SQfxAMD2aSv4vbxsMn4puEYJ1wblTjL0BY+4
         LqC+9ZnZEhBczI6iOUQvgCHll+5Yp3ArloJ79B3oC7Es7BQW6fJciYXczEDplJzp/jFK
         ZfAd+JShEVPTB1R7Y0kegFfNRxXtK6dsb/sA4y0tZHhQvV3FC24piNZaPtQTm4v4q4xl
         cflg==
X-Gm-Message-State: APt69E0qRRyTjqbZMEBaUClq+9qhtpKuR8CvpXxAog/JfVVKLsVoKaKx
        6rt2d8rSYZxocRsgqfcPwtVCCwTcgA348hbduQ==
X-Google-Smtp-Source: AAOMgpe7UZeXN10tDMIrHGtIurNC/LNooVKFvXsD4WCMH7vcDjKqX7FomJiaiZwLDrM7w7MNhGFKcq9JtctPs/ar9zY=
X-Received: by 2002:a24:de84:: with SMTP id d126-v6mr8138660itg.18.1530885152469;
 Fri, 06 Jul 2018 06:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
 <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com> <20180706083603.GA9063@wunner.de>
In-Reply-To: <20180706083603.GA9063@wunner.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 6 Jul 2018 21:52:21 +0800
Message-ID: <CAFgQCTsouCPy7GWGFzWbLuSUxnE2rWe5EGqsE5ivT+=ATw2MJg@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     lukas@wunner.de
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org,
        kishon@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 4:36 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> [cc += Kishon Vijay Abraham]
>
> On Thu, Jul 05, 2018 at 11:18:28AM +0200, Rafael J. Wysocki wrote:
> > OK, so calling devices_kset_move_last() from really_probe() clearly is
> > a mistake.
> >
> > I'm not really sure what the intention of it was as the changelog of
> > commit 52cdbdd49853d doesn't really explain that (why would it be
> > insufficient without that change?)
>
> It seems 52cdbdd49853d fixed an issue with boards which have an MMC
> whose reset pin needs to be driven high on shutdown, lest the MMC
> won't be found on the next boot.
>
> The boards' devicetrees use a kludge wherein the reset pin is modelled
> as a regulator.  The regulator is enabled when the MMC probes and
> disabled on driver unbind and shutdown.  As a result, the pin is driven
> low on shutdown and the MMC is not found on the next boot.
>
> To fix this, another kludge was invented wherein the GPIO expander
> driving the reset pin unconditionally drives all its pins high on
> shutdown, see pcf857x_shutdown() in drivers/gpio/gpio-pcf857x.c
> (commit adc284755055, "gpio: pcf857x: restore the initial line state
> of all pcf lines").
>
> For this kludge to work, the GPIO expander's ->shutdown hook needs to
> be executed after the MMC expander's ->shutdown hook.
>
> Commit 52cdbdd49853d achieved that by reordering devices_kset according
> to the probe order.  Apparently the MMC probes after the GPIO expander,
> possibly because it returns -EPROBE_DEFER if the vmmc regulator isn't
> available yet, see mmc_regulator_get_supply().
>
> Note, I'm just piecing the information together from git history,
> I'm not responsible for these kludges.  (I'm innocent!)
>
Thanks for your exploration, very clearly. I had tried, but failed
since these commits are contributed with different authors. I am not
familiar with ARM and dts, so had thought
really_probe()->devices_kset_move_last() is used to address a very
popular "supplier<-consumer" order issue in smart phone, based on the
configuration hard-coded in "bios(or counterpart in ARM).

> @Pingfan Liu, if you just remove the call to devices_kset_move_last()
> from really_probe(), does the issue go away?
>
Yes, it goes away.

> If so, it might be best to remove that call and model the dependency
> with a call to device_link_add() in mmc_regulator_get_supply().
> Another idea would be to automatically add a device_link in the
> driver core if -EPROBE_DEFER is returned.
>
Maybe the first one is better, as it is already used by other drivers.

Thanks,
Pingfan
