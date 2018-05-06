Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3584689-1525629611-2-8592709465206077477
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525629610; b=Diyq4La7alix4kznIZwcLXXoKPxK63cc55tSADIdybRqC9oexQ
    hxpRiU75Ojk81eKmSjowF86GPvYrPzM5vJKrMsHRtkeopgQVvJ9cXGAp+8vg7Lqe
    aaz3CJoBr5EJhvgW65VQdU8GCxOh/KXFZzSzQTU0O3EgMsHP6x6XYHugoD4a9I9x
    W3Cq702B+/s2+Qy23v8vsdBB2iwCedzEXwuvpW7/U4e1A5gPspdjP9rYheKDkyAB
    T9kPAfJ7vwkp+PVKP3XQjemRGNlEc8uWc/QizmduGgSKegebSt/T7EZb4a7Cd7ds
    2JAA1yy+NS3yzRHfdyuWRL9P4N+9n25JMMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525629610; bh=5NNgy
    SJVlf0NfyRy2PWUC3k8DKOgZ5n3crOEAbZIM14=; b=S0t8lizGH0GMZPC8L3MD6
    CnRjD3/6WY6DbS8lsdUPoYAYBfrGsphRr0KlI34jH+lfix/5oYg4xZWd+GxidDwM
    eggI8X5wG88opy/7QwDNAlymEzGTEpmrRwvTCa39M23mICxPwGz0KSUc4vLgwYpG
    zjMrX9whpnfSc+V66x0c5OQUGaikUjzJiNKdHXiWgOjogv72fzhY/xEvsP9ZYbBE
    KK/AsZJej5irhDwUApcwb1YkJmXxk5fw4byYebsA5/RcZbqh5b+nv7AqLsXBRARE
    zRjUmLkZhQlUmfMOgyHffPadOn0eVqjAe/8j52FGb7miz9OYcLy75Nibu6hCWJ+Q
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=0lRAPkPZ x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=0lRAPkPZ x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG895nmzKtMJX8K0Pf+pjEZCmygd9CWKXWuFHsoq8FptRrrih2lYvv7XT2vxGpCEqNJy0bqm3z2v8iuqm2nIMOW8N754YKNLVVleRHyl34Ehe3nVIy1w
    RmO1CS6f0kiauUW8NG44dfH+H38kF9B6LM4Tx75LmZB7HTKdIIOWh3eEziUoCtREGBjpiNyirPt95QfdjgzPhV+KkYVxy3T8RehsgIIQ9lqoydlgMIs5kGI9
    AautGpBdUcpGtLVVUMA1NQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=1XH82ks_koQIDDZe6VMA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 18:59:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v2 01/11] staging: iio: tsl2x7x: use GPL-2.0+ SPDX
 license identifier
Message-ID: <20180506185954.7367ef59@archlinux>
In-Reply-To: <20180504025319.28953-2-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
 <20180504025319.28953-2-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de, drew.paterson@ams.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu,  3 May 2018 22:53:09 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The summary text for the GPL is not needed since the SPDX identifier
> is a legally binding shorthand that can be used instead.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
I'm always less than totally keen on these patches not coming from the
copyright holder, but is is probably fine.  If taos is unhappy we
can always switch back again.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to ignore it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 11 +----------
>  drivers/staging/iio/light/tsl2x7x.h | 15 +--------------
>  2 files changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index e65621948cf8..01bff4593640 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1,19 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Device driver for monitoring ambient light intensity in (lux) and proximity
>   * detection (prox) within the TAOS TSL2X7X family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
>   * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
>   */
>  
>  #include <linux/delay.h>
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 91ce8f98982e..8eb7f4749ea7 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -1,22 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Device driver for monitoring ambient light intensity (lux)
>   * and proximity (prox) within the TAOS TSL2X7X family of devices.
>   *
>   * Copyright (c) 2012, TAOS Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write to the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA	02110-1301, USA.
>   */
>  
>  #ifndef __TSL2X7X_H

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
