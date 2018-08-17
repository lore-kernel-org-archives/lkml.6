Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A28C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D92321A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=exactcode.de header.i=@exactcode.de header.b="iRbk/CtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D92321A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeHQUTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:19:44 -0400
Received: from mx.exactcode.de ([144.76.154.42]:60270 "EHLO mx.exactcode.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeHQUTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactcode.de; s=x;
        h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=S+3LG6dPZDSvOF2NUZqp448QUEcnG5NsvHdYmkS1Y5k=;
        b=iRbk/CtUQ2F45lQtPvdBxYH6HyWvUjkmo6TuPhDldWVGgSgGGGuscAuRDYtixI8BTSjTZmquKNmmCLsxTlbwVfO30y6aW6sg1wV1rAKG0jiPyoqnFPfceZfvfpyE6EP/dVA/EwRz2fg+2tKKz46+7V0/D5qiJ5PKpKcB0s+OKnA=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1fqiLw-0008TP-Q4; Fri, 17 Aug 2018 17:16:00 +0000
Received: from 54.203.140.77.rev.sfr.net ([77.140.203.54] helo=[192.168.0.34])
        by exactco.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.54)
        id 1fqiOx-0006uy-7E; Fri, 17 Aug 2018 17:19:17 +0000
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [RESEND PATCH v2 0/2] Add support for ZSTD-compressed kernel
From:   =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.com>
In-Reply-To: <20180817165403.GC12066@tassilo.jf.intel.com>
Date:   Fri, 17 Aug 2018 19:15:06 +0200
Cc:     Nick Terrell <terrelln@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Chris Mason <clm@fb.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Julian Andres Klode <julian.klode@canonical.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <22E07EBB-CDC2-4EFF-B30F-61B848332BE4@exactcode.com>
References: <20180322012943.4145794-1-terrelln@fb.com> <5B282FAD-EDCF-44C8-A131-A3C6FF3EA84F@fb.com> <3F598446-EA1D-47CE-B7A1-4D3002DA3972@exactcode.com> <8DE2BD14-0C9C-43AF-B9B7-F760F8434B6B@exactcode.com> <20180817165403.GC12066@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17 Aug 2018, at 18:54, Andi Kleen <ak@linux.intel.com> wrote:

> On Fri, Aug 17, 2018 at 06:15:45PM +0200, Ren=E9 Rebe wrote:
>> Hey,
>>=20
>> is there any mainline future for this zstd support? Currently my most =
favourite compressor for this, and for what it=92s worth zstd/initrd now =
even tested on #t2sde / hp/pa-risc, =85 =
https://www.youtube.com/watch?v=3DMHplOJxnIHk
>=20
> Can you remove some other compressor for the kernel image if you merge =
this?
>=20
> The "favourite compressor" seems to roughly change every year, so if
> we keep adding new ones things will get more and more convoluted.

Well, we (t2 formerly known as rocklinux) only changed our pkg archive =
compression from bzip2 to zstd once in 20 years ,-)

> Surely zstd is universally better than some existing compressor
> the kernel already uses for itself for a particular sweet spot?
> If it isn't it's likely not needed.

Well, IMHO this is not that much code, but if you want to remove =
something I guess bzip2 or LZMA may be candidates.

	http://zstd.net

--=20
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | =
http://t2-project.org | http://rene.rebe.de

