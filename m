Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8423321480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8423321480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeIYN0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:26:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbeIYN0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:26:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E59BAAF41;
        Tue, 25 Sep 2018 07:20:25 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Zong Li <zongbox@gmail.com>
Cc:     hch@infradead.org, palmer@sifive.com, aou@eecs.berkeley.edu,
        vincentc@andestech.com, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
References: <cover.1537260207.git.zongbox@gmail.com>
        <2ccc6c0758624dbb22f6fe451a3e476a000108ef.1537260207.git.zongbox@gmail.com>
        <20180921070006.GC8401@infradead.org>
        <CA+ZOyaiJv-NZWk3ec_3zhRTSn7G-NGgyaiPTXOmuWfTWD7KSJw@mail.gmail.com>
X-Yow:  I think I am an overnight sensation right now!!
Date:   Tue, 25 Sep 2018 09:20:25 +0200
In-Reply-To: <CA+ZOyaiJv-NZWk3ec_3zhRTSn7G-NGgyaiPTXOmuWfTWD7KSJw@mail.gmail.com>
        (Zong Li's message of "Tue, 25 Sep 2018 10:19:55 +0800")
Message-ID: <mvmefdicabq.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 25 2018, Zong Li <zongbox@gmail.com> wrote:

> The RV32 need the umoddi3 to do modulo when the operands are long long
> type, like other libraries implementation such as ucmpdi2, lshrdi3 and
> so on. I encounter the undefined reference 'umoddi3' when I use the in
> house dma driver, although it is in house driver, but I think that
> umoddi3 is a common function for RV32.

You probably should use the macros from <asm/div64.h> instead.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
