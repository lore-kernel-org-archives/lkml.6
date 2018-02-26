Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3594401-1519673692-2-3530706356015793335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519673691; b=hw9B1QcNA7Yu3aNJZcqDct5ld6ILE1D8tb1lb95ClUNdfm7
    1aj5PEP8NwhLTIT77WCH1+8mRsxjijZuYj638KEw7P+zcGfhI8RnEV4ofShsEn4z
    ZDyCNoyzPlXR6xIV2bAA1uoGpUK1D9cRNiBJr12PEOd8EV8S23lAshBKC9qHl3fF
    z/i5KBZcnKTvX671h1yhMAY/sUfNOvMjOdK+RYJ9ooNfoGVRdpRsjO88/0KSCSYb
    5n5Zqah1XR3qOClOHiCQOQSpUJmxZahlVWmw60fmLSj632K09Msyvi+i6S16p1nW
    SkvVqN7JKewak1SKt1T8KFFCTBqBsTmbansqcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519673691; bh=KDZsur7ghcI+VrwZmRlUP1P4rvcT498h6w6/LSw40as=; b=k
    Hy1T1r/EF2HxSeyLVUsw1FvJKzWTsstNmaBjd54ib7nUrSrQKDdY3MrOG6DQtH3G
    1FFoSHiriUmZCk1P6v2dNi3rCoM9+gKgGZqje/knZy35g+ZV1U6SPCdmW5SR80pN
    CajPNajWeKbKOFpvTwNcJ9AGudre9+gBykfpXdZf/25C3NCV0Xx330njCQzh+4+X
    d2E7TzR8De6qXV2O8ri3LysIYcapW7HkQp7X1B3g8WwRNLf4donT/EJAw95XZbgW
    K2aKslYt0InLA7/3AOvyDdXiY5xFLRTE1zG7taeFIospMzOGRfzp8Ia1V7DPy2j4
    RmxS+xCsw+Gc2Z6jFOJKg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e3zruzMg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e3zruzMg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbeBZTer (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 14:34:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBZTeq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Feb 2018 14:34:46 -0500
Subject: Re: [PATCH v4 01/12] drivers: base: Unified device connection lookup
To: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180226183919.24353-1-hdegoede@redhat.com>
 <20180226183919.24353-2-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3a6850c4-7c54-c889-a7d0-347b8df65d31@infradead.org>
Date: Mon, 26 Feb 2018 11:34:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226183919.24353-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 10:39 AM, Hans de Goede wrote:
> diff --git a/include/linux/connection.h b/include/linux/connection.h
> new file mode 100644
> index 000000000000..0b4430eae53a
> --- /dev/null
> +++ b/include/linux/connection.h
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef _LINUX_CONNECTION_H_
> +#define _LINUX_CONNECTION_H_
> +
> +#include <linux/list.h>
> +
> +struct device;
> +
> +/**
> + * struct devcon - Device Connection Descriptor
> + * @endpoint: The names of the two devices connected together
> + * @id: Unique identifier for the connection

Hi,
 * @list: <description>
is missing above.

> + */
> +struct devcon {
> +	const char		*endpoint[2];
> +	const char		*id;
> +	struct list_head	list;
> +};


-- 
~Randy
