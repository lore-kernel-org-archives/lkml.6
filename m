Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49320C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FA1222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392793AbfBMQxg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:53:36 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:24852 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392559AbfBMQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:53:36 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-131-5bfnswKhP721ybj2SXPzFA-1; Wed, 13 Feb 2019 16:53:32 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 13 Feb 2019 16:54:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 Feb 2019 16:54:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Ogness' <john.ogness@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: RE: [RFC PATCH v1 00/25] printk: new implementation
Thread-Topic: [RFC PATCH v1 00/25] printk: new implementation
Thread-Index: AQHUwt+yw0tokMnSLkaf/+oK4gykJqXd8fOw
Date:   Wed, 13 Feb 2019 16:54:15 +0000
Message-ID: <6f965383270d45d6ac26529fec5ad470@AcuMS.aculab.com>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 5bfnswKhP721ybj2SXPzFA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness
> Sent: 12 February 2019 14:30
...
> - A dedicated kernel thread is created for printing to all consoles in
>   a fully preemptible context.
> 
> - A new (optional) console operation "write_atomic" is introduced that
>   console drivers may implement. This function must be NMI-safe. An
>   implementation for the 8250 UART driver is provided.
> 
> - The concept of "emergency messages" is introduced that allows
>   important messages (based on a new emergency loglevel threshold) to
>   be immediately written to any consoles supporting write_atomic,
>   regardless of the context.
...

Does this address my usual 'gripe' that the output is written to the console
by syslogd and not by the kernel itself?
When you are trying to find out where the system is completely deadlocking
you need the 'old fashioned' completely synchronous kernel printf().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

