Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx48XKq9/I8j8sqP/CYZaMv4bIV85hqzOBAekbd6VLyQjYCLJzRDb57fc+zJy/fLe2KOalLSB
ARC-Seal: i=1; a=rsa-sha256; t=1524505255; cv=none;
        d=google.com; s=arc-20160816;
        b=quMsnyUIjOMs9RgMXsbE3LLekdHL+ljAyKW1fYoLsvDELlyJwGXxfKUvko3fksOFqK
         mSSBVIARKK6mHqRwKQ5+FmY3xu8iQE7/EFKHUBBGxxJGlf/i+KS/ei+hO0e3O1HQKjw+
         i3qkHN5fZPtsIvbvT0B5SxyPhYMVtTJgJ2ABh9nELc2cWcj06TSoWF4+FY2K+P+uZvdk
         PmgTLZ7PWMhmIiqOR3Bk/8P+UZ5a8kmFVf3W+P2ZLVjW0sqpUOObZNTVJlDMF1fzYPjX
         gCLXiotjMfYqL80ngfnq8YYJHPc/qrARuAWGmJxULmF6QKxg9tN9d+m++QNwj5c6UtaT
         m0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=0f8hq3D17kk2xP0TsQO3PJjCT90JiIqQvQ7lNElFTYQ=;
        b=hRNE9KOWuCrZCl8uqw9d7ypj5bzfsjT8xEjjaNmgqKLiGyvfAEwuE42K+XRckB1Hrb
         6sVt1YjNSJUxplxpLEgLWLiQ7eNldUUWDZQB0TE7t+IQ/EYJ6JGsTY9sBnUgOqp41vMq
         urRurg5sqMNtOU0m4k7ncwDEJYGPs9VPD7/MkV5Rd6VAwfeXcjyLmQCShOwDe/+UhVzx
         iW1sUQyy0cChVS1vhGfjod1X60TASC+1MUZdwu5QcT9PeugvucRpQMSGR3Y45MEm63WV
         plewPai+wV+saPc22rc7oFsdPSSnZvU5fO4SPP+4oBJT+BGmSTvgXtNgb/eBMNolM6KO
         ujxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,319,1520924400";
   d="scan'208";a="53015049"
Subject: Re: [PATCH v3 03/10] drivers/peci: Add support for PECI bus driver
 core
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck <linux@roeck-us.net>,
 Haiyue Wang <haiyue.wang@linux.intel.com>,
 James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
 <20180423105224.GA1444@kroah.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <09b1a8af-4d47-0714-8f68-d7fe35cc7a72@linux.intel.com>
Date: Mon, 23 Apr 2018 10:40:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180423105224.GA1444@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135111000345?=
X-GMAIL-MSGID: =?utf-8?q?1598559622627533013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/23/2018 3:52 AM, Greg KH wrote:
> On Tue, Apr 10, 2018 at 11:32:05AM -0700, Jae Hyun Yoo wrote:
>> +static void peci_adapter_dev_release(struct device *dev)
>> +{
>> +	/* do nothing */
>> +}
> 
> As per the in-kernel documentation, I am now allowed to make fun of you.
> 
> You are trying to "out smart" the kernel by getting rid of a warning
> message that was explicitly put there for you to do something.  To think
> that by just providing an "empty" function you are somehow fulfilling
> the API requirement is quite bold, don't you think?
> 
> This has to be fixed.  I didn't put that warning in there for no good
> reason.  Please go read the documentation again...
> 
> greg k-h
> 

Hi Greg,

Thanks a lot for your review.

I think, it should contain actual device resource release code which is
being done by peci_del_adapter(), or a coupling logic should be added
between peci_adapter_dev_release() and peci_del_adapter().

As you suggested, I'll check it again after reading documentation and
understanding core.c code more deeply.

Jae
