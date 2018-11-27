Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22F720989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYpgiyPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22F720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbeK0S4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbeK0S4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:56:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7B22086B;
        Tue, 27 Nov 2018 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543305540;
        bh=KOUaHmeRcaqt40gU7nSXSoj4Mp98xxzsjip0axFtm3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYpgiyPY409GwUCMsr0EsGQF18QXjR/I8p8mvvZeTMl9ITL5aDQFfhMsJvMD6/G4u
         sqZo9Ei21Epg714mnTguAMo2t8QfOE5gBGF8Sf99K/DTPbATU/muUuVQNTWx+NdV1x
         h7/H/ORc86sFD4FlZZhH6L8ym1+uUgRKzaQK5IWM=
Date:   Tue, 27 Nov 2018 08:58:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     peng.hao2@zte.com.cn
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  misc/pvpanic: resolve compile errors for arch=um
Message-ID: <20181127075858.GB929@kroah.com>
References: <20181127072457.GA10278@kroah.com>
 <201811271547282511023@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201811271547282511023@zte.com.cn>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 03:47:28PM +0800, peng.hao2@zte.com.cn wrote:
> >> >On Fri, Nov 16, 2018 at 07:13:26PM +0800, Peng Hao wrote:
> >> >> Resolve compile error for arch=um
> >> >> pvpanic.c:(.text+0xb6): undefined reference to `devm_ioremap_resource'
> >> >>
> >> >> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >> >> ---
> >> >>  drivers/misc/Kconfig | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> >What commit is this fixing?  What broke and when did it break?
> >> kbuildtestrobot reports this compile  error for arch=um.
> >> here is content:
> >> " head:   24438e46268c721e14c5c888386af85c9e1c5db1
> >> commit: 77703e0b0326a1fb06b5cb5b468a633472c5a8e9 [10/26] misc/pvpanic : break dependency on ACPI
> >
> >Ah, it is breaking because of your patch, not a patch in the kernel
> >today.  So please integrate this patch into your latest patch series
> >when you redo your patches.
> >
> The series of patches has merged into "char-misc-next"
> (https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next),
> Do I need to re-send the entire series of patches ? 

Ah, I didn't realize that.  Ok, let me go dig this back up and add it
to my tree, sorry for the noise...

greg k-h
