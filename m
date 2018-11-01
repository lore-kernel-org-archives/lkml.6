Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D890DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A74F2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vXVMfNuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A74F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeKALjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:39:42 -0400
Received: from casper.infradead.org ([85.118.1.10]:48178 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeKALjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sKqnXYtUN+i9lIzenH1KfqTTBhM3hD3MRc4yLoaDKx4=; b=vXVMfNuLqxV7jlV2kk24Eex78n
        iyNjBDnQuurxRD52Lm6zjB3XBR59OEjDiCY/QGbEmiN3udDUZpATdazfwVsIMuWUFGG0smOeB7O1X
        q4fbKq9/7P0TgFgArphWpyX9rINtRsThyo0kn/AdMkt9hOUfEiv4o2KcTCHEo5CYjrFTmAPN75Y/u
        /i1m3DW4pcrqyJs2vjdwSUXXi0aV/lr7MUJSMrR5y9qB+GHcLrmm+mQtJBrInwfqArx/vvq8U5jRm
        PT/KJeGYIjxKpBdBtIUp+ud2r5I2q7PdDKouxatVBinQR09NLDSLRsg0hjID74dgS3B/S+rmhs6jN
        p5awEavA==;
Received: from 177.206.134.103.dynamic.adsl.gvt.net.br ([177.206.134.103] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI2sc-0004a4-9J; Thu, 01 Nov 2018 02:38:42 +0000
Date:   Wed, 31 Oct 2018 23:38:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: linux-next: build warning in Linus' tree tree
Message-ID: <20181031233825.2724585f@coco.lan>
In-Reply-To: <20181101082820.76abf19e@canb.auug.org.au>
References: <20181101082820.76abf19e@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 1 Nov 2018 08:28:20 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> Building Linus' tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> ./usr/include/linux/v4l2-controls.h:1105: found __[us]{8,16,32,64} type without #include <linux/types.h>
> 
> Introduced by commit
> 
>   c27bb30e7b6d ("media: v4l: Add definitions for MPEG-2 slice format and metadata")
> 

Somehow, I missed this warning. I'll send soon a fix for it.


Thanks,
Mauro
