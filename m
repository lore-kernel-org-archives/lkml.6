Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6899EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346E1214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547017671;
	bh=nReNoRqnajSDaFhCgO28QDqDsg8G2Ol4sa3cZdoV2bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SwRSFx0xOmOI0n2e+oVoJecMk59CG8tEkG1UBxKQlNTdf9VGt7aGgr2ZSDOI6huLf
	 ugHesK/+tQ2CEXKtk+c8wa9gA7HAY1ssQ6srGtfCPSCaNq3Saz8LxCtnc+q5IanrMk
	 y/KCAE4Ql+ko1K+Hwji2t1iaVZoYj6Jebd3NPwWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfAIHHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbfAIHHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:07:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C341420821;
        Wed,  9 Jan 2019 07:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547017669;
        bh=nReNoRqnajSDaFhCgO28QDqDsg8G2Ol4sa3cZdoV2bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uu5+qYsxbHBWK/NV5GFVUUtVxR6WoBprNcljYwOjquyr7chmw94HQ7VT4MDcVu0ty
         xAnGwIENu7wFsBH3zzN67GYHDjtHI/YfXlve8WUsS4NEWngAmCgXTnvdzfp3mMs86t
         K4pEQQLzbx1kRgPzxkF5zt3UnyDwM8H7xm2Xy2Ds=
Date:   Wed, 9 Jan 2019 08:07:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drivers: platform: goldfish: goldfish_sync: add a
 driver
Message-ID: <20190109070746.GA20817@kroah.com>
References: <20190107185039.190919-1-rkir@google.com>
 <20190107185039.190919-3-rkir@google.com>
 <20190108121335.GA3349@kroah.com>
 <CAOGAQepF4R8ry+irPxeL=G0yFqhxRmkMWd_iPGYOTFzdZSj6iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQepF4R8ry+irPxeL=G0yFqhxRmkMWd_iPGYOTFzdZSj6iQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 04:48:02PM -0800, Roman Kiryanov wrote:
> > Also, why is this driver needed at all?  Why can't you use the "normal"
> > drm sync api interface?  Why write a custom ioctl driver just for this
> > one kernel interface?
> 
> This driver allows us to talk to host's sync api.

That describes what your code does, yes, but you did not answer my
question at all.  Why do you need this?  What are you trying to do?  And
why is this so different from any other drm driver?

thanks,

greg k-h
