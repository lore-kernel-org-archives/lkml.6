Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/XvlgPzv582OCsU/IHsXze5tUOl7JWMSO0Q66mv4GVMmg9RrrlybmmrYiZC7vJgiBmQnFs
ARC-Seal: i=1; a=rsa-sha256; t=1524585405; cv=none;
        d=google.com; s=arc-20160816;
        b=vCkhkTBJfeOBhTS2xwcrIPX+LQailN3d5Xn/qiWVqc90dC1uqV+8fRE64Ty33O8XU2
         uEN6Rxz9agp/bcwLK3e03Ij0pb9XL36twjFmNo9dB5KqxIXgwVNlrVN32rj6l5N4WFsf
         gvaSgd49bJxM5qL+Q0+IcK94BcWhdd539AM1E7KcvS3SbBnejixOPObCjRGkOsdQBSCk
         gJ/kTa6ZhFBbz22n/MiK1Rd7x7em+1iHy4xhjYoztJ2jjJvVrBdweFtePkYO0Fz96NCi
         8mHGKoPZf9sRTfJCDdhPZySaYcOll7zZw/smNnaGz3kayr/eb0HUzumW7qFZRNYJjCPt
         W9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=NzVp2iIKk0Q4YtIziMO5jfcg/Qtxuw4I7MeEfRk17uM=;
        b=YvYXPl59MCK72/gepu77zUO2njFJ9Jxl+2yf467KBBLibzmiStcniw64XYWVYC1gB2
         N+xTBTjGDm93OBiZnRAF7SBROEtaWocp662ZFRIO7gMT2xq9Dn0EJt/qrfq2sIUTzDuC
         eFU1/Ik3f/wxzdxF1xL95cFNS+xws2KJh6qgLN0YTKfpQztflwoqyLj0hoU8GVV7u5q5
         Ioc9g6sN0e1GaRKhNQOjWQjmPgqkylgiQQwhvQCOMaj2KMNzYKBMTYJ5V3XCAMrB4e2b
         ptA+bt3J2wj5TPYJikJdBZP4rAySYEM/nu26Ieq2NVr53i91/TU1n8nlEkH5SgtMyRCB
         +bfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="222955339"
Message-ID: <1524585397.21176.502.camel@linux.intel.com>
Subject: Re: [PATCH v3 09/10] drivers/hwmon: Add PECI hwmon client drivers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Alan Cox
 <alan@linux.intel.com>,  Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn
 <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Fengguang Wu <fengguang.wu@intel.com>, Greg KH
 <gregkh@linuxfoundation.org>,  Guenter Roeck <linux@roeck-us.net>, Haiyue
 Wang <haiyue.wang@linux.intel.com>, James Feist
 <james.feist@linux.intel.com>, Jason M Biils
 <jason.m.bills@linux.intel.com>,  Jean Delvare <jdelvare@suse.com>, Joel
 Stanley <joel@jms.id.au>, Julia Cartwright <juliac@eso.teric.us>,  Miguel
 Ojeda <miguel.ojeda.sandonis@gmail.com>, Milton Miller II
 <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
 <rdunlap@infradead.org>, Stef van Os
 <stef.van.os@prodrive-technologies.com>, Sumeet R Pawnikar
 <sumeet.r.pawnikar@intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Date: Tue, 24 Apr 2018 18:56:37 +0300
In-Reply-To: <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
	 <20180410183212.16787-10-jae.hyun.yoo@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385144123845129?=
X-GMAIL-MSGID: =?utf-8?q?1598643665933352887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-10 at 11:32 -0700, Jae Hyun Yoo wrote:

>  drivers/hwmon/peci-cputemp.c  | 783
> ++++++++++++++++++++++++++++++++++++++++++
>  drivers/hwmon/peci-dimmtemp.c | 432 +++++++++++++++++++++++

Does it make sense one driver per patch?

> +#define CLIENT_CPU_ID_MASK    0xf0ff0  /* Mask for Family / Model
> info */

> +struct cpu_gen_info {
> +	u32 type;
> +	u32 cpu_id;
> +	u32 core_max;
> +};
> 

> +static const struct cpu_gen_info cpu_gen_info_table[] = {
> +	{ .type = CPU_GEN_HSX,
> +	  .cpu_id = 0x306f0, /* Family code: 6, Model number: 63
> (0x3f) */
> +	  .core_max = CORE_MAX_ON_HSX },
> +	{ .type = CPU_GEN_BRX,
> +	  .cpu_id = 0x406f0, /* Family code: 6, Model number: 79
> (0x4f) */
> +	  .core_max = CORE_MAX_ON_BDX },
> +	{ .type = CPU_GEN_SKX,
> +	  .cpu_id = 0x50650, /* Family code: 6, Model number: 85
> (0x55) */
> +	  .core_max = CORE_MAX_ON_SKX },
> +};

Are we talking about x86 CPU IDs here?
If so, why x86 corresponding headers, including intel-family.h are not
used?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
