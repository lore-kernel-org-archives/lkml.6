Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86485C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B17523FCE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B17523FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeGEUeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:34:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeGEUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:34:07 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbAwx-0004Ax-R7; Thu, 05 Jul 2018 22:34:00 +0200
Date:   Thu, 5 Jul 2018 22:33:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>, palmer@sifive.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/6] timex: prepare compat helpers for y2038 changes
In-Reply-To: <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807052232310.1771@nanos.tec.linutronix.de>
References: <20180703054422.12089-4-deepa.kernel@gmail.com> <201807051322.sUohKhUO%fengguang.wu@intel.com> <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
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

On Thu, 5 Jul 2018, Deepa Dinamani wrote:

> The error is fixed with the following patch that goes in before patch
> 3/6 above in the series.
> Let me know if I should post a v2 instead.
> 
> Thanks,
> Deepa
> 
> 
> commit bfe4b046ed7f01154aef44fcb77d3f172929ccc2
> Author: Deepa Dinamani <deepa.kernel@gmail.com>
> Date:   Thu Jul 5 11:47:25 2018 -0700
> 
>     riscv: Include asm-generic/compat.h
> 
>     riscv does not enable CONFIG_COMPAT in default configurations:
>     defconfig, allmodconfig and nomodconfig.
>     And hence does not inlude definitions for compat data types.
> 
>     Now that time syscalls are being reused in non CONFIG_COMPAT
>     modes, include asm-generic definitions for riscv.
> 
>     Alternative would be to make compat_time.h to be conditional on
>     CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
>     asm/compat.h include the generic version instead.
> 
>     Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>     Cc: palmer@sifive.com
>     Cc: linux-riscv@lists.infradead.org

Post a real patch please instead of something which I have to cleanup
manually. A V2 of the series is probably the simplest way.

Thanks,

	tglx
