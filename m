Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16F5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34C82147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfBGFu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:50:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:60512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfBGFu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 00:50:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28E4FAD6B;
        Thu,  7 Feb 2019 05:50:26 +0000 (UTC)
Date:   Wed, 6 Feb 2019 21:50:20 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip 0/2] more get_user_pages mmap_sem cleanups
Message-ID: <20190207055020.2czn72rk6fwpz7nu@linux-r8p5>
Mail-Followup-To: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190207053740.26915-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190207053740.26915-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike what the subject says, this is not against -tip, it applies
on today's -next.

On Wed, 06 Feb 2019, Davidlohr Bueso wrote:

>Hi,
>
>Here are two more patchlets that cleanup mmap_sem and gup abusers.
>The second is also a fixlet.
>
>Compile-tested only. Please consider for v5.1
>
>Thanks!
>
>Davidlohr Bueso (2):
>  xsk: do not use mmap_sem
>  MIPS/c-r4k: do no use mmap_sem for gup_fast()
>
> arch/mips/mm/c-r4k.c | 6 +-----
> net/xdp/xdp_umem.c   | 6 ++----
> 2 files changed, 3 insertions(+), 9 deletions(-)
>
>-- 
>2.16.4
>
