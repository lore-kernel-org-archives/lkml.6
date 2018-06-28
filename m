Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368A027086
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1DQhMlYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368A027086
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934518AbeF1H4X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:56:23 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34896 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934477AbeF1H4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:56:20 -0400
Received: by mail-it0-f68.google.com with SMTP id l16-v6so10434752ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hfg1djgByAH4+UqVGL7LdiclB8XxOUbQWfFYMZeDq7o=;
        b=1DQhMlYrsR5GeZ+u2chP32mpjVxh4NHMvXcWrNdz00eFuGx3Lq2fhVehX3ls3X+Aru
         JStnwZ7gxD+83G+UqKAOiJ6S/NyfPJeg1/F98Am140DTO4mmkzW11vDlKJXZQ8cZ58Dd
         YikDgyQSd035iBd8RzybTgnPi8mKZL3HeBFMehhYJxxHXPlQsRjIxuIcd4I4HraT1RXE
         wg7wumOKeT2NS/fCrz4OaijHmoBB9m8y1DHPIG5g/uJmJe8/0XKUfYfzHn7EaqQzAgNk
         8JzQqR3ZG1en8FBYB33NfxFPi4WLo6RdkVwVcdsPrUy+nKYseDW8KRw/tTx4AUIJfHvF
         SciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hfg1djgByAH4+UqVGL7LdiclB8XxOUbQWfFYMZeDq7o=;
        b=gCf0cikwaWw9o/A0En9Z6Bo9wj6URiiZDsSVmkH1+i79QPLN5HZw5IAEVggSnof7Ch
         fMwiHjcLdnEh0zvH2lHrhQacf8CpF4FQy8NtiOiVjZIc4o8hnPBywydOg1O2H4he1B1F
         W5cn3OVT6z8lI7Fm8CUC+s8rk5fpfrwF0yOMYMKZziYYHPNNuYYXekd9SkCrhiaphMN6
         CheHxMPgQydHkmxgpXud93g5jbMC1rzI7qbJ/8t66TaYZubpsQ9hE0TKHFFe4oEqGvJt
         X/BarTfG8au2nwAvL1txp9qjxcP+7R+UkeQ2ZvzLSgL6J4rYif8b+lT/uixKgOqtNi3q
         cITg==
X-Gm-Message-State: APt69E2ro3GbThKFiu1cQqw0qguocBvkAEJwxwme4FxF1rOyFaH4DSL6
        sWB+IA/6QY1Y4YJWtuQwfZ1kafHeRP0CiAwbKFk6qg==
X-Google-Smtp-Source: ADUXVKJgzRRxvOKmVXER48krTJ7mZfzNxEBjdlLoZ8jHrguCISQIUdzAVPTXTi1l36ZVOrXg2p5B1CtRzR/KpfoeuyU=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr7513123itg.141.1530172579446;
 Thu, 28 Jun 2018 00:56:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:9c51:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 00:56:18
 -0700 (PDT)
In-Reply-To: <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
References: <20180626102245.30711-1-brgl@bgdev.pl> <20180626102245.30711-2-brgl@bgdev.pl>
 <25ebceca-8cdd-edae-6393-dd29eb323c53@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Jun 2018 09:56:18 +0200
Message-ID: <CAMRc=Md8TM+zLn=T=BQeVHG-PGAvx-PHrs9y1t5zhdYo+m0ovg@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] nvmem: add support for cell lookups
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-26 13:06 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
> Thanks for the patch,
>
> On 26/06/18 11:22, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We can currently only register nvmem cells from device tree or by
>> manually calling nvmem_add_cells(). The latter options however forces
>> users to make sure that the nvmem provider with which the cells are
>> associated is registered before the call.
>>
>> This patch proposes a new solution inspired by other frameworks that
>> offer resource lookups (GPIO, PWM etc.). It adds a function that allows
>> machine code to register nvmem lookup which are later lazily used to
>> add corresponding nvmem cells.
>>
> Overall the idea look fine to me.
>
> This needs to be documented in ./Documentation/nvmem/nvmem.txt
>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/nvmem/core.c           | 57 +++++++++++++++++++++++++++++++++-
>>   include/linux/nvmem-consumer.h |  6 ++++
>>   include/linux/nvmem-provider.h |  6 ++++
>>   3 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index b5b0cdc21d01..a2e87b464319 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
>>   static LIST_HEAD(nvmem_cells);
>>   static DEFINE_MUTEX(nvmem_cells_mutex);
>>   +static LIST_HEAD(nvmem_cell_lookups);
>> +static DEFINE_MUTEX(nvmem_lookup_mutex);
>> +
>>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>   static struct lock_class_key eeprom_lock_key;
>>   #endif
>> @@ -247,6 +250,23 @@ static const struct attribute_group
>> *nvmem_ro_root_dev_groups[] = {
>>         NULL,
>>   };
>>   +/**
>> + * nvmem_register_lookup() - register a number of nvmem cell lookup
>> entries
>> + *
>
>
> Can we rename this to nvmem_add_lookup_table()?
> register sound bit heavy here.
>
> We should also have something like nvmem_remove_lookup_table() for
> consistency, and it should ensure that it clears the cells entry too.
>

What do you mean by clearing the cells entry exactly?

Bart

>
>> + * @lookup: array of nvmem cell lookup entries
>> + * @nentries: number of lookup entries in the array
>> + */
>> +void nvmem_register_lookup(struct nvmem_cell_lookup *lookup, size_t
>> nentries)
>> +{
>> +       int i;
>> + > +   mutex_lock(&nvmem_lookup_mutex);
>> +       for (i = 0; i < nentries; i++)
>> +               list_add_tail(&lookup[i].list, &nvmem_cell_lookups);
>> +       mutex_unlock(&nvmem_lookup_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(nvmem_register_lookup);
>> +
>>   static void nvmem_release(struct device *dev)
>>   {
>>         struct nvmem_device *nvmem = to_nvmem_device(dev);
>> @@ -916,6 +936,37 @@ struct nvmem_cell *of_nvmem_cell_get(struct
>> device_node *np,
>>   EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
>>   #endif
>>
