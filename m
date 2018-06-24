Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1205EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78E124F01
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78E124F01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeFXNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:19:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeFXNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:19:58 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fX4vG-00059s-WE; Sun, 24 Jun 2018 15:19:19 +0200
Date:   Sun, 24 Jun 2018 15:19:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Toshi Kani <toshi.kani@hpe.com>
cc:     mhocko@suse.com, akpm@linux-foundation.org, mingo@redhat.com,
        hpa@zytor.com, cpandya@codeaurora.org, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
In-Reply-To: <20180516233207.1580-1-toshi.kani@hpe.com>
Message-ID: <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
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

On Wed, 16 May 2018, Toshi Kani wrote:

> This series fixes two issues in the x86 ioremap free page handlings
> for pud/pmd mappings.
> 
> Patch 01 fixes BUG_ON on x86-PAE reported by Joerg.  It disables
> the free page handling on x86-PAE.
> 
> Patch 02-03 fixes a possible issue with speculation which can cause
> stale page-directory cache.
>  - Patch 02 is from Chintan's v9 01/04 patch [1], which adds a new arg
>    'addr', with my merge change to patch 01.
>  - Patch 03 adds a TLB purge (INVLPG) to purge page-structure caches
>    that may be cached by speculation.  See the patch descriptions for
>    more detal.

Toshi, Joerg, Michal!

I'm failing to find a conclusion of this discussion. Can we finally make
some progress with that?

Can someone give me a hint what to pick up urgently please?

Thanks,

	tglx
