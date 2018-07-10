Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED7C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C374D20873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C374D20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754591AbeGJBs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:48:26 -0400
Received: from icp-osb-irony-out2.external.iinet.net.au ([203.59.1.155]:26059
        "EHLO icp-osb-irony-out2.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754410AbeGJBsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:48:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CnAAA3D0Rb/zXSMGcNTxoBAQEBAQIBA?=
 =?us-ascii?q?QEBCAEBAQGFPxODepYWCCKVMoF6hHcCgmY2FgECAQEBAQEBAoZLAQEBAQIBIxV?=
 =?us-ascii?q?BBQsLDQsCAiYCAlcGAQwGAgEBgxyBcwWoWm6CHBqEQYNxgTqBC4l4gTYMglyHe?=
 =?us-ascii?q?4JVAodihSyMQQgBjx6ILwOFMZNYAYICMxoIKAiDJJBkXY59AQE?=
X-IPAS-Result: =?us-ascii?q?A2CnAAA3D0Rb/zXSMGcNTxoBAQEBAQIBAQEBCAEBAQGFPxO?=
 =?us-ascii?q?DepYWCCKVMoF6hHcCgmY2FgECAQEBAQEBAoZLAQEBAQIBIxVBBQsLDQsCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgxyBcwWoWm6CHBqEQYNxgTqBC4l4gTYMglyHe4JVAodihSyMQQg?=
 =?us-ascii?q?Bjx6ILwOFMZNYAYICMxoIKAiDJJBkXY59AQE?=
X-IronPort-AV: E=Sophos;i="5.51,332,1526313600"; 
   d="scan'208";a="123830785"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out2.iinet.net.au with ESMTP; 10 Jul 2018 09:48:15 +0800
Subject: Re: [PATCH 0/5] m68k: IO Fixes and Cleanups
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180709093040.23597-1-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <0f38c6fd-82f1-7211-3b2e-425bbd44b157@linux-m68k.org>
Date:   Tue, 10 Jul 2018 11:48:14 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709093040.23597-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 09/07/18 19:30, Geert Uytterhoeven wrote:
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
> Changes compared to v1:
>    - Move ARCH_HAS_IOREMAP_WT to fix "ioremap_wt redefined" warnings with
>      m5475evb defconfig,
>    - Add Acked-by.
> 
> Given the dependencies, I think it's easiest if the respective
> maintainers would provide their Acked-by, so all patches can go in
> through the m68k tree.

Retested on ColdFire 5475, looks good.
For the whole series:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> Thanks!
> 
> Geert Uytterhoeven (5):
>    m68k/io: Add missing ioremap define guards, fix typo
>    net: mac8390: Use standard memcpy_{from,to}io()
>    Input: hilkbd - Add casts to HP9000/300 I/O accessors
>    m68k/io: Move mem*io define guards to <asm/kmap.h>
>    m68k/io: Switch mmu variant to <asm-generic/io.h>
> 
>   arch/m68k/include/asm/io.h          |  7 +++++
>   arch/m68k/include/asm/io_mm.h       | 42 +++--------------------------
>   arch/m68k/include/asm/io_no.h       | 12 ---------
>   arch/m68k/include/asm/kmap.h        |  9 ++++++-
>   drivers/input/keyboard/hilkbd.c     |  4 +--
>   drivers/net/ethernet/8390/mac8390.c | 20 +++++++-------
>   6 files changed, 30 insertions(+), 64 deletions(-)
> 
