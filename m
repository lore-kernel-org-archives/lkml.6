Return-Path: <kernel-hardening-return-12998-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48dIwPoUJo+/R6V/kyPa5HK0az0H+5FyAcwMmJOu3OT+7KGMLh2EFyZi8Dm8I7B0tqUXYKL
ARC-Seal: i=1; a=rsa-sha256; t=1523703375; cv=none;
        d=google.com; s=arc-20160816;
        b=r4N7Gpge1eif7RC//LA1c1UFqjQgs6O0/vOGdezGqyNmYaQ3gEJ0hnGAg26dOKcYnD
         kdzvM/WOX/7rL8TbCWRipDH3Tmsep+54/m6/BFwHOPuaMOP9P87QqPigyRDjbxcK3XIc
         R/HfmXtH0yxiQTiJ5den3hM8DnYyh0kfHSAQM/dQ3HSCEeBrgseP4K/NViGQHjPc8njs
         MNhAXLqNtsVEyCygwhxAOmJ/y076FIrTlvToxhfYfmZj2BDjsogl8dt34djTEhA81HWu
         uxezzjnfwMDqSbqqFd+/2Ntl719LCisgWE9lmAF0WacdE3mzJ7DwHEt2953eXBkPhCCM
         oufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=/Gd6KtCsJai/9kgGV2vlsweznDYVatCtFqtopBaO9Po=;
        b=hKsNJtYoI6FCxacbPsm5vPGt7hZBJmMr1bRdb0Zzwrsl079DllBNXcLcLlkPoC1tE7
         96dR3uqoHgyNd+KzNzSPFRaIFNeuTCxGgc1G6JpFA7HqO6/y7ke8WGDhwDbmf497RwDs
         N4N3swkduhVkZuvt+KHc7Y+pCsA14rxqaJzjpah0JDJc31TSkl0Lqa5+jgPvrY7M92oz
         DydAv/b+ilPg+sf6S7USmzSaB/JTTZWBEh7HCGtKEoem8+3CG/03jTY2sepQH3huGgUU
         hRj8mkP/GIVo1N6uckIiUqxOrhKO1VP1axvXFHfRMtlULhgrB2KgQ2bKT6H6ZDj6aSBo
         8BRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12998-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12998-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12998-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12998-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv4] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>,
  Linus Walleij <linus.walleij@linaro.org>
Cc: Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
  Rasmus Villemoes <linux@rasmusvillemoes.dk>,
  "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  kernel-hardening@lists.openwall.com
References: <20180411010352.17929-1-labbott@redhat.com>
 <CACRpkdb04=5eHW3xR-qmY6UzOUcAC35mV4eDgHaFn9nQEL_eEw@mail.gmail.com>
 <c618af81-2dbb-1aff-212a-e87e56caa7eb@electromag.com.au>
 <0aea6c90-ba94-708c-5cad-836c50dadfe6@redhat.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <20968086-4e27-6f71-707a-3c1b3d48390a@electromag.com.au>
