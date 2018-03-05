Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeCEOks (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:40:48 -0500
Received: from smtp-out4.electric.net ([192.162.216.183]:54935 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeCEOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:40:44 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Thorsten Leemhuis'" <regressions@leemhuis.info>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        Christoph Hellwig <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Herring, Jan-kristian Augustin"
        <jan-kristian.augustin.herring@intel.com>
Subject: RE: regression: SCSI/SATA failure
Thread-Topic: regression: SCSI/SATA failure
Thread-Index: AQHTtIzer0h5KJaBnkyettjEnZZXWqPBtVZA
Date: Mon, 5 Mar 2018 14:41:24 +0000
Message-ID: <3ccf46026ca74faea98d4a9cdce221f9@AcuMS.aculab.com>
References: <1519311270.2535.53.camel@intel.com>
 <1519311443.2535.55.camel@gmail.com>
 <c405f270-1bea-d34e-259e-fd9f372a495c@leemhuis.info>
In-Reply-To: <c405f270-1bea-d34e-259e-fd9f372a495c@leemhuis.info>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w25EetBm016650

From: Thorsten Leemhuis
> Hi! On 22.02.2018 15:57, Artem Bityutskiy wrote:
> > On Thu, 2018-02-22 at 16:54 +0200, Artem Bityutskiy wrote:
> >> one of our test box Skylake servers does not boot with v4.16-rcX.
> >> Bisection lead us to this commit:
> >> 84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs
> >> Reverting this single commit fixes the problem.
> 
> Artem, is this issue still happening? I still have it in my list of
> regressions. Side note: I accidentally noticed people continue working
> in the area that 84676c1f21e8 touched;  see
> https://marc.info/?l=linux-block&m=152021971313902&w=2 ("[PATCH V2 5/5]
> genirq/affinity: irq vector spread among online CPUs as far as
> possible"). I wonder if that might be related in any way. Ciao, Thorsten

Hmmm.... I can think of some workloads where you really don't want some
cpu taking any interrupts at all (well as few as possible).
Think of workloads where process affinities are used to ensure that only
a few specific processes run on certain cpus.
The last thing you want then is interrupt load sharing and/or per cpu
ethernet rings.

	David
