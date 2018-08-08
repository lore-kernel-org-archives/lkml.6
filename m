Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F741C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E77721B31
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E77721B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbeHIBDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:03:13 -0400
Received: from nautica.notk.org ([91.121.71.147]:47021 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729729AbeHIBDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:03:13 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 716D7C009; Thu,  9 Aug 2018 00:41:26 +0200 (CEST)
Date:   Thu, 9 Aug 2018 00:41:11 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>,
        David Miller <davem@davemloft.net>,
        v9fs-developer@lists.sourceforge.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] 9p: fix NULL pointer dereferences
Message-ID: <20180808224111.GB12890@nautica>
References: <20180726081049.10527-1-tomasbortoli@gmail.com>
 <20180726081727.GA6699@nautica>
 <CACT4Y+ark+0EYSZaOX-qDKpOkyfLgSO9CkidZzx=xkUuhpr65A@mail.gmail.com>
 <20180726094849.GA18334@nautica>
 <abbeafa2-9008-5749-aee5-b4a115d71af7@gmail.com>
 <20180726142109.GA4235@nautica>
 <baa7368f-e149-ef3d-cf10-4fcd16dce0e6@gmail.com>
 <20180726221527.GA9426@nautica>
 <CACT4Y+Z+Q__-cMaQ-85H38Rs5AeFGitXoE8-Bv4pNsvat+G+xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z+Q__-cMaQ-85H38Rs5AeFGitXoE8-Bv4pNsvat+G+xQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote on Wed, Aug 08, 2018:
> > If you want to factor it in, v9fs_mount does not know which transport is
> > used, but p9_client_create does know - although the functions/structs
> > are all static so you need to check clnt->trans_mod->name with strcmp
> > and I'm honestly not sure that's better than checking in each function..
> >
> > But, as usual I'm happy as long as it works, so pick your poison :)
> 
> So let's proceed with checking in each transport function?

Yes, he's done it a while ago, just didn't se the in-reply-to field to
keep part of the thread but the Reported-by was here:
http://lkml.kernel.org/r/20180727110558.5479-1-tomasbortoli@gmail.com

This is in linux-next right now as 631263a1b23c71

-- 
Dominique
