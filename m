Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD146C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3883920891
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oxYQiXNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3883920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeH1SdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:33:05 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32791 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeH1SdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:33:05 -0400
Received: by mail-io0-f196.google.com with SMTP id r196-v6so1670936iod.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 07:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rfmv4FNlCnI9a+GHyNjCuqkxdHjyQOD8dQr/XiXG1ao=;
        b=oxYQiXNt3xERKQrxEVa4R/jyhHeuy2FyEiu7/pgTChx1aKD4kZDt6WSYkgl5YyJAbs
         zz4+6Iho/O2jUnfLPmNwQLceDkrkf3VJupdP/PjT8m2uxhDphNl1tfPOEaNfTiobkPG1
         irBSweFAfCRVyzHxhBFJNlKmXSVZe05X8DlRlo3HeeVYeC3VfkrI3eCpTWlUOMAEYutC
         oy2NpB7goJ1Xf8gRcCQBTnra+jluTra8wRzwuMwZEoypBPY11jHI/SpsHVMXmoVoJ6HR
         MFKlEePEz2tOmett+yDvhCTgfe0pcgVmSXCrXg769HdSvLdCEt/9HjTz0d2TUgM8vGaH
         vbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rfmv4FNlCnI9a+GHyNjCuqkxdHjyQOD8dQr/XiXG1ao=;
        b=ddaav+yplnpVHDf7cHnAtQ1k6ucngflutba/9479IMzTWqy3ME/aXS0rC1MZoHOhPZ
         C3ckzez1v77KFSPly8jpXOOJm+dcuh/xkDsNfoUyMCDtiMXilHOU5gSWxQFJqOSQBx7f
         fmhZ4PwpM8wvtCI09Y0fy7z2LMr9N2IkYFhd+KvWEGGasK/GsmFcHBy2bphHPENpbhyT
         WhZTfbFduowycBIyugcjPLCpxsWgdoiEYr/hfD0JGei33V72BcQ9rqT+VQYBHl4/+s+v
         uN/Y93Ra8nxo5a1jYYEsTrdKsJaSbeV6yKwjSU/oA4p9I8BAeS4bQKu6lVTImzFbK5yY
         HSCQ==
X-Gm-Message-State: APzg51CZ0vsFuz7wUPEU6g+m14pe7vXbJyGqTi6P5SdviFFCewUCb0gr
        nZXFqT1/r4TzJ8nTRcrXRO72Eu6//tXl5g59fUWXqw==
X-Google-Smtp-Source: ANB0VdZODrlV+3ts7RhUPKemVlMXJjF3+UmdnhcLJRZK6ID3nLvTDpOREZv53fGcRntGnZ6xdJV52zeA6icg0j6c+1w=
X-Received: by 2002:a6b:9157:: with SMTP id t84-v6mr1588613iod.187.1535467264980;
 Tue, 28 Aug 2018 07:41:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 07:41:04
 -0700 (PDT)
In-Reply-To: <916e3e89-82b3-0d52-2b77-4374261a9d0f@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl> <20180810080526.27207-2-brgl@bgdev.pl>
 <20180824170848.29594318@bbrezillon> <20180824152740.GD27483@lunn.ch>
 <20180825082722.567e8c9a@bbrezillon> <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon> <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
 <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org> <CAMRc=Mex5WAm8uiV4T=0+bLduBBdj18iekuYT55W9gA_rzQ_sg@mail.gmail.com>
 <916e3e89-82b3-0d52-2b77-4374261a9d0f@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 28 Aug 2018 16:41:04 +0200
Message-ID: <CAMRc=MeALxpyBQhWxGPt9BubO_ZwKGih1d8zhRzFYZ0+3kHFAA@mail.gmail.com>
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

2018-08-28 15:45 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>
>
> On 28/08/18 12:56, Bartosz Golaszewski wrote:
>>
>> 2018-08-28 12:15 GMT+02:00 Srinivas Kandagatla
>> <srinivas.kandagatla@linaro.org>:
>>>
>>>
>>> On 27/08/18 14:37, Bartosz Golaszewski wrote:
>>>>
>>>>
>>>> I didn't notice it before but there's a global list of nvmem cells
>>>
>>>
>>>
>>> Bit of history here.
>>>
>>> The global list of nvmem_cell is to assist non device tree based cell
>>> lookups. These cell entries come as part of the non-dt providers
>>> nvmem_config.
>>>
>>> All the device tree based cell lookup happen dynamically on
>>> request/demand,
>>> and all the cell definition comes from DT.
>>>
>>
>> Makes perfect sense.
>>
>>> As of today NVMEM supports both DT and non DT usecase, this is much
>>> simpler.
>>>
>>> Non dt cases have various consumer usecases.
>>>
>>> 1> Consumer is aware of provider name and cell details.
>>>          This is probably simple usecase where it can just use device
>>> based
>>> apis.
>>>
>>> 2> Consumer is not aware of provider name, its just aware of cell name.
>>>          This is the case where global list of cells are used.
>>>
>>
>> I would like to support an additional use case here: the provider is
>> generic and is not aware of its cells at all. Since the only way of
>> defining nvmem cells is through DT or nvmem_config, we lack a way to
>> allow machine code to define cells without the provider code being
>> aware.
>
>
> machine driver should be able to do
> nvmem_device_get()
> nvmem_add_cells()
>

