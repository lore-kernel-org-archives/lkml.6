Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeCTOjg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 10:39:36 -0400
Received: from smtp-out4.electric.net ([192.162.216.182]:58490 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeCTOjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 10:39:33 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Rahul Lakkireddy'" <rahul.lakkireddy@chelsio.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC: "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        Indranil Choudhury <indranil@chelsio.com>
Subject: RE: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
Thread-Topic: [RFC PATCH 2/3] x86/io: implement 256-bit IO read and write
Thread-Index: AQHTwE/Xw7n4cdHVjE+3sRSKJWyME6PZMJwQ
Date: Tue, 20 Mar 2018 14:40:19 +0000
Message-ID: <5f43882155104f50bbd2e5cf63d432f2@AcuMS.aculab.com>
References: <cover.1521469118.git.rahul.lakkireddy@chelsio.com>
 <6ec3e7e0c70e85a804933f27bb4275d5363c044b.1521469118.git.rahul.lakkireddy@chelsio.com>
 <alpine.DEB.2.21.1803191525010.2010@nanos.tec.linutronix.de>
 <20180320133206.GB25574@chelsio.com>
In-Reply-To: <20180320133206.GB25574@chelsio.com>
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

From: Rahul Lakkireddy
> Sent: 20 March 2018 13:32
...
> On High Availability Server, the logs of the failing system must be
> collected as quickly as possible.  So, we're concerned with the amount
> of time taken to collect our large on-chip memory.  We see improvement
> in doing 256-bit reads at a time.

Two other options:

1) Get the device to DMA into host memory.

2) Use mmap() (and vm_iomap_memory() in your driver) to get direct
   userspace access to the (I assume) PCIe memory space.
   You can then use whatever copy instructions the cpu has.
   (Just don't use memcpy().)

	David
