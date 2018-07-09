Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7233CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2665520881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2665520881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754538AbeGINVK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:21:10 -0400
Received: from smtp-out6.electric.net ([192.162.217.192]:64497 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGINVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:21:08 -0400
Received: from 1fcW68-0008V2-Tg by out6c.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcW6A-0008fJ-T8; Mon, 09 Jul 2018 06:21:02 -0700
Received: by emcmailer; Mon, 09 Jul 2018 06:21:02 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6c.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcW68-0008V2-Tg; Mon, 09 Jul 2018 06:21:00 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Jul 2018 14:22:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Jul 2018 14:22:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Ingo Molnar <mingo@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86: Avoid pr_cont() in show_opcodes()
Thread-Topic: [PATCH] x86: Avoid pr_cont() in show_opcodes()
Thread-Index: AQHUF2IXOw2g4hxHjEejYvq2wFVyxKSG37zw
Date:   Mon, 9 Jul 2018 13:22:39 +0000
Message-ID: <f3b0dee2b61940b5976571e769692ec9@AcuMS.aculab.com>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
 <20180709084953.GB2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709084953.GB2476@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 09 July 2018 09:50
> On Sat, Jul 07, 2018 at 10:54:28PM +0900, Tetsuo Handa wrote:
> > >> Since syzbot is confused by concurrent printk() messages [1],
> > >> this patch changes show_opcodes() to use snprintf().

snprintf() is probably the wrong function.
You want the variant that always returns the number of characters
added to the buffer - not the number that would have been added
were the buffer infinite length.

> But how big of a problem is that really? We can't very well remove all
> pr_cont stuff from the kernel.

On my ubuntu 17.10 system with a 4.13 kernel some messages printed with
pr_cont end up split when displayed by dmesg.
(These are from one of our drivers, I've not looked very hard at it though.)

So maybe removing pr_cont isn't a bad idea.

	David

