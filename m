Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E29BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57635214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfAJP0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:26:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:34518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728181AbfAJP0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:26:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9BA0AF9A;
        Thu, 10 Jan 2019 15:26:47 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        "linux-kernel\@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty/serial: emit CR before NL in RISC-V SBL console
References: <20181204135507.3706-1-anup@brainfault.org>
        <20181204135507.3706-2-anup@brainfault.org>
        <mvmbm4oehd5.fsf_-_@suse.de>
        <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
X-Yow:  Why is everything made of Lycra Spandex?
Date:   Thu, 10 Jan 2019 16:26:46 +0100
In-Reply-To: <CAAhSdy3-SaP7RBbgx7kZgkkxeN2W-Ue8QDFXkOgFG5GiAg52-g@mail.gmail.com>
        (Anup Patel's message of "Thu, 10 Jan 2019 20:46:51 +0530")
Message-ID: <mvm7efcedop.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10 2019, Anup Patel <anup@brainfault.org> wrote:

> Instead of doing '\n' handling here, we should do it in BBL or
> OpenSBI (i.e. SBI runtime firmware) otherwise all users of
> SBI_CONSOLE_PUTCHAR (namely, Linux, FreeBSD,
> FreeRTOS, U-Boot S-mode, etc) will endup having '\n'
> handling.

I don't think the serial driver should do NLCR handling on its own,
without being instructed by the tty layer.  Since the earlycon does not
have a tty layer, it needs to handle it explicitly.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
