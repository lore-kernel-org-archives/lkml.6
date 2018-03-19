Return-Path: <liuwenliang@huawei.com>
X-Google-Smtp-Source: AG47ELuTFcVO2ybknW1JWwxxAZSLwEMQyFF3ELAcfY3CmJXv9d3b/xdMo70KUEmsnHWNjTWY4fSo
ARC-Seal: i=1; a=rsa-sha256; t=1521421357; cv=none;
        d=google.com; s=arc-20160816;
        b=I+Cc4lkH8prpjhiGDTPS5jpvmDcVm+vCEDEcUD1EuOWjMFObpmw6Qr+sLRg0y3xEhV
         pnZeTHZcbo2lEqL74x0/zlBbqXxy3cAuDlSs8R+peLCTECxyJEYzbUJJArQjr/d7IuvE
         iDzobn/vztmdrU9QHQXDrsZ3Y/WhMNcbwUcKYBcPOv/mfv4Edd5IXsihru3AZ855K6UY
         t5mDlnB5uwI13KoiyGjmKeVuj/nga15sZe3ADijlViTwZjuiUotofS3g12CsG19YLrqN
         A474W7E0SI2qIcl/nCU3tkDTdFRJj62XeeSVJ0Zu/LPqV7373i11VQgbEZZPvxechgmV
         S6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=FotpmdIm8XN2DEgPIYEosxzqymbtG0sA1BAJXb9i48c=;
        b=athhoGReiDzACOZ938Hwlzn5rmzL5K9HssRHEPHrfjj5tLQtIW45EI17nbmpTJA+KJ
         JblV079X0XLMnlSd3ciu4OicQtlFbk+LemCJimQO7jIUN8DLce+wE+cvQfo0heRBZTyk
         P85GIZcP3XkQLMCFdJ+VHBDYXkT8DWLFZBsFKp9s6GrVr/1pJgDWL1+rMAVFuk+tMvMI
         9KghdW0/K4F72zrT+uCk1HnydWgtT1lezTIPJO+hiJs3Ef4cznRKp9f1H21sAJsOHbSE
         MU6BuBVdVsDoDcTLwIr2Mpy8bAJay6DcllfS+WcO/Q5WbQNufJknKa8iqtDkgYESVTut
         hueA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.188 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of liuwenliang@huawei.com designates 45.249.212.188 as permitted sender) smtp.mailfrom=liuwenliang@huawei.com
From: "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
CC: "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
	"alexander.levin@verizon.com" <alexander.levin@verizon.com>,
	"glider@google.com" <glider@google.com>, "dvyukov@google.com"
	<dvyukov@google.com>, "christoffer.dall@linaro.org"
	<christoffer.dall@linaro.org>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>, "mawilcox@microsoft.com"
	<mawilcox@microsoft.com>, "pombredanne@nexb.com" <pombredanne@nexb.com>,
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
	"nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thgarnie@google.com" <thgarnie@google.com>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>, "tixy@linaro.org"
	<tixy@linaro.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>, "zhichao.huang@linaro.org"
	<zhichao.huang@linaro.org>, "jinb.park7@gmail.com" <jinb.park7@gmail.com>,
	"labbott@redhat.com" <labbott@redhat.com>, "philip@cog.systems"
	<philip@cog.systems>, "grygorii.strashko@linaro.org"
	<grygorii.strashko@linaro.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "opendmb@gmail.com" <opendmb@gmail.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kvmarm@lists.cs.columbia.edu"
	<kvmarm@lists.cs.columbia.edu>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/7] 2 1-byte checks more safer for memory_is_poisoned_16
Thread-Topic: [PATCH 1/7] 2 1-byte checks more safer for
 memory_is_poisoned_16
Thread-Index: AdO/HI59LJ0q51oFQXu6g3rOUkrXKw==
Date: Mon, 19 Mar 2018 01:02:34 +0000
Message-ID: <B8AC3E80E903784988AB3003E3E97330C0076F8D@dggemm510-mbs.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.90.243]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595281327885358177?=
X-GMAIL-MSGID: =?utf-8?q?1595325921298329055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 21:21:20PM +0800, Russell King wrote:
>On Sun, Mar 18, 2018 at 08:53:36PM +0800, Abbott Liu wrote:
>> Because in some architecture(eg. arm) instruction set, non-aligned
>> access support is not very well, so 2 1-byte checks is more
>> safer than 1 2-byte check. The impact on performance is small
>> because 16-byte accesses are not too common.
>
>This is unnecessary:
>
>1. a load of a 16-bit quantity will work as desired on modern ARMs.
>2. Networking already relies on unaligned loads to work as per x86
>   (iow, an unaligned 32-bit load loads the 32-bits at the address
>   even if it's not naturally aligned, and that also goes for 16-bit
>   accesses.)
>
>If these are rare (which you say above - "not too common") then it's
>much better to leave the code as-is, because it will most likely be
>faster on modern CPUs, and the impact for older generation CPUs is
>likely to be low.

Thanks for your review.
OK, I am going to remove this patch in the next version.
