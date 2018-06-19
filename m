Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A6C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080532083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080532083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937651AbeFSL04 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:26:56 -0400
Received: from smtp-out6.electric.net ([192.162.217.189]:64362 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937502AbeFSL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:26:55 -0400
Received: from 1fVEmZ-000hIV-Tk by out6e.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fVEmb-000hZT-T7; Tue, 19 Jun 2018 04:26:45 -0700
Received: by emcmailer; Tue, 19 Jun 2018 04:26:45 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6e.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fVEmZ-000hIV-Tk; Tue, 19 Jun 2018 04:26:43 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 19 Jun 2018 12:27:54 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 19 Jun 2018 12:27:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mike Galbraith' <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>,
        "h.peter.anvin@intel.com" <h.peter.anvin@intel.com>,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
Thread-Topic: [tip:x86/pti] x86/asm: Pad assembly functions with INT3
 instructions
Thread-Index: AQHUBkDa0HgDAKJTY0OMOyPcIRcuE6RndBSw
Date:   Tue, 19 Jun 2018 11:27:54 +0000
Message-ID: <01de2a572d964a349e556e6c638e06d4@AcuMS.aculab.com>
References: <20180507213755.GA32406@avx2>
         <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
         <1529235613.4572.7.camel@gmx.de> <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
In-Reply-To: <1529242717.4472.3.camel@gmx.de>
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

From: Mike Galbraith
> Sent: 17 June 2018 14:39
...
> > > Is dinky patchlet suggesting cryptomgr is being naughty?
...
> > diff --git a/arch/x86/crypto/aegis128-aesni-asm.S b/arch/x86/crypto/aegis128-aesni-asm.S
> > index 9254e0b6cc06..717bf0776421 100644
> > --- a/arch/x86/crypto/aegis128-aesni-asm.S
> > +++ b/arch/x86/crypto/aegis128-aesni-asm.S
> > @@ -535,6 +535,7 @@ ENTRY(crypto_aegis128_aesni_enc_tail)
> >  	movdqu STATE3, 0x40(STATEP)
> >
> >  	FRAME_END
> > +	ret
> >  ENDPROC(crypto_aegis128_aesni_enc_tail)
...

How much of the rest of the associated crypyo changes were actually tested?
I can't image the code DTRT without the 'ret'.

	David

