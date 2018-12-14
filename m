Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F41EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13336214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789204;
	bh=4pf7FxXzgRc1M0SW28xuKHBAenxdrPvyyto6ib7/rZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuoFoXX1vwiwKsm77PP+PR7IfquJNvHPKN3glSPwC5B1uwfBd8yWfHNwneb9RNnqJ
	 QzH5TyNsGJvIbf1iu3BN3XplG+tvuSjCK+87G7KQ3YoYlGLdWdGSi2cAqc9b1e0Z8t
	 afY3AAsGYSLHee2N90cd/FcnJr8jKEJ1sCHdQwI8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13336214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeLNMGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbeLNMGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED4B5214AE;
        Fri, 14 Dec 2018 12:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789199;
        bh=4pf7FxXzgRc1M0SW28xuKHBAenxdrPvyyto6ib7/rZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZBuEaUeImj0R65Uf9H8whqHvZw/pccpWav3px5SnnjeXoxS/Wm15809IQfMgrzA5a
         0hxiMNTaL0CCJgqOdeK+LKjdeyRYx6QdaXL2TS3SDsyJwhVQOWBzIpkpfqwnmDDWWx
         K4ARuoDXahACJsSbVV/eEFQOIljTyzUorpjF5F6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 133/142] flexfiles: enforce per-mirror stateid only for v4 DSes
Date:   Fri, 14 Dec 2018 13:00:18 +0100
Message-Id: <20181214115752.358204949@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>

commit 320f35b7bf8cccf1997ca3126843535e1b95e9c4 upstream.

Since commit bb21ce0ad227 we always enforce per-mirror stateid.
However, this makes sense only for v4+ servers.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/flexfilelayout/flexfilelayout.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1733,7 +1733,8 @@ ff_layout_read_pagelist(struct nfs_pgio_
 	if (fh)
 		hdr->args.fh = fh;
 
-	if (!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
+	if (vers == 4 &&
+		!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
 		goto out_failed;
 
 	/*
@@ -1798,7 +1799,8 @@ ff_layout_write_pagelist(struct nfs_pgio
 	if (fh)
 		hdr->args.fh = fh;
 
-	if (!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
+	if (vers == 4 &&
+		!nfs4_ff_layout_select_ds_stateid(lseg, idx, &hdr->args.stateid))
 		goto out_failed;
 
 	/*


