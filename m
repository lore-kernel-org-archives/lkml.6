Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2629C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC6F2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392330AbfBOWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:01:03 -0500
Received: from fieldses.org ([173.255.197.46]:39820 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbfBOWBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:01:02 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 7E7C11CE7; Fri, 15 Feb 2019 17:01:02 -0500 (EST)
Date:   Fri, 15 Feb 2019 17:01:02 -0500
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more nfsd fixes for 5.0
Message-ID: <20190215220102.GD22354@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull nfsd bugfixes from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.0-2

Two small fixes, one for crashes using nfs/krb5 with older enctypes, one
that could prevent clients from reclaiming state after a kernel upgrade.

--b.

J. Bruce Fields (1):
      Revert "nfsd4: return default lease period"

Scott Mayhew (1):
      sunrpc: fix 4 more call sites that were using stack memory with a scatterlist

 fs/nfsd/nfsctl.c                      |  4 +--
 net/sunrpc/auth_gss/gss_krb5_seqnum.c | 49 +++++++++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 13 deletions(-)
