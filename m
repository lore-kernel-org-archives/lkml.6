Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2988274-1523468262-2-2263967534349235811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523468261; b=KBIkmIepv5C3mPGxHe7YTWgnHQZhZ4aUSfkUWWGoN5fjkTQ1S2
    BLaUME3bsHz1qITkLXVmptvTPy7Sol0qy98ToiD+F2unU8uBbrWEIhesN+cmHGod
    d7UOTMFCOsE0VG5o62QU+O3qEa0X9/6rSzacM5E0k7fNZS/bToGJ83KglJfy0B+3
    n1hNXBrsVGfeByZifqPDKEFxNVSAB0ifHPxW3T6ESmTGGzijGeN9/Eu0Hk7dGOWr
    GXak1gFRtfY3lhPoGbPR7RU1sXeIgexcpiUucA0jH28WhcrS2cYIdAd7nGqPVd3Z
    u7MHxaYk+GfiAA59YaIKEJxJHfMd5u+vnLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523468261;
    bh=K/PwQzvdT+JDNl4EXRSgBtQjCb7A67O9JeEh1DGZ+Ho=; b=SMhc1XstMkI2
    TlktwUgX9xM96XtOV14ubE2X2UAzmXxeBhuZPtwWWTU99UqJOtYhYThHkjV3sRem
    5eiObLoXo1Wk1iFZweXrfbbf0QXwAHJmMEJ4mdauirfQkvasyl/oxMYNeUFHAtAu
    uAhelaJFihNxp6kBn7vLCEFLVqi3mGoGx2cDpyyMyRbZt7IaGrVaOgoYP9xHd2Pb
    WKWStfGjobqkytXIWgSTaxP7WNe+1TzgTdUG+X75VMFlYosa3FaGPUlO3drkDx4q
    lrq231zfy5NsfCbutogfHDZb9ifUrUjq0tD1M3c9qxP/oRUJ9xdhBov3sktXbat6
    4UjraaeypQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Dq0TwPwI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Dq0TwPwI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCElA2cj0ZmIJhGVkRQVTqEhtXT63o/pQtYvHEswUZImhqF2Wha3OoR3lhMZK+wYZjn0bmqeGGZJZw7GrCNVwjBcvizWHxxxrP5sjrhvlXMXXQWBPnKm
    XmL6igX7Im8GoNsiBSG+B2fW1NLFioP/saVjIdIokbgGbT3nsromOKD20qb02x+8stgaHGcx7BVEpe96rIX31rIvz/UHXQJW/NEVSpgjyTY93ZJNoaidtNJm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=inoG4m36AAAA:8 a=VwQbUJbxAAAA:8 a=D75MK_40BgmKsU1utOEA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=_Qgj-RFg6mImvLaOgLPg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbeDKRhk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:37:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeDKRhj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 13:37:39 -0400
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6a37b428-d9fb-12d5-8d36-8a032984af8c@infradead.org>
Date: Wed, 11 Apr 2018 10:37:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 09:24 AM, David Howells wrote:
> ---
> 
>  arch/x86/kernel/setup.c |    2 +
>  include/linux/kernel.h  |   32 +++++++++++++++++++++++
>  security/Kconfig        |   23 ++++++++++++++++-
>  security/Makefile       |    3 ++
>  security/lock_down.c    |   65 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 security/lock_down.c

> diff --git a/security/Kconfig b/security/Kconfig
> index c4302067a3ad..a68e5bdebad5 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -231,6 +231,28 @@ config STATIC_USERMODEHELPER_PATH
>  	  If you wish for all usermode helper programs to be disabled,
>  	  specify an empty string here (i.e. "").
>  
> +config LOCK_DOWN_KERNEL
> +	bool "Allow the kernel to be 'locked down'"
> +	help
> +	  Allow the kernel to be locked down.  Locking down the kernel turns
> +	  off various features that might otherwise allow access to the kernel

	  s/turns off/disables/

> +	  image (eg. setting MSR registers).

	         e.g.

> +
> +	  Note, however, that locking down your kernel will prevent some

	                                   the kernel
	                                   a kernel

> +	  drivers from functioning because allowing manual configuration of
> +	  hardware parameters is forbidden, lest a device be used to access the
> +	  kernel by DMA.  This mostly applies to ISA devices.

	Is DMA from non-ISA devices OK, or did I miss seeing that patch?

> +	  The kernel lockdown can be triggered by adding lockdown=1 to the
> +	  kernel command line.


> diff --git a/security/lock_down.c b/security/lock_down.c
> new file mode 100644
> index 000000000000..f35ffdd096ad
> --- /dev/null
> +++ b/security/lock_down.c
> @@ -0,0 +1,65 @@
> +/* Lock down the kernel
> + *
> + * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.

fsf.org spells that Licence word as License. :)

> + */


-- 
~Randy
