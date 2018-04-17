Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AIpwx4+iRAAK9CFeRJVJy/9xB6Ql6k86Y/riBCgGDCLrPmW6Km6iu0QBLFEBQ33iKujn3XoXZoX3
ARC-Seal: i=1; a=rsa-sha256; t=1523972256; cv=none;
        d=google.com; s=arc-20160816;
        b=b9hG9+wIRABm3o4IUuLyGt0eN/2L8Q17GI2Dz66scggMP6tOoBbA3gNuRLiGdTbkGK
         GZPuVP8AaZwyWwgpBCLmHOLHxAvyA5924LMHweiNIVJSmP1mddLuuCH0mEyZGwODgJ69
         mXqY2djsZIRra2WvQx9g0Cdusz7EzRm0wd86hSYbYF/b+ua6ASxFIJ/sGMARlTgwTVaP
         ZfqmW0g/TJPwved8WsK0C+9oKrz94TtGf8I5b4LDBMOON0mkYIqBVHuUrbiXSdukZVGz
         GtRSJFArTvjBAm22IgVHvvjRVvrhZ+Mg7+fKAyJNPI9kZiXqoi+W/sI969dheJzJLK4E
         vpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=AVFVqBToI2z/0E6vIQT2voBGC10UknG1DZGJokBkZoY=;
        b=BjfTftpRlumT+3F9Z5kiDQpLv5oly5apE/n37oulzxIk3cEP2EWgUywOIgObzkAk/z
         qWiKpXyFtQm/s+AgjUcjBboLgPzuuUyOSrLyrbomeBXlioLS4Km4ls9M8VqmxJb+fecJ
         BPDo7FJp44KG7iG/TMi6Zn4xxwYYOqpUV0bqANBjf6pz18mCDcOVZ2OvzI+I7FaPWJux
         zrTtVbx9Z16u18GcQxH4jF0rJMy3XGEHLkmkGqQeTHmbyRz0FGFsjf6Ej0dY50fVBD5b
         yISvtLsN75lVzs0SHegVXJ0/ArQFe4v8/fm2tJwmkwId1GCnzgL4Gj8wfYXOwIJ55+5l
         QNEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v3 06/10] drivers/peci: Add a PECI adapter driver for
 Aspeed AST24xx/AST25xx
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
 Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Haiyue Wang
 <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-7-jae.hyun.yoo@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <93e7f93c-a2e4-1e16-be4c-b908f88b9897@arm.com>
Date: Tue, 17 Apr 2018 14:37:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410183212.16787-7-jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385137876997151?=
X-GMAIL-MSGID: =?utf-8?q?1598000732729764455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Just a drive-by nit:

On 10/04/18 19:32, Jae Hyun Yoo wrote:
[...]
> +#define PECI_CTRL_SAMPLING_MASK     GENMASK(19, 16)
> +#define PECI_CTRL_SAMPLING(x)       (((x) << 16) & PECI_CTRL_SAMPLING_MASK)
> +#define PECI_CTRL_SAMPLING_GET(x)   (((x) & PECI_CTRL_SAMPLING_MASK) >> 16)

FWIW, <linux/bitfield.h> already provides functionality like this, so it 
might be worth taking a look at FIELD_{GET,PREP}() to save all these 
local definitions.

Robin.
