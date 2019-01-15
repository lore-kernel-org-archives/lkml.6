Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF0BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421B420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbfAOSz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:55:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbfAOSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:55:26 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjTrp-00037G-Ug; Tue, 15 Jan 2019 19:55:18 +0100
Date:   Tue, 15 Jan 2019 19:55:10 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Hedi Berriche <hedi.berriche@hpe.com>
cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>
Subject: Re: [PATCH 1/3] efi/x86: turn EFI runtime semaphore into a global
 lock
In-Reply-To: <20190109104541.25733-2-hedi.berriche@hpe.com>
Message-ID: <alpine.DEB.2.21.1901151953370.1655@nanos.tec.linutronix.de>
References: <20190109104541.25733-1-hedi.berriche@hpe.com> <20190109104541.25733-2-hedi.berriche@hpe.com>
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

On Wed, 9 Jan 2019, Hedi Berriche wrote:

> Make efi_runtime_lock semaphore global so that it can be used by EFI
> runtime callers that may be defined outside efi/runtime-wrappers.c.

The changelog should mention why the lock is renamed. I have no strong
opinion, but to apply that I need an Ack from Ard.

Thanks,

	tglx
