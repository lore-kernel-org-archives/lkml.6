Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26513C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63BF24B00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63BF24B00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeFXNQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:16:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44961 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFXNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:16:11 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX4rV-00057W-Qm; Sun, 24 Jun 2018 15:15:26 +0200
Date:   Sun, 24 Jun 2018 15:15:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        jason@lakedaemon.net, marc.zyngier@arm.com, arnd@arndb.de,
        keescook@chromium.org, vladimir.murzin@arm.com,
        nicolas.pitre@linaro.org, jinb.park7@gmail.com,
        yamada.masahiro@socionext.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, jhogan@kernel.org,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org
Subject: Re: Finish the GENERIC_IRQ_MULTI_HANDLER conversion
In-Reply-To: <20180621181756.12493-1-palmer@sifive.com>
Message-ID: <alpine.DEB.2.21.1806241513260.8650@nanos.tec.linutronix.de>
References: <20180621181756.12493-1-palmer@sifive.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Palmer Dabbelt wrote:
> A while ago I sent a patch set that adds a GENERIC_IRQ_MULTI_HANDLER,
> which is an exact copy of the existing IRQ_MULTI_HANDLER support in the
> arm port, which is being used unconditionally by arm64 and openrisc.
> GENERIC_IRQ_MULTI_HANDLER is currently being used by the RISC-V port.  I
> managed to make a few mistakes in my original patch set and as a result
> my conversion of the other architectures of GENERIC_IRQ_MULTI_HANDLER
> was dropped.
> 
> This patch set finishes up my original patch set by converting arm,
> arm64, and openrisc over to the new GENERIC_IRQ_MULTI_HANDLER support
> and then removing MULTI_IRQ_HANDLER as it's obselete.
> 
> At the time I wrote this I gave it fairly extensive build testing, but
> went I recently rebased it I just tested the full patch set on arm,
> arm64, and openrisc defconfigs.
> 
> Various flavors of this patch set have bounced around a few times
> before, but I'm calling this a whole new patch set as it builds on top
> of what was merged.

I'll take the whole pile through tip irq/core which probably makes the most
sense unless there are any objections from architecture maintainers.

Thanks,

	tglx

