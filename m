Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523554637; cv=none;
        d=google.com; s=arc-20160816;
        b=hJfB4+585hjrodyDDRbR1n6j9v3w/LKZS/4yyblgtGkvlo5P2ERcPwBD1+tu89UEY7
         UGXquWdDmv4BijIQ/Wh1UhLfPmj2epmGypuitqeuWkY0kRf8pcbEfDLc1gKvxA+GiN0d
         zC5k4qOk8a+sE/2nG80sx72Yh8QgInQbHKoJqvT/SQj/+cxiTIrPgo502hmKajjoMzF3
         eDHHOBbJmXlNpxdyDzk4TXjXB1jfUMjKf0M86P3eMxjhqaMtOKya4tv+mu0G8+a1pB5v
         VuZW2NVUECyJtm2oQ0poRvt+HgIbY5Rxll+TQOmNRI0GzaI4jlpLjSWECXNsnM3elTii
         SDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:sender:dkim-signature:arc-authentication-results;
        bh=RUSXcbBkt1fxkghag2nr5gB4UuXXw0/dkFAKGZ7lYIc=;
        b=qrqaBN/HcMFisQ+a3ejQMOfp0xE1Z7xwrvxQdXjWwKBPlNprVFQzdYg7WtGzwN9tHo
         54/kDFAW0F0USpkWR6UNrb9wmqyAixueuzQ7i6pdKYKv0kDyBO/aJ0AS7LqOb7+sgWSo
         oXiqc62D+dhnZq2hvVmAWdzxyD74ZkoS+AKqsi4A0v3jPAJ5xH9nXT6JM+wKxhYW896F
         myCMkcW0i5IEiimEm/tNDjNkAm9i2Z2mkSRe4QvEx3hb7xcjmM6bkrMoLRuHqqQUTzqD
         7YCcVj2aaIgCoB/Bxq0uAFnMYlUJ19hXu4H9umQc/kbmSHXOlsuCFbczsPull7ERsCDG
         BIhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MxfmZgvf;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MxfmZgvf;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AIpwx4/11sS6SoqNZpw9C60HKIjPoqTnVsScmLe46MCGuOQzDzWZV14lyNunDFh69+HNAY7QaTfPnw==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 12 Apr 2018 10:37:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
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
	Vernon Mauery <vernon.mauery@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 09/10] drivers/hwmon: Add PECI hwmon client drivers
Message-ID: <20180412173714.GA13496@roeck-us.net>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
 <20180410222800.GA8484@roeck-us.net>
 <637d7812-e567-0bc2-4f08-fbdca0ee85d8@linux.intel.com>
 <292be2d9-e572-2e06-9899-f6c2c53fdefc@roeck-us.net>
 <7b378954-1ce8-a2d2-5d09-8b6b36c048be@linux.intel.com>
 <13d4c632-a20e-3c40-066a-1e9df02a0595@roeck-us.net>
 <89c8c847-87e7-a849-e05d-d32b787e9305@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c8c847-87e7-a849-e05d-d32b787e9305@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385144123845129?=
X-GMAIL-MSGID: =?utf-8?q?1597562827253899656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 10:09:51AM -0700, Jae Hyun Yoo wrote:
[ ... ]
> >>>>>>+static int find_core_index(struct peci_cputemp *priv, int channel)
> >>>>>>+{
> >>>>>>+    int core_channel = channel - DEFAULT_CHANNEL_NUMS;
> >>>>>>+    int idx, found = 0;
> >>>>>>+
> >>>>>>+    for (idx = 0; idx < priv->gen_info->core_max; idx++) {
> >>>>>>+        if (priv->core_mask & BIT(idx)) {
> >>>>>>+            if (core_channel == found)
> >>>>>>+                break;
> >>>>>>+
> >>>>>>+            found++;
> >>>>>>+        }
> >>>>>>+    }
> >>>>>>+
> >>>>>>+    return idx;
> >>>>>
> >>>>>What if nothing is found ?
> >>>>>
> >>>>
> >>>>Core temperature group will be registered only when it detects at
> >>>>least one core checked by check_resolved_cores(), so
> >>>>find_core_index() can be called only when priv->core_mask has a
> >>>>non-zero value. The 'nothing is found' case will not happen.
> >>>>
> >>>That doesn't guarantee a match. If what you are saying is correct
> >>>there should always be
> >>>a well defined match of channel -> idx, and the search should be
> >>>unnecessary.
> >>>
> >>
> >>There could be some disabled cores in the resolved core mask bit
> >>sequence also it should remove indexing gap in channel numbering so it
> >>is the reason why this search function is needed. Well defined match of
> >>channel -> idx would not be always satisfied.
> >>
> >Are you saying that each call to the function, with the same parameters,
> >can return a different result ?
> >
> 
> No, the result will be consistent. After reading the priv->core_mask once in
> check_resolved_cores(), the value will not be changed. I'm saying about this
> case, for example if core number 2 is unresolved in total 4 cores, then the
> idx order will be '0, 1, 3' but channel order will be '5, 6, 7' without
> making any indexing gap.
> 

And you yet you claim that this is not well defined ? Or are you concerned
about the amount of memory consumed by providing an array for the mapping ?

Note that an indexing gap is acceptable and, in many cases, preferred.

[ ... ]

> >>>>>>+
> >>>>>>+    dev_dbg(dev, "%s: sensor '%s'\n", dev_name(hwmon_dev),
> >>>>>>priv->name);
> >>>>>>+
> >>>
> >>>Why does this message display the device name twice ?
> >>>
> >>
> >>For an example, dev_name(hwmon_dev) shows 'hwmon5' and priv->name shows
> >>'peci-cputemp0'.
> >>
> >And dev_dbg() shows another device name. So you'll have something like
> >
> >peci-cputemp0: hwmon5: sensor 'peci-cputemp0'
> >
> 
> Practically it shows like
> 
> peci-cputemp 0-30:00: hwmon10: sensor 'peci_cputemp.cpu0'
> 
> where 0-30:00 is assigned by peci core.
> 

And what message would you see for cpu1 ?
