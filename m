Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C72C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AE82085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfAGGxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:53:46 -0500
Received: from verein.lst.de ([213.95.11.211]:52908 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGGxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:53:46 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5F1E868C8E; Mon,  7 Jan 2019 07:53:44 +0100 (CET)
Date:   Mon, 7 Jan 2019 07:53:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the csky tree with Linus' tree
Message-ID: <20190107065344.GA11989@lst.de>
References: <20190107102727.0c67e3d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107102727.0c67e3d7@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:27:27AM +1100, Stephen Rothwell wrote:
> You want to add "select ARCH_NO_SG_CHAIN" to your Kconfig somewhere
> (see the commit from Linus' tree above).

No, csky should not select it.  There is no code directly poking
into scatterlists internals in csky, so it can safely enable chained
sglists.
