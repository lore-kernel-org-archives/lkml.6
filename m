Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1EAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A5124E33
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="udldNnGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A5124E33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeGBQsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:48:02 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:56753 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeGBQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NJBi5rh18Gn/XUYA/IYESQZZ6Uzy/r8sIMEMhSF6z2E=; b=udldNnGQPsbcjwcizW697J/SEU
        QYCyx94qaHboow4YcSjrnlG4tXjxeR1eFtyO8Cm06MWpbwj4UPd14Do9RuCalRbDmCohhQipmEgkq
        3CMzgqPlOAwiaTeUH6IqaheprPDzSJUPqqxEaWKHGTqZjwJkF/A2R5uNgJmIZ9qjxxunbz1hlyfyJ
        CD6uQu+s3MYZy9I80eLlEihkAsIEKja8sReXEfqshrlpPgp+6jXeMwPETUvdGzUGa6L6Slf7Xw80Q
        J+YCqwwg8Pf63tRPgwkFE5snKZdGVGCfgtArTXfyfKQUXmrup8e9TJYuITPWtH7Gh4CYQnsmUGRgl
        I7Rsuoxg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57370 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fa1zb-00A0A9-MV; Mon, 02 Jul 2018 16:48:00 +0000
Date:   Mon, 2 Jul 2018 09:47:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: v4.18-rc3: Build and qemu test results
Message-ID: <20180702164758.GA9835@roeck-us.net>
References: <20180702164605.GF9114@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702164605.GF9114@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[trying again, this time to a valid address]

Build and qemu test results for v4.18-rc3:

Build results:
	total: 134 pass: 128 fail: 6
Failed builds: 
	arm:allmodconfig 
	i386:allyesconfig 
	i386:allmodconfig 
	nds32:defconfig 
	nds32:allnoconfig 
	sparc32:allmodconfig
Qemu test results:
	total: 158 pass: 158 fail: 0

---
arm:allmodconfig:

/tmp/ccXj8hfB.s: Assembler messages:
/tmp/ccXj8hfB.s:35: Error: .err encountered
/tmp/ccXj8hfB.s:36: Error: .err encountered
/tmp/ccXj8hfB.s:37: Error: .err encountered
make[2]: *** [arch/arm/firmware/trusted_foundations.o] Error 1

Fix at:
	https://patchwork.kernel.org/patch/10434909/
	[not queued in -next]

---
i386:allyesconfig, i386:allmodconfig:

x86_64-linux-ld: i386:x86-64 architecture of input file
`net/bpfilter/bpfilter_umh.o' is incompatible with i386 output

next-20180702 builds fine, so presumably the fix is queued there.

---
nds32:defconfig, nds32:allnoconfig:

nds32le-linux-ld: kernel/time/timekeeping.o: in function `timekeeping_init':
timekeeping.c:(.init.text+0x1a8): undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1ac):
	undefined reference to `__ashldi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1ec):
	undefined reference to `__lshrdi3'
nds32le-linux-ld: timekeeping.c:(.init.text+0x1f0):
	undefined reference to `__lshrdi3'
nds32le-linux-ld: fs/direct-io.o: in function `do_direct_IO':
direct-io.c:(.text+0x16a0): undefined reference to `__ashldi3'

Fix is queued in -next.

---
sparc32:allmodconfig:

...
drivers/staging/media/omap4iss/iss_video.c:15:
build/include/linux/highmem.h: In function 'clear_user_highpage':
include/linux/highmem.h:137:31: error:
	passing argument 1 of 'sparc_flush_page_to_ram' from incompatible pointer type 

This is only seen with gcc 5 and later; gcc 4 produces warnings.

Building drivers/staging/media/omap4iss/iss_video.c for sparc32 was only
recently enabled with COMPILE_TEST. A possible fix for the problem is
available at https://patchwork.kernel.org/patch/10497941/.

Further details are available at http://kerneltests.org/builders.

Guenter
