Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD2C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEF020671
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEF020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeHWS7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:59:30 -0400
Received: from fieldses.org ([173.255.197.46]:52812 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeHWS73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:59:29 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D52B3189; Thu, 23 Aug 2018 11:29:20 -0400 (EDT)
Date:   Thu, 23 Aug 2018 11:29:20 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [GIT PULL] nfsd changes for 4.19
Message-ID: <20180823152920.GE32415@fieldses.org>
References: <20180823125810.GC32415@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823125810.GC32415@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, I messed up my pull request.  The result was just a few
commits mentioned in the tag description but missing from the tip of the
branch, and I thought simplest was to make a new tag and a new pull
request with the additional commits, I hope that works OK.  Thanks to
Chuck for noticing the problem quickly.  Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-4.19-1

--b.

----------------------------------------------------------------
A mistake on my part caused me to tag my branch 6 commits too early,
missing Chuck's fixes for the problem with callbacks over GSS from
multi-homed servers, and a smaller fix from Laura Abbott.

----------------------------------------------------------------
Chuck Lever (5):
      sunrpc: Enable the kernel to specify the hostname part of service principals
      sunrpc: Extract target name into svc_cred
      nfsd: Use correct credential for NFSv4.0 callback with GSS
      nfsd: Remove callback_cred
      sunrpc: Add comment defining gssd upcall API keywords

Laura Abbott (1):
      sunrpc: Don't use stack buffer with scatterlist

 fs/nfsd/nfs4callback.c                | 29 ++++-----------
 fs/nfsd/nfs4state.c                   | 17 ++++-----
 fs/nfsd/state.h                       |  2 -
 include/linux/sunrpc/svcauth.h        |  3 ++
 net/sunrpc/auth_gss/auth_gss.c        | 37 ++++++++++++++++--
 net/sunrpc/auth_gss/gss_krb5_crypto.c | 12 ++++--
 net/sunrpc/auth_gss/gss_rpc_upcall.c  | 70 ++++++++++++++++++++++-------------
 7 files changed, 106 insertions(+), 64 deletions(-)
