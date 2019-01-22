Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3E121019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548148763;
	bh=IByZdug91o7KmZHLYdv1kXlr1lb8QU4slF/JJJsfa+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nzY8ZQqlnuVqpvDQLLP/AlKDaI2FfxSGjqRmH2kH7qiSDIuItRw0C3N4TOI0fpisw
	 r+NJAX9rmJWc0MvNV+ShEm9WDRncy5mNmnxoSfVBB/3/oorX91aE/5kh05z2rTczi+
	 ClsPTMxUlD0Vs6Lurcr47BQvK9FJ6GUacYtW1xPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfAVJTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfAVJTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:19:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB8420823;
        Tue, 22 Jan 2019 09:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548148760;
        bh=IByZdug91o7KmZHLYdv1kXlr1lb8QU4slF/JJJsfa+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZWOGU/l52F1XFxguERzt2DGuzdlPNLo8BA+TMJBMqBG0qySpLPyVJV9K/AIZT2eHw
         bqPa8Wppx//uY3LkuZS3P0Qbe5XfBMU40qz+92bdZOx1m456RNoIyeyenF5zraF/Tk
         B3hc/FPe4EtutJHH5f81rEBeedrt2RpjFVqIWvVI=
Date:   Tue, 22 Jan 2019 10:19:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 15/22] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
Message-ID: <20190122091917.GA16612@kroah.com>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
 <fc5f13c7e60b846f533de41b179d904a95f58aea.1547525936.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5f13c7e60b846f533de41b179d904a95f58aea.1547525936.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:18:56PM +1100, Finn Thain wrote:
> A multi-platform kernel binary has to decide at run-time how to dispatch
> the arch_nvram_ops calls. Add a platform-independent arch_nvram_ops
> struct for this, to replace the atari-specific one.
> 
> Enable CONFIG_HAVE_ARCH_NVRAM_OPS for Macs.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
> Changed since v8:
>  - Adopted nvram_read_bytes() and nvram_write_bytes() where possible.

This patch fails to apply to my tree, what did you make it against?

I tried against 5.0-rc1 :(

Can you rebase this series against the char-misc-next branch of my
char-misc.git tree and resend so that I can apply the whole series?

thanks,

greg k-h
