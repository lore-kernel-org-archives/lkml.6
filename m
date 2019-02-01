Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1216AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7FA2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBAWEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:04:52 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52363 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBAWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:04:52 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gpgvZ-0007mN-5H; Fri, 01 Feb 2019 23:04:49 +0100
Date:   Fri, 1 Feb 2019 23:04:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alan Mackenzie <acm@muc.de>
cc:     linux-kernel@vger.kernel.org, 34235@debbugs.gnu.org,
        Eli Zaretskii <eliz@gnu.org>,
        Alex Branham <alex.branham@gmail.com>
Subject: Re: 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94 (posix-timers: Fix
 division by zero bug). Problems with glibc.
In-Reply-To: <20190201214700.GA4950@ACM>
Message-ID: <alpine.DEB.2.21.1902012301310.8200@nanos.tec.linutronix.de>
References: <20190201214700.GA4950@ACM>
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

Hello Alan,

On Fri, 1 Feb 2019, Alan Mackenzie wrote:
> 0e334db6bb4b1fd1e2d72c1f3d8f004313cd9f94
> posix-timers: Fix division by zero bug
> Committed: 2018-12-17 17:35:45 +0100
> 
> With this patch in place I am seeing problems with glibc's function
> timer_create.  I am an Emacs maintainer, and saw these problems whilst
> investigating Emacs bug #34235 "27.0.50; lisp profiler does not work".

> Emacs's profiler fails in kernel 4.19.13, but works in a version of
> 4.19.13 with the patch reversed, otherwise unchanged.  My current version
> of glibc is 2.27-r6 (I think the "-r6" comes from Gentoo, my distro).

Please upgrade to 4.19.19. The issue should be fixed there with the
backported variant of

   93ad0fc088c5 ("posix-cpu-timers: Unbreak timer rearming")

Commit 21c0d1621b8d4b in 4.19.19

Thanks,

	tglx
