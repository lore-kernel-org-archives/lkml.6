Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96051C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694A620883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694A620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeKJBsK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:48:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53150 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727828AbeKJBsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:48:10 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-174-dqchVRUSO16jaBaTGo3y_w-1; Fri, 09 Nov 2018 16:06:55 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 9 Nov 2018 16:07:01 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 9 Nov 2018 16:07:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     Yi Wang <wang.yi59@zte.com.cn>, Michael Matz <matz@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "puwen@hygon.cn" <puwen@hygon.cn>,
        "davidwang@zhaoxin.com" <davidwang@zhaoxin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>
Subject: RE: [PATCH v2] x86/cpu: fix prototype warning
Thread-Topic: [PATCH v2] x86/cpu: fix prototype warning
Thread-Index: AQHUd3jUzn4rdJSfqUq5NosMvhSfq6VHnNmg
Date:   Fri, 9 Nov 2018 16:07:01 +0000
Message-ID: <3e5713c2f323453d80bdd2259e3392e5@AcuMS.aculab.com>
References: <1541639548-11149-1-git-send-email-wang.yi59@zte.com.cn>
 <20181108150318.GD7543@zn.tnic> <20181108153226.GF7543@zn.tnic>
 <alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811081633160.1549@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: dqchVRUSO16jaBaTGo3y_w-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner
> Sent: 08 November 2018 15:36
> On Thu, 8 Nov 2018, Borislav Petkov wrote:
> > And frankly, I don't see why we should be fixing all those. So what if a
> > global function does't have a previous prototype declaration?!
> 
> Global function declarations must have a prototype definition, really.
> 
> Otherwise you can change the function signature and all callers which use
> the old unchanged prototype are hosed.

I bet there are at least double-figures of real bugs out there.

The next on the list should be -Wwriteable-strings.
Usually just needs a few 'const' sprinkled.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

