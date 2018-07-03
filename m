Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B712EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CA022434
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CA022434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeGCCQD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:16:03 -0400
Received: from icp-osb-irony-out5.external.iinet.net.au ([203.59.1.221]:39422
        "EHLO icp-osb-irony-out5.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932216AbeGCCQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:16:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AAAQAk2zpb/zXSMGcNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFP4QMliIIIpcehHcCg1U3FQECAQEBAQEBAoZLAQEBAQIBIxVBBQs?=
 =?us-ascii?q?LDQsCAiYCAlcGAQwIAQGDHIFzBaheboIcGoRBg3qBOoELiXeBNgyCXId7glUCh?=
 =?us-ascii?q?2CFKYw9CAGPF4grhTCTXoF0MxoIKAiDJZBjkUABAQ?=
X-IPAS-Result: =?us-ascii?q?A2AAAQAk2zpb/zXSMGcNTxoBAQEBAQIBAQEBCAEBAQGFP4Q?=
 =?us-ascii?q?MliIIIpcehHcCg1U3FQECAQEBAQEBAoZLAQEBAQIBIxVBBQsLDQsCAiYCAlcGA?=
 =?us-ascii?q?QwIAQGDHIFzBaheboIcGoRBg3qBOoELiXeBNgyCXId7glUCh2CFKYw9CAGPF4g?=
 =?us-ascii?q?rhTCTXoF0MxoIKAiDJZBjkUABAQ?=
X-IronPort-AV: E=Sophos;i="5.51,301,1526313600"; 
   d="scan'208";a="145574596"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 03 Jul 2018 10:15:50 +0800
Subject: Re: [PATCH 0/5] m68k: IO Fixes and Cleanups
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702133532.5412-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <53ec59b8-0483-6b02-6dae-9f1d44bc2c69@linux-m68k.org>
Date:   Tue, 3 Jul 2018 12:15:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 02/07/18 23:35, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series contains fixes and cleanups for I/O accessors on m68k
> platforms (with MMU).
> 
> The first patch contains small fixes without any dependencies.
> Patches 2 and 3 make small adjustments to drivers that are dependencies
> for further cleanup.
> Patch 4 and 5 complete the cleanup.
> 
> Given the dependencies, I think it's easiest if the respective
> maintainers would provide their Acked-by, so all patches can go in
> through the m68k tree.
> 
> Thanks for your comments!

I like it alot. If we can just fix up the warnings caused by patch
number 1 I am more than happy to ack.

Regards
Greg


> Geert Uytterhoeven (5):
>    m68k/io: Add missing ioremap define guards, fix typo
>    net: mac8390: Use standard memcpy_{from,to}io()
>    Input: hilkbd - Add casts to HP9000/300 I/O accessors
>    m68k/io: Move mem*io define guards to <asm/kmap.h>
>    m68k/io: Switch mmu variant to <asm-generic/io.h>
> 
>   arch/m68k/include/asm/io.h          |  7 +++++
>   arch/m68k/include/asm/io_mm.h       | 40 +++--------------------------
>   arch/m68k/include/asm/io_no.h       | 12 ---------
>   arch/m68k/include/asm/kmap.h        |  7 ++++-
>   drivers/input/keyboard/hilkbd.c     |  4 +--
>   drivers/net/ethernet/8390/mac8390.c | 20 +++++++--------
>   6 files changed, 28 insertions(+), 62 deletions(-)
> 
