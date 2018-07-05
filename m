Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA93C24140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA93C24140
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeGEKzR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:55:17 -0400
Received: from smtp-out6.electric.net ([192.162.217.186]:62188 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbeGEKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:55:13 -0400
Received: from 1fb1ul-00063Y-T2 by out6b.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fb1um-0006Ic-WC; Thu, 05 Jul 2018 03:55:08 -0700
Received: by emcmailer; Thu, 05 Jul 2018 03:55:08 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6b.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fb1ul-00063Y-T2; Thu, 05 Jul 2018 03:55:07 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 5 Jul 2018 11:56:46 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 5 Jul 2018 11:56:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pavel Machek' <pavel@ucw.cz>, Willy Tarreau <w@1wt.eu>
CC:     Andreas Klinger <ak@it-klinger.de>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "ben.whitten@gmail.com" <ben.whitten@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: RE: [PATCH v2] leds: ledtrig-morse: send out morse code
Thread-Topic: [PATCH v2] leds: ledtrig-morse: send out morse code
Thread-Index: AQHUE8PIvpX+/24/IUKW/GbX/x8KQKSAdDxg
Date:   Thu, 5 Jul 2018 10:56:46 +0000
Message-ID: <6db92ee3e66a45338c187ad575a759c2@AcuMS.aculab.com>
References: <20180703155328.GA18299@arbeit> <20180704065305.GA23509@amd>
 <20180704073443.GA9388@1wt.eu> <20180704181916.GA10785@amd>
In-Reply-To: <20180704181916.GA10785@amd>
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

...
> > Well, just like we have LED and LED triggers in the kernel, I think having
> > a generic way to use patterns could be nice and in this case Morse could be
> > one such pattern, but if that means it's limited to userland to configure
> > it then it sadly voids all of its benefits.

I've been involved in a system that used morse for short error messages.
Unless you actually know morse it is completely hopeless.

With two leds next to each other you should be able to generate
a lot of easily identifiable patterns by repeating separate 4-bit
patterns (in sync) on both leds (at about 2Hz update).

	David

