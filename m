Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030605AbeBPPyl convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:54:41 -0500
Received: from smtp-out4.electric.net ([192.162.216.195]:61364 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758444AbeBPPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:54:40 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] platform/x86: wmi: Replace kmalloc + sprintf() with
 kasprintf()
Thread-Topic: [PATCH v1] platform/x86: wmi: Replace kmalloc + sprintf() with
 kasprintf()
Thread-Index: AQHTpzygAxHNoy4Glk28iB2GiTOQyqOnLiMg
Date: Fri, 16 Feb 2018 15:55:24 +0000
Message-ID: <829ccf8330b7418a976205665e0ab4bd@AcuMS.aculab.com>
References: <20180216154024.389-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180216154024.389-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko
> Sent: 16 February 2018 15:40
>
> kasprintf() does the job of two: kmalloc() and sprintf().
> Replace two calls with one.
...
> -		buf = kmalloc(strlen(wdriver->driver.name) + 5, GFP_KERNEL);
> +		buf = kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
...

Except that kasprintf() has no idea how long a buffer is needed.
It might even do the printf twice just to get the length.

	David
