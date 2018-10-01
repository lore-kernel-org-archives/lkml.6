Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E9C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3243C20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="k+pMe4Oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3243C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cesnet.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbeJAU6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:41 -0400
Received: from office2.cesnet.cz ([195.113.144.244]:49860 "EHLO
        office2.cesnet.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbeJAU6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:40 -0400
Received: from localhost (unknown [IPv6:2001:718:1:2c:618c:c23d:a7ac:fd26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 5FE88400064;
        Mon,  1 Oct 2018 16:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2; t=1538403636;
        bh=03Yk8Ad+aohQnvxcpSDu1J1hU8+w9ZNzPdILtt6b07Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k+pMe4Oen98qaaXcV5AgchNaAIpLlTxL8bAQOrdxvObRQUNbl6RxUEeDDW7mOm8l9
         r+qmd/B8n/fEj796oRCPyw/e6wDDs0ODBv3FwGTJQFqmxpUvNoR5griySi2touzmuX
         7wRbeSftVvHUoaHNeto5iOOc0oUjxFAwjRT9Mhy8=
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spidev: Enable the Liebherr's BK4 board to work with =?iso-8859-1?Q?spidev_driver?=
Date:   Mon, 01 Oct 2018 16:20:32 +0200
MIME-Version: 1.0
Message-ID: <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
In-Reply-To: <20180927223152.24990-1-lukma@denx.de>
References: <20180927223152.24990-1-lukma@denx.de>
Organization: CESNET
User-Agent: Trojita/v0.7-361-gfee56b6f-dirty; Qt/5.11.0; xcb; Linux; Gentoo Base System release 2.4.1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On p=C3=A1tek 28. z=C3=A1=C5=99=C3=AD 2018 0:31:52 CEST, Lukasz Majewski wrot=
e:
> With this commit the DSPI driver on the BK4 board can be used for SPI
> transmission managed from user space (via /dev/spidev0.0).

Hi Lukasz,
I tried submitting a similar patch for another devicem but got no reaction=20=

[1]. In the meanwhile, there has been another proposal [2] which moves=20
handling of this into userspace via udev. You might want to take a look at=20=

that mechanism instead (and perhaps send your Tested-by tag). It has worked=20=

well for me.

[1] https://patchwork.kernel.org/patch/10558889/
[2]=20
https://patchwork.kernel.org/project/spi-devel-general/list/?series=3D21295

Cheers,
Jan
