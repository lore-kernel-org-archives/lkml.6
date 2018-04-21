Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AIpwx48UK4ar34jTaIHq3SEbLnaLdiv7I1YRo1eWSd1PLqRUi0rKqWE5ZN5RgS7Uqcfon+r665Jv
ARC-Seal: i=1; a=rsa-sha256; t=1524295187; cv=none;
        d=google.com; s=arc-20160816;
        b=Vp2RZuxXMJQKuG1KPo0MigLx1yo2c64MtKVCCd+a+eDKOEkCA0SwZcyke0wyuz3FZh
         dlpi4nSQTk89pcMMioyR+JGxXmubsQHlSb+LLbL503uDQ52oIV664KHQf2GOuImjV/5f
         JgWznAWCfJu5Nqw70C8AIOhTkce3tTp5zSWnVww5/FK/yyRI5oUAYPrMtSPI5onLLEGx
         OPC8oBG6hHMII+MwDB1cEHrWLjM4GGoIiiflpVOut/+4mT19FBg4veSpFF2Qmv8YkkA0
         HffMyLpa8Qv8yi38sgiY6CpY4iVCQVD4ewmfuDEjeW81KVPNaJXNn8T3HC81i8IMgIbz
         FRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=V6GcmckNlJFYkeA7D46UCHdm8BW+DQJ2cYKNH/BTP5M=;
        b=A47BkJpUY7VkCeeRvOGf320/zcbyr2DJMEAuDGQFQSfSsOZ8+OHmJNTyd9bW2JN84W
         HRnEUofpbxp75nTDenKQKCONjVKMOfxiu6yZHS1nrcT6w6C0SIp9tMAJ0uldFJ13xA/R
         EHIUwOh+ffHVYoCiGfvZ8TJZfpNQ0FTyH4OWONb2gUa47WMpFoi4yvO3tzQipTJZlvRp
         davLlZo8hhRebOSY8Ou9QHTsFbmI2GWPB4YL0TWHpsHws9JiuQU31skp4Wk84EUTugc3
         mWs68nckMu9jyKj/PiZxDkecoPR08sqaRsUYHgG55x8mWjKOJL5hN5cZCf6+BrXVxpJ5
         0WjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mTqBrG1A;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mTqBrG1A;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mTqBrG1A;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mTqBrG1A;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BCB9602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  mcgrof@kernel.org,  alexdeucher@gmail.com,  ckoenig.leichtzumerken@gmail.com,  arend.vanspriel@broadcom.com,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] brcmfmac: use request_firmware_nowait2 to load firmware without warnings
References: <20180417153307.3693-1-andresx7@gmail.com>
	<20180417153307.3693-10-andresx7@gmail.com>
	<87h8o6i36l.fsf@kamboji.qca.qualcomm.com>
	<65954790-8579-66ee-9b67-d44e18b4abb3@gmail.com>
Date: Sat, 21 Apr 2018 10:19:42 +0300
In-Reply-To: <65954790-8579-66ee-9b67-d44e18b4abb3@gmail.com> (Andres
	Rodriguez's message of "Fri, 20 Apr 2018 15:33:36 -0400")
Message-ID: <87efj9f2lt.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008020626065507?=
X-GMAIL-MSGID: =?utf-8?q?1598339349984202730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andres Rodriguez <andresx7@gmail.com> writes:

>>> +				      fwctx->nvram_name, fwctx->dev,
>>> +				      GFP_KERNEL, fwctx,
>>>   				      brcmf_fw_request_nvram_done);
>>>     	/* pass NULL to nvram callback for bcm47xx fallback */
>>> @@ -547,7 +548,7 @@ int brcmf_fw_get_firmwares_pcie(struct device *dev, u16 flags,
>>>   	fwctx->domain_nr = domain_nr;
>>>   	fwctx->bus_nr = bus_nr;
>>>   -	return request_firmware_nowait(THIS_MODULE, true, code, dev,
>>> +	return request_firmware_nowait2(THIS_MODULE, true, false, code, dev,
>>>   				       GFP_KERNEL, fwctx,
>>>   				       brcmf_fw_request_code_done);
>>>   }
>>
>> Also the number two in the function name is not really telling anything.
>> I think that something like request_firmware_nowait_nowarn() would be
>> better, even if it's so ugly.
>>
>
> The 2 is meant to signify that this is an new version of the api with
> different parameters.

Ah, I missed that. I didn't have time to review your patches in detail,
just looked at the wireless patches.

> I don't think we need to codify into the name what the new parameters
> mean (mostly because when a 2 version of an api is implemented, usage
> of the original version tends to be discouraged).

Yeah, makes sense now.

-- 
Kalle Valo
