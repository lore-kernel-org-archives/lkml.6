Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01A2C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDD920895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 12:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDD920895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeJMUK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:10:29 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:37826 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeJMUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:10:28 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gBJ6k-0003b8-LB from Vladimir_Zapolskiy@mentor.com ; Sat, 13 Oct 2018 05:33:26 -0700
Received: from [137.202.108.125] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 13 Oct 2018 13:33:22 +0100
Subject: Re: [PATCH 4/7] mfd: ds90ux9xx: add TI DS90Ux9xx de-/serializer MFD
 driver
To:     <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-5-vz@mleia.com> <20181012060314.GU4939@dell>
 <63733d2e-f95e-8894-f2b0-0b551b5cfeeb@mentor.com>
 <20181012083924.GW4939@dell>
 <eef99526-9232-8cd4-9a7c-c30114d58806@ideasonboard.com>
 <506c03d7-7986-44dd-3290-92d16a8106ad@mentor.com>
 <4a807a53-1592-a895-f140-54e7acc473b3@ideasonboard.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <646af723-b78b-4481-50d9-e1b8f57abd79@mentor.com>
Date:   Sat, 13 Oct 2018 15:33:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <4a807a53-1592-a895-f140-54e7acc473b3@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-09.mgc.mentorg.com (139.181.222.9) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On 10/12/2018 02:47 PM, Kieran Bingham wrote:
> Hi Vladimir,
> 

[snip]

> 
> Essentially they are multi purpose buses - which do not yet have a home.
> We have used media as a home because of our use case.
> 
> The use case whether they transfer frames from a camera or to a display
> are of course closely related, but ultimately covered by two separate
> subsystems at the pixel level (DRM vs V4L, or other for other data)
> 
> Perhaps as they are buses - on a level with USB or I2C (except they can
> of course carry I2C or Serial as well as 'bi-directional video' etc ),
> they are looking for their own subsystem.
> 
> Except I don't think we don't want to add a new subsystem for just one
> (or two) devices...
> 

I suppose that the incomplete list includes Maxim GMSL, TI FPD-Link III,
SMSC/Microchip MOST (drivers/staging/most -- what's the destination after
exiting staging?) an Inova APIX.

--
Best wishes,
Vladimir
