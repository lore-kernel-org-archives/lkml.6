Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FF6C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404A920844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN1no42G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404A920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeKIIOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:14:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40341 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeKIIOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:14:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id x2-v6so5878637pfm.7;
        Thu, 08 Nov 2018 14:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+7uZPQYocoTPdOPW2eoFZLEqZhkxc+dH2lz4oOyhp4M=;
        b=tN1no42GAjLXzfztj5qMVZfeG8gkYm7TXQTYSLFhB3uqMqFqKTYvJIVGhqTUjOlcc1
         4SayLluQHiZmizXDFitFE1t0c5zr36/gEL4TW03uIcgNhlxYaTe8xOt3h7Zo3hQQjTPn
         5hHb4Xa/8lVqC+8BzoQB18ztCAd7AxVCCRxdjAMId957DJ0KyjwKJNi5Zx0K7ydBBj8n
         +6YSbhv0R9o71Z09v1iXpS8F0qkar8M1kCM1eyEXAlUwaWz/wPQlidhkBt2D18cor1zD
         c612DrZDDAzK/eIvRWWWaJ3zFrj8FdnKDh+l38gN6eh9mIUTzM3WPZJnkx477UYOBF4p
         e81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+7uZPQYocoTPdOPW2eoFZLEqZhkxc+dH2lz4oOyhp4M=;
        b=m/diziX+T0IAnk90h/SwcOcYNOnEa052Bebl2vCG7Pj5rHYfNwv0exkBy3wjysPr91
         UKgkLr9zgEF8YGSJNDjkvn8+CqBVahyCOngJazeQtQmtGDcUcYZY+te+wMzBJzUeBWKs
         76dJQI8YCZsRBHCMeIZt2dPLAhzduMtIOKnyno9mB9RtKPBIOK1hg6BvMklEcFbQzHvx
         qEbhxd18jZrvRi3DfRqmT7RxG8kJA8t9QyMLKl6/kXLhUXXg9pKO74ahgYn5KXZ3B+K8
         VOmega4yF9acyKTt6CebqlYIKnhmcIrIf7QvtkhVUOFGhFdbpcBG+RjnkiYZAo2pUQEQ
         r/fg==
X-Gm-Message-State: AGRZ1gJJll3G5EoGIgPtILiX4VHrCnyzdvIXj/tmrYe+RcmUjePSy5G1
        DE7wbHby0vmpwuGj/hTMk5s=
X-Google-Smtp-Source: AJdET5elbb17djo8orxV/Gg5zZDEnPl2q0OERwTSs10Zt1EpXA1HovaQDDRxPboe1krSKUGujJhEeA==
X-Received: by 2002:a62:3384:: with SMTP id z126-v6mr6502109pfz.112.1541716616762;
        Thu, 08 Nov 2018 14:36:56 -0800 (PST)
Received: from [10.67.49.62] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 27-v6sm7540415pfm.36.2018.11.08.14.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 14:36:56 -0800 (PST)
Subject: Re: [PATCH stable 4.9] posix-timers: Sanitize overrun handling
To:     Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        stable@vger.kernel.org, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <1541102558-14839-1-git-send-email-f.fainelli@gmail.com>
 <6341cf9e-b2aa-9447-88e9-ad89ab42a641@gmail.com>
 <alpine.DEB.2.21.1811080747450.1666@nanos.tec.linutronix.de>
 <20181108154625.GC8097@sasha-vm>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <0fabf89c-9452-3e14-6e47-69ca3e28c9e9@gmail.com>
Date:   Thu, 8 Nov 2018 14:36:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108154625.GC8097@sasha-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/18 7:46 AM, Sasha Levin wrote:
> On Thu, Nov 08, 2018 at 07:48:16AM +0100, Thomas Gleixner wrote:
>> Florian,
>>
>> On Wed, 7 Nov 2018, Florian Fainelli wrote:
>>> On 11/1/18 1:02 PM, Florian Fainelli wrote:
>>> > From: Thomas Gleixner <tglx@linutronix.de>
>>> >
>>> > [ Upstream commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 ]
>>> >
>>> > The posix timer overrun handling is broken because the forwarding
>>> functions
>>> > can return a huge number of overruns which does not fit in an int.
>>> As a
>>> > consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
>>> > random number generators.
>>> >
>>> > The k_clock::timer_forward() callbacks return a 64 bit value now. Make
>>> > k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
>>> > accounting is correct. 3Remove the temporary (int) casts.
>>> >
>>> > Add a helper function which clamps the overrun value returned to
>>> user space
>>> > via timer_getoverrun(2) or siginfo::si_overrun limited to a
>>> positive value
>>> > between 0 and INT_MAX. INT_MAX is an indicator for user space that the
>>> > overrun value has been clamped.
>>> >
>>> > Reported-by: Team OWL337 <icytxw@gmail.com>
>>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> > Acked-by: John Stultz <john.stultz@linaro.org>
>>> > Cc: Peter Zijlstra <peterz@infradead.org>
>>> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>>> > Link: https://lkml.kernel.org/r/20180626132705.018623573@linutronix.de
>>> > [florian: Make patch apply to v4.9.135]
>>> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> > ---
>>> > Thomas, can you review for correctness? Thanks!
>>>
>>> Thomas, John, does that look like a reasonable backport for 4.9?
>>
>> Looks correct.
> 
> Queued for 4.9, thanks all.

Thanks, the same patch should be applicable to earlier kernel versions
as well with little to no hunks. At least I applied it as far back as
4.1 so far. I could provide a patch for earlier kernels that did not
have the file renaming.
-- 
Florian
