Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A095BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648B120854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648B120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeGWWJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:09:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48802 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWWJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:09:15 -0400
Received: from localhost (unknown [172.58.43.32])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2C38108CE37A;
        Mon, 23 Jul 2018 14:06:13 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:06:12 -0700 (PDT)
Message-Id: <20180723.140612.672897895629613645.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     linux@roeck-us.net, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 4.18-rc6
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
        <20180723204617.GA14487@roeck-us.net>
        <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Jul 2018 14:06:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Jul 2018 13:56:15 -0700

> Hmm.  I assume it's
> 
>     arch/sparc/include/asm/cacheflush_32.h
> 
> that wants a forward-declaration of 'struct page', and doesn't include
> any header files.
> 
> The fix is presumably to move the
> 
>    #include <asm/cacheflush.h>
> 
> in drivers/staging/media/omap4iss/iss_video.c down to below the
> <linux/*> includes?
> 
> The old patchwork link you had for a fix no longer works, I think
> because the patchwork database got re-generated during the upgrade
> (and the patchwork numbering isn't stable).

I think modifying the include order in that driver is the best fix.

BTW, here is a proper patchwork link in the SPARC project on ozlabs:

http://patchwork.ozlabs.org/patch/947434/
