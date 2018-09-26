Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B47C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7FA21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eNrRKPEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7FA21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeIZXxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:53:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeIZXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mq/KVVDq5oYZWt2QxJWTn2+Z8gX47B21yrOrHlYqnx8=; b=eNrRKPEkWoYpIgvFwli2KRfAU
        ShxtpkK1VuPu+Ay69yV9ASzTVq17mRMxMbfuH+qV0MsZkLso3pt13QwutoemaFcqu5cnI8dq7Kgz/
        thhLBxlkIv9vcke9qZCdzmbLA+iU4x2vOjHs9rm2utMSXedu8dOpBsFb6yuCDIoI6YpkLEbzSu1Nz
        g3y+NnLQqEV8rom5sBMCFJ2O8YZXjhsfIH55l8WBIu1MSE8QWpbXUQjogWeDx6OYD3OKoLAKthE8a
        Qplj3QgGb0CpL9r23nO1IZxAlU1lauLu0lUfYvqMVeaUUAXGIgweFtm++Fyo+rCAXIBxvOmkzumzs
        /5rjvRkLQ==;
Received: from 177.43.23.201.dynamic.adsl.gvt.net.br ([177.43.23.201] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5Dmf-0002rD-1L; Wed, 26 Sep 2018 17:39:42 +0000
Date:   Wed, 26 Sep 2018 14:39:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926143928.56f1f079@coco.lan>
In-Reply-To: <20180926161749.GI5584@zn.tnic>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
        <20180925152659.GE23986@zn.tnic>
        <20180925175023.GA16725@agluck-desk>
        <20180925180458.GG23986@zn.tnic>
        <20180926093510.GA5584@zn.tnic>
        <20180926152752.GG5584@zn.tnic>
        <20180926130340.6b22918b@coco.lan>
        <20180926161749.GI5584@zn.tnic>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 26 Sep 2018 18:17:49 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Wed, Sep 26, 2018 at 01:03:40PM -0300, Mauro Carvalho Chehab wrote:
> > I guess this is/was needed to create things like this:
> > 
> > 	lrwxrwxrwx 1 root root 0 set 26 05:24 /sys/bus/edac/devices/mc -> ../../../devices/system/edac/mc  
> 
> They're still there:
> 
> $ ls -l /sys/bus/edac/devices/
> total 0
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 csrow0 -> ../../../devices/system/edac/mc/mc0/csrow0
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm0 -> ../../../devices/system/edac/mc/mc0/dimm0
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm3 -> ../../../devices/system/edac/mc/mc0/dimm3
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm6 -> ../../../devices/system/edac/mc/mc0/dimm6
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm9 -> ../../../devices/system/edac/mc/mc0/dimm9
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc -> ../../../devices/system/edac/mc
> lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc0 -> ../../../devices/system/edac/mc/mc0
> 

Ok. Yeah, probably some changes at the driver's core made that bus
thing obsolete. Or maybe it is there to allow unbind/remove
the edac driver. Had you test it with KASAN and tried to unbind/remove
the EDAC driver?

Thanks,
Mauro
