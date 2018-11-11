Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F2221104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2Ra6CWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F2221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeKKVWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKKVWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:22:38 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56917208A3;
        Sun, 11 Nov 2018 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541936059;
        bh=X77+7lgy5nZlaPnz/VldXKUfEbmr8FiqJv5GcM+fh40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D2Ra6CWaejPBqTPw5tVjReREdnxDHdp0x08OT7UrvR9gH6e8u3HEeuk7FGL+8Vyec
         Sg33EMmgZzuLJeRsJ+MLrjzJKJugb1CYKoaXMErSxxeojjbNgIZ6Wpmiiv2O4bbKeD
         U3N7ipekLTQiYwOPcBYGnAtGGXCHQ/H1Xpj/g3T0=
Date:   Sun, 11 Nov 2018 11:34:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: Re: [PATCH 0/6] staging:iio:ad2s90: Add dt support and move out of
 staging
Message-ID: <20181111113413.46e1070f@archlinux>
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 20:00:38 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> This patch set adds device tree support to ad2s90, with standard
> device tree id table, adds the respective dt-binding documentation,
> solves a codestyle warning and move the driver out of staging.
> 
> This patch set completes all the remaining itens listed to be done
> before moving the driver out of staging, enumerated in this mail thread:
> https://marc.info/?l=linux-iio&m=154028966111330&w=2, except by one
> codestyle problem: "CHECK: struct mutex definition without comment". It
> seems to be a commonly ignored check for mutexes of device states. If I
> am wrong, please, let me know and I will be happy to send a patch to
> tackle it.
It should be commented.  Device state is not actually all that
well defined and means different things in different drivers.

Here it is very straight forward as it's role is to protect the
buffer. There is no other state maintained.

Jonathan


> 
> Matheus Tavares (6):
>   staging:iio:ad2s90: Add device tree support
>   staging:iio:ad2s90: Remove spi setup that should be done via dt
>   staging:iio:ad2s90: Add max frequency check at probe
>   dt-bindings:iio:resolver: Add docs for ad2s90
>   staging:iio:ad2s90: Add SPDX license identifier
>   staging:iio:ad2s90: Move out of staging
> 
>  .../bindings/iio/resolver/ad2s90.txt          | 26 ++++++++++++++++
>  drivers/iio/resolver/Kconfig                  | 10 ++++++
>  drivers/iio/resolver/Makefile                 |  1 +
>  drivers/{staging => }/iio/resolver/ad2s90.c   | 31 ++++++++++++-------
>  drivers/staging/iio/resolver/Kconfig          | 10 ------
>  drivers/staging/iio/resolver/Makefile         |  1 -
>  6 files changed, 57 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
>  rename drivers/{staging => }/iio/resolver/ad2s90.c (81%)
> 

