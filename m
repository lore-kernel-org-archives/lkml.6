Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx48QqkA0Eq9GsAIQOlzRNj/ELyKDpKeKZAOguj6RhlUAKQ8ytS2sG9gen7RwncclEDxlRKM6
ARC-Seal: i=1; a=rsa-sha256; t=1524060020; cv=none;
        d=google.com; s=arc-20160816;
        b=t5zkvFdw6R+NIT2naztkP7Lu3K3849bcIz4AbzIDB3KOGXohOw6r2RKJnVV4z/h5Lg
         bkyC+TU8KtItjyRGGgLzYpYHZfkD7PimMPmzx8hnrZtumOZKq3nTcqV4ul/A665AemAr
         DOoU59bGCqEAqj22DVstnSaIaAsqrblSSYAeJ9IaNEtvu4c1nAdOurqM8Ahf0y+6Lrs8
         P1oP3gVMeZMYoI6mRE78AXOWB/cFHT3J0xw+TgUZ3BYq4CJ06OKCOvHxnqGZ2A6bj6Xu
         tNaXbobNyClG2rNJph/xivyJZoWfyiXy6caiQ78V76fV4f3UPMMpFMpNoMVu7xnJz9hn
         8FUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=QV8OBVE2ZGDOuo/9hJOKtyDm0MqCtyTyLh0LitxN1yc=;
        b=WDdo2vRbqQhodId0yhUSa5AC/wcHqt7/QnX9ZKOlESF+8osqgCvvOPBPAW1BCK8oN+
         hxnKmVuCFPHwPuqAr4Om+DdhhuYvfVvFYZmPpxDLwBEw7MNc2xph/aXonIyStz8jaiAO
         /u5i+kJ8My6pHfgRlxD7/zdXGcPOMumSdbF5VQliXbZ0Q9iAnnoqDhcoUZ51BOzAFNHU
         6xYtTJVPJHFQuV6D3ZYZVP0J1zW87+VQu2fefvuKKsEqlG4/YKId+iemL9YrsO7o0X6e
         9uYaFKopyuV3Z+wZd/q+PlZNoBh+S8cgYU/N/e7+1Nu/O01M9Z8QSgWnwArAiLBSKUFx
         0xDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FF62183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <584aca6c-c87a-ff7a-2fdc-3c742236be60@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com> <20180416181035.rcjvt4rlrwaj5yxf@rob-hp-laptop>
 <53ff5b2b-eba8-8311-64a9-abd4bc72226d@linux.intel.com> <CAL_Jsq+1wC-KhXPeCSNhCeCih6=CatJbyumO51ucD17Rt7qofw@mail.gmail.com>
 <f07623c4-5f0c-4ab1-f761-44bd702bbdf0@linux.intel.com> <584aca6c-c87a-ff7a-2fdc-3c742236be60@linux.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Apr 2018 08:59:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+9YDv04Gu=WODdqb6wD4fk6=-fFw_3skU79UC8OW0jZA@mail.gmail.com>
Message-ID: <CAL_Jsq+9YDv04Gu=WODdqb6wD4fk6=-fFw_3skU79UC8OW0jZA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>, Jean Delvare <jdelvare@suse.com>,
	Joel Stanley <joel@jms.id.au>, Julia Cartwright <juliac@eso.teric.us>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Milton Miller II <miltonm@us.ibm.com>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, Linux HWMON List <linux-hwmon@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135853793781?=
X-GMAIL-MSGID: =?utf-8?q?1598092759767768228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 5:06 PM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> On 4/17/2018 11:16 AM, Jae Hyun Yoo wrote:
>>
>> On 4/17/2018 6:16 AM, Rob Herring wrote:
>>>
>>> On Mon, Apr 16, 2018 at 6:12 PM, Jae Hyun Yoo
>>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>>
>>>> On 4/16/2018 11:10 AM, Rob Herring wrote:
>>>>>
>>>>>
>>>>> On Tue, Apr 10, 2018 at 11:32:06AM -0700, Jae Hyun Yoo wrote:
>>>>>>
>>>>>>
>>>>>> This commit adds a dt-bindings document of PECI adapter driver for
>>>>>> Aspeed
>>>>>> AST24xx/25xx SoCs.
>>>
>>>
>>> [...]
>>>
>>>>>> +- clocks            : Should contain clock source for PECI
>>>>>> controller.
>>>>>> +                     Should reference clkin.
>>>>>> +- clock_frequency   : Should contain the operation frequency of PECI
>>>>>> controller
>>>>>> +                     in units of Hz.
>>>>>> +                     187500 ~ 24000000
>>>>>
>>>>>
>>>>>
>>>>> This is the frequency of the bus or used to derive it? It would be
>>>>> better to specify the bus frequency instead and have the driver
>>>>> calculate its internal freq. And then use "bus-frequency" instead.
>>>>>
>>>>
>>>> I agree with you. Actually, it is being used for operation frequency
>>>> setting
>>>> of PECI controller module in SoC so it's different from the meaning of
>>>> "bus-frequency". I'll change it to "operation-frequency".
>>>
>>>
>>> No, now you've gone from a standard property name to something custom.
>>> Why do you need to set the frequency in DT if it is not related to the
>>> interface frequency?
>>>
>>> Rob
>>>
>>
>> Actually, the interface frequency is affected by the operation frequency
>> but there is no description of its relationship in datasheet. I'll check
>> again about the detail to ASPEED chip vendor and will use
>> 'bus-frequency' if available.
>>
>
> I investigated it more deeply. Basically, by the spec, PECI bus speed
> cannot be set as a fixed speed. A PECI bus can have a wide speed range
> from 2Kbps to 2Mbps which is dynamically set by a handshaking sequence
> between an originator and clients called 'timing negotiation' in spec.
> This timing negotiation behavior happens on every single transaction so the
> bus speed also can vary on every transactions. So I'm thinking a custom
> property name for it, 'peci-clk-frequency' if it is acceptable.

Okay, seems bus-frequency is not appropriate here. So use
'clock-frequency' (note the '-' not '_' as that is the standard
property).

Rob
