Return-Path: <vivek.gautam@codeaurora.org>
X-Google-Smtp-Source: AIpwx484vGfs2wzVo2zLimL+EViP7HBb0EsDzAdHIMQek/n0rHyYJdFYFg3xRAvFyHEQn/JcP7Hz
ARC-Seal: i=1; a=rsa-sha256; t=1522751726; cv=none;
        d=google.com; s=arc-20160816;
        b=Iiq7Riv5bjU34yq4tLftwWw5EfV7MavW3nlIPWnlI5AiTW7Yh29TquFuYn8EmJt71X
         2tSEtWpaezFbNP+dGiArdd9MXY8z3SfJ/SlmuYbX0QqxWZkgBQTQ+7dyqA65bCGu6Wf2
         WXrzbRixMIZyNOjT95MEu304rG1BVWtsBH/WNiLyBccgCZJoilxfvTD6AQB1BXGW9OOk
         oHWcRrvT1HcnwutOUKHR0QAQtAWMZA0Qmm1Uh5Egr7Ti2sy1qaaasJe7U/zQ8FOMNcTo
         DSzsMU9vq76dkJUkpcbg0WbsvF5tSaH3LvBYEVkuRwT/4Phf41UN0QPDG8l4Jvv0W41U
         ZGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=khe7Z6zOZ28aMaLfxydyFnNuh36+HV1OA2hiSFP7UAw=;
        b=0gMzBJxl0vuEzBudX4Jwxqqs0OJG4JtKnNj6fBe7d+XBhBqVYCpg+pHrTvcua7pJ5n
         TB/0BDWqSz/8AZpZnMyJ0x4LcN9E3Pn226nShANkMvg4ditstQrz6TGarNOdQL5Ioh6t
         sF89EBV1Ep+CUBm/4XgyoTal9tLu/9ugw57UTsZgva7ooj5O7jNot4+GE5YXrf4zBzGu
         gnosXY3BwOZnSvV2DkUSOczd52paHF0SzBaMqdvZPCgcA00OnKiE4pK6+nk24k2VB+jp
         YuXiQWekIlNpCDLp939kUxCYTYxW+vwa97IpcY/u6ZuTsGaWgtRFUGy+up/UNudzzp0h
         Id+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cXvp3a1e;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cXvp3a1e;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cXvp3a1e;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cXvp3a1e;
       spf=pass (google.com: domain of vivek.gautam@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vivek.gautam@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82EAA60807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH] usb: dwc3: of-simple: use managed and shared reset
 control
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, linux-usb@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <balbi@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com>
 <1522742421.5089.1.camel@pengutronix.de>
 <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
 <1522745178.5089.10.camel@pengutronix.de>
 <CAK7LNAQ8ySPxyetOU_m5Sjrzb_4PTsVkZd0KzH7cVmq3yJtWcQ@mail.gmail.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <adf0ab8f-2808-8772-76c5-b4a3075557c4@codeaurora.org>
