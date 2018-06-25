Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9636EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5913225DA1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5913225DA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755316AbeFYQBK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:01:10 -0400
Received: from smtp-out4.electric.net ([192.162.216.184]:56007 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754716AbeFYQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:01:07 -0400
Received: from 1fXTvJ-0001Gf-V3 by out4d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fXTvM-0001hf-T6; Mon, 25 Jun 2018 09:01:04 -0700
Received: by emcmailer; Mon, 25 Jun 2018 09:01:04 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fXTvJ-0001Gf-V3; Mon, 25 Jun 2018 09:01:01 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 25 Jun 2018 17:02:40 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 25 Jun 2018 17:02:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthias Kaehlcke' <mka@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Thread-Topic: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Thread-Index: AQHUCAN80F3SBShFI0K/KXIEJhRI5KRxK3VA
Date:   Mon, 25 Jun 2018 16:02:40 +0000
Message-ID: <ea5b51cbdb8a4a2fa8ef51e6de68d960@AcuMS.aculab.com>
References: <20180619192504.180479-1-mka@chromium.org>
In-Reply-To: <20180619192504.180479-1-mka@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="iso-8859-2"
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

From: Matthias Kaehlcke
> Sent: 19 June 2018 20:25
> To: Paolo Bonzini; Radim Krèmáø; Thomas Gleixner; H . Peter Anvin
> Cc: x86@kernel.org; kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Nick Desaulniers; Joe Perches;
> Matthias Kaehlcke
> Subject: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in update_permission_bitmask()
> 
> update_permission_bitmask() negates u8 bitmask values and assigns them
> to variables of type u8. Since the MSB is set in the bitmask values the
> compiler expands the negated values to int, which then is assigned to
> an u8 variable. Cast the negated value back to u8.
> 
> This fixes several warnings like this when building with clang:
> 
> arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
>   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
>   -Wconstant-conversion]
>     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
>        ~~                               ^~

Shoot the compiler writer - or turn off that warning.
Or try 'w ^ 0xff'.

	David

