Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FE020647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 21:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="H23YSXgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FE020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeH3BPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 21:15:30 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51006 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3BP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 21:15:29 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4BAA824E0A3F;
        Wed, 29 Aug 2018 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535577405; bh=fXMs6XQHbDPX/LX2jsruet93lP4/PYcTgsopB7EKyRI=;
        h=From:To:CC:Subject:Date:References:From;
        b=H23YSXgiDwMtY80FuIkP1yQfHUeP5EllqH2KLzmJdql+f0vGxaQGdvHOqTyaBPAM1
         5xKXekqmn3SgOuJbcJGk17frdrvkz+5am3K8Mq2YfWKBL1m0qYysXctMH9XNfuObQg
         snW/7gwrP3SSQ401FTD2WND6MwMO/K0bBsMNHftIF47a8GGBdcMPTh3/a7rWdIXxFh
         2MblBn8tZvLDUSbR2AqTFkNBxctsiRB1/XbBxkIbQqavDCW74CFl8DskFwd3q0e6tO
         g3TGelXX4NNh3djgdFywr4JGJHXSCqa4KHm2Ie10P6HMkhxfJYWKF2TzpEYQ61bhDg
         9MYgqgCRC9P0w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0FD6E3581;
        Wed, 29 Aug 2018 14:16:45 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed, 29
 Aug 2018 14:16:44 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Topic: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Index: AQHUP8bWpY6ZRO7qfEeDcvF8FJVDUg==
Date:   Wed, 29 Aug 2018 21:16:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 11:33 AM, Eugeniy Paltsev wrote:=0A=
> Hi Guys,=0A=
> Since v4.19-rc1 we are getting a serious regression on platforms with ARC=
 architecture.=0A=
> The kernel have become unstable and spontaneously crashes on LTP tests ex=
ecution / IO tests or=0A=
> even on boot.=0A=
>=0A=
> I don't know exactly what breaks but bisect clearly assign the blame to t=
his commit:=0A=
> 84c6591103db ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using =
atomic_fetch_*()")=0A=
> https://github.com/torvalds/linux/commit/84c6591103dbeaf393a092a3fc7b0951=
0825f6b9=0A=
>=0A=
> Reverting the commit solves this problem.=0A=
>=0A=
> I tested v4.19-rc1 on ARM (wandboard, i.mx6, 32bit, quard core, ARMv7) wh=
ich uses same=0A=
> generic bitops implementation and it works fine.=0A=
>=0A=
> Do you have any ideas what went wrong?=0A=
=0A=
Back in 2016, Peter had fixed this file due to a problem I reported on ARC.=
 See=0A=
commit f75d48644c56a ("bitops: Do not default to __clear_bit() for=0A=
__clear_bit_unlock()")=0A=
That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic=0A=
__clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock=
() same.=0A=
=0A=
This patch undoes that which could explain the issues you see. @Peter, @Wil=
l ?=0A=
=0A=
-Vineet=0A=