Date: Tue, 3 Apr 2018 16:05:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ8ySPxyetOU_m5Sjrzb_4PTsVkZd0KzH7cVmq3yJtWcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596251133980885597?=
X-GMAIL-MSGID: =?utf-8?q?1596720914140764892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 4/3/2018 3:49 PM, Masahiro Yamada wrote:
> 2018-04-03 17:46 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>> On Tue, 2018-04-03 at 17:30 +0900, Masahiro Yamada wrote:
>>> 2018-04-03 17:00 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
>>>> On Thu, 2018-03-29 at 15:07 +0900, Masahiro Yamada wrote:
>>>>> This driver handles the reset control in a common manner; deassert
>>>>> resets before use, assert them after use.  There is no good reason
>>>>> why it should be exclusive.
>>>> Is this preemptive cleanup, or do you have hardware on the horizon that
>>>> shares these reset lines with other peripherals?
>>> This patch is necessary for Socionext SoCs.
>>>
>>> The same reset lines are shared between
>>> this dwc3-of_simple and other glue circuits.
>> Thanks, this is helpful information.
>>
>>>>> Also, use devm_ for clean-up.
>>>>>
>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>> ---
>>>>>
>>>>> CCing Philipp Zabel.
>>>>> I see his sob in commit 06c47e6286d5.
>>>> At the time I was concerned with the reset_control_array addition and
>>>> didn't look closely at the exclusive vs shared issue.
>>>>>   drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
>>>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
>>>>> index e54c362..bd6ab65 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>>>>> @@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>>>>        platform_set_drvdata(pdev, simple);
>>>>>        simple->dev = dev;
>>>>>
>>>>> -     simple->resets = of_reset_control_array_get_optional_exclusive(np);
>>>>> +     simple->resets = devm_reset_control_array_get_optional_shared(dev);
>>>>  From the usage in the driver, it does indeed look like _shared reset
>>>> usage is appropriate. I assume that the hardware has no need for the
>>>> reset to be asserted right before probe or after remove, it just
>>>> requires that the reset line is kept deasserted while the driver is
>>>> probed.
>>>>
>>>>>        if (IS_ERR(simple->resets)) {
>>>>>                ret = PTR_ERR(simple->resets);
>>>>>                dev_err(dev, "failed to get device resets, err=%d\n", ret);
>>>>> @@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>>>>
>>>>>        ret = reset_control_deassert(simple->resets);
>>>>>        if (ret)
>>>>> -             goto err_resetc_put;
>>>>> +             return ret;
>>>>>
>>>>>        ret = dwc3_of_simple_clk_init(simple, of_count_phandle_with_args(np,
>>>>>                                                "clocks", "#clock-cells"));
>>>>> @@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>>>>   err_resetc_assert:
>>>>>        reset_control_assert(simple->resets);
>>>>>
>>>>> -err_resetc_put:
>>>>> -     reset_control_put(simple->resets);
>>>>>        return ret;
>>>>>   }
>>>>>
>>>>> @@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
>>>>>        simple->num_clocks = 0;
>>>>>
>>>>>        reset_control_assert(simple->resets);
>>>>> -     reset_control_put(simple->resets);
>>>>>
>>>>>        pm_runtime_put_sync(dev);
>>>>>        pm_runtime_disable(dev);
>>>> Changing to devm_ changes the order here. Whether or not it could be a
>>>> problem to assert the reset only after pm_runtime_put (or potentially
>>>> never), I can't say. I assume this is a non-issue, but somebody who
>>>> knows the hardware better would have to decide.
>>>
>>>
>>> I do not understand what you mean.
>> Sorry for the confusion, I have mixed up things here.
>>
>>> Can you describe your concern in more details?
>>>
>>> I am not touching reset_control_assert() here.
>> With the change to shared reset control, reset_control_assert
>> potentially does nothing, so it could be possible that
>> pm_runtime_put_sync cuts the power before the reset es asserted again.
>>
>>> I am delaying the call for reset_control_put().
>> Yes, please disregard my comment about the devm_ change, that should
>> have no effect whatsoever and looks fine to me.
>>
>>> If I understand reset_control_put() correctly,
>>> the effects of this change are:
>>>    - The ref_count and module ownership for the reset controller
>>>      driver will be held a little longer
>>>    - The call for kfree() will be a little bit delayed.
>> Correct.
>>
>>> Why do you need knowledge about this hardware?
>> Is it ok to keep the reset deasserted while the power is cut?
>> Or do you
>> have to guarantee that drivers sharing the same reset also keep the same
>> power domains active?
>>
> If this were really a problem, the driver would have to check
> the error code from reset_control_assert().

Just to understand this - If the power domain isn't active for the said 
device,
does it matter if it is in reset state or not?

>
>
>   ret = reset_control_assert(simple->resets);
>   if (ret)
>             return ret; /* if we cannot assert reset, do not allow
> driver detach */

What's the point of this. The power domain and reset should be independent
of each other, and when we are doing a driver detach, the state of hardware
should be of less concern.
The device should anyways not leak power when the power domain isn't active.

Regards
Vivek
>
>   pm_runtime_put_sync(dev);
>   pm_runtime_disable(dev);
>   return 0;
>
>
>
> What I can tell is, the current situation is
> blocking hardware with shared reset lines
> from using this driver.
>
>
>
