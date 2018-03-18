Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AG47ELtB1sbozm109qNQYwRv73bmFkVmOGqwCC5kv0FQWhGf2/QhQwm0LO1FMLIZn2Xcx1jaNnrd
ARC-Seal: i=1; a=rsa-sha256; t=1521379321; cv=none;
        d=google.com; s=arc-20160816;
        b=Ieapyak1gqG2KpIKO/Tyn3PvsaW+Y3vObDlBxtZW3vNKHcz6poBHELE6rv1rqQ5DDp
         EWFWIMWdoV+BAdc8ZfIiJht2Gp3o+LJLw895ahCwMmgBwI/N6Ku197ajSvKPIvN/9R/Z
         iIbnvNrKsPna5xH9Ud0qhNehzHU9+RZHhw65vHClZCmKXUPjuilOnlfRTx9LqFMdqoFi
         hgxppQlrvJ/1WZiWzad+pkAifJFhiJr+k7fhj4tJVdKNCPmLfUSjqeRSVBH9hsmaFgSn
         DEeKF9/dkrYI/eQ4LL7LfzQt9RHXgM96cG3JQdxuBD49I7Ekfg/ddJ9HkhYfdykJ891A
         iAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Mu+zw0sEoDNXoa54KZT6AUaZ2N+izpSA0EHE2l/KYu4=;
        b=n497eTXtkysY4fvFCRIfTTVm0odpe5qih7rIpzK9ZO7wrDDvGtc63KDK/QewGyy9eC
         DLU0MUv1woBSRGhLiO0SScrWrkt230j/N9p/1KFAaqfHmXe1O/tBz44+pFQuH9aTGiJs
         eymWlEtqs/SKhhCkCN8QWDoSNQZh2GJcClzIRO5BjYVUGbSmHrvRipAaLp6RgnaPH4Si
         M7rXVaqyWjahA44uJnf7bIEQcpK8AUA4CaggUL4aVwll6PNNPVOrSM4t570UNRSaNiaD
         o1Z85Icf3FP+L/zXlxT289x30HsZTBAUryPESa/YUQuyjMGNoC3q8O+RXnfoDxEJ+0ZL
         y2lA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=TjqD6kJu;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=TjqD6kJu;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Sun, 18 Mar 2018 13:21:27 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Abbott Liu <liuwenliang@huawei.com>
Cc: aryabinin@virtuozzo.com, marc.zyngier@arm.com,
	kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
	f.fainelli@gmail.com, akpm@linux-foundation.org,
	afzal.mohd.ma@gmail.com, alexander.levin@verizon.com,
	glider@google.com, dvyukov@google.com, christoffer.dall@linaro.org,
	linux@rasmusvillemoes.dk, mawilcox@microsoft.com,
	pombredanne@nexb.com, ard.biesheuvel@linaro.org,
	vladimir.murzin@arm.com, nicolas.pitre@linaro.org,
	tglx@linutronix.de, thgarnie@google.com, dhowells@redhat.com,
	keescook@chromium.org, arnd@arndb.de, geert@linux-m68k.org,
	tixy@linaro.org, mark.rutland@arm.com, james.morse@arm.com,
	zhichao.huang@linaro.org, jinb.park7@gmail.com, labbott@redhat.com,
	philip@cog.systems, grygorii.strashko@linaro.org,
	catalin.marinas@arm.com, opendmb@gmail.com,
	kirill.shutemov@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/7] 2 1-byte checks more safer for memory_is_poisoned_16
Message-ID: <20180318132126.GA565@n2100.armlinux.org.uk>
References: <20180318125342.4278-1-liuwenliang@huawei.com>
 <20180318125342.4278-2-liuwenliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180318125342.4278-2-liuwenliang@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327885358177?=
X-GMAIL-MSGID: =?utf-8?q?1595281842279236623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 08:53:36PM +0800, Abbott Liu wrote:
> Because in some architecture(eg. arm) instruction set, non-aligned
> access support is not very well, so 2 1-byte checks is more
> safer than 1 2-byte check. The impact on performance is small
> because 16-byte accesses are not too common.

This is unnecessary:

1. a load of a 16-bit quantity will work as desired on modern ARMs.
2. Networking already relies on unaligned loads to work as per x86
   (iow, an unaligned 32-bit load loads the 32-bits at the address
   even if it's not naturally aligned, and that also goes for 16-bit
   accesses.)

If these are rare (which you say above - "not too common") then it's
much better to leave the code as-is, because it will most likely be
faster on modern CPUs, and the impact for older generation CPUs is
likely to be low.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
