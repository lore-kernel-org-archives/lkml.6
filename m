Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E30ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B462B20779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B462B20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbeGWPhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:37:00 -0400
Received: from ozlabs.org ([203.11.71.1]:35627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387910AbeGWPhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:37:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Z3tk3qdMz9s3Z;
        Tue, 24 Jul 2018 00:35:26 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 23
In-Reply-To: <20180723200032.221a8f18@canb.auug.org.au>
References: <20180723200032.221a8f18@canb.auug.org.au>
Date:   Tue, 24 Jul 2018 00:35:22 +1000
Message-ID: <877elmhvf9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Changes since 20180720:
>
> Dropped trees: xarray, ida (complex conflicts)
>
> The drm-msm tree gained a conflict against the drm tree and a build
> failure due to an interaction with the drm tree for which I added a
> merge fix patch.
>
> The kvm-arm tree gained a conflict against the arm64 tree.
>
> The driver-core tree gained a conflict against the net-next tree.
>
> The xarray tree gained complex conflicts against the nvdimm tree so I have
> dropped it for today (along with the ida tree that is built on top of it).
>
> The akpm-current tree gained a conflict against Linus' tree and also a
> build failure for which I reverted a commit.
>
> Non-merge commits (relative to Linus' tree): 7606
>  7110 files changed, 316203 insertions(+), 143278 deletions(-)

Hi Stephen,

Would you mind adding my "topic/hvc" branch to linux-next.

We (ppc) are notionally the maintainers for that code but it's used by
some other folks, so I'd like it to get some wider testing before I
commit it.

You should get:

  9f65b81f36e3 ("tty: hvc: introduce the hv_ops.flush operation for hvc drivers")

cheers
