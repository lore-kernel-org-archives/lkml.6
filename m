Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECF4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6E920897
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Cprax1Zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6E920897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeILOh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:37:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39617 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeILOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:37:29 -0400
Received: by mail-it0-f67.google.com with SMTP id h1-v6so2116688itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=85KDPdZ7tNQtaOiNW9oe0N419oNpGETKK32RY0w8Mno=;
        b=Cprax1ZdBROEr23sAhrl8cFjwLnhqItwn0OC8UPzykx9cc12oJA8eDuGmFVa7hj35y
         EUNNL/q9z8Xe2UtczSIaatTuewjWEbFaaFiJS5aGU1D2eKA5AbuceKS0HhTOm9MfBxXd
         +PPH+UUwPb7t41Eq/YQkObHznf7MGvXd8A8SDbWnkdnMFKhkO+HNLk90YOn1fyKSQW8g
         aDrAWF0gvnspFUv8eBtqARE8rti7lIbQkbnNsX+VTH4BLKMWmlDd5+0vjSKYW/gpLeef
         r1dU0oiRceSQS8tI49LBPFSb5OVvLOo2XBOvj9IexNuAcHuQvI3jOvqCiCh6ufbKqCXW
         nPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=85KDPdZ7tNQtaOiNW9oe0N419oNpGETKK32RY0w8Mno=;
        b=b9yit4YSs0h0elM3L+iFrSEfnzMGxgc+z0Cvsq2NJYL1Bmi2P+fgA9wHmDkBppoiz/
         0wIm4Nj85StdQapirRaP5JXqeGbRKCa/ZCfinGhWpj+/Hs98Hrsz22zHxXy143FUM/yQ
         os1ud5cMD161wSIpkiPzoGJVGRWHdQ/jJRPurMwXaJHPulCjHkpgvAVyzgeiom8gEC9c
         tN5mEGn7gRnrNKkvzIiG+tXp3Jsotia/PZq86CZnkqOiZW2LflarIC/VTLQVCWaBqyOd
         +Ac0VSCfyVk8z2ynMJMccaFjzVzjdDsRS9dUqjmFlQe0c2ts8xPzRCeWx+atzRpqexFQ
         0TBA==
X-Gm-Message-State: APzg51Dht6FBDbMkp4B1EYBt2sdYebNuqLhOqNSe8W6S59DD/MM9dovF
        dNSdzNegQkYG0C/43CQtU1Jk6py/Oa6OJtnAfMKrow==
X-Google-Smtp-Source: ANB0VdYx0zoTepp56ylXAGg6rYYeIKpZg3K9Pc5aRhl6LCU6Mz/M8eeX+Q/RW2Q0wTSlUNCHsXIjJmcBNYU+lHJBi8Q=
X-Received: by 2002:a02:95c4:: with SMTP id b62-v6mr771377jai.43.1536744825839;
 Wed, 12 Sep 2018 02:33:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 02:33:45
 -0700 (PDT)
