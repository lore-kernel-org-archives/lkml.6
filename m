Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA66C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE1520779
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE1520779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbeGIQIr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:08:47 -0400
Received: from smtp-out6.electric.net ([192.162.217.188]:59919 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeGIQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:08:45 -0400
Received: from 1fcYiO-000BCy-T4 by out6d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcYiP-000BKB-Vy; Mon, 09 Jul 2018 09:08:41 -0700
Received: by emcmailer; Mon, 09 Jul 2018 09:08:41 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcYiO-000BCy-T4; Mon, 09 Jul 2018 09:08:40 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Jul 2018 17:10:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Jul 2018 17:10:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mark Rutland' <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "greg@kroah.com" <greg@kroah.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: RE: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Topic: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Index: AQHUF5xRYtcNwcQOfUmtgpsbxmBbOaSHDgUA
Date:   Mon, 9 Jul 2018 16:10:19 +0000
Message-ID: <b42f7223e0e54a5589f75fc21039f348@AcuMS.aculab.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
 <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
 <20180709153427.GY2476@hirez.programming.kicks-ass.net>
 <20180709154521.GS2512@hirez.programming.kicks-ass.net>
 <20180709154844.5p5yk34ezw2gbt3y@lakrids.cambridge.arm.com>
In-Reply-To: <20180709154844.5p5yk34ezw2gbt3y@lakrids.cambridge.arm.com>
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

From: Mark Rutland
> Sent: 09 July 2018 16:49
> 
> On Mon, Jul 09, 2018 at 05:45:21PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 09, 2018 at 05:34:27PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jul 09, 2018 at 04:29:58PM +0100, Mark Rutland wrote:
> > > > Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
> > > > x86_32:
> > >
> > > Curious, I wonder why we put that align in atomic64_32 then.
> >
> > Shiny, look at this: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=54188
> >
> 
> Ouch.

Indeed.

changing the definition to:
struct ull {
        unsigned long long v __attribute__((aligned(__alignof__(long long))));
};

prints 8 for the structure alignment.

Time to audit uses of __alignof__().

#define actual_alignof(type) __alignof__(struct { type jsdjdhjdjh; })

	David

