Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310E7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D892087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548777695;
	bh=+TMEg19uHPDseH/5sgT51/L59/zG9LXUogtoRycIMI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lajufG/XeRlK1vzMBh3mMkESbtGDJLl/Fcu4KHjzZGr/tIYYkfCmNa+pXsSPG6ftG
	 fsWP8X31oup+i9EOygKmfzYFfMHTpYysZxpXE7ejLBfq6Dh7m56oSEaUfSWlODKRbH
	 G9JVOzdJcF3PuwkrpooEtoN9JK5twIe0/prva63k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfA2QBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:01:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfA2QBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:01:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 218932087E;
        Tue, 29 Jan 2019 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548777692;
        bh=+TMEg19uHPDseH/5sgT51/L59/zG9LXUogtoRycIMI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YyxIi8nhoV0MI8wSZPxGP+6CiKcVgYk/cPLk2R90YM4DfDWcJndDiimdp7rDwwpYF
         bSJw08Ckb9b8oDe+4yS9qB0UAXB+pjUN+Zp6MqNE9nVoDdOlXNnL4V/sdWIiL23r+/
         1KG8/tkmxd2t8gnEIiOgKNogz4SSK+zgNelkmubg=
Date:   Tue, 29 Jan 2019 17:01:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: 64bit IO
Message-ID: <20190129160130.GA19439@kroah.com>
References: <20190129154102.17655-1-vladimir.kondratiev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129154102.17655-1-vladimir.kondratiev@linux.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:41:02PM +0200, Vladimir Kondratiev wrote:
> implement missing io{read|write}64
> 
> For 64-bit platforms, these 64-bit io functions are defined in
> include/asm-generic/iomap.h,
> but actual implementation missing. Provide it.

What is in include/asm-generic/io.h?

$ git grep iowrite64be | grep generic
include/asm-generic/io.h:#ifndef iowrite64be
include/asm-generic/io.h:#define iowrite64be iowrite64be
include/asm-generic/io.h:static inline void iowrite64be(u64 value, volatile void __iomem *addr)
include/asm-generic/iomap.h:extern void iowrite64be(u64, void __iomem *);

so are you sure this is needed?

What code is failing to build for you?

thanks,

greg k-h
