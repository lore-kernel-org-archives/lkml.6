Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D46EC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF131214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548057705;
	bh=9SWjkjqwgi1ZCdmGJA4NlfIkPiIjZnJawI/FCgxHItw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pe0RnthZGdyjvtM8LvxaTEcpG3vsz5bEsnhmZRpBskW/a60vFxk4+Aby41/YnPIY+
	 8uuo70MHLvex6d2UfzMQaZW3Ug213jYeSY63hX5bPlQJWf0LzXAnICqVc/fmzSD3aa
	 slABex0yS/ztpB8ewlkR8QlTd1UQcjT17IVdlzl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfAUIBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbfAUIBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:01:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858E620823;
        Mon, 21 Jan 2019 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548057702;
        bh=9SWjkjqwgi1ZCdmGJA4NlfIkPiIjZnJawI/FCgxHItw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QILGcOr+7ba/55l5XXJy6EfX1F8Uyz+vQo1Lff91vTiTBneXhJQYY6Q90Zk9b/K2b
         YYdXzGyvK8/vHBAganJAPpRSn1zEyCkxsagN6Bmdm8sfG3ZAlD6fNnZipgLANbCRkx
         a0AdLisgAUtF53k7HMmQ6q/2Op+g+uo0MPrTOTTs=
Date:   Mon, 21 Jan 2019 09:01:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [BUG] USB: atm: Licensing conflict
Message-ID: <20190121080139.GB29934@kroah.com>
References: <alpine.DEB.2.21.1901181150090.1647@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901181150090.1647@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:53:18AM +0100, Thomas Gleixner wrote:
> The addition of SPDX identifiers to the USB subsystem introduced a license
> conflict. The driver is dual licensed under GPL v2 and BSD 2 clause
> according to the license texts in the file. But even the GPL v2 licensing
> of this driver is ambiguous:
> 
>  * This software is available to you under a choice of one of two
>  * licenses. You may choose to be licensed under the terms of the GNU
>  * General Public License (GPL) Version 2, available from the file
>  * COPYING in the main directory of this source tree, or the
> 
> This points to the kernel license which is GPL v2 only.
> 
>  * BSD license below:
>  *
>  * Redistribution and use in source and binary forms, with or without
>  * modification, are permitted provided that the following conditions
>  * are met:
>  * 1. Redistributions of source code must retain the above copyright
>  *    notice [unmodified], this list of conditions, and the following
>  *    disclaimer.
>  * 2. Redistributions in binary form must reproduce the above copyright
>  *    notice, this list of conditions and the following disclaimer in the
>  *    documentation and/or other materials provided with the distribution.
>  *
>  * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
>  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
>  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
>  * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
>  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
>  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
>  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
>  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
>  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
>  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>  * SUCH DAMAGE.
> 
> This is clearly a BSD 2 Clause license and not BSD 3 Clause
> 
>  * GPL license :
>  * This program is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public License
>  * as published by the Free Software Foundation; either version 2
>  * of the License, or (at your option) any later version.
> 
> And here the license is GPL V2 or later.
> 
> Some detective work is due ...

Yes, this is on my todo list to fix up, thanks for reminding me of the
problems here.

greg k-h

> 
> Thanks,
> 
> 	tglx
