Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx4+8fGupr4iAQg31/Y/NPyEcgYPTE8LG/c0HOIWzb69nJFH8PpRIerbrZWfFLNE0SNfMAkY0
ARC-Seal: i=1; a=rsa-sha256; t=1523971034; cv=none;
        d=google.com; s=arc-20160816;
        b=blqHomOAhwrKC++S7t0ipxavwP7VOAwXEWksAHznS3RvwMFMAJ4sbFhSR+fNporkZF
         /rNXp7RUvgY4UDTFk1wIsgBJWDHe2Vyj8bPITUoIQptKh7p46Ld1alqCDQI7aCfTJ2rB
         fR1oU698Nwu3OmjExT07UmZWjdnTe+RHeSk91vZhvOkFDJ6LXyywcMhnik4CwxTsJXRn
         ao8J7i976k2OATd/BgyYnmqNVxoWFi15UQyDrnmbdF+PLNMlCT0dsbZBuh6/NFYgEPfN
         Tb751mdv4X2ILCz5ppAUtT88KJkxGF0zMng73uYUJADMMSYkd57IGVE74a/q4I5XSTWW
         nLpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=z5OGqMAPMPsUgkDKH8vzWqa0thinCBp4Onnjxl+EWP8=;
        b=xMcok8LLJHcRC16CVzgREJsFu2IAyy5oLOBW9lfLMOu6mWTS0Te8ieIgq97DDk0E0g
         gco8nmxpYOKEBoX7duLwrSpa6WR/uBtQevKfr0FelkEmdTXZUe/7VzHY9sw3uaHR8AKA
         fmGZ+xBDZm4EmtPTfATX2T1mZjcjcUm/suCzIX/Vxr8y/AZYbkPgO5RdTDVSbxw1HAsu
         GiFxCLErtLzr6CqTy+PNkzxatWjSmDUiUNZESujK59cqR8h6UbSMjXd7RG3M8IFEpB/B
         Qw5+cO56kqBIsEdJwKGCvyGdCZa5MA/b57E2kmsd3HivcLIt0KemegrDrKz0GjURIYte
         cdlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF24D2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <53ff5b2b-eba8-8311-64a9-abd4bc72226d@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com> <20180416181035.rcjvt4rlrwaj5yxf@rob-hp-laptop>
 <53ff5b2b-eba8-8311-64a9-abd4bc72226d@linux.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 17 Apr 2018 08:16:52 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+1wC-KhXPeCSNhCeCih6=CatJbyumO51ucD17Rt7qofw@mail.gmail.com>
Message-ID: <CAL_Jsq+1wC-KhXPeCSNhCeCih6=CatJbyumO51ucD17Rt7qofw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1597999452039853256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 6:12 PM, Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
> On 4/16/2018 11:10 AM, Rob Herring wrote:
>>
>> On Tue, Apr 10, 2018 at 11:32:06AM -0700, Jae Hyun Yoo wrote:
>>>
>>> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
>>> AST24xx/25xx SoCs.

[...]

>>> +- clocks            : Should contain clock source for PECI controller.
>>> +                     Should reference clkin.
>>> +- clock_frequency   : Should contain the operation frequency of PECI
>>> controller
>>> +                     in units of Hz.
>>> +                     187500 ~ 24000000
>>
>>
>> This is the frequency of the bus or used to derive it? It would be
>> better to specify the bus frequency instead and have the driver
>> calculate its internal freq. And then use "bus-frequency" instead.
>>
>
> I agree with you. Actually, it is being used for operation frequency setting
> of PECI controller module in SoC so it's different from the meaning of
> "bus-frequency". I'll change it to "operation-frequency".

No, now you've gone from a standard property name to something custom.
Why do you need to set the frequency in DT if it is not related to the
interface frequency?

Rob