In-Reply-To: <20180912075129.25185-17-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl> <20180912075129.25185-17-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 12 Sep 2018 11:33:45 +0200
Message-ID: <CAMRc=MdoUon+cCOqLaNMN+814bg+t7Ltv_2ysOvztP9B93dAYw@mail.gmail.com>
Subject: Re: [PATCH v3 16/21] nvmem: add a notifier chain
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-12 9:51 GMT+02:00 Bartosz Golaszewski <brgl@bgdev.pl>:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add a blocking notifier chain with four events (add and remove for
> both devices and cells) so that users can get notified about the
> addition of nvmem resources they're waiting for.
>
> We'll use this instead of the at24 setup callback in the mityomapl138
> board file.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/nvmem/core.c           | 36 ++++++++++++++++++++++++++++++++++
>  include/linux/nvmem-consumer.h | 21 ++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9cc86d131e1e..af6f7163cb67 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -65,6 +65,8 @@ static LIST_HEAD(nvmem_cell_tables);
>  static DEFINE_MUTEX(nvmem_lookup_mutex);
>  static LIST_HEAD(nvmem_lookup_list);
>
> +static BLOCKING_NOTIFIER_HEAD(nvmem_notifier);
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  static struct lock_class_key eeprom_lock_key;
>  #endif
> @@ -300,6 +302,7 @@ static struct nvmem_device *nvmem_find(const char *name)
>
>  static void nvmem_cell_drop(struct nvmem_cell *cell)
>  {
> +       blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_REMOVE, cell);
>         mutex_lock(&nvmem_mutex);
>         list_del(&cell->node);
>         mutex_unlock(&nvmem_mutex);
> @@ -319,6 +322,7 @@ static void nvmem_cell_add(struct nvmem_cell *cell)
>         mutex_lock(&nvmem_mutex);
>         list_add_tail(&cell->node, &cell->nvmem->cells);
>         mutex_unlock(&nvmem_mutex);
> +       blocking_notifier_call_chain(&nvmem_notifier, NVMEM_CELL_ADD, cell);
>  }
>
>  static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
> @@ -434,6 +438,32 @@ static int nvmem_setup_compat(struct nvmem_device *nvmem,
>         return 0;
>  }
>
> +/**
> + * nvmem_register_notifier() - Register a notifier block for nvmem events.
> + *
> + * @nb: notifier block to be called on nvmem events.
> + *
> + * Return: 0 on success, negative error number on failure.
> + */
> +int nvmem_register_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_register_notifier);
> +
> +/**
> + * nvmem_unregister_notifier() - Unregister a notifier block for nvmem events.
> + *
> + * @nb: notifier block to be unregistered.
> + *
> + * Return: 0 on success, negative error number on failure.
> + */
> +int nvmem_unregister_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&nvmem_notifier, nb);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_unregister_notifier);
> +
>  static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
>  {
>         const struct nvmem_cell_info *info;
> @@ -647,6 +677,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>         if (rval)
>                 goto err_remove_cells;
>
> +       rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
> +       if (rval)
> +               goto err_remove_cells;
> +
>         return nvmem;
>
>  err_remove_cells:
> @@ -675,6 +709,8 @@ static void nvmem_device_release(struct kref *kref)
>         nvmem_device_remove_all_cells(nvmem);
>         device_del(&nvmem->dev);
>         put_device(&nvmem->dev);
> +
> +       blocking_notifier_call_chain(&nvmem_notifier, NVMEM_REMOVE, nvmem);

Ugh this is wrong, it should be called before all the other code in
this function. I'll resend in the next version after reviews.

Bart

>  }
>
>  /**
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index 27eee3945405..0326b52e906b 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -14,6 +14,7 @@
>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/notifier.h>
>
>  struct device;
>  struct device_node;
> @@ -47,6 +48,13 @@ struct nvmem_cell_lookup {
>         struct list_head        node;
>  };
>
> +enum {
> +       NVMEM_ADD = 1,
> +       NVMEM_REMOVE,
> +       NVMEM_CELL_ADD,
> +       NVMEM_CELL_REMOVE,
> +};
> +
>  #if IS_ENABLED(CONFIG_NVMEM)
>
>  /* Cell based interface */
> @@ -80,6 +88,9 @@ void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
>  void nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries,
>                             size_t nentries);
>
> +int nvmem_register_notifier(struct notifier_block *nb);
> +int nvmem_unregister_notifier(struct notifier_block *nb);
> +
>  #else
>
>  static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
> @@ -179,6 +190,16 @@ nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
>  static inline void
>  nvmem_del_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
>
> +static inline int nvmem_register_notifier(struct notifier_block *nb)
> +{
> +       return -ENOSYS;
> +}
> +
> +static inline int nvmem_unregister_notifier(struct notifier_block *nb)
> +{
> +       return -ENOSYS;
> +}
> +
>  #endif /* CONFIG_NVMEM */
>
>  #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
> --
> 2.18.0
>
