Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AG47ELs2VRWU0KFdCO5cn8OJbylsDXDJv7BM5fJqvNB66wFnPo69lYpsKIKxlpKT+w430+e5QE3F
ARC-Seal: i=1; a=rsa-sha256; t=1521017331; cv=none;
        d=google.com; s=arc-20160816;
        b=fz29026D3zqi8EPAxiCXFhBwd2DCjb9PgRNyFqvJ4FVDeJjEgUdbbA9Oa1otlKieCe
         /w9u2MR8eD4mC3mw8gu5C6DfZFsXuIbjj3WRetTAKyH8f0xcN1WQa+4YK42R+3w7B2Rs
         kDrgRFBa0JeYZI7QmWAw0jPl3AeZvvcOfOblV8Ct06FC7gNaJj0jto4xPq8bAYJbpEx+
         BwaouNqx9MqQ6BUK9NR+aUCQKjMunWmPyt3dMgMtVRWO+EntIgxphUJ8XOOA9JyWsJcC
         qq0M0anHQa7jFciJrTnm73RWhgWo/Y//N98TAlHt1wO9wqaiDKgPduPV8ZI+iu3ahFGx
         cNYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=qecmmof22t4YrS6vrWcdiFg4T9ctEFvWE925ODv0wm8=;
        b=o6XklLSJNIs3/gXpF4E+1zb46b/9/lwLD/bHLaEtuuUker9tIk5tB3Ohuuerab5B4L
         +Y9dgxXw8FaV1EOaS+RBmBOYmwu/3csDToQhbnaIes6g/PcFFV6puw+oCzykAmmybU2z
         Og4Jesf9Gr5Oagw/hFYe07fw/xMMYgjiYLTJIb2wg52oPjV/6eqdORZ1V+qUFaytnMAf
         Wdf44z0Do0kw+Hc4X39kDHKMy2w9n7ByPjYCnabkMsXjJIwDclEmOs/zABsdb31SHvE5
         3g+vovoSuNxO0nsRdt1UxziEkIPBq7c717wVO8v+gIlwacHUW3P9NmO3btRrMT95/g/o
         066A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ooNvhnEQ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ooNvhnEQ;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ooNvhnEQ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ooNvhnEQ;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 609B06081A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,  Andres Rodriguez <andresx7@gmail.com>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
References: <20180309221243.15489-2-andresx7@gmail.com>
	<20180309230925.3573-1-andresx7@gmail.com>
	<CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
	<87a7vcazf1.fsf@kamboji.qca.qualcomm.com>
	<20180313164026.GG4449@wotan.suse.de>
	<87fu53apod.fsf@kamboji.qca.qualcomm.com>
	<5AA8DC29.2000806@broadcom.com>
Date: Wed, 14 Mar 2018 10:48:46 +0200
In-Reply-To: <5AA8DC29.2000806@broadcom.com> (Arend van Spriel's message of
	"Wed, 14 Mar 2018 09:24:09 +0100")
Message-ID: <87vadz6o0h.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594902269915059527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 3/13/2018 5:46 PM, Kalle Valo wrote:
>> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
>>
>>> On Tue, Mar 13, 2018 at 03:16:34PM +0200, Kalle Valo wrote:
>>>> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
>>>>
>>>>>> +/**
>>>>>> + * request_firmware_optional: - request for an optional fw module
>>>>>> + * @firmware_p: pointer to firmware image
>>>>>> + * @name: name of firmware file
>>>>>> + * @device: device for which firmware is being loaded
>>>>>> + *
>>>>>> + * This function is similar in behaviour to request_firmware(), except
>>>>>> + * it doesn't produce warning messages when the file is not found.
>>>>>> + **/
>>>>>> +int
>>>>>> +request_firmware_optional(const struct firmware **firmware_p, const char *name,
>>>>>> +                         struct device *device)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       /* Need to pin this module until return */
>>>>>> +       __module_get(THIS_MODULE);
>>>>>> +               ret = _request_firmware(firmware_p, name, device, NULL, 0,
>>>>>> +                               FW_OPT_UEVENT | FW_OPT_NO_WARN );
>>>>>> +       module_put(THIS_MODULE);
>>>>>> +       return ret;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(request_firmware_optional);
>>>>>
>>>>> New exported symbols for the firmware API should be EXPORT_SYMBOL_GPL().
>>>>
>>>> To me the word optional feels weird to me. For example, in ath10k I
>>>> suspect we would be only calling request_firmware_optional() with all
>>>> firmware and not request_firmware() at all.
>>>>
>>>> How about request_firmware_nowarn()? That would even match the
>>>> documentation above.
>>>
>>> _nowarn() works with me. Do you at least want the return value to give
>>> an error value if no file was found? This way the driver can decide
>>> when to issue an error if it wants to.
>>
>> Yes, it would be very good to return the error value to ath10k. That way
>> we can give a proper error message to the user if we can't find a
>> suitable firmware image.
>
> I fully agree with the _nowarn() and returning an error. However, the
> firmware_p parameter (btw. do we really want the _p postfix?)

Oh yeah, that _p is ugly. Please get rid of it, hungarian notation is
awful.

> is an output parameter which will be null in case of an error so do
> you really need a specific error code for the proper error message.

Sometimes the error code helps with debugging. But let's ask it this
way: why would we NOT return an error code? What would we gain from
that? I don't see any advantage from dropping the error code, on the
contrary better to be consistent with request_firmware() to avoid any
confusion.

-- 
Kalle Valo
