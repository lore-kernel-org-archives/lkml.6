Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519830401; cv=none;
        d=google.com; s=arc-20160816;
        b=Wp3VsIFeoKEVV4YX09+qsosvDdPFsMhu59GfwFrz9asoRYTCk6nX9DooO3ifM1e/bF
         yIXNwE2ElAnTplZ47H1O4mL2rcmSUSbw46CJXqwuhD4v3j/XouY/wdDacf52P8sSO0xw
         EHvsJOckqX2PlYvTWAZzkBpas4Q+GEApMv/BPP+xDhR0SuzXZS/iYB9yJPCBNspT9Bil
         gVxdxLgQhQLmyMyhlcxvRflgV3MrFwYuZ5ieoyp7pLLAQXb6FGzYYXm0U3/y/66CZCtQ
         OcVFiaVDj9Eoe34eCFVM6/QvPqriUzUto3Y46sW7OsdIbDM3m6gBG/7cPN3BilY8liaU
         9XGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=qcIqSkPJjKwyyowbnBwa9mExkoK3r6KGY3IqavX3xwE=;
        b=nchBI5qvCGK81P0GJe4YjjSm3+hOMAof3qsxvOfAIcqWkDJWcG8hRY4RaLDNQ40F4u
         /4kZn2ULAADrjFYqzIBRKewhbXZ3O9wHtehY51Ky/Zf/yjPFVFI3D9d9/wmXQgK28le6
         QJqFuUksNlbE3MaazR6WTl1gcGeqTi2hDdlU/GLOZirh/IqTGPdk/Ono6EVK3nTWNYCf
         kB/I2F9fKelnPl3nga3+ouOLWCLYUZgKjrgLRKYmy8eBgBR+JNUIUezI191mZPdXl8vE
         7EPqJCQC/3ikYrAdHW1wJAxuFSNtWyOO1BvVqy8FKkc0OddXzAtnlT8wGr7mXBVwTb0m
         YQYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AH8x227IGDLbDXVhgisHSFE3lzpi2uxxJntBBa3HVqw0Ioxhl2nWcAJTtZfR73iI6LmbTGBX51rsNw==
Subject: Re: [PATCH v4 01/12] drivers: base: Unified device connection lookup
To: Randy Dunlap <rdunlap@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Andy Shevchenko <andy@infradead.org>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20180226183919.24353-1-hdegoede@redhat.com>
 <20180226183919.24353-2-hdegoede@redhat.com>
 <3a6850c4-7c54-c889-a7d0-347b8df65d31@infradead.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5d0084b1-77c1-ae2b-1623-a2e1bf4b0c22@redhat.com>
Date: Wed, 28 Feb 2018 16:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3a6850c4-7c54-c889-a7d0-347b8df65d31@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454017476208824?=
X-GMAIL-MSGID: =?utf-8?q?1593657683067839219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 26-02-18 20:34, Randy Dunlap wrote:
> On 02/26/2018 10:39 AM, Hans de Goede wrote:
>> diff --git a/include/linux/connection.h b/include/linux/connection.h
>> new file mode 100644
>> index 000000000000..0b4430eae53a
>> --- /dev/null
>> +++ b/include/linux/connection.h
>> @@ -0,0 +1,33 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#ifndef _LINUX_CONNECTION_H_
>> +#define _LINUX_CONNECTION_H_
>> +
>> +#include <linux/list.h>
>> +
>> +struct device;
>> +
>> +/**
>> + * struct devcon - Device Connection Descriptor
>> + * @endpoint: The names of the two devices connected together
>> + * @id: Unique identifier for the connection
> 
> Hi,
>   * @list: <description>
> is missing above.

Thanks, fixed in v5, which I'm going to send out right
away since there have been no other remarks for the last 24h.

Regards,

Hans



> 
>> + */
>> +struct devcon {
>> +	const char		*endpoint[2];
>> +	const char		*id;
>> +	struct list_head	list;
>> +};
> 
> 
