Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36CB213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36CB213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJHXgo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:36:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:60038 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbeJHXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:36:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-5-47QI0Q_NP5m09-sOej_yfg-1; Mon, 08 Oct 2018 17:24:12 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Oct 2018 17:24:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Oct 2018 17:24:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Michael Matz' <matz@suse.de>,
        Segher Boessenkool <segher@kernel.crashing.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        Richard Biener <rguenther@suse.de>,
        Nadav Amit <namit@vmware.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Alok Kataria" <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: RE: PROPOSAL: Extend inline asm syntax with size spec
Thread-Topic: PROPOSAL: Extend inline asm syntax with size spec
Thread-Index: AQHUXlXo64INA1O8UEmnaVydWfJQNqUViHqQ
Date:   Mon, 8 Oct 2018 16:24:12 +0000
Message-ID: <14efacd19a76488c8771b9781dec34c0@AcuMS.aculab.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
In-Reply-To: <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 47QI0Q_NP5m09-sOej_yfg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Matz
> Sent: 07 October 2018 16:53
...
> I think the examples I saw from Boris were all indirect inlines:
> 
>   static inline void foo() { asm("large-looking-but-small-asm"); }
>   static void bar1() { ... foo() ... }
>   static void bar2() { ... foo() ... }
>   void goo (void) { bar1(); }  // bar1 should have been inlined
> 
> So, while the immediate asm user was marked as always inline that in turn
> caused users of it to become non-inlined.  I'm assuming the kernel guys
> did proper measurements that they _really_ get some non-trivial speed
> benefit by inlining bar1/bar2, but for some reasons (I didn't inquire)
> didn't want to mark them all as inline as well.

Could you add a 'size' attribute to the 'always inlined' foo() above
rather than trying to add one to the asm() statement itself.
Then add a warning in the documentation that small size attributes
might make the assembly fail due to limited branch offsets (etc).

Size '1' probably ought to be reserved for things that definitely
fit in a delay slot.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

