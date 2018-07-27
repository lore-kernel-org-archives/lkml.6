Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66CF2089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GSpaDYmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66CF2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbeG0LyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:54:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbeG0LyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TZdq/khbKx87tq+zY1V5s7m8egq8T6gFVIiGCEyQXEU=; b=GSpaDYmndTe4VWslbxK8z04g/
        i8gw7Sl6eH20OQbaE8omTfpplXOgAzEzZnw98gwlFninRcjmQjO43XTi9B4YN3llVE8aLVS0+q/UN
        Y0/0doloIfuzkDzZmp1TPxNxscOWxYm0AeYk+wpFb4R27N1Omjp8znkTMg90FqWsIMysIxpreGcAJ
        yqaAnwSCmwEgcCANO2JAvL9DSoHF8hFw1hIy8nHMFCEs7+pR+Eitb2zoJ2wDoZWquFN0KXOJzNsPs
        EwZvMsM2u8GwdsmFFusq/vwxQepeqXV1VBWtUNl8oqU8YuFy9lRiRdj8mHspqj3krSEKIj/RBY4an
        majpSStdw==;
Received: from 179.176.120.227.dynamic.adsl.gvt.net.br ([179.176.120.227] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fj03E-0007jt-5F; Fri, 27 Jul 2018 10:32:48 +0000
Date:   Fri, 27 Jul 2018 07:32:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>
Subject: Re: linux-next: manual merge of the drm tree with the v4l-dvb tree
Message-ID: <20180727073242.4b18aa05@coco.lan>
In-Reply-To: <20180727143640.4dc3fa54@canb.auug.org.au>
References: <20180727143640.4dc3fa54@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 27 Jul 2018 14:36:40 +1000
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> Today's linux-next merge of the drm tree got a conflict in:
> 
>   drivers/gpu/ipu-v3/ipu-cpmem.c
> 
> between commit:
> 
>   343b23a7c6b6 ("media: gpu: ipu-v3: Allow negative offsets for interlaced scanning")
> 
> from the v4l-dvb tree and commit:
> 
>   4e3c5d7e05be ("gpu: ipu-v3: Allow negative offsets for interlaced scanning")
> 
> from the drm tree.
> 
> I fixed it up (I just used the drm tree version) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

My mistake. Not sure why media ML was c/c on this patch. As the author
is an usual media contributor and we have an IPU3 driver that has being
taking some discussions those days, I ended by merging it without
noticing that it was for the gpu driver.

I'll remove it from my tree in order to avoid conflicts.

Thanks,
Mauro
