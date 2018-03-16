Return-Path: <mats.dev.list@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521206983; cv=none;
        d=google.com; s=arc-20160816;
        b=ssYwTB0vMWEjVibOcRcfisbCJS4Qejwhg5lA7KcdqgKs4Je3S6MdBhdgQx3hv4ePZg
         5EAhd8l/F31mbjmFZyEENsnFaxINnhSADAViO6w3uEfJFcWRZmT/zKCL45BNfVBI47Ig
         Sk31ELqTHNp1k/TATFU/lwUJKUfGfDgEMTPxQUXK0qwU+qQ7Syu5HYhHWecmelGTIGJz
         Gh2CEb7M4bfKQHF4dPIYae7qvYAZm9vxVNgJ0pg2ZZr5P1AgHGDYCzum5qlepJy9c6mh
         f7akTU6JSIZZUTTaLHZuPXpWoB8qMvibYogUudVCXjzc1f+H4lNDEGCNI2E23Vz2jJ+f
         rDwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=vqP/S08UUb/jktyBhBWtXenIUVNepIYmkclrp0jMuww=;
        b=wzsALyoeGUpNyFfdGeVi+AAvKI/bl4Iq7rClsqhV+BjtIf0faPSRrmfmOoFc0e9e1s
         Qz4dNFVofnKEh34g6nzWBslj5Oh6qaOv61pj3LRH3Z/xQa8NWyTTiLNSmLjNxfyLLhFq
         H3MDYplDfM7eDmNrtGlx3A9YkmQMFjElbgyGLmD4dipahPMlaNfm6qfMiN1O5u84GxAn
         BDA7hzWnKlFPUdF4BDLwGTR9Br9BNe+yFInLvsq+qenBY7gSgUtJrQ/DF+DYpNcgsMI7
         KAW5pKIJBbzHBH8G7hBQofb+mjEf35BsNLezlcOQGeuCaQxApK1GwIHS3haU/EX7rFsx
         4Igg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sfKrJviC;
       spf=pass (google.com: domain of mats.dev.list@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mats.dev.list@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sfKrJviC;
       spf=pass (google.com: domain of mats.dev.list@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mats.dev.list@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvdBe7ZfAQU3PgUXZI1ys/V+hdcHvA/m2xrATQ7YqCLGLmI7afD48as4DjGpssRmdbp6QONng==
Subject: Re: [PATCH] staging: typec: rt1711h typec chip driver
To: Greg KH <gregkh@linuxfoundation.org>, ShuFan Lee <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux@roeck-us.net,
 shufan_lee@richtek.com, cy_huang@richtek.com, jun.li@nxp.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <1521191569-21221-1-git-send-email-leechu729@gmail.com>
 <20180316125811.GB22994@kroah.com>
From: Mats Karrman <mats.dev.list@gmail.com>
Message-ID: <aa838cdd-6333-68fc-0ead-8ad9e7fd8ff9@gmail.com>
Date: Fri, 16 Mar 2018 14:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316125811.GB22994@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595101134568694264?=
X-GMAIL-MSGID: =?utf-8?q?1595101134568694264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018-03-16 13:58, Greg KH wrote:

> On Fri, Mar 16, 2018 at 05:12:49PM +0800, ShuFan Lee wrote:
>> From: ShuFan Lee <shufan_lee@richtek.com>
>>
>> Richtek RT1711H Type-C chip driver that works with
>> Type-C Port Controller Manager to provide USB PD and
>> USB Type-C functionalities.
>> Add definition of TCPC_CC_STATUS_TOGGLING.
>>
>> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
>> ---
>>   drivers/staging/typec/Kconfig         |   8 +
>>   drivers/staging/typec/Makefile        |   1 +
>>   drivers/staging/typec/tcpci.h         |   1 +
>>   drivers/staging/typec/tcpci_rt1711h.c | 344 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 354 insertions(+)
>>   create mode 100644 drivers/staging/typec/tcpci_rt1711h.c
> This looks nice and simple to me, any reason it has to live in
> drivers/staging/ and we can't just move it to drivers/usb/typec/ now?
>
> Or are there still api things that need to be resolved with the existing
> drivers/staging/typec/ code?

For one thing it depends on the tcpci driver that is still in staging until Jun Li's patches, [1], comes through.

// Mats

[1] https://marc.info/?l=linux-usb&m=152093458605648&w=2

> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
