Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526462189; cv=none;
        d=google.com; s=arc-20160816;
        b=MRw8dK33t5eUhezE7/grqgStPUnRh9ulB8CsF3+ahr68/K/4krILGET9VWLM9I7Nt6
         lRWvVDtZJjMAWV8GxuIJThiS0ECaZ2SEAY0RUhdqQP+YyDh+9vKdqBfE5qrMrOpQKskV
         z4G0HEoWV5XyCLEu1+aqKd8qfofcXT1/Maa0kJtQWQ9eAc6NX6SlSdD7NjQo4+vQWXeS
         Ggx8nFxSigtLrqwmRydMCcLf8QVY41K40GzvF+bdxHry//pwtsPRGBHKJ2FQvb0nK+1L
         aUCK3XLYMNnenhL7sRSmRM1EfWwh23v0/ECZts2MvkQvcWOJeS4uXSw8KWtFEsl2JKtt
         owLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=wM51Jxjg9p8j4Fr52O6cXyqYQBtPXW1dYVqE5tcZ8h0=;
        b=iNmcN/JwkPojwixujfmaNwDQpZMl1zIRrikqRsmoAG30dO/7vjJerbZibC+nXhbh3s
         7fo2p6V0ikHNY4glD9OQ5idojCjE9RaOZD7IDh5hKhc+/uwF5ipzOboCKrJ60ZrMv5r7
         p+pRzNv1wDEy9w/jVDHWbOH/AMZPapmaWTyGjrsZWQfXjTEdB5FlOZToqA4jw10GQev+
         diGBMSxWgzkLAdQ/kBFoPdsjLmfiLB8beTVCNQehcovykxtc2IxZ3Cxjp3+CC5W76Zti
         g1xa0Tn1RLNa4U/yR2MUtSEk3520jC7zrwZyj02UbPAMuih1Fl5wjiKzWysuLLwI9mai
         1yAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=THRTZp0i;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=THRTZp0i;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqhYeXxJYk/CK1jgBdpHhpGJFmL1Rz+9Wnje8aKpz62W1nssK9ByJtuTP2yMu+7ytF5YH4rM6PIhdarpzo7oVQ=
MIME-Version: 1.0
In-Reply-To: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 12:16:28 +0300
Message-ID: <CAHp75VfGpS_QkLj4XM8uHW0BAJV0EBWZ_yLP0R2D+ok4Mt=SQg@mail.gmail.com>
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>, Rik van Riel <riel@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600611616668040335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 10:06 PM, Kim Phillips <kim.phillips@arm.com> wrote:
> This patch is provided in the context of allowing the Coresight driver
> subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> to bus_find_device() in of_coresight_get_endpoint_device() when
> searching for a configurable endpoint device.  This patch allows
> Coresight to reference amba_bustype when built as a module.

> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -197,6 +197,7 @@ struct bus_type amba_bustype = {
>         .pm             = &amba_pm,
>         .force_dma      = true,
>  };
> +EXPORT_SYMBOL_GPL(amba_bustype);

Oh,

What wrong with the approach let's say similar to PCI bus?

Whenever you have a struct device you may use two helpers:

dev_is_pci() -> is the device of PCI bus type?
to_pci_dev() -> get's container of struct device for PCI bus case

-- 
With Best Regards,
Andy Shevchenko
