Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3207182-1524779362-5-5841988747551730446
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524779362; b=OktNeTZCLKNg04CKmTp6ckjwLeXP5buZJYk2wzG4ZSQi5mywlO
    opGlMpCqLz6XLf9lhxdzzHllBGu3xapYi9gYXZt+Wo2VTkc+ZWnqHYE1xDfiLuDB
    l5bgX/axPt3m6HFY821Mxh+cQSgWcIDcA4KyQYxDNEyVV/nXYGDmLXpwKLNnRrCc
    zXLtyj8HtFhhyzii/LKAaCqGziqZehSSTWl6qYBtFXRSE0dhTS3LbHongoPt3K8g
    Zx8Snt4SzINZP7Hn6BJjTRIxI74BXNoxn7QGdKvlzynf4BM3q0KgqXe3FRSzzVkh
    brVfKUPqk0wAkv7Eg7L5YdSN3Q+PGCPSi3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524779362; bh=UYYKm
    gn4/w/7kZ5W/WAP+lm8x4Ueujjg4dNQBPTIj48=; b=CpPRLcuP5Lm/yEQvBnQV8
    mkymUZAgr9zQjupI2B1CNOxmaCzsulaDX10lOz+QYG5NSB/Pr2+N2OJJVzzgjNn3
    PLG2Mo1J779f6XRfZ4kQ1TB+Q+rmjqI6C4ftItoalnkktRCRpQQEcJAadB3tdGHh
    P3KUtrWQ5TBs2FHSRygrAqIh8wvWTOyh0VHmuyYd0R+/7++kvyp2ENNY4wlbXZJX
    KCO5nrcHIVEGtCOWP6kJ88al11+l4kXbSGGPDwImwmWPNEgoaMYBJQViKtv1CoqM
    J9WSrzmLCNXOkiLL9Ljycy/0pRlTenCbBXWBmkfuBxpL8U9yv3bk//UOV4FMp7fG
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxxvvjJvqqXp4mBBOioq0hcSPjjYFFbPSXH4sJP0dQfXEGjndQhf6pG3ceENHBTvsJ0eRIdEDi1pTUoCN5MxCWTpX7A/pXlf7iEuyoZ3TZvjlGjvEt2
    kBOpHDxa6YqwesK9+HslhUfdjKFVLIORnHkH4O0zZAGiCriFryxDZb8lTYLxQ6IdVif495DLmBQN+7RzqwonEhpVLW1kHaHI+xBH3p1hSM2Eg31jbryR2fUz
    SS3Q+Hn0MGvY9saaIRMN0g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Odnh0R2cAAAA:8 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=R5APUA0LWR7pvWcvDH0A:9 a=CjuIK1q_8ugA:10
    a=lNAA6UHySJB7qmBR1x20:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 26 Apr 2018 23:49:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
In-Reply-To: <20180425181250.8740-1-kys@linuxonhyperv.com>
Message-ID: <alpine.DEB.2.21.1804262342140.1596@nanos.tec.linutronix.de>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
Cc: olaf@aepfle.de, sthemmin@microsoft.com, gregkh@linuxfoundation.org,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Michael.H.Kelley@microsoft.com, hpa@zytor.com, apw@canonical.com,
 devel@linuxdriverproject.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, kys@linuxonhyperv.com wrote:
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0

Thanks for putting the license identifier in.

> +
> +/*
> + * Hyper-V specific APIC code.
> + *
> + * Copyright (C) 2018, Microsoft, Inc.
> + *
> + * Author : K. Y. Srinivasan <kys@microsoft.com>

But can you please check with your lawyers whether you can avoid the
pointless boilerplate? The SPDX identifier should cover it.

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
> + * NON INFRINGEMENT.  See the GNU General Public License for more
> + * details.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
> +#include <linux/version.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/clockchips.h>
> +#include <linux/hyperv.h>
> +#include <linux/slab.h>
> +#include <linux/cpuhotplug.h>

We usually order the includes

#include <linux/....>
...
#include <linux/....>

#include <asm/....>
#include <asm/....>


> -void hyperv_init(void);
> +void __init hyperv_init(void);
>  void hyperv_setup_mmu_ops(void);
>  void hyper_alloc_mmu(void);
>  void hyperv_report_panic(struct pt_regs *regs, long err);
> @@ -269,14 +269,16 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
>  void set_hv_tscchange_cb(void (*cb)(void));
>  void clear_hv_tscchange_cb(void);
>  void hyperv_stop_tsc_emulation(void);
> +void hv_apic_init(void);
>  #else /* CONFIG_HYPERV */
> -static inline void hyperv_init(void) {}
> +static __init  inline void hyperv_init(void) {}

The __init on the empty inline function is pointless.

Other than the few nits. This looks well done!

Thanks,

	tglx
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
