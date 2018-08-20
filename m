Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8D1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5F521722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5F521722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeHTS4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:56:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55847 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeHTS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:56:51 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frmHy-0008O5-PQ; Mon, 20 Aug 2018 17:40:18 +0200
Date:   Mon, 20 Aug 2018 17:40:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jiri Kosina <jikos@kernel.org>, x86@kernel.org,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86: apm: mark proc_apm_show as __maybe_unused
In-Reply-To: <20180814091904.2186262-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1808201737330.1551@nanos.tec.linutronix.de>
References: <20180814091904.2186262-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018, Arnd Bergmann wrote:

> A new build error appeared with CONFIG_PROC_FS disabled:
> 
> arch/x86/kernel/apm_32.c:1643:12: error: 'proc_apm_show' defined but not used [-Werror=unused-function]
> 
> This marks the function as __maybe_unused to let the compiler drop
> it silently.
>
> Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")

The proper fix for this is to convert the stub function for proc_apm_show()
to an inline. The compiler complains because the stub is a macro ....

Thanks,

	tglx