Indeed, I missed the fact that you can retrieve the nvmem device by
name. Except that we cannot know that the nvmem provider has been
registered yet when calling nvmem_device_get(). This could potentially
be solved by my other patch that adds notifiers to nvmem, but it would
require much more boilerplate code in every board file. I think that
removing nvmem_cell_info from nvmem_config and having external cell
definitions would be cleaner.

> currently this adds to the global cell list which is exactly like doing it
> via nvmem_config.
>>
>>
>>>> with each cell referencing its owner nvmem device. I'm wondering if
>>>> this isn't some kind of inversion of ownership. Shouldn't each nvmem
>>>> device have a separate list of nvmem cells owned by it? What happens
>>>
>>>
>>> This is mainly done for use case where consumer does not have idea of
>>> provider name or any details.
>>>
>>
>> It doesn't need to know the provider details, but in most subsystems
>> the core code associates such resources by dev_id and optional con_id
>> as Boris already said.
>>
>
> If dev_id here is referring to provider dev_id, then we already do that
> using nvmem device apis, except in global cell list which makes dev_id
> optional.
>
>
>>> First thing non dt user should do is use "NVMEM device based consumer
>>> APIs"
>>>
>>> ex: First get handle to nvmem device using its nvmem provider name by
>>> calling nvmem_device_get(); and use nvmem_device_cell_read/write() apis.
>>>
>>> Also am not 100% sure how would maintaining cells list per nvmem provider
>>> would help for the intended purpose of global list?
>>>
>>
>> It would fix the use case where the consumer wants to use
>> nvmem_cell_get(dev, name) and two nvmem providers would have a cell
>> with the same name.
>
>
> There is no code to enforce duplicate checks, so this would just decrease
> the chances rather than fixing the problem totally.
> I guess this is same problem
>
> Finding cell by name without dev_id would still be an issue, am not too
> concerned about this ATM.
>
> However, the idea of having cells per provider does sound good to me.
> We should also maintain list of providers in core as a lookup in cases where
> dev_id is null.
>
> I did hack up a patch, incase you might want to try:
> I did only compile test.
> ---------------------------------->cut<-------------------------------
> Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date:   Tue Aug 28 13:46:21 2018 +0100
>
>     nvmem: core: maintain per provider cell list
>
>     Having a global cell list could be a issue in cases where the cell-id is
> same across multiple providers. Making the cell list specific to provider
> could avoid such issue by adding additional checks while addding cells.
>
>     Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index aa1657831b70..29da603f2fa4 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -40,6 +40,8 @@ struct nvmem_device {
>         struct device           *base_dev;
>         nvmem_reg_read_t        reg_read;
>         nvmem_reg_write_t       reg_write;
> +       struct list_head        node;
> +       struct list_head        cells;
>         void *priv;
>  };
>
> @@ -57,9 +59,7 @@ struct nvmem_cell {
>
>  static DEFINE_MUTEX(nvmem_mutex);
>  static DEFINE_IDA(nvmem_ida);
> -
> -static LIST_HEAD(nvmem_cells);
> -static DEFINE_MUTEX(nvmem_cells_mutex);
> +static LIST_HEAD(nvmem_devices);
>
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  static struct lock_class_key eeprom_lock_key;
> @@ -284,26 +284,28 @@ static struct nvmem_device *of_nvmem_find(struct
> device_node *nvmem_np)
>
>  static struct nvmem_cell *nvmem_find_cell(const char *cell_id)
>  {
> -       struct nvmem_cell *p;
> +       struct nvmem_device *d;
>
> -       mutex_lock(&nvmem_cells_mutex);
> -
> -       list_for_each_entry(p, &nvmem_cells, node)
> -               if (!strcmp(p->name, cell_id)) {
> -                       mutex_unlock(&nvmem_cells_mutex);
> -                       return p;
> -               }
> +       mutex_lock(&nvmem_mutex);
> +       list_for_each_entry(d, &nvmem_devices, node) {
> +               struct nvmem_cell *p;
> +               list_for_each_entry(p, &d->cells, node)
> +                       if (!strcmp(p->name, cell_id)) {
> +                               mutex_unlock(&nvmem_mutex);
> +                               return p;
> +                       }
> +       }
>
> -       mutex_unlock(&nvmem_cells_mutex);
> +       mutex_unlock(&nvmem_mutex);
>
>         return NULL;
>  }
>
>  static void nvmem_cell_drop(struct nvmem_cell *cell)
>  {
> -       mutex_lock(&nvmem_cells_mutex);
> +       mutex_lock(&nvmem_mutex);
>         list_del(&cell->node);
> -       mutex_unlock(&nvmem_cells_mutex);
> +       mutex_unlock(&nvmem_mutex);
>         kfree(cell);
>  }
>
> @@ -312,18 +314,18 @@ static void nvmem_device_remove_all_cells(const struct
> nvmem_device *nvmem)
>         struct nvmem_cell *cell;
>         struct list_head *p, *n;
>
> -       list_for_each_safe(p, n, &nvmem_cells) {
> +       list_for_each_safe(p, n, &nvmem->cells) {
>                 cell = list_entry(p, struct nvmem_cell, node);
>                 if (cell->nvmem == nvmem)
>                         nvmem_cell_drop(cell);
>         }
>  }
>
> -static void nvmem_cell_add(struct nvmem_cell *cell)
> +static void nvmem_cell_add(struct nvmem_device *nvmem, struct nvmem_cell
> *cell)
>  {
> -       mutex_lock(&nvmem_cells_mutex);
> -       list_add_tail(&cell->node, &nvmem_cells);
> -       mutex_unlock(&nvmem_cells_mutex);
> +       mutex_lock(&nvmem_mutex);
> +       list_add_tail(&cell->node, &nvmem->cells);
> +       mutex_unlock(&nvmem_mutex);
>  }
>
>  static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> @@ -385,7 +387,7 @@ int nvmem_add_cells(struct nvmem_device *nvmem,
>                         goto err;
>                 }
>
> -               nvmem_cell_add(cells[i]);
> +               nvmem_cell_add(nvmem, cells[i]);
>         }
>
>         /* remove tmp array */
> @@ -519,6 +521,10 @@ struct nvmem_device *nvmem_register(const struct
> nvmem_config *config)
>         if (config->cells)
>                 nvmem_add_cells(nvmem, config->cells, config->ncells);
>
> +       mutex_lock(&nvmem_mutex);
> +       list_add_tail(&nvmem->node, &nvmem_devices);
> +       mutex_unlock(&nvmem_mutex);
> +
>         return nvmem;
>
>  err_device_del:
> @@ -544,6 +550,8 @@ int nvmem_unregister(struct nvmem_device *nvmem)
>                 mutex_unlock(&nvmem_mutex);
>                 return -EBUSY;
>         }
> +
> +       list_del(&nvmem->node);
>         mutex_unlock(&nvmem_mutex);
>
>         if (nvmem->flags & FLAG_COMPAT)
> @@ -899,7 +907,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node
> *np,
>                 goto err_sanity;
>         }
>
> -       nvmem_cell_add(cell);
> +       nvmem_cell_add(nvmem, cell);
>
>         return cell;
>
> ---------------------------------->cut<-------------------------------
>
>>
>> Next we could add a way to associate dev_ids with nvmem cells.
>>
>>>> if we have two nvmem providers with the same names for cells? I'm
>>>
>>>
>>> Yes, it would return the first instance.. which is a known issue.
>>> Am not really sure this is a big problem as of today! but am open for any
>>> better suggestions!
>>>
>>
>> Yes, I would like to rework nvmem a bit. I don't see any non-DT users
>> defining nvmem-cells using nvmem_config. I think that what we need is
>> a way of specifying cell config outside of nvmem providers in some
>> kind of structures. These tables would reference the provider by name
>> and define the cells. Then we would have an additional lookup
>> structure which would associate the consumer (by dev_id and con_id,
>> where dev_id could optionally be NULL and where we would fall back to
>> using con_id only) and the nvmem provider + cell together. Similarly
>> to how GPIO consumers are associated with the gpiochip and hwnum. How
>> does it sound?
>
> Yes, sounds good.
>
> Correct me if am wrong!
> You should be able to add the new cells using struct nvmem_cell_info and add
> them to particular provider using nvmem_add_cells().
>
> Sounds like thats exactly what nvmem_add_lookup_table() would look like.
>
> We should add new nvmem_device_cell_get(nvmem, conn_id) which would return
> nvmem cell which is specific to the provider. This cell can be used by the
> machine driver to read/write.

Except that we could do it lazily - when the nvmem provider actually
gets registered instead of doing it right away and risking that the
device isn't even there yet.

>
>>>>
>>>> BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
>>>> instance even if the cell for this node was already added to the nvmem
>>>> device.
>>>
>>>
>>> I hope you got the reason why of_nvmem_cell_get() always allocates new
>>> instance for every get!!
>>
>>
>>
>> I admit I didn't test it, but just from reading the code it seems like
>> in nvmem_cell_get() for DT-users we'll always get to
>> of_nvmem_cell_get() and in there we always end up calling line 873:
>> cell = kzalloc(sizeof(*cell), GFP_KERNEL);
>>
> That is correct, this cell is created when we do a get and release when we
> do a put().
>

Shouldn't we add the cell to the list, and check first if it's there
and only create it if not?

Bart
