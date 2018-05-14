Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeENPSy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:18:54 -0400
Received: from alln-iport-5.cisco.com ([173.37.142.92]:10970 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeENPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:18:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CRAQBXpvla/4kNJK1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNDgVwoCoNoiASMboFYgTCTMoF4CyyEQAIagnchNBgBAgE?=
 =?us-ascii?q?BAQEBAQJsKIUpBiMRRRACAQgaAiYCAgIwFRACBAENBYMjggGqZYIciD2CJxR?=
 =?us-ascii?q?1hxyCE4EyDIInNYQ/S4JpMIIkAoEjAZcSBgMCjk+Mb4ZfiV0CERMBgSQBHDi?=
 =?us-ascii?q?BUnB6AXKBJpBOb4EVjjwBgRcBAQ?=
X-IronPort-AV: E=Sophos;i="5.49,400,1520899200";
   d="scan'208";a="113727694"
From: "Christian Hansen (chansen3)" <chansen3@cisco.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: allowing mmap to be traced
Thread-Topic: [PATCH] arm64: allowing mmap to be traced
Thread-Index: AQHT65BtxXmhcPwuaEyagdzF5pniaaQvZL6A
Date: Mon, 14 May 2018 15:09:30 +0000
Message-ID: <370F7C12-ADF7-4365-BA32-35148B7D0280@cisco.com>
References: <1526308362-45443-1-git-send-email-chansen3@cisco.com>
In-Reply-To: <1526308362-45443-1-git-send-email-chansen3@cisco.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.44.192.70]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9AAA909CF3634409069A551A9CD37A4@emea.cisco.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4EFIv7C004314

Indeed, you have the quicker draw.  I concede to your patch.

﻿On 2018-05-14, 10:32 AM, "Christian Hansen (chansen3)" <chansen3@cisco.com> wrote:

    Adding missing macro which is present all other system calls to
    to mmap declaration for ARM.  This allows it to appear as a kernel
    tracing target.
    
    Signed-off-by: Christian Hansen <chansen3@cisco.com>
    ---
     arch/arm64/kernel/sys.c | 6 +++---
     1 file changed, 3 insertions(+), 3 deletions(-)
    
    diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
    index 72981ba..1ccdbfc 100644
    --- a/arch/arm64/kernel/sys.c
    +++ b/arch/arm64/kernel/sys.c
    @@ -27,9 +27,9 @@
     #include <linux/syscalls.h>
     #include <asm/cpufeature.h>
     
    -asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
    -			 unsigned long prot, unsigned long flags,
    -			 unsigned long fd, off_t off)
    +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
    +		unsigned long, prot, unsigned long, flags,
    +		unsigned long, fd, off_t, off)
     {
     	if (offset_in_page(off) != 0)
     		return -EINVAL;
    -- 
    2.5.0
    
    
