Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45702C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C86F2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546933446;
	bh=ugyEcfRAPvlo8/Nk5i0X/CyFjB5dTxfYrg5l5qqtwpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yegpQai8yg5wwYuB1PE1mhogKBQEatFZhjqesTfeZqxUln8pEKKGPEICy66ekYlnX
	 VLL/x0PIL6S3V8vjVj+641bAPqI07TOuyVb2T8e2D5pljTWh1vAslvswxtrnaifeWe
	 E30LOl2BWNZLTsq4BwYTW1UZYvmFd2t6xpft/bNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfAHHoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:44:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHHoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:44:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25ECB20700;
        Tue,  8 Jan 2019 07:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546933444;
        bh=ugyEcfRAPvlo8/Nk5i0X/CyFjB5dTxfYrg5l5qqtwpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFRqURjZwOYNIfm3IvFDIrXyFMWLYkmgWvi7YBMApPd7nf7+5s8cH9xUx51TRx/hU
         eClhOoyqcc+Kwkj+JVTCNNFzJ2s4uAWXvg5wJhgNZJ+lsAom8dPA7uQXcxYQoxovCj
         iAy3mB6FldIuA7bj6caPr+uKgNO+ThogXdM/sQYg=
Date:   Tue, 8 Jan 2019 08:44:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     sudipm.mukherjee@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH 4.14 001/101] phonet: af_phonet: Fix Spectre v1
 vulnerability
Message-ID: <20190108074402.GD2102@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <20190107105330.456283338@linuxfoundation.org>
 <CADVatmOcv31QUSHcY_TCLkjJCZ60FtYmnOPj=V5s1Q6KV_08Fw@mail.gmail.com>
 <20190107.163615.1889752317333533278.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107.163615.1889752317333533278.davem@davemloft.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:36:15PM -0800, David Miller wrote:
> From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Date: Mon, 7 Jan 2019 21:11:33 +0000
> 
> > Hi Greg,
> > 
> > On Mon, Jan 7, 2019 at 1:16 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> 4.14-stable review patch.  If anyone has any objections, please let me know.
> >>
> >> ------------------
> >>
> >> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> >>
> >> [ Upstream commit d686026b1e6ed4ea27d630d8f54f9a694db088b2 ]
> > 
> > This has been reverted upstream by f2ab95814103 ("net: Revert recent
> > Spectre-v1 patches.")
> 
> Indeed, Greg please drop this.

Now dropped from everywhere, thanks.

greg k-h
