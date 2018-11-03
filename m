Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E1AC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B55E20843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJs/UiKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B55E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeKDCfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKDCfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:35:09 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6ABC204FD;
        Sat,  3 Nov 2018 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541265796;
        bh=d85B/lQT3Q1TXMJd2VWO2PKEkKczQ0UCY/VcWcy3sjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DJs/UiKpcOu/cqq91b6eDIoUT++OiaRoz8G+N0ZSlK7c1GxllRtSlID4vFeGgIReA
         b+gnG8fU3Xc+6WtNdad8nx5GMy+7EoqJy2apsdM3AHh+YfkG7ejnhPC8DuLUULVRwt
         nFmObkscFSo+hNcHH/j1mFxWhax9DJRurhj7WiKo=
Date:   Sat, 3 Nov 2018 17:23:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Message-ID: <20181103172311.7a73b759@archlinux>
In-Reply-To: <20181103155915.32wgi6ybkvhr5qzb@renatolg>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
        <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
        <20181103130721.53a806a5@archlinux>
        <20181103155915.32wgi6ybkvhr5qzb@renatolg>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 12:59:16 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Hi,
> 
> >On Thu, 1 Nov 2018 15:02:32 +0000
> >"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >  
> >> Good catch.  
> 
> That was actually Jonathan's catch. :)
> 
> >> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> 
> I read up on Acked-by on the kernel docs, as I didn't know exactly what
> it meant, but I'm not so sure on how to proceed once the patch has been
> acked.  For future patches, do I add this Acked-by line on the patch's
> message body? Or is this just an informal way of approval?
It's formal.  You put the line directly below your Signed-off-by: line
if you are resending.  If I pick up the patch I paste it in there
whilst applying.

> 
> >On the basis this has been broken for a long time, and you are clearly
> >doing other nearby not fix work, I'm going to take this through the togreg
> >tree rather than via the quicker fix path.  It makes my life
> >easier :)
> >
> >Applied to the togreg branch of iio.git and pushed out as testing for
> >the autobuilders to play with it.  
> 
> So this means I should skip this patch on v4, right?
Yes. Already in the tree so don't send it again.

Thanks

Jonathan

> 
> Thanks,
> Renato
> 

