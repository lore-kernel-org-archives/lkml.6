Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6469C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F92020C0C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 19:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dX7fjTGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92020C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeHSWUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 18:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeHSWUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 18:20:54 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF7220C0C;
        Sun, 19 Aug 2018 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534705704;
        bh=bq+EcNxu+W33opez9wtMACq1jPoRKl90VupGfLJ4NfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dX7fjTGF1AETq0l89bydUkhRAgK0RmAl6uJVDtvi4sPVEk2bAwXJ3kuBE/4jgFsFb
         W48gqSwdiMC8CBTiFctz1+ABgXG/cTU1UhBUQ/h7AOlswt7Z3UTPRq9E7FvjBDGlxF
         wkdnYLnSeXDNb7qe/YdlhP8MV82VTP5J3WJ/l1dM=
Date:   Sun, 19 Aug 2018 20:08:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     dpfrey@gmail.com, daniel.baluta@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: bme680: Add check for val2 in the
 write_raw function
Message-ID: <20180819200820.3ad2252a@archlinux>
In-Reply-To: <20180819171014.GA13175@himanshu-Vostro-3559>
References: <20180811102636.6171-1-himanshujha199640@gmail.com>
        <20180819172514.370d34fb@archlinux>
        <20180819171014.GA13175@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2018 22:40:14 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sun, Aug 19, 2018 at 05:25:14PM +0100, Jonathan Cameron wrote:
> > On Sat, 11 Aug 2018 15:56:36 +0530
> > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> >   
> > > val2 is responsible for the floating part of the number to be
> > > written to the device. We don't need the floating part
> > > while writing the oversampling ratio for BME680 since the
> > > available oversampling ratios are pure natural numbers.
> > > 
> > > So, add a sanity check to make sure val2 is 0.
> > > 
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>  
> > 
> > As discussed in David's patch series v3, I think this is still relevant
> > but now needs an update to cover the new code.  
> 
> I already had informed David to reabse his series on top of my patch
> and he rebased this patch series.
> 
> So, it should apply cleanly without any further effort.
> 
> If it doesn't, then ping me.

Meh, was only some trivial fuzz. I thought things had changed more than that
as hadn't noticed you just applied it at the top of write_raw as all the
things that can be written in this driver are integers.

Anyhow, applied now.  Thanks,

Jonathan
> 

