Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A72C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB6122434
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB6122434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeGCCNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:13:53 -0400
Received: from icp-osb-irony-out5.external.iinet.net.au ([203.59.1.221]:16146
        "EHLO icp-osb-irony-out5.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753663AbeGCCNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:13:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BTAQAk2zpb/zXSMGcNTxsBAQEBAwEBA?=
 =?us-ascii?q?QkBAQGFPxODeZYiCCKVJIF6hHcCg1U2FgECAQEBAQEBAoZMAQEBAyMVQRALDQs?=
 =?us-ascii?q?CAiYCAlcGAQwGAgEBgxyBc6hjboIcGoRBg3qBOoELiXeBNgyCLi6EQ4M4glUCj?=
 =?us-ascii?q?QmMPQgBjxeIK4Uwk08JgXozGggoCIMkgiQXjildjhuCSAEB?=
X-IPAS-Result: =?us-ascii?q?A2BTAQAk2zpb/zXSMGcNTxsBAQEBAwEBAQkBAQGFPxODeZY?=
 =?us-ascii?q?iCCKVJIF6hHcCg1U2FgECAQEBAQEBAoZMAQEBAyMVQRALDQsCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgxyBc6hjboIcGoRBg3qBOoELiXeBNgyCLi6EQ4M4glUCjQmMPQgBjxeIK4U?=
 =?us-ascii?q?wk08JgXozGggoCIMkgiQXjildjhuCSAEB?=
X-IronPort-AV: E=Sophos;i="5.51,301,1526313600"; 
   d="scan'208";a="145573822"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out5.iinet.net.au with ESMTP; 03 Jul 2018 10:13:47 +0800
Subject: Re: [PATCH 1/5] m68k/io: Add missing ioremap define guards, fix typo
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Helge Deller <deller@gmx.de>
Cc:     linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702133532.5412-1-geert@linux-m68k.org>
 <20180702133532.5412-2-geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <1349f685-e4a2-5e04-8227-dd55e11153f6@linux-m68k.org>
Date:   Tue, 3 Jul 2018 12:13:46 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702133532.5412-2-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 02/07/18 23:35, Geert Uytterhoeven wrote:
>    - Add missing define guard for ioremap_wt(),
>    - Fix typo s/ioremap_fillcache/ioremap_fullcache/,
>    - Add define guard for iounmap() for consistency with other
>      architectures.
> 
> Fixes: 9746882f547d2f00 ("m68k: group io mapping definitions and functions")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

If I build for the m5475evb defconfig then I get warnings like this:

   CC      init/main.o
In file included from ./include/asm-generic/io.h:19:0,
                  from ./arch/m68k/include/asm/io_no.h:147,
                  from ./arch/m68k/include/asm/io.h:3,
                  from ./include/linux/bio.h:28,
                  from ./include/linux/blkdev.h:21,
                  from init/main.c:80:
./include/asm-generic/iomap.h:79:0: warning: "ioremap_wt" redefined
  #define ioremap_wt ioremap_nocache
  ^
In file included from ./arch/m68k/include/asm/io_no.h:145:0,
                  from ./arch/m68k/include/asm/io.h:3,
                  from ./include/linux/bio.h:28,
                  from ./include/linux/blkdev.h:21,
                  from init/main.c:80:
./arch/m68k/include/asm/kmap.h:37:0: note: this is the location of the previous definition
  #define ioremap_wt ioremap_wt
  ^

Regards
Greg


> ---
>   arch/m68k/include/asm/kmap.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
> index 84b8333db8ad1987..bf1026def698f21f 100644
> --- a/arch/m68k/include/asm/kmap.h
> +++ b/arch/m68k/include/asm/kmap.h
> @@ -16,6 +16,7 @@
>    */
>   extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
>   			       int cacheflag);
> +#define iounmap iounmap
>   extern void iounmap(void __iomem *addr);
>   extern void __iounmap(void *addr, unsigned long size);
>   
> @@ -33,13 +34,14 @@ static inline void __iomem *ioremap_nocache(unsigned long physaddr,
>   }
>   
>   #define ioremap_uc ioremap_nocache
> +#define ioremap_wt ioremap_wt
>   static inline void __iomem *ioremap_wt(unsigned long physaddr,
>   				       unsigned long size)
>   {
>   	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
>   }
>   
> -#define ioremap_fillcache ioremap_fullcache
> +#define ioremap_fullcache ioremap_fullcache
>   static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
>   					      unsigned long size)
>   {
> 
