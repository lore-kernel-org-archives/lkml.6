Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7338AC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EED320843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 16:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1JrX+Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EED320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeJ2BhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 21:37:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ2BhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 21:37:16 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAFD52064C;
        Sun, 28 Oct 2018 16:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540745526;
        bh=Q25RdGMcKDdcPcVKKRfxnuf3ykl948biB8E8fK9bK5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k1JrX+Hb+oTfYV7uF/QcJbojp87E5NL+F/Z/6uliVly/N7lVznPm9c7UzWN9W0z0H
         Ml+j+iv+dnOO4AOrqcgqvecu5MAQGq/A93wA1UGKVqPyY+uM7jfTMYyDFQ5XI5Pdls
         dxyX0spiqRzuJNbqfodWL93kT4Zbs9B1VeJMCzRk=
Date:   Sun, 28 Oct 2018 16:52:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 0/6] staging:iio:ad2s90: Add scale info and improve
 error handling
Message-ID: <20181028165202.52ee89b3@archlinux>
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 22:59:59 -0300
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch set adds scale info to ad2s90's single channel, improve
> error handling in it's functions and fix a possible race condition
> issue.
> 
> The goal with this patch set is to address the points discussed in the
> mailing list in an effort to move ad2s90.c out of staging.
Thanks,

A good series in general.  A few suggested improvements.
If I haven't commented on a patch, usually it means I'm happy with it
and will pick it up with the rest of the series.

Jonathan

> 
> Changes in v2:
>  - Added my S-o-B in patch 5.
> 
> Matheus Tavares (5):
>   staging:iio:ad2s90: Make read_raw return spi_read's error code
>   staging:iio:ad2s90: Make probe handle spi_setup failure
>   staging:iio:ad2s90: Remove always overwritten assignment
>   staging:iio:ad2s90: Move device registration to the end of probe
>   staging:iio:ad2s90: Check channel type at read_raw
> 
> Victor Colombo (1):
>   staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
>     read_raw
> 
>  drivers/staging/iio/resolver/ad2s90.c | 55 ++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 

