Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD69CECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E720852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWwA6p+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1E720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbeGXCxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:53:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49864 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388269AbeGXCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AHOlqjUwQe+x+iuZPqfns3W3XrTgw4f19J323zjLOKU=; b=lWwA6p+T7GJNO0kJMuHx/Wgoke
        p7t1aq0AQd9tRKpzH/iImuVQhdNrNHTiIYSF1kx/0GLdfbpT7BvrXWENxEZNfFNlOuhwgqAVGAHlJ
        1ENBHVeV869Zi3gxBFMq2lsw0uczhePCW3OWkRJU2pXpGTyMISebCENARBk/wdvkD7sdJW1VHHnxb
        afSVVNo9k7qZc1e8BevJUuX7mqnt9jAfGmW0uvw3IxsExcXGqpuaRWKxdLFR1aeZXunZaSzk/uIy3
        v/La28Yw9TR3i46dgaPn1mtRorq+MP7UIlVSPxtadGS7/AKbLH3hhJDVBEb8xXznTI9oMItySc0Ei
        gv1R1e2g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fhmSW-0003nB-6d; Tue, 24 Jul 2018 01:49:52 +0000
Subject: Re: m68k allmodconfig build errors
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org>
 <alpine.LNX.2.21.1807201454590.8@nippy.intranet>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8991ac62-0239-ddfd-6378-95c4ec2fe42b@infradead.org>
Date:   Mon, 23 Jul 2018 18:49:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1807201454590.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 10:17 PM, Finn Thain wrote:
> On Thu, 19 Jul 2018, Randy Dunlap wrote:
> 
>> Hi Geert,
>>
>> I am seeing a few errors when cross-building m68k on x86_64, using the 
>> toolchain at https://mirrors.edge.kernel.org/pub/tools/crosstool/ 
>> (thanks, Arnd). (so this is gcc 8.1.0)
>>
>> block/partitions/ldm.o: In function `ldm_partition':
>> ldm.c:(.text+0x1900): undefined reference to `strcmp'
>> ldm.c:(.text+0x1964): undefined reference to `strcmp'
>> drivers/rtc/rtc-proc.o: In function `is_rtc_hctosys':
>> rtc-proc.c:(.text+0x290): undefined reference to `strcmp'
>> drivers/watchdog/watchdog_pretimeout.o: In function `watchdog_register_governor':
>> (.text+0x142): undefined reference to `strcmp'
>>
>>
>> Adding #include <linux/string.h> does not help.
>>
>> Is this a toolchain problem or drivers or something else?
>>
> 
> This gcc build was apparently configured like so:
> 
> /home/arnd/git/gcc/configure --target=m68k-linux --enable-targets=all 
> --prefix=/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/m68k-linux 
> --enable-languages=c --without-headers --disable-bootstrap --disable-nls 
> --disable-threads --disable-shared --disable-libmudflap --disable-libssp 
> --disable-libgomp --disable-decimal-float --disable-libquadmath 
> --disable-libatomic --disable-libcc1 --disable-libmpx 
> --enable-checking=release
> 
> In my own cross toolchain builds strcmp comes from glibc but this 
> toolchain has no libc at all.
> 
>> help?
>>
> 
> Linux will use the strcmp in lib/string.c unless __HAVE_ARCH_STRCMP is 
> defined in the arch headers. Grep suggests that m68k, mips, x86, xtensa, 
> arc, sh, arm64, s390 all define that macro. But maybe you could just patch 
> out that definition for build testing.

Sure, that works.  Thanks.

-- 
~Randy
