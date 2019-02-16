Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B762192D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732594AbfBPTQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:16:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54794 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbfBPTQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:16:42 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gv5S4-0003nt-0f; Sat, 16 Feb 2019 20:16:40 +0100
Date:   Sat, 16 Feb 2019 20:16:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hugo Lefeuvre <hle@owl.eu.com>
cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: void __iomem *addr should be const
In-Reply-To: <20190210122903.GA2400@behemoth.owl.eu.com.local>
Message-ID: <alpine.DEB.2.21.1902162016000.1683@nanos.tec.linutronix.de>
References: <20190210122903.GA2400@behemoth.owl.eu.com.local>
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

On Sun, 10 Feb 2019, Hugo Lefeuvre wrote:
> __iomem *addr seems to lack a const qualifier in the ioread* definitions
> from include/asm-generic/iomap.h (other definitions such as
> asm-generic/io.h do have the const).
> 
> This issue was briefly discussed a while ago[0] but the outcome is not
> quite clear to me. Should I submit a patch addressing this issue or is it
> a definitive wontfix?
> 
> This issue triggers warnings in my current work but I would like to avoid
> dropping the const if possible.

The const makes perfectly sense and we should have consistent state all
over the place.

Thanks,

	tglx
