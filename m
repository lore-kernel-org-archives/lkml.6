Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C63C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A42087A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="UD2wp4u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155A42087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeH1Prt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:47:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55429 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeH1Prp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:47:45 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so2241423itj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 04:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XpPw2FSOb+718Q8QJfioTU4VzUlvrFWcfzuxR0OQiP8=;
        b=UD2wp4u+mUFO4e4FXrh38Th1EDmQwlySnJuf64J9hEvKAUqqy+ftFZX8CyURrW3w5I
         bJGUMxMXnZHbe3fZcv2pQ5JU22dqDp5zqryl1sZp9r771DWbkbGLo8xEFELzcEAeutlp
         znoRcbuaz966/rUYCDL93fxDvms8NVPT2HPYNwk7sgmBBg6pHnFdgi/Rp3ov306O0tVo
         Bq2GVi+EujmICjKPMgbM/YoWZjvmIoW0UTvaSvE+7R++XS9Sx1gN2k7dVq/2M7xclQDQ
         sa61aEsLqZcVv+AqkPhyQ8T6uM2XWUypJbtK1e94YIrxjiFwP7x8243aGQ5jz+QgkoTk
         1yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XpPw2FSOb+718Q8QJfioTU4VzUlvrFWcfzuxR0OQiP8=;
        b=hDG7OLitpmK6BWZ37zNw/pZSNU3f6Z4I9JXI2CLaQzAn3O/RWDCtnRTQ26Cznfrovv
         ZITaVKtXFkEFbvI2dFUsKBoDMjIRwiHfy9ZieLOtxyqG7KOgTqmmQlN/foDtu0FyFhiE
         vTdV5FfqND0hI1lFIgUTV8XwSF8n7sYrRlyrnKleGZJqIjT3zA/v4e/LxEnqRtEabe3J
         mztpvtZGFUTl7ve1cVGbi8ja6em3i33UpnVFhwTtx9YjBvcA58chydX7KgEHJYo1LdBE
         /65JfejeVBZ6dFzV2msccIhHqaDG16DAx/OTVYVsIcxGtXpa4yejYpzy8qWP37btPN8x
         9E8Q==
X-Gm-Message-State: APzg51Aizq/vEpNFt1Czn36Sc8WL7VrKqgy8HXhbylMvgNh3C6dmD9lA
        9d37aOllkMFk1WiUn6EPdfnceKXbWB1CrDcalx6C5A==
X-Google-Smtp-Source: ANB0VdZ3I+0jSRssN2PwH68CVClMla40cy8dylHaZ61ipsG5D0ORemblyoiAi4AI6T9+nM7rws1dzYti1ca/Lt8qpaA=
X-Received: by 2002:a02:943:: with SMTP id f64-v6mr921994jad.31.1535457385937;
 Tue, 28 Aug 2018 04:56:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 04:56:25
 -0700 (PDT)
In-Reply-To: <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-2-brgl@bgdev.pl>
 <20180824170848.29594318@bbrezillon> <20180824152740.GD27483@lunn.ch>
 <20180825082722.567e8c9a@bbrezillon> <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon> <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
 <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 28 Aug 2018 13:56:25 +0200
Message-ID: <CAMRc=Mex5WAm8uiV4T=0+bLduBBdj18iekuYT55W9gA_rzQ_sg@mail.gmail.com>
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sven Van Asbroeck <svendev@arcx.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, Naren <naren.kernel@gmail.com>,
        netdev <netdev@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-28 12:15 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
> On 27/08/18 14:37, Bartosz Golaszewski wrote:
>>
>> I didn't notice it before but there's a global list of nvmem cells
>
>
> Bit of history here.
>
> The global list of nvmem_cell is to assist non device tree based cell
> lookups. These cell entries come as part of the non-dt providers
> nvmem_config.
>
> All the device tree based cell lookup happen dynamically on request/demand,
> and all the cell definition comes from DT.
>

Makes perfect sense.

> As of today NVMEM supports both DT and non DT usecase, this is much simpler.
>
> Non dt cases have various consumer usecases.
>
> 1> Consumer is aware of provider name and cell details.
>         This is probably simple usecase where it can just use device based
> apis.
>
> 2> Consumer is not aware of provider name, its just aware of cell name.
>         This is the case where global list of cells are used.
>

I would like to support an additional use case here: the provider is
generic and is not aware of its cells at all. Since the only way of
defining nvmem cells is through DT or nvmem_config, we lack a way to
allow machine code to define cells without the provider code being
aware.

>> with each cell referencing its owner nvmem device. I'm wondering if
>> this isn't some kind of inversion of ownership. Shouldn't each nvmem
>> device have a separate list of nvmem cells owned by it? What happens
>
> This is mainly done for use case where consumer does not have idea of
> provider name or any details.
>

It doesn't need to know the provider details, but in most subsystems
the core code associates such resources by dev_id and optional con_id
as Boris already said.

> First thing non dt user should do is use "NVMEM device based consumer APIs"
>
> ex: First get handle to nvmem device using its nvmem provider name by
> calling nvmem_device_get(); and use nvmem_device_cell_read/write() apis.
>
> Also am not 100% sure how would maintaining cells list per nvmem provider
> would help for the intended purpose of global list?
>

It would fix the use case where the consumer wants to use
nvmem_cell_get(dev, name) and two nvmem providers would have a cell
with the same name.

Next we could add a way to associate dev_ids with nvmem cells.

>> if we have two nvmem providers with the same names for cells? I'm
>
> Yes, it would return the first instance.. which is a known issue.
> Am not really sure this is a big problem as of today! but am open for any
> better suggestions!
>

Yes, I would like to rework nvmem a bit. I don't see any non-DT users
defining nvmem-cells using nvmem_config. I think that what we need is
a way of specifying cell config outside of nvmem providers in some
kind of structures. These tables would reference the provider by name
and define the cells. Then we would have an additional lookup
structure which would associate the consumer (by dev_id and con_id,
where dev_id could optionally be NULL and where we would fall back to
using con_id only) and the nvmem provider + cell together. Similarly
to how GPIO consumers are associated with the gpiochip and hwnum. How
does it sound?

>
>> asking because dev_id based lookup doesn't make sense if internally
>> nvmem_cell_get_from_list() doesn't care about any device names (takes
>> only the cell_id as argument).
>
>
> As I said this is for non DT usecase where consumers are not aware of
> provider details.
>
>>
>> This doesn't cause any trouble now since there are no users defining
>> cells in nvmem_config - there are only DT users - but this must be
>> clarified before I can advance with correctly implementing nvmem
>> lookups.
>
> DT users should not be defining this to start with! It's redundant and does
> not make sense!
>

Yes, this is what I said: we only seem to have DT users, so this API
is not used at the moment.

>>
>> BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
>> instance even if the cell for this node was already added to the nvmem
>> device.
>
> I hope you got the reason why of_nvmem_cell_get() always allocates new
> instance for every get!!


I admit I didn't test it, but just from reading the code it seems like
in nvmem_cell_get() for DT-users we'll always get to
of_nvmem_cell_get() and in there we always end up calling line 873:
cell = kzalloc(sizeof(*cell), GFP_KERNEL);

There may be something I'm missing though.

>
> thanks,
> srini

BR
Bart
