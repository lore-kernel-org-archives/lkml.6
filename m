Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935525AbeE2PX3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:23:29 -0400
Received: from smtp-out4.electric.net ([192.162.216.195]:56741 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935287AbeE2PXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:23:20 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Christophe LEROY'" <christophe.leroy@c-s.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Geoff Levand <geoff@infradead.org>
Subject: RE: [PATCH v2] powerpc/64: Fix build failure with GCC 8.1
Thread-Topic: [PATCH v2] powerpc/64: Fix build failure with GCC 8.1
Thread-Index: AQHT9zDPBjvhoFHDzkqo/3KDVVesC6RG03lg
Date: Tue, 29 May 2018 15:24:21 +0000
Message-ID: <1bfdea64b0cc4be2970e296684c097dc@AcuMS.aculab.com>
References: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
 <CAMuHMdVSKigQPUQH=BVc2fRSRmuEThLaf+V9ghMPDT9_m1C6BA@mail.gmail.com>
 <1fa5b220-4d21-b4cd-33bf-8a3ce3178063@c-s.fr>
 <CAMuHMdXwO1_wrrTi40UmZC4o6KjvP0LF38m45n0ZNA2pDb_7Qg@mail.gmail.com>
 <3a438dd8-49c3-ad39-e2a1-040e0ce67279@c-s.fr>
In-Reply-To: <3a438dd8-49c3-ad39-e2a1-040e0ce67279@c-s.fr>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4TFNWH3000956

From: Christophe LEROY
> Sent: 29 May 2018 10:37
...
> >>>> -       strncpy(new_part->header.name, name, 12);
> >>>> +       memcpy(new_part->header.name, name, strnlen(name,
> >>>> sizeof(new_part->header.name)));
> >>>
> >>>
> >>> The comment for nvram_header.lgnth says:
> >>>
> >>>           /* Terminating null required only for names < 12 chars. */
> >>>
> >>> This will not terminate the string with a zero (the struct is
> >>> allocated with kmalloc).
> >>> So the original code is correct, the new one isn't.
> >>
> >> Right, then I have to first zeroize the destination.
> >
> > Using kzalloc() instead of kmalloc() will do.
> >
> > Still, papering around these warnings seems to obscure things, IMHO.
> > And it increases code size, as you had to add a call to strnlen().
> 
> Right but then, what is the best solution to elimate that warning ?

Time to add the I_really_mean_strncy() function.

	David
