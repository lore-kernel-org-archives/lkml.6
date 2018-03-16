Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCPL4Z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:56:25 -0400
Received: from smtp-out6.electric.net ([192.162.217.191]:55091 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeCPL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:56:23 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: "'Borislav Petkov'" <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Thread-Topic: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Thread-Index: AQHTvInvQ04RH5ZYEE2cCUdW+6SuaqPSwjfA
Date: Fri, 16 Mar 2018 11:57:15 +0000
Message-ID: <107ab804c8f44a9fba4cb52a60ee1f0d@AcuMS.aculab.com>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-5-bp@alien8.de>
 <20180315181054.3fuuetu6fxpzlpcn@treble> <20180315181612.GH27816@pd.tnic>
In-Reply-To: <20180315181612.GH27816@pd.tnic>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2GBuTSk027423

From: Borislav Petkov
> Sent: 15 March 2018 18:16
> On Thu, Mar 15, 2018 at 01:10:54PM -0500, Josh Poimboeuf wrote:
> > I liked OPCODE_BUFSIZE where it was before :-)  Here it disrupts the
> > readability of the function a bit IMO.
> 
> My thinking is have it close by so that you don't have to go search for
> its definition.
> 
> But I don't have a strong opinion on where it should be so...

Is OPCODE_BUFSIZE even needed?
Maybe replace with 64 and use sizeof() and/or ARRAY_SIZE() elsewhere.
Then no one has to check that the bound is appropriate for the array.

	David
