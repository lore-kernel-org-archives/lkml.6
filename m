Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520972482; cv=none;
        d=google.com; s=arc-20160816;
        b=oGb/ma1CwZRF8eZ7Jgf41G9FXvuetXFrLORXDcsQrvSY3E7dv0mZGlcWDPDW7QJ7IU
         MoRuyvNJAsyw7plOMJ0kjaolOnRN5emxm5d/KY/py38g+QWc7tRTPCcwAL1iwUerfint
         7YR7OcELltYizFfUyyC4cGgHdMq3WI05kDj8D7J5t5lSxxnOJDrbhe5HMSbF0b3KN7KZ
         W1FzGLkM+iIcwZAaXxvoMK/Lbw/7tvdJg8ZlBmIHc4Il2B+p9+Rc15oR6L6aPDmYZ3ab
         PNdTKkIaBHi9h++8ia6cmiwMOIRLkT2px93YjhPilOFHgMr1AwNv10jKy5XOfzsXx3q6
         D7tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=QjYXVaQeRW6mGGBj1XnRydVpqMkAfhJDwI5xjJiCvAo=;
        b=MYaVuIhF5oFRHH+Lz2AJpF5PuXR/NaplNaEkUZP9S8BPuzmqh6T4kjn71X5N8Xc6Z6
         qAOaU6w7KJexOrPMVcE84hoEaIyyOBGJa7kKPgf9DP9inwu21s9fO0XikFQ1hJc9Pf85
         elj9opv4a054uy5mISzotJnF/7nE11f9UYvS3SF/C2rTMRkhxpc9Q0JEZkvwMF4vn7jl
         +9uxoiR9KjIX+UEe99UOXTuOuXnB8UGE0luYn2nHHGIkITAOv0Q219jQPFzByYzrBEuD
         riTY8HZdYhBThOOFodevAlV1QUv6bRHAKTI9s5zkrm7BRw6a+3qQ+54D578kmfgdb5+s
         V44A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=B4G7i3kP;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=B4G7i3kP;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELs0RQLn4NMijHXDg7MY0jNxbGY1oTY8Mqs0VZm5q8UVlPABdcYoyQTn7gFwzydFhtj5SR3DGA==
Subject: Re: [2/3] mwifiex: support sysfs initiated device coredump
To: Marcel Holtmann <marcel@holtmann.org>
References: <1519210220-22437-3-git-send-email-arend.vanspriel@broadcom.com>
 <20180312094115.2E1C1606DB@smtp.codeaurora.org>
 <5AA67616.2000602@broadcom.com> <87efkoazow.fsf@kamboji.qca.qualcomm.com>
 <5AA829A1.1090209@broadcom.com>
 <24B25258-E680-490C-B7FF-D34CEBBA8566@holtmann.org>
Cc: Kalle Valo <kvalo@codeaurora.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA832B7.2010007@broadcom.com>
Date: Tue, 13 Mar 2018 21:21:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <24B25258-E680-490C-B7FF-D34CEBBA8566@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593007398864870404?=
X-GMAIL-MSGID: =?utf-8?q?1594855242349738191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/13/2018 9:19 PM, Marcel Holtmann wrote:
> Hi Arend,
>
>>>>>> Since commit 3c47d19ff4dc ("drivers: base: add coredump driver ops")
>>>>>> it is possible to initiate a device coredump from user-space. This
>>>>>> patch adds support for it adding the .coredump() driver callback.
>>>>>> As there is no longer a need to initiate it through debugfs remove
>>>>>> that code.
>>>>>>
>>>>>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>>>>>
>>>>> Based on the discussion I assume this is ok to take to w-d-next. If that's not
>>>>> the case, please let me know ASAP.
>>>>
>>>> It is up to the mwifiex maintainers to decide, I guess. The ABI
>>>> documentation need to be revised and change the callback to void
>>>> return type. I am not sure what the best approach is. 1) apply this
>>>> and fix return type later, or 2) fix return type and resubmit this.
>>>> What is your opinion?
>>>
>>> I guess the callback change will go through Greg's tree? Then I suspect
>>> it's easier that you submit the callback change to Greg first and wait
>>> for it to trickle down to wireless-drivers-next (after the next merge
>>> window) and then I can apply the driver patches. Otherwise there might
>>> be a conflict between my and Greg's tree.
>>
>> That was my assessment, but unfortunately Marcel already applied the btmrvl patch before I could reply. So how do I move from here? Option 1) revert brmrvl and fix callback return type, or 2) apply mwifiex patch and fix callback return type later for both drivers.
>
> I can take the patch back out of bluetooth-next if needed. It is your call.

Thanks, Marcel

Let's go for that. Please revert/remove the patch.

Regards,
Arend
