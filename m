Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4A6C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2398F218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 05:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBGFiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 00:38:07 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:42691 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfBGFiH (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 7 Feb 2019 00:38:07 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 07 Feb 2019 06:38:05 +0100
Received: from localhost.localdomain (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 07 Feb 2019 05:38:00 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, dave@stgolabs.net, linux-kernel@vger.kernel.org
Subject: [PATCH -tip 0/2] more get_user_pages mmap_sem cleanups
Date:   Wed,  6 Feb 2019 21:37:38 -0800
Message-Id: <20190207053740.26915-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two more patchlets that cleanup mmap_sem and gup abusers.
The second is also a fixlet.

Compile-tested only. Please consider for v5.1

Thanks!

Davidlohr Bueso (2):
  xsk: do not use mmap_sem
  MIPS/c-r4k: do no use mmap_sem for gup_fast()

 arch/mips/mm/c-r4k.c | 6 +-----
 net/xdp/xdp_umem.c   | 6 ++----
 2 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.16.4

