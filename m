Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5725E20875
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5725E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeGMVDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:03:39 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:56390 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731564AbeGMVDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:03:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0C903608897D;
        Fri, 13 Jul 2018 22:47:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ps6FMl-HsBTU; Fri, 13 Jul 2018 22:47:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A591C608897E;
        Fri, 13 Jul 2018 22:47:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0XM6uKqlzo5G; Fri, 13 Jul 2018 22:47:21 +0200 (CEST)
Received: from blindfold.localnet (213-225-2-247.nat.highway.a1.net [213.225.2.247])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 6676F608897D;
        Fri, 13 Jul 2018 22:47:21 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] [RESEND] jffs2: use 64-bit intermediate timestamps
Date:   Fri, 13 Jul 2018 22:47:13 +0200
Message-ID: <2205649.NecG7tB80L@blindfold>
In-Reply-To: <20180713144739.3150217-1-arnd@arndb.de>
References: <20180713144739.3150217-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. Juli 2018, 16:47:16 CEST schrieb Arnd Bergmann:
> The VFS now uses timespec64 timestamps consistently, but jffs2 still
> converts them to 32-bit numbers on the storage medium. As the helper
> functions for the conversion (get_seconds() and timespec_to_timespec64())
> are now deprecated, let's change them over to the more modern
> replacements.
> 
> This keeps the traditional interpretation of those values, where
> the on-disk 32-bit numbers are taken to be negative numbers, i.e.
> dates before 1970, on 32-bit machines, but future numbers past 2038
> on 64-bit machines.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I originally sent these two patches on Jun 19, but got no reply aside
> from a harmless sparse warning reported by the kbuild test robot.
> 
> Looking at the git history for jffs2, it seems that David Woodhouse
> hasn't applied any patches for over two years, so I suppose he's
> not taking these either.
> 
> Al or Andrew, could you pick these up instead?

We can carry it also via the MTD tree.

Thanks,
//richard
