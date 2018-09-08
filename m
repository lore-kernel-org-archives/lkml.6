Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CE1C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BAC20652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BAC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeIHQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:56:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37541 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:56:30 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyc4c-0007lv-S8; Sat, 08 Sep 2018 14:10:47 +0200
Date:   Sat, 8 Sep 2018 14:10:46 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
cc:     mingo@kernel.org, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/mm/KASLR: Fix the wrong calculation of kalsr
 region initial size
In-Reply-To: <20180829021754.21850-1-bhe@redhat.com>
Message-ID: <alpine.DEB.2.21.1809081410230.1402@nanos.tec.linutronix.de>
References: <20180829021754.21850-1-bhe@redhat.com>
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

On Wed, 29 Aug 2018, Baoquan He wrote:

> In memory KASLR, __PHYSICAL_MASK_SHIFT is taken to calculate the
> initial size of the direct mapping region. This is right in the
> old code where __PHYSICAL_MASK_SHIFT was equal to MAX_PHYSMEM_BITS,
> 46bit, and only 4-level mode was supported.
> 
> Later, in commit:
> b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52"),
> __PHYSICAL_MASK_SHIFT was changed to be 52 always, no matter it's
> 5-level or 4-level. This is wrong for 4-level paging. Then when
> adapt phyiscal memory region size based on available memory, it
> will overflow if the amount of system RAM and the padding is bigger
> than 64TB.
> 
> In fact, here MAX_PHYSMEM_BITS should be used instead. Fix it by
> by replacing __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

This lacks a fixes tag .....

Thanks,

	tglx
