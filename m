Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D01C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B152087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547924688;
	bh=iUFFUSldXqruoD9G+xUC7fE9CNao6JwmibOrmaIiYAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wGYPKdFaBbPBhhItGWzdMBGViE3UnajM15pJGyOhcf+vmNNxaqbnhHuhr9oYpX/yF
	 wYgB+7GSNf6mBRpz8OCGCc6IgbOG3a/3/6AvxA2QSmnw+lFQwZPbvqw85UPLaa1FPm
	 9VOUf0XqWds+Zdg/zuhfzdddASmYxuCRsHHwiGtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfASTEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:04:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbfASTEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:04:45 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75BDA2086D;
        Sat, 19 Jan 2019 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547924685;
        bh=iUFFUSldXqruoD9G+xUC7fE9CNao6JwmibOrmaIiYAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q+x6yvNb2GR+OvDuqlwfLX4B5c8Fdz2ZFh1zCA1EIf7F2zQ62/Y2/ZmY1GTw5b6eA
         b2+ZQbp0xK7Tl+EPo6GSsmqvYabSBtUnBWD9m1S4xh9NuFGWUg3MIzdI2+gdsC/cIZ
         27V+UjpNHjupGEhTuFFFVjqCinWWsbq1RFHnBsdI=
Date:   Sat, 19 Jan 2019 19:04:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] adt7316 regmap implementation
Message-ID: <20190119190440.71dd0dd9@archlinux>
In-Reply-To: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
References: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jan 2019 00:09:29 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> This patchset consist of some initial patches for heading
> towards the regmap implementation and also the final patch
> which enables the driver to use regmap API thus removing
> the redundant and common code.
> 
> Shreeya Patel (3):
>   Staging: iio: adt7316: Remove irq from bus structure
>   Staging: iio: adt7316: Remove multi read and write functions
>   Staging: iio: adt7316: Add regmap support
> 
>  drivers/staging/iio/addac/adt7316-i2c.c | 101 ++--------------
>  drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
>  drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------------
>  drivers/staging/iio/addac/adt7316.h     |  15 +--
>  4 files changed, 103 insertions(+), 255 deletions(-)
> 

Hi Shreeya,

I'm not seeing a change log for any of these. Please make sure to
add one so we know what changed since V1.  Saves a lot of trying
to remember things from a while back!

Thanks,

Jonathan
