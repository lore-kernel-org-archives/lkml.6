Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC57C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC1624C5E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC1624C5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeGBNjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:39:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50578 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeGBNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:39:08 -0400
Received: from localhost (unknown [59.29.86.96])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C118E13F619A8;
        Mon,  2 Jul 2018 06:39:06 -0700 (PDT)
Date:   Mon, 02 Jul 2018 22:39:05 +0900 (KST)
Message-Id: <20180702.223905.294108944941067854.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     gerg@linux-m68k.org, dmitry.torokhov@gmail.com, deller@gmx.de,
        linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] net: mac8390: Use standard memcpy_{from,to}io()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180702133532.5412-3-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
        <20180702133532.5412-3-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Jul 2018 06:39:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon,  2 Jul 2018 15:35:29 +0200

> The mac8390 driver defines its own variants of memcpy_fromio() and
> memcpy_toio(), using similar implementations, but different function
> signatures.
> 
> Remove the custom definitions of memcpy_fromio() and memcpy_toio(), and
> adjust all callers to the standard signatures.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> This is a dependency for "m68k: Move mem*io define guards to
> <asm/kmap.h>".
> 
> Untested on real hardware, assembler output compared.

Acked-by: David S. Miller <davem@davemloft.net>
