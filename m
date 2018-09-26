Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EADC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AFD214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AFD214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeIZOff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:35:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48605 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:35:34 -0400
Received: from [217.9.97.180] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g556m-0001KK-Fp; Wed, 26 Sep 2018 10:23:44 +0200
Date:   Wed, 26 Sep 2018 10:23:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yi Sun <yi.y.sun@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH v2 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
In-Reply-To: <1537514712-62434-3-git-send-email-yi.y.sun@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1809261017530.2974@nanos.tec.linutronix.de>
References: <1537514712-62434-1-git-send-email-yi.y.sun@linux.intel.com> <1537514712-62434-3-git-send-email-yi.y.sun@linux.intel.com>
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

On Fri, 21 Sep 2018, Yi Sun wrote:
>  static inline int hyperv_flush_guest_mapping(u64 as) { return -1; }
> +void __init hv_init_spinlocks(void) {}

That stub want's to be static inline void hv_....

But as the code which uses it is ifdef guarded anyway, you don't need it at
all. We add stub functions to avoid te ifdeffery in the code so the
compiler can optimize them out, but if the ifdef guards are required for
other reasons, then providing the stub for nothing is a pointless exercise.

Thanks,

	tglx


