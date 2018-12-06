Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98379C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D828214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oberhumer.com header.i=@oberhumer.com header.b="AvIX82gQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D828214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberhumer.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbeLFPre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:47:34 -0500
Received: from mail.servus.at ([193.170.194.20]:49372 "EHLO mail.servus.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbeLFPrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:47:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.servus.at (Postfix) with ESMTP id B69BF3000694;
        Thu,  6 Dec 2018 16:47:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oberhumer.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:user-agent:date:date:message-id:organization:from
        :from:references:subject:subject:received:received; s=main; t=
        1544111246; x=1545925647; bh=kltSlKA3mbcTujRIdGfrANs0ZeALK2B9AEr
        AOYNpXsA=; b=AvIX82gQyQoo6zR6Hn1mM2z9MSE2T1E8X1Bip2hnWLtlujX9AFt
        e/viIiv2WeHITA/VzcSeaXOnHLN8qATiCmapH2SotFkZktthnsmlG5ydRlzVzSTR
        ppfxFPx3v1xTbarRdQa3Eqj2GSqZRy/TRfioPMImGZEYtceS+eYLFzKk=
X-Virus-Scanned: amavisd-new at servus.at
Received: from mail.servus.at ([127.0.0.1])
        by localhost (mail.servus.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6MxphbQIXpG4; Thu,  6 Dec 2018 16:47:26 +0100 (CET)
Received: from [192.168.216.53] (unknown [81.10.228.128])
        (Authenticated sender: oh_markus)
        by mail.servus.at (Postfix) with ESMTPSA id A70973000692;
        Thu,  6 Dec 2018 16:47:25 +0100 (CET)
Subject: Re: [PATCH v4 0/7] lib/lzo: performance improvements
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
Cc:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
From:   "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
Message-ID: <5C09448C.8010506@oberhumer.com>
Date:   Thu, 6 Dec 2018 16:47:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <20181130142600.13782-1-dave.rodgman@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-30 15:26, Dave Rodgman wrote:
> This patch series introduces performance improvements for lzo.
> 
> The previous version of this patchset is here:
> https://lkml.org/lkml/2018/11/30/807
> 
> This version of the patchset fixes a maybe-used-uninitialized warning
> (although the previous version was still safe).
> 
> Dave

Hi Dave,

as indicated in my previous mail please split your series into three
distinct pull requests.


Request 1 - ARM64 improvements; acked by me

   [PATCH 1/8] lib/lzo: tidy-up ifdefs
   [PATCH 3/8] lib/lzo: enable 64-bit CTZ on Arm
   [PATCH 4/8] lib/lzo: 64-bit CTZ on arm64
   [PATCH 5/8] lib/lzo: fast 8-byte copy on arm64

are simple arch patches that give a nice speedup on ARM64 and should
get merged ASAP.



Request 2 - add COPY16; *NOT* acked by me

  [PATCH 2/8] lib/lzo: clean-up by introducing COPY16

is still not correct because of possible overlapping copies. I'll
address this on the weekend.



Request 3 - add lzo-rle; *NOT* acked by me

   [PATCH 6/8] lib/lzo: implement run-length encoding
   [PATCH 7/8] lib/lzo: separate lzo-rle from lzo
   [PATCH 8/8] zram: default to lzo-rle instead of lzo

This can *NOT* be applied in the current implementation.

It (1) silently changes the compressed data format, (2) crashes on MIPS,
and (3) makes compression and decompression on typical data 10% slower on
X86_64 with our internal benchmarks, and (4) has to be carefully checked
for buffer overflows.

I understand that we want some optimizations for data with many zeros like
in the typical ZRAM use case, but the implementation will clearly need some
more work. I'll also have a look at the weekend - eg I have a nice idea
how to deal with (1).



As a final comment, I question the quality your benchmarks - combining
arch-related ARM64 improvements and algorithmic changes into one
benchmark comparision is just unprofessional marketing.

Cheers,
Markus



-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
