Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29581C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8072086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbfAaMIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:08:42 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:50822 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfAaMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:08:42 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gpB90-00053a-7J; Thu, 31 Jan 2019 20:08:34 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gpB8s-0003jc-Q8; Thu, 31 Jan 2019 20:08:26 +0800
Date:   Thu, 31 Jan 2019 20:08:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/test_rhashtable: Make test_insert_dup() allocate
 its hash table dynamically
Message-ID: <20190131120826.l4xd3vfonwmldudd@gondor.apana.org.au>
References: <20190130184230.225631-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130184230.225631-1-bvanassche@acm.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:42:30AM -0800, Bart Van Assche wrote:
> The test_insert_dup() function from lib/test_rhashtable.c passes a
> pointer to a stack object to rhltable_init(). Allocate the hash table
> dynamically to avoid that the following is reported with object
> debugging enabled:
> 
> ODEBUG: object (ptrval) is on stack (ptrval), but NOT annotated.
> WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:368 __debug_object_init+0x312/0x480
> Modules linked in:
> EIP: __debug_object_init+0x312/0x480
> Call Trace:
>  ? debug_object_init+0x1a/0x20
>  ? __init_work+0x16/0x30
>  ? rhashtable_init+0x1e1/0x460
>  ? sched_clock_cpu+0x57/0xe0
>  ? rhltable_init+0xb/0x20
>  ? test_insert_dup+0x32/0x20f
>  ? trace_hardirqs_on+0x38/0xf0
>  ? ida_dump+0x10/0x10
>  ? jhash+0x130/0x130
>  ? my_hashfn+0x30/0x30
>  ? test_rht_init+0x6aa/0xab4
>  ? ida_dump+0x10/0x10
>  ? test_rhltable+0xc5c/0xc5c
>  ? do_one_initcall+0x67/0x28e
>  ? trace_hardirqs_off+0x22/0xe0
>  ? restore_all_kernel+0xf/0x70
>  ? trace_hardirqs_on_thunk+0xc/0x10
>  ? restore_all_kernel+0xf/0x70
>  ? kernel_init_freeable+0x142/0x213
>  ? rest_init+0x230/0x230
>  ? kernel_init+0x10/0x110
>  ? schedule_tail_wrapper+0x9/0xc
>  ? ret_from_fork+0x19/0x24
> 
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> Changes compared to v2: fixed build error.
> 
> Changes compared to v1: instead of modifying rhashtable_init(), modify its
>    caller.
> 
> lib/test_rhashtable.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
