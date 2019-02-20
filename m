Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8249C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87D52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550661762;
	bh=sX01j6WKooxQwpnipBg+opJl+gN4BRupD1VvAe0s9Fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sHqEmgVDuvQK0+PRu+fewPYk9TD8kef0f8VVuQF/SOsenDygXKICR/rGJn47zABDl
	 nmDE+MW6Zh44IYC2gL7k1PRmDUFOZXH1X4mUIhGKget15k6ogOFBUThkmSlirMsOgf
	 BORyAdulXgjpJjXSEcAnAQ70PLU8n28061jlK19o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfBTLWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBTLWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:22:41 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D817206B7;
        Wed, 20 Feb 2019 11:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550661760;
        bh=sX01j6WKooxQwpnipBg+opJl+gN4BRupD1VvAe0s9Fk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6C2SCtsPvWBorC9LnnxTLsLaP7txKmA1vhPUrNWldmRtkopyb1DZeQsyy+oJaSus
         vUQ+T65lnALi6uy3NU7GA0ANtS0+3jLR/p/ZbHqoM47PVD/ZVBlXYmtEQalH+rSC+a
         pfajZknlb1+Uk/7AcJEKS8HbuM2Bo8RDumxbRc/o=
Date:   Wed, 20 Feb 2019 11:22:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dpfrey@gmail.com, colin.king@canonical.com
Subject: Re: [PATCH] iio/chemical/bme680: Fix SPI read interface
Message-ID: <20190220112234.1e42d810@archlinux>
In-Reply-To: <20190216112722.GA28619@himanshu-Vostro-3559>
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
        <20190216112722.GA28619@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..

> > Report temperature in millidegrees Celcius instead of degrees.  
> 
> Jonathan, I didn't know about this but is there any rationale to report
> in millidegress ?

Misguided attempt in the early days of IIO to match hwmon units.
Sadly it is now the ABI and hence 'unfixable'. Same odd units
for voltage and current + a few others that date back to those
days.   A big oops.  There are some other non obvious bits and
pieces so should always check the ABI docs which should be near
complete.
 
> 
> I was under the impression that degC is the standard and you would
> always want you Fitbit/Smart watch to report in degC. Ofcourse,
> userspace program can convert millideg -> degC
