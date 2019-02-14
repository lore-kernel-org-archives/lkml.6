Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FDDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9A8222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550128279;
	bh=LzjW3ivwAmr1ajksBSECHr0HtrXdoYSEHDdYHXnSSE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zvgfsct+lOl+vjmYTj5GnDUpAyXBTc0oe21//Maeqhe0MiEcbs1w7w3h0ndvaMoby
	 +XR5cZCm4Ww+O1vVinmKmhBXspk/PuXIc+bmSCVIedZ7WOCe5fITyQ//PCpXGIWlfb
	 e888qjWZaUHoRKxu2Hsyz31pStLqoLpsxhQOj0X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437173AbfBNHLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:11:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387523AbfBNHLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:11:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5894C222A4;
        Thu, 14 Feb 2019 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550128276;
        bh=LzjW3ivwAmr1ajksBSECHr0HtrXdoYSEHDdYHXnSSE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZsN9pjicmxiOKIRQOUyoNZAJUX5o0Dy8DUcyVNmILtn4lcMkYJm4eNkwZtSG/u+u
         /XIPB946zUL6To62nVuZ4sgLVZ8f+QiUF+5N1+t4f/Gejii7AaK1/zYlheKv+O2lky
         rDAgX9PhuRgGsf3Fcq6Yv/VA66dvuJu6x1VeDoQs=
Date:   Thu, 14 Feb 2019 08:11:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rppt@linux.ibm.com, olof@lixom.net,
        ogabbay@habana.ai, arnd@arndb.de, joe@perches.com
Subject: Re: [PATCH v4 00/15] Habana Labs kernel driver
Message-ID: <20190214071114.GA21381@kroah.com>
References: <20190211151751.12336-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211151751.12336-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 05:17:36PM +0200, Oded Gabbay wrote:
> Hello,
> This is v4 of the Habana Labs kernel driver patch-set. It contains fixes
> according to reviews done on v3, mainly for the command buffer, sysfs and MMU
> patches. In addition, patch 2/15 was reduced in size from 4.3MB to 1.4MB.
> 
> The patch-set is rebased on v5.0-rc6.
> 
> Link to v3 cover letter: https://lkml.org/lkml/2019/2/4/1033
> 
> Link to v2 cover letter: https://lkml.org/lkml/2019/1/30/1003
> 
> Link to v1 cover letter: https://lwn.net/Articles/777342/
> 
> I would appricate any feedback, question and/or review.

There's been some 0-day bot feedback on some of these patches now that I
put them in my -testing branch.  So I'm going to drop the patch series
from there now and wait for a v5 of the series that hopefully will have
those issues fixed :)

thanks,

greg k-h
