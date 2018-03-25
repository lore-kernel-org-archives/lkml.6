Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522022332; cv=none;
        d=google.com; s=arc-20160816;
        b=y9jUpCc0GsRVmSAEmW/mIYq9Ip/i76CSZ9e1227x/J+X8n06yVhvRzM+u8e0cgeAYs
         5FTaMnnePPUiXfHgsGU/1etSYoOM2s6WlFnq7Ho/s3ftHdpbp00GeqLQi/4B7cKgdv/k
         r7EVWiM20BA4Yk9uRU+S7PIqbbXo3yDlp6WrtsG/H3podaQm7zHrNh4S5aIPez+ODYNV
         tIDv6/xtW3SZsJMjFSX/BQwq9e1qw2iN1kqufKi9+R7w/lkTJsfvFATiW4Y3g6owkvx+
         +hvQtiLFyH40WYBaFtfIlWeYsw2q+vcux9GvJi+7hqoO667kO+ZotlZv+Cr/BXC4udD+
         JXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=sowHeiAtO/PVtulCpPP4kvNCY7uT+QVSXMhDdaiuHcg=;
        b=KTA/v8LYAldjHFl9Zo3Yg8m+ZvPW08t+pLfgaqfSx9E+nyIQR3SDBATqTJ30s5IKJW
         EhDm+raGnqwAg32qe1D9K/yjRnz7kIXBerLj5iNSKJ35NqQssVjY2aXs8X2FFcnPmK5l
         5Nv2ckDrjT+3oYtGd/J525pjrIvy8sPiq9yGPii7FBYGPcQqf6ZFvhSEJO1JB55tWD6Z
         Moopx2d6UuO0Bd576idkL6q4JqmyROJRhPbsRyQbB07i5EhKE0leWUFPEN/zu2pGs4wl
         2s4rRGJLhkr+i89dUr50h5lMqkZjQqLoXG47Wq/awAVHIJS1YZg8LD0VkVbD1KoHMlFi
         HzbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nuo2IebA;
       dkim=pass header.i=@jms.id.au header.s=google header.b=HceW6EiT;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nuo2IebA;
       dkim=pass header.i=@jms.id.au header.s=google header.b=HceW6EiT;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AIpwx4+Yzfzqlw6X0X55J5MLKuIrkmdyS1HQquQ5GBjtWDMBdXZ//FnNEQ8DyGo6unsQ8o9m6ZCTW6UoMNmBAhAp5ec=
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180318125342.4278-1-liuwenliang@huawei.com>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 26 Mar 2018 10:28:30 +1030
X-Google-Sender-Auth: YSJrGybeiWiSsO9fgORP0-nM7Pg
Message-ID: <CACPK8XemuC+uACYp=tP1gJ8=9k-S69saebOLmq8nrZtqPxWRjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KASan for arm
To: Abbott Liu <liuwenliang@huawei.com>
Cc: Russell King <linux@armlinux.org.uk>, aryabinin@virtuozzo.com,
	Marc Zyngier <marc.zyngier@arm.com>, kstewart@linuxfoundation.org,
	Greg KH <gregkh@linuxfoundation.org>, Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Afzal Mohammed <afzal.mohd.ma@gmail.com>,
	alexander.levin@verizon.com, glider@google.com, dvyukov@google.com,
	Christoffer Dall <christoffer.dall@linaro.org>, linux@rasmusvillemoes.dk,
	mawilcox@microsoft.com, Philippe Ombredanne <pombredanne@nexb.com>, ard.biesheuvel@linaro.org,
	vladimir.murzin@arm.com, nicolas.pitre@linaro.org,
	Thomas Gleixner <tglx@linutronix.de>, thgarnie@google.com, dhowells@redhat.com,
	Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com, zhichao.huang@linaro.org,
	jinb.park7@gmail.com, labbott@redhat.com, philip@cog.systems,
	grygorii.strashko@linaro.org, catalin.marinas@arm.com, opendmb@gmail.com,
	kirill.shutemov@linux.intel.com,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
	kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327886471398?=
X-GMAIL-MSGID: =?utf-8?q?1595956088787508967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18 March 2018 at 23:23, Abbott Liu <liuwenliang@huawei.com> wrote:

>    These patches add arch specific code for kernel address sanitizer
> (see Documentation/kasan.txt).

Thanks for implementing this. I gave the series a spin on an ASPEED
ast2500 (ARMv5) system with aspeed_g5_defconfig.

It found a bug in the NCSI code (https://github.com/openbmc/linux/issues/146).

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
