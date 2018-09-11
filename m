Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B0FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178652087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178652087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeILBVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:21:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42313 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeILBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:21:20 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzp8r-00058s-SF; Tue, 11 Sep 2018 22:20:10 +0200
Date:   Tue, 11 Sep 2018 22:20:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        jgross@suse.com, andy@strugglers.net
Subject: Re: [PATCH] x86/EISA: Don't probe EISA bus for Xen PV guests
In-Reply-To: <20180911195538.23289-1-boris.ostrovsky@oracle.com>
Message-ID: <alpine.DEB.2.21.1809112218580.1427@nanos.tec.linutronix.de>
References: <20180911195538.23289-1-boris.ostrovsky@oracle.com>
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

On Tue, 11 Sep 2018, Boris Ostrovsky wrote:

> For unprivileged Xen PV guests this is normal memory and ioremap will
> not be able to properly map it.
> 
> While at it, since ioremap may return NULL, add a test for pointer's
> validity.

I assume this goes back to very dead kernels, so that should go with a Cc
stable, right?

Thanks,

	tglx
