Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2BC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37952082A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGCBzrCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37952082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeKRCtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:49:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbeKRCtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:49:45 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 353E5206BA;
        Sat, 17 Nov 2018 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542472353;
        bh=PATnfR50dbISo0BUQLH0QiElfmfTjO9cootVI/7X1Ts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZGCBzrCC5dphLIYjWKpcWHjKSq/bM25LmKeQRpjnB3aTGOOwPARLuu4HdM0HiQ7rm
         6rNXcOTjFg4AhEtf668PE3QazsfDCZ7ThaKL6N+Qbgak0+iZr7lv82E9SJg3xZ++GV
         fSTAEZWHhkukutMAOTua2tuNRYJDepDw6C4Z1gtY=
Date:   Sat, 17 Nov 2018 16:32:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Stefan Popa <stefan.popa@analog.com>, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs
 properties to a separate file
Message-ID: <20181117163228.5f5b5bb8@archlinux>
In-Reply-To: <20181116225302.GA23266@bogus>
References: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
        <20181116183838.6a079255@archlinux>
        <20181116225302.GA23266@bogus>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 16:53:02 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Nov 16, 2018 at 06:38:38PM +0000, Jonathan Cameron wrote:
> > On Tue, 13 Nov 2018 13:21:01 +0200
> > Stefan Popa <stefan.popa@analog.com> wrote:
> >   
> > > There are several ADC drivers that depend on the same device tree
> > > bindings. Rather than continue to duplicate the properties, this patch
> > > adds a common adc binding document that can be referenced. For beginning,
> > > only two properties are documented.
> > > 
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>  
> > Looks very sensible to me, but as we are looking at a some generalization
> > here, I'd like an Ack from Rob if possible (as he suggested it I think :)  
> 
> Looks fine to me, but I don't have any clue if this will be flexible 
> enough for various h/w.
I think we'll need more to cover all cases, but hopefully things that
make sense to be optional in general.  Rather hard to predict.  This is
the obvious stuff so far.

This is better than the current mess of different options!

Jonathan

> 
> Rob
> 

