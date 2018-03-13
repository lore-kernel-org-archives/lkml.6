Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AG47ELs0MC7Vt5IcukgHZgu/SGKHZhKFXS5tmh2aLhxSevP7Ig0PG2J7PKknaUeBnfH6Oe5WDpjQ
ARC-Seal: i=1; a=rsa-sha256; t=1520935130; cv=none;
        d=google.com; s=arc-20160816;
        b=DVWSS5Hv2XoRhpYW6ZQY6flVxq/TL1eonm5YHEa30zOOw9YggnjIfM4D+9AOE/8LLX
         1tDshY2w+5UCg6ABJAL8fQDbmcJ7sJSWgddAwkXaJpGBsLdOJSpn8zem0GXwGtyQsNj5
         sRqgxAMb5ayWTBptDfvJzRKDSBSjwQqtl3ZWRrtaRjcrrKOW9EknH6ryAy32ZF99TLXB
         zZDn3ftSClt+Py5aNHcwp5K8JcMcWuLn9QUGkSoYFBmlHIj0HNs6++thS7yIrgDL0T8m
         5hBd7C/XETYyBZJ0/R4IntVTpMt/V92wRYmP5rTvqhSiLhDHcVcP7LZT2fwK3AcXnuAy
         8XaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=hnHnbclzHB1BY3sn1vpgU1pEBUBfCLor18ccQ3l2UKs=;
        b=NOA+w2O58ONDvZbNmzsQbagrFQXD/o/WamqK8FUzUtuTQQMwnN34rRWJ3/eqRWSTsv
         vvp3Xq1yaashjRVjSkt+4T/OXS5k4L2b42M4i72lRub+zS2qHHYiwRDq++uysFj5o+LD
         iQ3cMjfeYy0PKysJYAYttTdTgC8utaABYATpqbUbUj2a+nmItLOCWGFMruZhqt9S4e/5
         3YE0nQZ4HVr5TduY5sL5KhgAH+2s6RZd6tfLDtDq5hEjQkKrKgLttyv7HfHqA2Y3Lsc5
         uQ6swKPdh6uThTWRoVVbpEI6XgWFR4SYyNrByCe7PjHC8TOhSX4Gob/lj6IQrS0qj9O9
         ffSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Gf4I7+Bg;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EEYoYkKM;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Gf4I7+Bg;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=EEYoYkKM;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9FF16081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
MIME-Version: 1.0
In-Reply-To: <20180313085534.11650-2-vivek.gautam@codeaurora.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org> <20180313085534.11650-2-vivek.gautam@codeaurora.org>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Tue, 13 Mar 2018 15:28:47 +0530
X-Gmail-Original-Message-ID: <CAFp+6iH5E3qZNS65AHWEAypMwy7bfRg62_TFc3dBEYu_H-K0mg@mail.gmail.com>
Message-ID: <CAFp+6iH5E3qZNS65AHWEAypMwy7bfRg62_TFc3dBEYu_H-K0mg@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
To: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <joro@8bytes.org>, "robh+dt" <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rob Clark <robdclark@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
	Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Vivek Gautam <vivek.gautam@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594816075292926829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 2:25 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> The lists managing the device-links can be traversed to
> find the link between two devices. The device_link_add() APIs
> does traverse these lists to check if there's already a link
> setup between the two devices.
> So, add a new APIs, device_link_find(), to find an existing
> device link between two devices - suppliers and consumers.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>
>  * New patch added to this series.
>
>  drivers/base/core.c    | 30 +++++++++++++++++++++++++++---
>  include/linux/device.h |  2 ++
>  2 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5847364f25d9..e8c9774e4ba2 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -144,6 +144,30 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>         return 0;
>  }
>
> +/**
> + * device_link_find - find any existing link between two devices.
> + * @consumer: Consumer end of the link.
> + * @supplier: Supplier end of the link.
> + *
> + * Returns pointer to the existing link between a supplier and
> + * and consumer devices, or NULL if no link exists.
> + */
> +struct device_link *device_link_find(struct device *consumer,
> +                                    struct device *supplier)
> +{
> +       struct device_link *link = NULL;
> +
> +       if (!consumer || !supplier)
> +               return NULL;
> +
> +       list_for_each_entry(link, &supplier->links.consumers, s_node)
> +               if (link->consumer == consumer)
> +                       break;
> +
> +       return link;

My bad, this too needs fixing (didn't add the changes to the patch :( )

           list_for_each_entry(link, &supplier->links.consumers, s_node)
                   if (link->consumer == consumer)
                           return link;

           return NULL;

> +}
> +EXPORT_SYMBOL_GPL(device_link_find);
> +
>  /**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
> @@ -195,9 +219,9 @@ struct device_link *device_link_add(struct device *consumer,
>                 goto out;
>         }
>
> -       list_for_each_entry(link, &supplier->links.consumers, s_node)
> -               if (link->consumer == consumer)
> -                       goto out;
> +       link = device_link_find(consumer, supplier);
> +       if (link)
> +               goto out;
>
>         link = kzalloc(sizeof(*link), GFP_KERNEL);
>         if (!link)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index b093405ed525..13bc1884c3eb 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1278,6 +1278,8 @@ extern const char *dev_driver_string(const struct device *dev);
>  struct device_link *device_link_add(struct device *consumer,
>                                     struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
> +struct device_link *device_link_find(struct device *consumer,
> +                                    struct device *supplier);
>
>  #ifdef CONFIG_PRINTK
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
