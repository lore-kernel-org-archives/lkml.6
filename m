Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA1BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F8D20869
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfBJVXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:23:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37383 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfBJVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:23:48 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gswZm-0001Of-Dt; Sun, 10 Feb 2019 22:23:46 +0100
Date:   Sun, 10 Feb 2019 22:23:45 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/alternatives: check int3 breakpoint physical
 addresses
In-Reply-To: <1548428249-8258-1-git-send-email-alexandre.chartre@oracle.com>
Message-ID: <alpine.DEB.2.21.1902102221500.8784@nanos.tec.linutronix.de>
References: <1548428249-8258-1-git-send-email-alexandre.chartre@oracle.com>
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

On Fri, 25 Jan 2019, Alexandre Chartre wrote:
> Note that this issue has been observed and reproduced with a custom kernel
> with some code mapped to different virtual addresses and using jump labels
> As jump labels use text_poke_bp(), crashes were sometimes observed when
> updating jump labels.

Rightfully so. text_poke_bp() pokes at the kernels text mapping which is
very well defined and unique. Why would you map the same text to different
virtual addresses and then use a randomly chosen one to poke at it?

Thanks,

	tglx
