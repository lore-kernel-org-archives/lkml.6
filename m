Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3445CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CE6208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CE6208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeH0MTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:19:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42423 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0MTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:19:46 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fuCyK-0005FK-NP; Mon, 27 Aug 2018 10:34:04 +0200
Date:   Mon, 27 Aug 2018 10:34:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT pull] timer updates for 4.19
In-Reply-To: <CAK8P3a28q8PrKGFzp7fS98sXP0ZH3QS8s9gEuZo2DYWQ2CfzTQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808271032330.1631@nanos.tec.linutronix.de>
References: <153527451522.1785.1711099585239615812.tglx@nanos.tec.linutronix.de> <153527451524.1785.7684129956167424331.tglx@nanos.tec.linutronix.de> <CA+55aFwBRzrWDsyzQLLurET_cfD4JNRPddNmFnJJodtLdLpL4w@mail.gmail.com>
 <CAK8P3a28q8PrKGFzp7fS98sXP0ZH3QS8s9gEuZo2DYWQ2CfzTQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018, Arnd Bergmann wrote:
> Only a handful of syscalls actually require that complexity, most of them
> need only two entry points either way (32-bit time, and 64-bit time), the
> question is what we call them. I have a mild preference for the second
> version after the discussion with Christoph, but I'm also fine with going back
> to the orignal plan if you like that better after all.

Nah, lets use that old_ naming scheme for the existing 32bit time mess and
use compat for everything which is truly compat in the sense of 32bit on
64bit.

Thanks,

	tglx
