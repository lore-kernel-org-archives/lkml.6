Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521145244; cv=none;
        d=google.com; s=arc-20160816;
        b=aQ1dI59WBgMGkJeTdPhYQODrOfJdp3XT0hbe7/VITiOJVS5GgTXAMmI2MnvkS6IoZw
         V8dxDrMRyx/nDoyYiUJaSP+tlrOcPYJH4sbRReDYrroKp6dLTtMoBulhQG7jyl64Neoj
         nLv8B1RbAQzlh2yWM4pAQBCZpqjN6EIlNRfYYleysldUYCIFNIrxdkKxFATUAUKuljLB
         TJq+mx8BrOehAKbSsR98NgGXCkSCwmbNIgb9D+c0alsLiMz2n2HUexvzAWQ++12vK8KD
         NeV4AcATej6+TpZNHqveSyTjnXhhVE3IIV8vK2rZ93D4o0BOBGyLTAXmwdsKmYAQvlzK
         Q/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=35SdAnsAJVDqIlmLJsH4UBvDkHec4eo/S9iSQiao5x4=;
        b=btTTOLqidNMGh34I9BFnS8tu28qA0kyD9k/l7hY7xHE/h9P5lNypKCSFgavoKpPXoW
         bfsPen3fEq2ifnh7+bXOOdzKPjH8QGNtxwabStayBCSAkfLCZBlijp+AQGBTKqk3aCCU
         zh0uKZorQE5jHQu3ItdZ6GpNwAlM82u02AqswVWMk3rGcVYRyPhRQNtPar6SHrW+m0Dc
         RmSlBNeoqyEqmhySlv4n7eCA0HfjfKsQrHxOgimKBprMhmY6qFIoO+MR1xIWVT36H+QY
         RpkeubFmjvFHsCdevss43sa/FnXk1k9ydrtVzb5Xn/wkCcK6sTfM73jPopPWNFXcvzQp
         9/9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=Pkz2RrzC;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=Pkz2RrzC;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELufESghMC79NY1Zi/2PBGhn040E2L4O4Eyv3GLXSwHuC4N9VMSfu4HnVlTQi8KFavsU4ATnFw==
Subject: Re: [PATCH for-4.16 1/3] sysfs: improve devices-coredump description
 with user-space perspective
To: Brian Norris <briannorris@chromium.org>,
 Arend van Spriel <aspriel@gmail.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
 <1521107725-25027-2-git-send-email-aspriel@gmail.com>
 <20180315170459.GA120116@rodete-desktop-imager.corp.google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Johannes Berg
 <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AAAD59B.7060503@broadcom.com>
Date: Thu, 15 Mar 2018 21:20:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180315170459.GA120116@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067406689415?=
X-GMAIL-MSGID: =?utf-8?q?1595036395565858373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/15/2018 6:05 PM, Brian Norris wrote:
> On Thu, Mar 15, 2018 at 10:55:23AM +0100, Arend van Spriel wrote:
>> Instead of referring to kernel internals, describe the ABI from user-space
>> perspective to clarify what can be expected when using it.
>>
>> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
>> ---
>>   Documentation/ABI/testing/sysfs-devices-coredump | 14 +++++++++-----
>>   1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-coredump b/Documentation/ABI/testing/sysfs-devices-coredump
>> index e459368..d5a4c75 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-coredump
>> +++ b/Documentation/ABI/testing/sysfs-devices-coredump
>> @@ -2,9 +2,13 @@ What:		/sys/devices/.../coredump
>>   Date:		December 2017
>>   Contact:	Arend van Spriel <aspriel@gmail.com>
>>   Description:
>> -		The /sys/devices/.../coredump attribute is only present when the
>> -		device is bound to a driver, which provides the .coredump()
>> -		callback. The attribute is write only. Anything written to this
>> -		file will trigger the .coredump() callback.
>> +		When present the /sys/devices/.../coredump attribute can be used
>> +		to trigger a coredump of the device. The coredump contents are
>> +		device driver specific and thus vary. The coredump attribute is
>> +		writeonly. Anything written to this file will trigger creation
>> +		of the coredump. When the coredump is made available under
>> +		/sys/class/devcoredump it will generate a uevent. When the
>> +		coredump can not be successfully generated no ueven will occur.
>
> s/ueven/uevent/

crap. I mean: Thanks ;-)

>>
>> -		Available when CONFIG_DEV_COREDUMP is enabled.
>> +		Available when CONFIG_DEV_COREDUMP is enabled and the device
>> +		driver supports coredump generation.
>
> What about /sys/class/devcoredump/disabled? Maybe we just need a
> sysfs-class-devcoredump too, now that there's a formal method for
> triggering devcoredumps.

I am not sure about this. Not my daily routine so I can use some 
opinions here. Not that yours does not count, but I would like to be 
sure before respinning.

Regards,
Arend
