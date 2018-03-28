Return-Path: <kernel-hardening-return-12785-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/G+nNN78oPw4+scLwk90o5HlR/bcpvY5WaCBeQcrerphP9/I8ueLAJ9vkgyf+CnBb0DH1b
ARC-Seal: i=1; a=rsa-sha256; t=1522197462; cv=none;
        d=google.com; s=arc-20160816;
        b=grWym/yOLQH19HQ4gJbG5qi2whYR/AJ0RZ/7QHPDEccWn+lNY2K2BXKnkDmG9bVSxy
         bkzTLguej647sEYGYGuX0/JJm7c38VesRlRnIKCsEQ7jg5YA4x2RJkn9Hq4mUuBM8gZF
         htKSxRcuiz0njW92X+WQh9uV9zRVGa5c8jspOPiPn/f7OoEWUxlxrLxrbBLdqoF3ipM9
         9NHwI8gfyYwsyphkqiLWotyxV398E9iyD2dPxMGftFYdN79vWyf3wQ3twwM5OVHoLmJ4
         lRTRYESCW1Udm2jZ9p3vGQ1QpJVGL54vGliczSMUDHEWuXBzm0Skex8cp7nNuFDbfJrS
         gUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=luWMVxkIU2JC13STYk6FCwlxHiEtK91jRhznNFQWJpM=;
        b=Nmi0rC2XfVzX2b4EcEy7wNlBLqszqkkBZyI5T0GE4HTwzUwdYRF1e8JlAUGFDF99pB
         JbBTzzHwNPDp0+/y+k9rxroDhLHRcfMHHTXZ3tpy2ZRJ738h/+c1nVnWqT0K2YQRmU7l
         OJpZh4uRXK1CgeTVs9LSJF32rlpEwyNCjGHFTiZ0CfuAWMeIHZTh2QFsq7cULZkRWe6M
         aBTh5Wh9vI1RD4rwdyhXbT1raNhsko2OvHNx3R8Un2nul5cdmv375hiQun5azcwbrVem
         I8RFZ13Th5i5oQU5gmX7o91zFQKOT/ya/sZz2QYicRe9X+BAfF3ih2UEiYshHYsovUaq
         zWdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12785-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12785-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12785-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12785-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
To: Lukas Wunner <lukas@wunner.de>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Kees Cook <keescook@chromium.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 Mathias Duckeck <m.duckeck@kunbus.de>, Nandor Han <nandor.han@ge.com>,
 Semi Malinen <semi.malinen@ge.com>, Patrice Chotard <patrice.chotard@st.com>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
 <20180317082509.GA2579@wunner.de> <20180318142327.GA23761@wunner.de>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b162140d-5c71-196b-8f1f-555fd07810df@redhat.com>
