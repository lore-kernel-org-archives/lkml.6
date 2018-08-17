Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C21C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B037921536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=exactcode.de header.i=@exactcode.de header.b="idcQKXTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B037921536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeHQTr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:47:57 -0400
Received: from mx.exactcode.de ([144.76.154.42]:59646 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbeHQTr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:47:57 -0400
X-Greylist: delayed 1649 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Aug 2018 15:47:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactcode.de; s=x;
        h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=J6RRJB5RpBWyq7tZv7AIp4LcDivL1HDD3TQROCGIinU=;
        b=idcQKXTGw626SvST+5bB4zRREKSkRWwxZLoLZdWwy59n6K5Qh2d6g+IDw9RjlBR0e9yvqZGx+2cHcrInY/XPPJVoji85KxpfJfG3Y28xnWE/EZb1Eul4IYYmOrQQfmR4HZIBDYWB3VN7l+gxpuhts51Ll53XRdak7JKiZkDkl5M=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1fqhQj-0005N1-Ta; Fri, 17 Aug 2018 16:16:54 +0000
Received: from 54.203.140.77.rev.sfr.net ([77.140.203.54] helo=[192.168.0.34])
        by exactco.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.54)
        id 1fqhTb-0005mc-GV; Fri, 17 Aug 2018 16:20:10 +0000
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
From:   =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
In-Reply-To: <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
Date:   Fri, 17 Aug 2018 18:15:45 +0200
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com>
References: <20180322012943.4145794-1-terrelln@fb.com> <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com> <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com>
To:     Nick Terrell <terrelln@fb.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

is there any mainline future for this zstd support? Currently my most =
favourite compressor for this, and for what it=92s worth zstd/initrd now =
even tested on #t2sde / hp/pa-risc, =85 =
https://www.youtube.com/watch?v=3DMHplOJxnIHk

	Ren=E9

On 10 Jul 2018, at 00:13, Ren=E9 Rebe <rene@exactcode.com> wrote:

> Hi Nick,
>=20
> On 09 Jul 2018, at 20:04, Nick Terrell <terrelln@fb.com> wrote:
>=20
>>> On Mar 21, 2018, at 6:29 PM, Nick Terrell <terrelln@fb.com> wrote:
>>> This patch set adds support for a ZSTD-compressed kernel and ramdisk
>>> images in the kernel boot process. It only integrates the support =
with
>>> x86, though the first patch is generic to all architectures.
>>=20
>> Hi all,
>>=20
>> Is there anything blocking this from getting merged?
>> Please let me know if there is anything I can do to help move this =
patch forward.
>=20
> works fine on my side, initrd test booted on i486, x86-64, ppc, ppc64 =
and
> sparc64. For testing on mips64 I would first need to re-base the =
Octane^1
> patch-set ;-)
>=20
> Greetings,
> 	Ren=E9
>=20
> ^1) https://www.youtube.com/watch?v=3DAU_RV8uoTIo
>=20
> --=20
> ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
> http://exactcode.com | http://exactscan.com | http://ocrkit.com | =
http://t2-project.org | http://rene.rebe.de
>=20

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 DE Legal: Amtsgericht Berlin (Charlottenburg) HRB 105123B, Tax-ID#: =
DE251602478
 Managing Director: Ren=E9 Rebe
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | =
http://t2-project.org | http://rene.rebe.de

