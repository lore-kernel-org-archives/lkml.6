Return-Path: <arend.vanspriel@broadcom.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521106375; cv=none;
        d=google.com; s=arc-20160816;
        b=MR2/HLQsjMT+YSDoGxIslng70PYre7jvO2nksLEJGVrD5nn5QccHpfgIXWAPzD6/Pv
         bTtaGLOKrpUm2azHJvjiZ6NK3tICmWCMvy2fjtRSa00SZPyge3us2UJUOP1wtvdWZHRk
         y/n9+X3TjA0njs3iT3f0v0i96h0+tPXy+UW/wnCjwF8EJ68vJ3KZ16bu+pcMWCrRlcOV
         JxqHlk56TaicEenQUSsSMUXafT09r7oz5Xq0sn3CW5EXDVdOHw2158iIGZ8TAl1vMsLC
         YP0Pkyvo7KwOqI4RX4KDeWyJIMEGLsh5Md+n2wAFJIxGUi9HumeyVWIG4Sbmjj0I7w+I
         ckyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=pC1C55+tqSHU3Zv58a5kbGr2ukA4fkbokXDqkfOQ2fM=;
        b=JAlJ3Y9gZCT5/PVjpVbs40rQs8z+sWzCPfW7YmvWqfWV0Q5i7QeIqDGV89fz+xhq1I
         NgynuAPxh86Cj8y9S9S19JYW7H6j+wVmArvUWQ/ahadM9o0QH+LCPGoSvrrQULR7qVEi
         Vl2RzpwbsrXsdrS35cHNPKJBjA9PI3fhrtnwuptLJ/48//tZpaWGq+Fbi5/2LjXkjSK+
         zA75fHQjky37VAHjPbYYX/6bJp5NcKmi8ZOX346fvC2VpfAWjubsoB7XFLRlPM5dRtX5
         mr3uqyUgLdAzpIcGvFjoKj2IbThJzDQsE3MCrvMJef+ZpPmbv6rDLqQuunN0HLsc0mus
         nk1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=N0ZAWri7;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=N0ZAWri7;
       spf=pass (google.com: domain of arend.vanspriel@broadcom.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arend.vanspriel@broadcom.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
X-Google-Smtp-Source: AG47ELu/0YVQwvGK77xuQGkpQK6hB9LD3sWwF//z7888jsNL6Noi8xp8nHM7RxLmMotHWxm81yNQNA==
Subject: Re: [PATCH] drivers: base: add description for .coredump() callback
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1518167637-1948-1-git-send-email-aspriel@gmail.com>
 <5AA8E61F.9090500@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AAA3DC5.4070101@broadcom.com>
Date: Thu, 15 Mar 2018 10:32:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <5AA8E61F.9090500@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914160440023159?=
X-GMAIL-MSGID: =?utf-8?q?1594995638650201208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/14/2018 10:06 AM, Arend van Spriel wrote:
> On 2/9/2018 10:13 AM, Arend van Spriel wrote:
>> Commit 3c47d19ff4dc ("drivers: base: add coredump driver ops") added
>> a new callback in struct device_driver, but not a kerneldoc description
>> so here it is.
>
> Hi Greg,
>
> Revisiting the header file I notice this patch is not yet applied. I am
> pretty sure I got an automated email from you regarding the merge
> window, but nothing else so did this one slip the cracks?

Hi Greg,

As I am touching this in follow-up patch, can we just drop this one? I 
will be posting a couple of new patch assuming it is fine to drop this. 
Let me know how you want to handle this.

Regards,
Arend

> Regards,
> Arend
>
>> Fixes: 3c47d19ff4dc ("drivers: base: add coredump driver ops")
>> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
>> ---
>>   include/linux/device.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index b093405..0b32a42 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -256,6 +256,7 @@ enum probe_type {
>>    *        automatically.
>>    * @pm:        Power management operations of the device which matched
>>    *        this driver.
>> + * @coredump:    Called through sysfs to initiate a device coredump.
>>    * @p:        Driver core's private data, no one other than the driver
>>    *        core can touch this.
>>    *
>>
>
