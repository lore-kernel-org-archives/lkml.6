Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeEUVCN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:02:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39758 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbeEUVCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:02:09 -0400
Date: Mon, 21 May 2018 23:01:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Stef van Os <stef.van.os@prodrive-technologies.com>
Subject: Re: [v4 09/11] drivers/hwmon: Add PECI cputemp driver
Message-ID: <20180521210158.GH8077@lunn.ch>
References: <20180521195952.28073-1-jae.hyun.yoo@linux.intel.com>
 <20180521204238.GA26471@roeck-us.net>
 <f8824489-a0d7-6a13-baab-a6fc50164b67@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8824489-a0d7-6a13-baab-a6fc50164b67@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>+#if IS_ENABLED(CONFIG_X86)
> >>+#include <asm/intel-family.h>
> >>+#else
> >>+#define INTEL_FAM6_HASWELL_X   0x3F
> >>+#define INTEL_FAM6_BROADWELL_X 0x4F
> >>+#define INTEL_FAM6_SKYLAKE_X   0x55
> >>+#endif
> >
> >The entire code is very Intel specific. Why this #if instead of
> >making the driver dependent on X86 ?
> >
> 
> This code will be running on ARM kernel at this moment with a purpose
> of monitoring remote x86 CPUs through PECI connection

How about moving what you need from asm/intel-family.h into a header
file in include/linux/. Or move the entire header?

     Andrew
