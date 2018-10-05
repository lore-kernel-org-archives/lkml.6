Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E741BC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9642206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9642206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeJEVec convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:34:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38332 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbeJEVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:34:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g8RCU-0002Al-Bu; Fri, 05 Oct 2018 16:35:30 +0200
Date:   Fri, 5 Oct 2018 16:35:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kurt Kanzenbach <kurt@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] tty: serial: pl011: fix warning about uninitialized
 variable
Message-ID: <20181005143530.o5g6kuh5i3ym44os@linutronix.de>
References: <20180924082901.21191-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180924082901.21191-1-kurt@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-24 10:29:01 [+0200], Kurt Kanzenbach wrote:
> Silence the following gcc warning:
> 
> drivers/tty/serial/amba-pl011.c: In function ‘pl011_console_write’:
> ./include/linux/spinlock.h:260:3: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    _raw_spin_unlock_irqrestore(lock, flags); \
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/tty/serial/amba-pl011.c:2214:16: note: ‘flags’ was declared here
>   unsigned long flags;
>                 ^~~~~
> 
> The code is correct. Thus, initializing flags to zero doesn't change the
> behavior and resolves the warning.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

applied.

Sebastian
