Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520970148; cv=none;
        d=google.com; s=arc-20160816;
        b=lyrRtClkW6xnrZgIzI7hUxmtTNl+gJ0zZZR3FQOnRsQt62HKOojjs/OlvO26bULIPo
         oA4qcQ+1vK/dL0XPKjRJW/eyxAyyCIcqwbT/2JUz5liznZIPnoex/zt9BleP8yCbfO0N
         Z6JERLlyks0pm9FpDwE8tsphDChhQUk1pfE5oybsgZYAHIvgNZjiXvnUHEjz3XwKy2DS
         CjKfhaLZhA2YzHT7p8z7NhN3Ai0YGa5KktU4eXCVmBAZvtZYYYrjYXzeTM4jvxa2okUU
         H1IoOR6GJCUVRo7llag8D9yX3ApzbpNPdyYR5aPtFwewzEyd5cUqw6+D74Q7zofBor1M
         DKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=ah6XUmiz8deGNXT0Zw+ruGJzNaDbYvdIYKCHqyE0tGc=;
        b=ctCVQtMsXgNAFWmD1Xjxoi7hbRF7iN8F089hOq+aFHPi3sZwiGUn8Jr+juQZngcFPA
         lnOPBpGTC/yRLEBrLNLpVrCZC3vr8ZJfeVlgr4l0mncEEZ0SlFHAT5i64D75pfGpx09n
         kwcjS8Jo6zEtULRP9IBbOScC0kfBcC7BahjnJq5kLg4OyKPEB9FVW7A0ngnPB2Ug9WXd
         TwSg8Bp6R8O6pq8t8ah+XQx3LPpvm7dR6HNkWkHWQDI4bQyf9K5JVbUEI3+ubhqGwCG4
         5SKHiXry+2DeREj9pcQwjeSe1aDnWU4vm/AOS+oVRBRMW1jDdS+hHz/xVtkG7iS3Visk
         o7AA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=RPo0h+sQ;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=RPo0h+sQ;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELtUs6E8jP8Abi46fmY6NjBVFOTwrlEsOY8zcpKD1XzBX2i1MB47VHA9NXaOk+IuHEx05LrAQA==
Subject: Re: [2/3] mwifiex: support sysfs initiated device coredump
To: Kalle Valo <kvalo@codeaurora.org>
References: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
 <20180312094115.2E1C1606DB@smtp.codeaurora.org>
 <5AA67616.2000602@broadcom.com> <87efkoazow.fsf@kamboji.qca.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wireless@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA829A1.1090209@broadcom.com>
Date: Tue, 13 Mar 2018 20:42:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <87efkoazow.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1594852794103914138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/13/2018 2:10 PM, Kalle Valo wrote:
> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>
>> On 3/12/2018 10:41 AM, Kalle Valo wrote:
>>> Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:
>>>
>>>> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
>>>> it is possible to initiate a device coredump from user-space. This
>>>> patch adds support for it adding the .coredump() driver callback.
>>>> As there is no longer a need to initiate it through debugfs remove
>>>> that code.
>>>>
>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>
>>> Based on the discussion I assume this is ok to take to w-d-next. If that's not
>>> the case, please let me know ASAP.
>>
>> It is up to the mwifiex maintainers to decide, I guess. The ABI
>> documentation need to be revised and change the callback to void
>> return type. I am not sure what the best approach is. 1) apply this
>> and fix return type later, or 2) fix return type and resubmit this.
>> What is your opinion?
>
> I guess the callback change will go through Greg's tree? Then I suspect
> it's easier that you submit the callback change to Greg first and wait
> for it to trickle down to wireless-drivers-next (after the next merge
> window) and then I can apply the driver patches. Otherwise there might
> be a conflict between my and Greg's tree.

That was my assessment, but unfortunately Marcel already applied the 
btmrvl patch before I could reply. So how do I move from here? Option 1) 
revert brmrvl and fix callback return type, or 2) apply mwifiex patch 
and fix callback return type later for both drivers.

Regards,
Arend
