Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519897528; cv=none;
        d=google.com; s=arc-20160816;
        b=Civ1EiiaZrIR/9Xg2yOku0ImQLfUh8tqmbcP+AYoPlSFICfo+ykOTyg9/otZW15WzK
         RFF4n+uEnLL9rew7XyC8wyc0ANniD57ANHjolyIu1joHtVeZSsN0bKW3Zotd0wGi35NC
         0spXALgCgoSIHABRW35jVzYwxarALyRMIAQAYrMN3+iFvJERmpvYmnltJ27SCQT13Wel
         EXfTbAncdqLXfgyPhichNXkN4VBnMQ6C8FiTZYdOkmNtmBnSAj7okQU39nRVQ2cy5n9p
         kncSqFVOUeTOnQhW2bAfJc3rchoGiWEVBAY9AVhlbMPcUh5bRAt+sMcKN/fGDlXPqZHK
         AXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=gP08Yu0Ii5PvoP274QBIv9aym6lKsMaiXh2RlBhqrGc=;
        b=AUOxNguGU2pYK57GUxptNf7t6/9HM4TjTDq5u9qA04rzg9Auit0txFxeMJLz6A51ln
         x14ZWxi4B0zXX3kG8/RpvJ6IO4RCwI1Pw4q4TLiOhk18dcmZuBPmERbMYK3SiDiNDSWf
         MJrDe/c8UaX0NKju0qNfESYCfdnifFGzKDpNkO1xG1xjSY11vZTudu/8KVZD0UEFhKM/
         GiOavZsQiUwk3lYBma/6ZmCAivgQ/yUGWFEN8FgCVngv9FeqJ0hAXXKLgttZc+WDhOcI
         hPWHgJUHLfzVTqt05iLil6DJcjjswMdH36jdaoVekoDG/m1pwt8Q+hI7KxCBdYHH8VMP
         4bKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELuSioQnfKWqvCT+vdLUhEBOG3wRUwPLyTYQ2Hnc6TXf5LnrQ+nfkEdcEbYeO5fh0LUI6c/OrQ==
Subject: Re: [PATCH v5 01/12] drivers: base: Unified device connection lookup
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Jun Li <jun.li@nxp.com>, Darren Hart <dvhart@infradead.org>,
 Andy Shevchenko <andy@infradead.org>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20180228150749.26831-1-hdegoede@redhat.com>
 <20180228150749.26831-2-hdegoede@redhat.com>
 <VI1PR0402MB3917DD93F114873CC736117389C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
 <20180301072825.GC5335@kuha.fi.intel.com>
 <CAHp75Vc4CF_Vn90FdFKwBf7egPNHvEWa=mja8w4SarKaW2KZRw@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <bcf738d9-0bcb-42f8-d706-c2e72a150720@redhat.com>
Date: Thu, 1 Mar 2018 10:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc4CF_Vn90FdFKwBf7egPNHvEWa=mja8w4SarKaW2KZRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454017476208824?=
X-GMAIL-MSGID: =?utf-8?q?1593728070136740022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 01-03-18 10:32, Andy Shevchenko wrote:
> On Thu, Mar 1, 2018 at 9:28 AM, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
>> Hi,
>>
>> On Thu, Mar 01, 2018 at 12:56:57AM +0000, Jun Li wrote:
>>>> +struct device *device_find_connection(struct device *dev, const char
>>>> +*con_id) {
>>>> +   return __device_find_connection(dev, con_id, generic_match, NULL); }
>>>
>>> -       return __device_find_connection(dev, con_id, generic_match, NULL);
>>> +       return __device_find_connection(dev, con_id, NULL, generic_match);
>>
>> Good catch!
> 
> It seems I proposed to put function first parameter followed by opaque
> data pointer for it.
> In that case it would be exactly like now.

Yes, but as mentioned I decided to keep it as is, so this is really a bug,
will fix for v6.

Regards,

Hans
