Return-Path: <kernel-hardening-return-12482-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELucNNiqA/p79/Pe+1LtVdUNvKei4FvC5E/04bSE0mYHttz/Cr5gkifEAOuEJphU5MLTWvqA
ARC-Seal: i=1; a=rsa-sha256; t=1520898072; cv=none;
        d=google.com; s=arc-20160816;
        b=NXU4J/3VnDgiZeT0MJZhN4sIhzRWlHwAu5sKi7i13av9/S+6wyQlsCkWyZI+NT1cTt
         Aogs9Rd2lxGYpEbIPiNMoE0NIgZxj+qxjJLaXaYVdJmH5/6pbGyBnfKKnZwKkfMullpS
         s1dp+BUgMnRgauoz9isWV2ma7uuyI0ExpFu8O879Gs5k2+rbv9ibd5xMo4fg4fDDQV3x
         Rz/IT2dpEd+pvcOWRBb/YfsEUQp0G9jUIzyiPGdN7spOdrAqUYBDbcW7Rw53C4EffteZ
         2u2JMNiQK13g1w2BdqW1Y6QWuYsBXwJ0XeJdtHG6aTC4NKCAt2lq3Dj5uyU7Ql7RWBS1
         5roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Ra8RzQ6NF3WoJWHoLHJZC52OVd80crpXYQfrAlX5uo8=;
        b=Tt8+1nOY96kZO9AYwCJlk+Mbesd3C3R5ohk5CRiC5dEVfs6g4r0MMvEg3EWq3rPDSD
         b6KlBy1qU1Q0TfpRGI5IEdBJl9EY6aJtr+Mh4PSX0xzihCAbPelYZAzLhMeF7ZrTaqSI
         pAYetTSD1yIUUQMnvweZ4BfNeRj07XMZj30qF1Mhqj3HrlKbQapuUUgNRth9uuxTx2tg
         lv9yAe2cf3dMk+5wASQnETDX06420AFtQNflcg+RwyS07Ob044lF62WLe1EKgvy+6uQI
         sjiGLrhCQtWsyBZu0hr9n39ThWSAW2luLXuy6mpm8NqewZPFy6yWMLceVQiznpqoybac
         /37w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12482-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12482-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12482-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12482-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/4] gpio: Remove VLA from gpiolib
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com, Lukas Wunner <lukas@wunner.de>,
 Mathias Duckeck <m.duckeck@kunbus.de>, Nandor Han <nandor.han@ge.com>,
 Semi Malinen <semi.malinen@ge.com>, Patrice Chotard <patrice.chotard@st.com>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-2-labbott@redhat.com>
 <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <301ecaf7-62a4-14af-3a5b-7bd76a49c4f6@redhat.com>
Date: Mon, 12 Mar 2018 16:40:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a758ce3f-fed7-2ecf-94c5-ba133ea75bde@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507304079648871?=
X-GMAIL-MSGID: =?utf-8?q?1594777217264723663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/12/2018 08:00 AM, Rasmus Villemoes wrote:
> On 2018-03-10 01:10, Laura Abbott wrote:
>>   		/* collect all inputs belonging to the same chip */
>>   		first = i;
>> -		memset(mask, 0, sizeof(mask));
>> +		memset(mask, 0, sizeof(*mask));
> 
> see below
> 
>> @@ -2887,14 +2909,30 @@ void gpiod_set_array_value_complex(bool raw, bool can_sleep,
>>   
>>   	while (i < array_size) {
>>   		struct gpio_chip *chip = desc_array[i]->gdev->chip;
>> -		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
>> -		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
>> +		unsigned long *mask;
>> +		unsigned long *bits;
>>   		int count = 0;
>>   
>> +		mask = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
>> +				sizeof(*mask),
>> +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
>> +
>> +		if (!mask)
>> +			return;
>> +
>> +		bits = kmalloc_array(BITS_TO_LONGS(chip->ngpio),
>> +				sizeof(*bits),
>> +				can_sleep ? GFP_KERNEL : GFP_ATOMIC);
>> +
>> +		if (!bits) {
>> +			kfree(mask);
>> +			return;
>> +		}
>> +
>>   		if (!can_sleep)
>>   			WARN_ON(chip->can_sleep);
>>   
>> -		memset(mask, 0, sizeof(mask));
>> +		memset(mask, 0, sizeof(*mask));
> 
> Hm, it seems you're now only clearing the first word of mask, not the
> entire allocation. Why not just use kcalloc() instead of kmalloc_array
> to have it automatically cleared?
> 

Bleh, I didn't think through that carefully. I'll just switch
to kcalloc, especially since it calls kmalloc_array.

> Other random thoughts: maybe two allocations for each loop iteration is
> a bit much. Maybe do a first pass over the array and collect the maximal
> chip->ngpio, do the memory allocation and freeing outside the loop (then
> you'd of course need to preserve the memset() with appropriate length
> computed). And maybe even just do one allocation, making bits point at
> the second half.
> 

I was trying to make minimal changes and match the existing code. Is this
likely to be an actual hot path to optimize?

> Does the set function need to be updated to return an int to be able to
> inform the caller that memory allocation failed?
> 

That would involve changing the public API. I don't have a problem
doing so if that's what you want.

> Rasmus
> 

Thanks,
Laura
