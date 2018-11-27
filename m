Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6D8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216C021104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yuHiz7sE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216C021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeK0SV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:21:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbeK0SV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:21:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E4B2086B;
        Tue, 27 Nov 2018 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543303501;
        bh=qZYiD46H9ev0ddS9ueG3seC8QXna3kvQVWKfljsRN/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yuHiz7sEhrc1ttihJkwY8oPn2o5HMqXUSom9ck1ZLmvjg3Za0I9bMyfMq8BUOq/qg
         JL9OFDE/fYVKtEvpNqM0YqLxS920xG3S0VeLCPFoIXGA0XKKTlg905WIz8tuMhZ29i
         opEBp+Df4vd3wDUZc8+q/HZH9UzpeXjYRyq7H+2U=
Date:   Tue, 27 Nov 2018 08:24:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     peng.hao2@zte.com.cn
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  misc/pvpanic: resolve compile errors for arch=um
Message-ID: <20181127072457.GA10278@kroah.com>
References: <20181126195331.GA1720@kroah.com>
 <201811270827031748068@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811270827031748068@zte.com.cn>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:27:03AM +0800, peng.hao2@zte.com.cn wrote:
> >On Fri, Nov 16, 2018 at 07:13:26PM +0800, Peng Hao wrote:
> >> Resolve compile error for arch=um
> >> pvpanic.c:(.text+0xb6): undefined reference to `devm_ioremap_resource'
> >>
> >> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >> ---
> >>  drivers/misc/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> >What commit is this fixing?  What broke and when did it break?
> kbuildtestrobot reports this compile  error for arch=um.
> here is content:
> " head:   24438e46268c721e14c5c888386af85c9e1c5db1
> commit: 77703e0b0326a1fb06b5cb5b468a633472c5a8e9 [10/26] misc/pvpanic : break dependency on ACPI

Ah, it is breaking because of your patch, not a patch in the kernel
today.  So please integrate this patch into your latest patch series
when you redo your patches.

thanks,

greg k-h
