Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A42DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D18920663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D18920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeKZSt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:49:29 -0500
Received: from verein.lst.de ([213.95.11.211]:50185 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbeKZSt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:49:29 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 99B9568BDF; Mon, 26 Nov 2018 08:56:11 +0100 (CET)
Date:   Mon, 26 Nov 2018 08:56:11 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Sterba <dsterba@suse.cz>, Kees Cook <keescook@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: build warning after merge of the btrfs-kdave tree
Message-ID: <20181126075611.GA799@lst.de>
References: <20181126110629.45969c51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126110629.45969c51@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:06:29AM +1100, Stephen Rothwell wrote:
> Introduced by commit
> 
>   cf8cddd38bab3 ("btrfs: don't abuse REQ_OP_* flags for btrfs_map_block")
> 
> exposed by my new use of -Wimplicit-fallthrough
> 
> I am not sure why this has only turned up now (as opposed to earlier
> today).

It looks like something only in linux-next moved the code around a bit.

Either way the fallthough looks fine, it will just need a little
/*FALLTHRU*/ annotation.
