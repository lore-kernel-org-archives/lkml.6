Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81967C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D66E21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545212766;
	bh=h0f14PZ4LwED5eW8kr4Nt+kke98V2FiplZHB432/Q2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d7+fndrw4Ee5ZlYRbxrZ/+jhzwCOojhucA1ToNkyRHG1riMnJAjKxrvbYmLuu0hTI
	 UDqBHxrrenYdEOUE7BXRX+5HAzz3LjNUP8ouxSFmwUpHWzCZsrrZNw6gZyZoILsHoQ
	 sPhVUd6zl2+CwatDrS9lgxtJ5jRWAHfT3rp83h7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbeLSJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbeLSJqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:46:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4AFC20873;
        Wed, 19 Dec 2018 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545212764;
        bh=h0f14PZ4LwED5eW8kr4Nt+kke98V2FiplZHB432/Q2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fddfKjuMrkH7Fm0i6ycuXZl1WTsijMVi2E7Xd+VxSYKk/zUb8jIEvk4hIY6RprEvC
         xWGOsudsLc3IohVvb3Kr96hY4jh3Ihwo7S3/ni5LGIN+nKhtByk+usZS8XLxN2O2W6
         g5ptzJNSY+6TPfsnaEY2EKysvEZJdRGPs3QKuXQw=
Date:   Wed, 19 Dec 2018 10:46:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     peng.hao2@zte.com.cn
Cc:     arnd@arndb.de, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/3]  misc/pvpanic: return 0 for empty body
 registerfunction
Message-ID: <20181219094601.GB11441@kroah.com>
References: <20181219082806.GA31421@kroah.com>
 <201812191703216682499@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812191703216682499@zte.com.cn>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 05:03:21PM +0800, peng.hao2@zte.com.cn wrote:
> >> Return 0 for empty body register function normally.
> >>
> >> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> >> ---
> >> v4 --> v5 : handle all typo "drvier/driver" in funtion name.
> >>
> >> v3 --> v4 : use pcim* function instead of pci* function.
> >>             handle typo "drvier/driver" in funtion name.
> >>
> >> v2 --> v3 : handle a uninitialized variable in some path.
> >>
> >> v2 --> v1 : arch=sh don't support pci, adjust  CONFIG_PCI macro.
> >>
> >> v1 : QEMU community requires additional PCI devices to simulate PVPANIC devices
> >> so that some architectures can not occupy precious less than 4G of memory
> >> space.
> >
> >Have you also fixed the kbuild issues that keep getting reported?
> >
> 
> yes.  v2--> v1 fixed the first kbuild issue.
>          v2--> v3 fixed the second kbuild issue.
>          v4 -->v5 fixed the last two kbuild issues.

And why did you not list all of this?  Am I supposed to just guess it?
:(