Date: Tue, 27 Mar 2018 17:37:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318142327.GA23761@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1596139726607795315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 07:23 AM, Lukas Wunner wrote:
> On Sat, Mar 17, 2018 at 09:25:09AM +0100, Lukas Wunner wrote:
>> On Mon, Mar 12, 2018 at 04:00:36PM +0100, Rasmus Villemoes wrote:
>>> On 2018-03-10 01:10, Laura Abbott wrote:
>>>> @@ -2887,14 +2909,30 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
>>>>   
>>>>   	while (i < array_size) {
>>>>   		struct gpio_chip *chip = desc_array[i]->gdev->chip;
>>>> -		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
>>>> -		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
>>>> +		unsigned long *mask;
>>>> +		unsigned long *bits;
>>>>   		int count = 0;
>>>>   
>>>> +		mask = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
>>>> +				sizeof(*mask),
>>>> +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
>>>> +
>>>> +		if (!mask)
>>>> +			return;
>>>> +
>>>> +		bits = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
>>>> +				sizeof(*bits),
>>>> +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
>>>> +
>>>> +		if (!bits) {
>>>> +			kfree(mask);
>>>> +			return;
>>>> +		}
>>>> +
>>>>   		if (!can_sleep)
>>>>   			WARN_ON(chip->can_sleep);
>>>>   
>>>> -		memset(mask, 0, sizeof(mask));
>>>> +		memset(mask, 0, sizeof(*mask));
>>>
>>> Other random thoughts: maybe two allocations for each loop iteration is
>>> a bit much. Maybe do a first pass over the array and collect the maximal
>>> chip->ngpio, do the memory allocation and freeing outside the loop (then
>>> you'd of course need to preserve the memset() with appropriate length
>>> computed). And maybe even just do one allocation, making bits point at
>>> the second half.
>>
>> I think those are great ideas because the function is kind of a hotpath
>> and usage of VLAs was motivated by the desire to make it fast.
>>
>> I'd go one step further and store the maximum ngpio of all registered
>> chips in a global variable (and update it in gpiochip_add_data_with_key()),
>> then allocate 2 * max_ngpio once before entering the loop (as you've
>> suggested).  That would avoid the first pass to determine the maximum
>> chip->ngpio.  In most systems max_ngpio will be < 64, so one or two
>> unsigned longs depending on the arch's bitness.
> 
> Actually, scratch that.  If ngpio is usually smallish, we can just
> allocate reasonably sized space for mask and bits on the stack,
> and fall back to the kcalloc slowpath only if chip->ngpio exceeds
> that limit.  Basically the below (likewise compile-tested only),
> this is on top of Laura's patch, could be squashed together.
> Let me know what you think, thanks.
> 

It seems like there's general consensus this is okay so I'm going
to fold it into the next version. If not, we can discuss again.

> -- >8 --
> Subject: [PATCH] gpio: Add fastpath to gpiod_get/set_array_value_complex()
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drivers/gpio/gpiolib.c | 76 ++++++++++++++++++++++++--------------------------
>   1 file changed, 37 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 429bc251392b..ffc67b0b866c 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2432,6 +2432,8 @@ static int gpio_chip_get_multiple(struct gpio_chip *chip,
>   	return -EIO;
>   }
>   
> +#define FASTPATH_NGPIO 256
> +
>   int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   				  unsigned int array_size,
>   				  struct gpio_desc **desc_array,
> @@ -2441,27 +2443,24 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   
>   	while (i < array_size) {
>   		struct gpio_chip *chip = desc_array[i]->gdev->chip;
> -		unsigned long *mask;
> -		unsigned long *bits;
> +		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
> +		unsigned long *slowpath = NULL, *mask, *bits;
>   		int first, j, ret;
>   
> -		mask = kcalloc(BITS_TO_LONGS(chip->ngpio),
> -				sizeof(*mask),
> -				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> -
> -		if (!mask)
> -			return -ENOMEM;
> -
> -		bits = kcalloc(BITS_TO_LONGS(chip->ngpio),
> -				sizeof(*bits),
> -				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> -
> -		if (!bits) {
> -			kfree(mask);
> -			return -ENOMEM;
> +		if (likely(chip->ngpio <= FASTPATH_NGPIO)) {
> +			memset(fastpath, 0, sizeof(fastpath));
> +			mask = fastpath;
> +			bits = fastpath + BITS_TO_LONGS(FASTPATH_NGPIO);
> +		} else {
> +			slowpath = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
> +					   sizeof(*slowpath),
> +					   can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +			if (!slowpath)
> +				return -ENOMEM;
> +			mask = slowpath;
> +			bits = slowpath + BITS_TO_LONGS(chip->ngpio);
>   		}
>   
> -
>   		if (!can_sleep)
>   			WARN_ON(chip->can_sleep);
>   
> @@ -2478,8 +2477,8 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   
>   		ret = gpio_chip_get_multiple(chip, mask, bits);
>   		if (ret) {
> -			kfree(bits);
> -			kfree(mask);
> +			if (slowpath)
> +				kfree(slowpath);
>   			return ret;
>   		}
>   
> @@ -2493,8 +2492,9 @@ int gpiod_get_array_value_complex(bool raw, bool can_sleep,
>   			value_array[j] = value;
>   			trace_gpio_value(desc_to_gpio(desc), 1, value);
>   		}
> -		kfree(bits);
> -		kfree(mask);
> +
> +		if (slowpath)
> +			kfree(slowpath);
>   	}
>   	return 0;
>   }
> @@ -2699,24 +2699,22 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>   
>   	while (i < array_size) {
>   		struct gpio_chip *chip = desc_array[i]->gdev->chip;
> -		unsigned long *mask;
> -		unsigned long *bits;
> +		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
> +		unsigned long *slowpath = NULL, *mask, *bits;
>   		int count = 0;
>   
> -		mask = kcalloc(BITS_TO_LONGS(chip->ngpio),
> -				sizeof(*mask),
> -				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> -
> -		if (!mask)
> -			return -ENOMEM;
> -
> -		bits = kcalloc(BITS_TO_LONGS(chip->ngpio),
> -				sizeof(*bits),
> -				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> -
> -		if (!bits) {
> -			kfree(mask);
> -			return -ENOMEM;
> +		if (likely(chip->ngpio <= FASTPATH_NGPIO)) {
> +			memset(fastpath, 0, sizeof(fastpath));
> +			mask = fastpath;
> +			bits = fastpath + BITS_TO_LONGS(FASTPATH_NGPIO);
> +		} else {
> +			slowpath = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
> +					   sizeof(*slowpath),
> +					   can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +			if (!slowpath)
> +				return -ENOMEM;
> +			mask = slowpath;
> +			bits = slowpath + BITS_TO_LONGS(chip->ngpio);
>   		}
>   
>   		if (!can_sleep)
> @@ -2753,8 +2751,8 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>   		if (count != 0)
>   			gpio_chip_set_multiple(chip, mask, bits);
>   
> -		kfree(mask);
> -		kfree(bits);
> +		if (slowpath)
> +			kfree(slowpath);
>   	}
>   	return 0;
>   }
> 
