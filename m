Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522329145; cv=none;
        d=google.com; s=arc-20160816;
        b=LcwJWrFU6ksrZLE9hUW4N66yA41ephtn0UyQH1nZCUfrMgTNNMQrq0KE64w+nspYdF
         6Xo/c23VR4TQtEI2wvdqfI2j0gFIEuimnhPO/wEj8nSrJL4Ymr7y1jErSFjDHHWhAnwF
         diCudNC129pSrbxnfLN7cFEAMz+/mDZ7yYC30ChJqb3gM8pq6yqEzfmjRuiVn7+p9Q02
         VpZ/dxefDb3kAY0azQoIW4DNbnmiNItiAXXmQpqixXQ6Cj8gIRzbaTjcZYe93GfKT+UE
         1DW6+P9vNI3uKxubasfIUsXY3kr2T0ZegHHxNLepP1tsklBKU6h9FYwdNvw+2plnc8Ob
         y/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=QB9IDM8P7RJtdHiysDp3qiJuygQlx+uDrqhH6zFfX2k=;
        b=l2J2pXMccTQQXuQz977BsI9hkKUAbgAUdppZfKzEAkcyxQHUKh7ecmWl5LiXQY0ZUI
         JfkN6ews2vNDom7ePi9N1O5+3KZyjZzmxoy02KXbkVa64H0JT4TRlAgXEfxZJdNqHxCt
         pJODfD60mEJPl1fw7oH+P+Kj74MkMKqk66j9Y+UAwfRPXrXcmPrgehwqQqjp3ylQKcg0
         UhRaUidMlyQDNpJYzEjdx9L0k/+NWXPk4PfeLTP3S7VThV5fB/DT6vmg9E6D0ZH/0uf+
         Es2hH+iNURLDSMiC43P/9V5AC76XYQL9+gSrz1th7UO4Qc9gMzSQJ58FEfA4G/K0z0hs
         o49w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx48pfPprjaj/EJ7M3d9jU8YL5Dc+KSfSUF18xelnaZ8koRqmGlBvlH5O4b/Q666q7QxKaCLCxA==
Subject: Re: [PATCH 1/3] virt: vbox: Add vbg_req_free() helper function
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Thayer
 <michael.thayer@oracle.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20180329112116.26488-1-hdegoede@redhat.com>
 <20180329115517.GA6734@kroah.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <ba390b90-eb1f-0b28-61a5-97dd9dd90e34@redhat.com>
Date: Thu, 29 Mar 2018 15:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329115517.GA6734@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596270815677103806?=
X-GMAIL-MSGID: =?utf-8?q?1596277805679623277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 29-03-18 13:55, Greg Kroah-Hartman wrote:
> On Thu, Mar 29, 2018 at 01:21:14PM +0200, Hans de Goede wrote:
>> --- a/include/linux/vbox_utils.h
>> +++ b/include/linux/vbox_utils.h
>> @@ -33,6 +33,13 @@ __printf(1, 2) void vbg_debug(const char *fmt, ...);
>>    */
>>   void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
>>   
>> +/**
>> + * Free a request allocated by vbg_req_alloc()
>> + * @req:		Request to free.
>> + * @len:		Length, must be the same as the value used for alloc.
>> + */
>> +void vbg_req_free(void *req, size_t len);
>> +
> 
> Why is this in vbox_utils.h and not exported?  Shouldn't you just put
> this in drivers/virt/vboxguest/vboxguest_core.h?

I put it in include/linux/vbox_utils.h because that is where its
counterpart vbg_req_alloc() lives. But you're right that neither
is used outside of the vboxguest module, so I will move vbg_req_alloc()
to vboxguest_core.h for v2 and also put the new vbg_req_free() there.

Regards,

Hans
