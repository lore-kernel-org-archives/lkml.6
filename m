Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3140C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24E520844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24E520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeIHPtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:49:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37506 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIHPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:48:59 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyb1X-0006nF-Ox; Sat, 08 Sep 2018 13:03:31 +0200
Date:   Sat, 8 Sep 2018 13:03:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 00/10] Removing SEND_SIG_FORCED
In-Reply-To: <87musyl3fa.fsf@xmission.com>
Message-ID: <alpine.DEB.2.21.1809081302350.1402@nanos.tec.linutronix.de>
References: <87musyl3fa.fsf@xmission.com>
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

On Mon, 3 Sep 2018, Eric W. Biederman wrote:
 
> SEND_SIG_FORCED has two functions.  It forces a pid namespace init to
> receive a signal it would ordinarily ignore, and it causes a siginfo to
> not be allocated for a signal.
> 
> This patchset makes __send_signal a little bit smarter so that it can
> detect when to apply these optimizations and the senders of signals
> don't have to worry about them.
> 
> The coupling of forcing a signal to the pid namespace init and not
> allocating siginfo resulted in serveral minor bugs where a signal
> sent by the kernel was marked SI_USER suggesting another userspace
> process sent that signal.  I have cc'd linux-api in case anyone cares
> about these minor userspace visible differences.
> 
> Unless someone notices a bug I intend to merge these changes through my
> tree during the next merge window.   While there are numerous fixes here
> none of them appear to be the kind that fixes real world problems so I
> don't see any urgency here.
> 
> Please look read and send my your review.  I will be out for about a
> week so I will address any comments when I get back.

Went through it carefuly and could not spot anything. Great work!

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

