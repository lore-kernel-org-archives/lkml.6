Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65511C10F02
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3420921905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550568314;
	bh=LiqV+mhvAnV97a6C+gfQ6+PX7bhlyIJYx3vJUHVE+/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fSf8A/mv4VS+v3/Kd8jQlNejGgV0kqvjuW0aPdWh38rKobBvrE13Khn9hCZmQ42Ou
	 x0f52CFZLHwKL7oL63THSMd3GtIahmkehD4Xtj1pm2tAYYoZA2SsxCvD84sjC3Sifg
	 3E8FMVpgStbdkFp9M4YZ9jz37Nsw6CltAQhOqw9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBSJZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfBSJZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:25:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B11921848;
        Tue, 19 Feb 2019 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550568310;
        bh=LiqV+mhvAnV97a6C+gfQ6+PX7bhlyIJYx3vJUHVE+/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vsMQ3AGzhm+mRRrKpiO/zoTEPEYC/Nzj16dHTySammVupLRd9MDz7OF11EltOlNWc
         T03M5P2ggs24BLDRTkNR276u7EDUtb6C7pMMqXoNQYw/pj6wXZ3APA5ACvREGZDRYM
         UwoX4WTIoI1AFhcOBcrx8fSH8em6hYhmY9AcKRWc=
Date:   Tue, 19 Feb 2019 10:25:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 04/62] uapi/if_ether.h: prevent redefinition of
 struct ethhdr
Message-ID: <20190219092507.GB30490@kroah.com>
References: <20190218133505.801423074@linuxfoundation.org>
 <20190218133506.144278426@linuxfoundation.org>
 <CADVatmNFN8scfVrTnb4UFEUVxEc1CAGTHa=6YsRpaUcYBubLuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNFN8scfVrTnb4UFEUVxEc1CAGTHa=6YsRpaUcYBubLuQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:33:38PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Mon, Feb 18, 2019 at 1:56 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > commit 6926e041a8920c8ec27e4e155efa760aa01551fd upstream.
> 
> This has been fixed upstream by da360299b673 ("uapi/if_ether.h: move
> __UAPI_DEF_ETHHDR libc define")

Thanks!  now queued up.

greg k-h
