Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AIpwx49+RB0MzmdM/iNiUcnxhYxy3CN+atXvMP21d0G5NXFhNqg2Wea3ZU+/ishX5V+QZ5rHNt6T
ARC-Seal: i=1; a=rsa-sha256; t=1522755057; cv=none;
        d=google.com; s=arc-20160816;
        b=Rqan2gwXRvkN6bKEz3UPQVlt7ZkySgH0rWIhn9yi+53VrPS5cPu3sl9y/Hdf16hBAU
         fAu4MLRu+hzN6XP+w0/pLrJTost2ZSuy0UguDhvvXDTJPUntQQSLH6FArUbOb0oOWqri
         lTBHO2NvuPJm5gy8tM6/hruWxSuJ4czqcblO4j/EPkQG7FyvL2YLEtRO+aFeHHJ+rEe9
         5z0bZ1NbXmRgsuZjhPjWKUD/fm9XJMJU+RncMnDXdKvlC9yHA88nOmHI4QYa7DgWhmTD
         7OU6HkARKw+GFZrf/VQJ2qLOt7TcObxrHvQtOQ0FMzZz5NDra2Sbm1/41Pp+D/n/SBip
         pQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :arc-authentication-results;
        bh=ZF/hqJD+VioQJt2CXwLyvFX9T71Ng+72UJpH5wcP1UA=;
        b=VlXGXsUoN6iOwM/yM38/FveHsWk1XH4O7BPmp2HBWCWnVA1oQ/D13wYAbSdv+n10dG
         wEFcKxsMboY9hTjh0/Gdjk2qrSZfdpAyWtu7D67gmGWuj0paImzfpW4tUErkxGkWW5gJ
         Z+GNPOlaeyoJ/LvSXPPvxfq+BlGRvyGQuFNlpr+TSrEN0WMdtr7y+r6hhZrasFpa9Vcz
         VCaF9bN2uq1nxvapX8QzV97prxZLWdM2TPzanMQSHG0lInM4IonU9+unHl8mlAxfW4DU
         eAZ0kZprmLo2qeWI5bPkJy6rnYSysMThGkl3dsREy2mHVqeumAkoU3c/4tn6OEEnN5i2
         C33w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH v3 2/6] Disable instrumentation for some code
To: Abbott Liu <liuwenliang@huawei.com>, aryabinin@virtuozzo.com,
 dvyukov@google.com, corbet@lwn.net, linux@armlinux.org.uk,
 christoffer.dall@linaro.org, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, f.fainelli@gmail.com, akpm@linux-foundation.org,
 linux@rasmusvillemoes.dk, mawilcox@microsoft.com, pombredanne@nexb.com,
 ard.biesheuvel@linaro.org, vladimir.murzin@arm.com,
 alexander.levin@verizon.com, nicolas.pitre@linaro.org, tglx@linutronix.de,
 thgarnie@google.com, dhowells@redhat.com, keescook@chromium.org,
 arnd@arndb.de, geert@linux-m68k.org, tixy@linaro.org,
 julien.thierry@arm.com, mark.rutland@arm.com, james.morse@arm.com,
 zhichao.huang@linaro.org, jinb.park7@gmail.com, labbott@redhat.com,
 philip@cog.systems, grygorii.strashko@linaro.org, catalin.marinas@arm.com,
 opendmb@gmail.com, kirill.shutemov@linux.intel.com,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org
References: <20180402120440.31900-1-liuwenliang@huawei.com>
 <20180402120440.31900-3-liuwenliang@huawei.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <7837103a-bcf0-6b00-14d6-bd6b80649886@arm.com>
Date: Tue, 3 Apr 2018 12:30:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402120440.31900-3-liuwenliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596637215509017214?=
X-GMAIL-MSGID: =?utf-8?q?1596724406585188517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/04/18 13:04, Abbott Liu wrote:
> From: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> Disable instrumentation for arch/arm/boot/compressed/*
> ,arch/arm/kvm/hyp/* and arch/arm/vdso/* because those
> code won't linkd with kernel image.
> 
> Disable kasan check in the function unwind_pop_register
> because it doesn't matter that kasan checks failed when
> unwind_pop_register read stack memory of task.
> 
> Reviewed-by: Russell King - ARM Linux <linux@armlinux.org.uk>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Just because I replied to this patch doesn't mean you can stick my
Reviewed-by tag on it. Please drop this tag until I explicitly say that
you can add it (see Documentation/process/submitting-patches.rst,
section 11).

Same goes for patch 1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
