Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F4BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074A425DEC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074A425DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeFYQMQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:12:16 -0400
Received: from smtp-out6.electric.net ([192.162.217.181]:51103 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbeFYQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:12:14 -0400
Received: from 1fXU5z-0009FV-US by out6d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fXU60-0009Kw-W9; Mon, 25 Jun 2018 09:12:04 -0700
Received: by emcmailer; Mon, 25 Jun 2018 09:12:04 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fXU5z-0009FV-US; Mon, 25 Jun 2018 09:12:03 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 25 Jun 2018 17:13:42 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 25 Jun 2018 17:13:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Fenghua Yu' <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [RFC PATCH 1/8] x86/cpufeatures: Enumerate MOVDIRI instruction
Thread-Topic: [RFC PATCH 1/8] x86/cpufeatures: Enumerate MOVDIRI instruction
Thread-Index: AQHUCBXina7mb9UEzUeoseVjbd5RvqRxLHeg
Date:   Mon, 25 Jun 2018 16:13:42 +0000
Message-ID: <d80e8650ad444b37b324d49139211218@AcuMS.aculab.com>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com>
 <1529118375-90191-2-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1806191057210.1692@nanos.tec.linutronix.de>
 <20180619213644.GC112652@romley-ivt3.sc.intel.com>
In-Reply-To: <20180619213644.GC112652@romley-ivt3.sc.intel.com>
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
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fenghua Yu
> Sent: 19 June 2018 22:37
> To: Thomas Gleixner
> Cc: Fenghua Yu; Ingo Molnar; H Peter Anvin; Ashok Raj; Alan Cox; Ravi V Shankar; linux-kernel; x86
> Subject: Re: [RFC PATCH 1/8] x86/cpufeatures: Enumerate MOVDIRI instruction
> 
> On Tue, Jun 19, 2018 at 10:57:44AM +0200, Thomas Gleixner wrote:
> > On Fri, 15 Jun 2018, Fenghua Yu wrote:
> >
> > > MOVDIRI moves doubleword or quadword from register to memory through
> > > direct store which is implemented by using write combining (WC) for
> > > writing data directly into memory without caching the data.
> >
> > And that is useful for what?
> 
> Programmable agents can handle streaming offload (e.g. high speed packet
> processing in network). Hardware implements a doorbell (tail pointer)
> register that is updated by software when adding new work-elements to
> the streaming offload work-queue.
> 
> MOVDIRI can be used as the doorbell write which is a 4-byte or 8-byte
> uncachable write to MMIO. MOVDIRI has lower overhead than other ways
> to write the doorbell.

I'd have thought that it wouldn't make any significant difference for
uncached accesses to device registers.

> In low latency offload (e.g. Non-Volatile Memory, etc), MOVDIR64B writes
> work descriptors (and data in some cases) to device-hosted work-queues
> with atomicity.

More likely it is useful more writing to memory without polluting the
data cache.
This might be because the programmer knows the data won't be read for
a long time (at least by the cpu in question).
It might also be useful to avoid a lot of cache snooping on data that
will be accessed by hardware - especially if the hardware is also
likely to be writing to the same cache line.

I can also just about imagine MOVDIR64B being useful for generating
64 byte PCIe TLP to optimise memcpy_to/fromio() without needing
an AVX512 register.

	David