Date: Sat, 14 Apr 2018 18:55:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0aea6c90-ba94-708c-5cad-836c50dadfe6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597409764349726473?=
X-GMAIL-MSGID: =?utf-8?q?1597718790327891759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/04/2018 05:10, Laura Abbott wrote:
> On 04/12/2018 05:39 PM, Phil Reid wrote:
>> On 12/04/2018 16:38, Linus Walleij wrote:
>>> On Wed, Apr 11, 2018 at 3:03 AM, Laura Abbott <labbott@redhat.com> wrote:
>>>
>>>> The new challenge is to remove VLAs from the kernel
>>>> (see https://lkml.org/lkml/2018/3/7/621) to eventually
>>>> turn on -Wvla.
>>>>
>>>> Using a kmalloc array is the easy way to fix this but kmalloc is still
>>>> more expensive than stack allocation. Introduce a fast path with a
>>>> fixed size stack array to cover most chip with gpios below some fixed
>>>> amount. The slow path dynamically allocates an array to cover those
>>>> chips with a large number of gpios.
>>>>
>>>> Reviewed-and-tested-by: Lukas Wunner <lukas@wunner.de>
>>>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>>> ---
>>>> v4: Changed some local variables to avoid coccinelle warnings. Added a
>>>> warning if the number of GPIOs exceeds the current fast path define.
>>>>
>>>> Lukas, I kept your Tested-by because the changes were pretty minimal.
>>>> Let me know if you want to run the tests again.
>>>
>>> This patch is starting to look really good.
>>>
>>>> +/*
>>>> + * Number of GPIOs to use for the fast path in set array
>>>> + */
>>>> +#define FASTPATH_NGPIO 256
>>>
>>> There is still some comment about this.
>>>
>>> And now that I am also tryint to think I wonder about it, we
>>> have a global ARCH_NR_GPIOS that is typically 512.
>>> Some archs set it up.
>>>
>>> This define is something of an abomination, in the ARM
>>> case it comes from arch/arm/include/asm/gpio.h
>>> where #define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
>>> where the latter is a Kconfig option that is mostly 512 for
>>> most ARM systems.
>>>
>>> Well, ARM looks like this:
>>>
>>> config ARCH_NR_GPIO
>>>          int
>>>          default 2048 if ARCH_SOCFPGA
>>>          default 1024 if ARCH_BRCMSTB || ARCH_SHMOBILE || ARCH_TEGRA || \
>>>                  ARCH_ZYNQ
>>>          default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
>>>                  SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
>>>          default 416 if ARCH_SUNXI
>>>          default 392 if ARCH_U8500
>>>          default 352 if ARCH_VT8500
>>>          default 288 if ARCH_ROCKCHIP
>>>          default 264 if MACH_H4700
>>>          default 0
>>>          help
>>>            Maximum number of GPIOs in the system.
>>>
>>>            If unsure, leave the default value.
>>>
>>> So if FASTPATH_NGPIO should be anything else than
>>> ARCH_NR_GPIO this has to be established somewhere
>>> as a floor or half or something, but I would just set it as
>>> the same as ARCH_NR_GPIOS...
>>>
>>> The main reason this define exist is for this function
>>> from <linux/gpio/consumer.h>:
>>>
>>> /* Convert between the old gpio_ and new gpiod_ interfaces */
>>> struct gpio_desc *gpio_to_desc(unsigned gpio);
>>>
>>> Nowadays that fact is a bit obscured since the variable is
>>> only used when assigning the base (in the global GPIO
>>> number space, which is what we want to get rid of but
>>> sigh) in gpiochip_find_base() where it attempts to place
>>> a newly allocated gpiochip in the higher region of this
>>> numberspace since the embedded SoC GPIO base tends
>>> to be 0, on old platforms.
>>>
>>> So I don't know about this.
>>>
>>> Can't we just use ARCH_NR_GPIOS?
>>>
>>> Very few systems have more than 512 assigned global
>>> GPIO numbers and those are FPGA experimental machines.
>>>
>>> In the long run obviously I want to get rid of these defines
>>> altogether and only allocate GPIO descriptos dynamically
>>> so as you see I am reluctant to add new numberspace weirdness
>>> around here.
>> Isn't that for total GPIO's in the system?
>> And the arrays just need to cater for max per chip?
>>  From what I can understand of the code which is admittedly limited.
>>
>>
> 
> Yeah the switch back to 256 was a mistake on my end (I think I
> grabbed an incorrect version for my base). ARCH_NR_GPIOs
> is the total number in the system which may be multiple
> chips so yes we would be possibly allocating more space
> than necessary.
> 
> unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)]
> 
> unsigned long fastpath[2 * BITS_TO_LONGS(512)]
> unsigned long fastpath[2 * DIV_ROUND_UP(512, 8 * sizeof(long))]
> 
> so we end up with 128 bytes on the stack total assuming I
> can do math correctly. I think this a fairly reasonable
> amount though, even if we are over-estimating if there are
> multiple chips.
> 

Yeah that's not too bad.
My system is a SOCFPGA so it'd be 2048 / 8 = 512.
Still not unreasonable.

But the system doesn't have a single gpio close to that.
The largest chip is 32.


-- 
Regards
Phil Reid
