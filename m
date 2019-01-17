Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CCCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7DE20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfAQQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:29:27 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:54793 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfAQQ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:29:26 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 33604200B1;
        Thu, 17 Jan 2019 17:29:23 +0100 (CET)
Date:   Thu, 17 Jan 2019 17:29:21 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: SUBDIRS= replacement
Message-ID: <20190117162921.GB31768@ravnborg.org>
References: <20190117145531.GA21429@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117145531.GA21429@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=P129rOOtknyQ5eiTGjUA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Thu, Jan 17, 2019 at 03:55:31PM +0100, Christoph Hellwig wrote:
> Hi Masahiro, hi Michal,
> 
> I just got this beatiful warning:
> 
> hch@carbon:~/work/xfs$ make -j4 SUBDIRS=fs/xfs
> Makefile:189: ================= WARNING ================
> Makefile:190: 'SUBDIRS' will be removed after Linux 5.3
> Makefile:191: Please use 'M=' or 'KBUILD_EXTMOD' instead
> Makefile:192: ==========================================
> 
> Both the replacement seem to be geared towards building externals
> modules.  But what is the replacement for just building a directory
> of the normal kernel tree?
> 
> E.g. what hit this is that I rebased an XFS series, and wanted to
> compile test just the xfs code for each step using
> 
> make -j4 SUBDIRS=fs/xfs

Try:

make -j4 fs/xfs/

This is the recommend way to do so.
Let us know if you see problem with this approach.

	Sam

