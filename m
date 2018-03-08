Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520519487; cv=none;
        d=google.com; s=arc-20160816;
        b=kc7WiIgQmBC97nt93FhF33VIUx5P6xXPtMypFJ0YeTKTe5+VRBUDYlkHsUxxWNbzuW
         tTROEFG9JWw2TIVZ6yFDquxqv3igh5r7EgQEj83XbRZ9xzzPk2v2n/OygSUY+NweOBcH
         yjCWr+VXwJuRdNKXmZakDiVSWnXs5DCMknVd31kVNJK0XB/yNAvl14c2tS5tofKPH5Pi
         y2JIxJqTKfKY4KK52xY0fUImwHU51FvyonNryr0Xtn2Zj6LaKv9As/zdNz7+1YShzFYO
         rlC09nzAE1oVmkcB+/RWhWNa4GWwZGtW7VPNx8z6AC+YcC432Shuqg8dkiNWdtyAbqHz
         JM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=EhMSOyPt0j50HSQlPtq+UTCKLccPuKAUxDLCcyANLTo=;
        b=zFEQGQVM2qsZ9iHXOy7vmTcJA89JF8ycG/xtPv+OnB/mDzBNTnsBqy/Ankzh6znaXr
         x/u/35SUk347H5oq+ig+OGvzTiTaFCxWhngOcTBaea1991fayqRqoaR/8SXWaAp3fa9A
         +43myOi1vL2iTpA1KSkq0PEbW/2PTr2GX0Ss6USGepbdVtTdJs4XBcK+XrNq4GfFdVOd
         HHgo8lqB/Rm82ny+RStOP7D7l+iGrzmg/CBECWS1wgjegl3s2moa1uHYmf6zPfPeg28Z
         Up1LzXuKddcoENphXKuyUBjKEerIqkxCnW/thpKOajzxwmCce8sBUW4CJBUcWoSTi7Jj
         F3Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Se1FD3BT;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Se1FD3BT;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELvkZ0/GvyAFfnVrhd7W0Utul9pD7jzYRlJyK2YqAyWR1L03CL22yL1KJBJCVjQ98RNalQ2x9A==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
To: Laxman Dewangan <ldewangan@nvidia.com>,
 Rajkumar Rampelli <rrajk@nvidia.com>, Mikko Perttunen <cyndis@kapsi.fi>,
 robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, jdelvare@suse.com, corbet@lwn.net,
 catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org,
 gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com,
 mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org,
 andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org,
 heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
 <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
 <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
 <2628eff2-dd33-34f4-a7e1-cfe46ef88a3f@nvidia.com>
 <4556a8d2-947d-72c4-2962-3167afb53978@kapsi.fi>
 <62ba7f67-5a99-51ab-1214-eb68ebb7e642@roeck-us.net>
 <952cb50e-d9a0-ae5e-d9f6-d1ce268f0384@nvidia.com>
 <f7818e4c-17b6-c58b-3424-85749bb9c1cc@roeck-us.net>
 <5bffef40-a4a7-5f7d-a448-b2a381c57822@nvidia.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d4e745a6-5534-662e-f6d5-a91bf580f550@roeck-us.net>
Date: Thu, 8 Mar 2018 06:31:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5bffef40-a4a7-5f7d-a448-b2a381c57822@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1594380242245425989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/2018 10:06 PM, Laxman Dewangan wrote:
> 
> 
> On Wednesday 07 March 2018 07:50 PM, Guenter Roeck wrote:
>> On 03/07/2018 01:47 AM, Rajkumar Rampelli wrote:
>>>
>>>>
>>>> While I am not opposed to ABI changes, the merits of those would need to be
>>>> discussed on the mailing list. But replacing "fan1_input" with "rpm" is
>>>> not an acceptable ABI change, even if it may measure something that turns
>>>> but isn't a fan.
>>>>
>>>> If this _is_ in fact supposed to be used for something else but fans, we
>>>> would have to discuss what that might be, and if hwmon is the appropriate
>>>> subsystem to measure and report it. This does to some degree lead back to
>>>> my concern of having the "fan" part of this patch series in the pwm core.
>>>> I am still not sure if that makes sense.
>>>>
>>>> Thanks,
>>>> Guenter
>>> I am planning to add tachometer support in pwm-fan.c driver (drivers/hwmon/) instead of adding new generic-pwm-tachometer.c driver. Measuring RPM value will be done in pwm-fan driver itself using pwm capture feature and will add new sysfs attributes under this driver to report rpm value of fan.
>>
>> There is an existing attribute to report the RPM of fans. It is called fan[1..n]_input.
>>
>> "replacing "fan1_input" with "rpm" is not an acceptable ABI change"
>>
>> Preemptive NACK.
> 
> The RPM is measured speed via PWM signal capture  which is output from fan.
> So should we have the fan[1..n]_output_rpm?
> 

No. I hear you clearly that you for some reason dislike fan[1..n]_input.
While ABIs are not always to our liking, that doesn't mean that we get
to change them at our whim. If that is not acceptable for you, I can't
help you. And you can't change inX_input to inX_voltage either, sorry.

Guenter
