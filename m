Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C01AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424592173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfAJSK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:10:29 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:59075 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbfAJSK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:10:28 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1ghemP-0006ih-QG from joseph_myers@mentor.com ; Thu, 10 Jan 2019 10:10:09 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 10 Jan 2019 18:10:06 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1ghemL-0001MG-Lx; Thu, 10 Jan 2019 18:10:05 +0000
Date:   Thu, 10 Jan 2019 18:10:05 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <y2038@lists.linaro.org>, <linux-api@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <tony.luck@intel.com>, <fenghua.yu@intel.com>,
        <geert@linux-m68k.org>, <monstr@monstr.eu>, <paul.burton@mips.com>,
        <deller@gmx.de>, <mpe@ellerman.id.au>, <schwidefsky@de.ibm.com>,
        <heiko.carstens@de.ibm.com>, <dalias@libc.org>,
        <davem@davemloft.net>, <luto@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <jcmvbkbc@gmail.com>, <firoz.khan@linaro.org>,
        <ebiederm@xmission.com>, <deepa.kernel@gmail.com>,
        <linux@dominikbrodowski.net>, <akpm@linux-foundation.org>,
        <dave@stgolabs.net>, <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 00/15] arch: synchronize syscall tables in preparation
 for y2038
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1901101808220.31458@digraph.polyomino.org.uk>
References: <20190110162435.309262-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019, Arnd Bergmann wrote:

> - Add system calls that have not yet been integrated into all
>   architectures but that we definitely want there.

glibc has a note that alpha lacks statfs64, any plans for that?

-- 
Joseph S. Myers
joseph@codesourcery.com
