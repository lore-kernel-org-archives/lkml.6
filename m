Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524327412-2-1958582136192469636
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524327411; b=hPYmSwn3BGZQVMeS9J5pFT624/LsL1H4LgaDcAo5G8HZFDWFTO
    LI80BOZVLP0UHcA58gCpp16pTxZv97AX8V2jVIMz1vQChOEYizlD8Kpwa5bhNngX
    ssQUrIj+MlzqGMFLrPRj/249o4pszW4t3crnvzkdntXr9vYcVx3kf7Y72r73/vMU
    MbQO6WhnNEToPPhUafG/ZZHT15ODtrCl+XRuS0Tm2UOF2oggegY6T2RCBBB/IpQD
    8AOI8xcM2P+bQmJsJTWYCGuheVMEkyNSrnob5Swg32dn1dN73BZjf4R90ZJJFMJi
    teW2Gs6yDoz6xZ8Jt6LY2UrbRGx66l/yDsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524327411; bh=ALI/K
    0qtSqO4CZAJLLzW9N8yUvT27L4x8zhORC51yPk=; b=fN2dBTXEPD0GZKgMoptRb
    rn6wftStNQfAwsYalr1H2/32SfhZqa7oha3GQkofz7Sr+jUEKrdgXzAFYFrN2jy4
    N2zX3Ldb/iWX7vqQgWkRJyljYiaVAowez/NelpX2eV9PN5IY3kVsiN1/eeFRqQNZ
    7FuVXMJbtDK81w0rcs8hxQCb8r3FH8wdmP9O15o+O9fJE7Zf5BBD/os139eUyonm
    PbKOpB0VKGZ4xjEfyUgyZQJ3t5Di0zvIcGpwNync19cZa9OeiGIeKJYKom4qDlRe
    6rW4iOKL20Knj9ND19ioZ+41ksUZCH/a5ihj6XEmsCf9tZGD3DSEQNOXoVR6q9ag
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHNe03WTpPwtPIAGyFPM4D/GhtLlDQmbcuOBZKR8faJfMCA1gG8QQJyKM2e+bBSmMXKDFinPAQhVLFQVGVazMenQLCxlkY0GrmgPhtdmP9EUXDQqPp+m
    fhzJ39Uus+xhhY2rCnCUk+f5FWK7PJe9s0DpMiGYM9EFvj88KAmxPXn6V+xCd8ZSv+PR51VU3U0b7wQTnU7TY1KOSDaJfKEEHN1bkoeWz+wTIZy4NSHczeV/
    b7+2456cOkmg+sqaaWKODg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=loSyNqLDSb14OlKScD4A:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274B120C09
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:16:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 02/13] staging: iio: tsl2x7x: use GPL-2.0+ SPDX license
 identifier
Message-ID: <20180421171638.13443ed8@archlinux>
In-Reply-To: <20180421004153.19073-3-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-3-masneyb@onstation.org>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 20:41:42 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The summary text for the GPL is not needed since the SPDX identifier
> is a legally binding shorthand that can be used instead.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
I sanity checked against other drivers because I wasn't 100% sure
this wasn't a valid formatting for SPDX.  It doesn't seem to be.
Normally convention is
//SPDX... 
On the first line of the file.
C style comments also fine, but it needs to be a comment line on it's
own.  This is all about making it trivial for automated tools to find.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 10 +---------
>  drivers/staging/iio/light/tsl2x7x.h | 14 +-------------
>  2 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index eeccfbb0eb1f..9cdcc8c9e812 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -5,15 +5,7 @@
>   * Copyright (c) 2012, TAOS Corporation.
>   * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> + * SPDX-License-Identifier: GPL-2.0+
>   */
>  
>  #include <linux/delay.h>
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index d382cdbb976e..992ee2465609 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -4,19 +4,7 @@
>   *
>   * Copyright (c) 2012, TAOS Corporation.
>   *
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
> + * SPDX-License-Identifier: GPL-2.0+
>   */
>  
>  #ifndef __TSL2X7X_H

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
