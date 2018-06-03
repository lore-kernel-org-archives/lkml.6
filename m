Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750913AbeFCEkY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 00:40:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeFCEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 00:40:22 -0400
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] net: skbuff.h: drop unneeded <linux/slab.h>
Message-ID: <86ee9a53-3136-7a2c-e59a-57d4d078188f@infradead.org>
Date: Sat, 2 Jun 2018 21:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

<linux/skbuff.h> does not use nor need <linux/slab.h>, so drop this
header file from skbuff.h.

<linux/skbuff.h> is currently #included in around 1200 C source and
header files, making it the 31st most-used header file.

Build tested [allmodconfig] on 20 arch-es.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/skbuff.h |    2 --
 1 file changed, 2 deletions(-)

--- lnx.orig/include/linux/skbuff.h
+++ lnx.next/include/linux/skbuff.h
@@ -852,8 +852,6 @@ struct sk_buff {
 /*
  *	Handling routines are only of interest to the kernel
  */
-#include <linux/slab.h>
-
 
 #define SKB_ALLOC_FCLONE	0x01
 #define SKB_ALLOC_RX		0x02
