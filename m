Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AIpwx48BrBdbgznnp0Xg2g3yMa24Gp9XrRfX70qckcIxIj07yQnjkyxK/mXt43YsewxOuhjm1RjU
ARC-Seal: i=1; a=rsa-sha256; t=1524491679; cv=none;
        d=google.com; s=arc-20160816;
        b=MO0f846n9zcAMUCpjuLSU9GUOyr2/Pv2/B5TohjIOq5toBUnzGNYfLWsfXHD2+w80P
         JrWuwMCdP9mXqJAz4nVNEnCcYg1GwNwIMeZFgMIZtZxLsuu1TTuHz9TT1ukp+nY4Zw1v
         Vj8BkH/+Dn4VrDcx7/BbeQUYJdYsK8QNn52Ggo/6YwpbMZCQI3Lp6GrG3z+0/8Gk/qQh
         64jNOQeMn6DYGAUcM/cy3pJMRQ9238wj51gR+GlDy5eeCARc8hzZLYpr0wOWU8tCzaM9
         4LlJa4Y+0Ea6kJcufWrr8MNpEl5lJomHtAekOxrTHCLmP4m4EoIv49Fa3sm3jHJSKMaK
         JvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=NGDrre08kIinDK6hPGOgh/1XZ9i1LanQcIDGcNCIPH4=;
        b=lhfKJbAgdymkWvFNapW7Y3oSNUH5r70b/kuQbg2sVacg7Y+UyOnIhGxOmAJLHtzH15
         rlsrEzxPRjKhHOYdH5+5/lKvwwDhDhykzKQ0OOHjU1calV+R0L2sGdBC1t+mnmsXLOGG
         IBvW6AqoY1d3QVLQEOCRApqR592GvLHtHtkhG/sK8lYZjAZC4ymzxJRMNwaTPDHXKqE5
         nW9UHvUxeeNuyzVJP1mq9zkR4hhyW8lf/jfwUwH/af5+f0J6ZQzaUwqa5Ur16KYPmOg9
         vELXIgR4JyGXVfFOqSSwe4nCeFhgeBVEO+9iuWB3cCVQpkR/4w+UeyQP7/2NtSrBw9FV
         6YkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=H60/DAmF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FG4+MNCe;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=H60/DAmF;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=FG4+MNCe;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8DF260117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Andres Rodriguez <andresx7@gmail.com>,  linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  mcgrof@kernel.org,  alexdeucher@gmail.com,  ckoenig.leichtzumerken@gmail.com,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] brcmfmac: use request_firmware_nowait2 to load firmware without warnings
References: <20180417153307.3693-1-andresx7@gmail.com>
	<20180417153307.3693-10-andresx7@gmail.com>
	<87h8o6i36l.fsf@kamboji.qca.qualcomm.com>
	<5ADAF0A9.2090604@broadcom.com>
Date: Mon, 23 Apr 2018 16:54:32 +0300
In-Reply-To: <5ADAF0A9.2090604@broadcom.com> (Arend van Spriel's message of
	"Sat, 21 Apr 2018 10:04:57 +0200")
Message-ID: <87k1sydo4n.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008020626065507?=
X-GMAIL-MSGID: =?utf-8?q?1598545387993879850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 4/20/2018 12:26 PM, Kalle Valo wrote:
>> Andres Rodriguez <andresx7@gmail.com> writes:
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>>> index 091b52979e03..26db3ebd52dc 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>>> @@ -503,8 +503,9 @@ static void brcmf_fw_request_code_done(const struct firmware *fw, void *ctx)
>>>   		goto done;
>>>
>>>   	fwctx->code = fw;
>>> -	ret = request_firmware_nowait(THIS_MODULE, true, fwctx->nvram_name,
>>> -				      fwctx->dev, GFP_KERNEL, fwctx,
>>> +	ret = request_firmware_nowait(THIS_MODULE, true, false,
>>
>> A perfect example why enums should be in function calls instead of
>> booleans, that "true, false" tells nothing to me and it would be time
>> consuming to check from headers files what it means. If you had proper
>> enums, for example "FIRMWARE_MODE_FOO, FIRMWARE_STATE_BAR", it would be
>> immediately obvious for the reader what the parameters are. Of course
>> the first boolean was already there before, but maybe change the new
>> boolean to an enum?
>
> I can not fully agree here. While being a bit more descriptive even
> with enums wrong enum values can be used due to copy-paste errors for
> instance.

Well, you can also copy paste booleans wrong. I would claim that it's
even easier to copy paste booleans wrong than enums.

> Also when reviewing code, sometime looking up function prototypes and
> type definitions are part of the fun. Tools like ctags or elixir
> website make it pretty easy.

Hehe :) But when reviewing patches ctags doesn't really help. But yeah,
booleans vs enums in function parameters is just a matter of taste. I
prefer enums but I'm sure there are people who prefer booleans.

-- 
Kalle Valo
