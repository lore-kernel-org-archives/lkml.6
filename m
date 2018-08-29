Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC6CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918B32084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 06:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=az8.co header.i=afonsobordado@az8.co header.b="lVyZGmFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918B32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=az8.co
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH2Kjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:39:42 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21368 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2Kjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1535525035; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=eMHbMCZJRS49NmvPwaDX9+h2k02Vjvt+4qF49nEemQiwv9tBZy4t9HCuNz/XN0R2m1K1nxGYV8D0yCIErFdz3E8gCvgA24zReGhQOlg5ES/ed1sz4iHT9shwtCN7KNmm58c5yq+IFXmpOMN3wSNNgTF7y1tXgR3os0jBC6quoUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1535525035; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=HImN7DSwPSlqJnVdPLxthaRtlcjcn8ETLq+7BQzaiBA=; 
        b=bnUs4k3VaRoXjxYlUdxrL1IgHxlWNCVVz5s6MKoBaEpCsWHbGNodcHiLxT1qU7ATeHOtwCqKXzyglSoTnyxEOF3xdVBLRHLDibIueUug7DooaPP3gRAcdObnsKZL/+JqcHHHz0YbJSbP2nSJ5i4ecbXp0H/1WDn6+dIqVyuR1+w=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=az8.co;
        spf=pass  smtp.mailfrom=afonsobordado@az8.co;
        dmarc=pass header.from=<afonsobordado@az8.co> header.from=<afonsobordado@az8.co>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1535525035;
        s=dkimmail; d=az8.co; i=afonsobordado@az8.co;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
        l=1369; bh=HImN7DSwPSlqJnVdPLxthaRtlcjcn8ETLq+7BQzaiBA=;
        b=lVyZGmFubbJ+7O99Nr3+TKpM/kvy9TimniG+I1gBzMxxnRprG4y0N1K7hYkJuCf/
        4Zazshp4DO9arjQFrDjE2nYgy2X08Ah6mXoSGNCPqO5mAMNFza98+xkXKvKRy5Z2MTc
        s4liB1Kl6WzwelGPOYA+Z1HAE+oNAC4G3+GhWoAA=
Received: from AYYLMAO-H (bl9-77-228.dsl.telepac.pt [85.242.77.228]) by mx.zohomail.com
        with SMTPS id 1535525035058852.3440447923557; Tue, 28 Aug 2018 23:43:55 -0700 (PDT)
Message-ID: <060655b11b68d25fd855e9535df75db4b113a615.camel@az8.co>
Subject: Re: [PATCH 2/4] iio: gyro: add device tree support for fxas21002c
From:   Afonso Bordado <afonsobordado@az8.co>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 29 Aug 2018 07:43:53 +0100
In-Reply-To: <20180827181341.6563c0bf@archlinux>
References: <20180825211910.22929-1-afonsobordado@az8.co>
         <20180825211910.22929-2-afonsobordado@az8.co>
         <20180827181341.6563c0bf@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 18:13 +0100, Jonathan Cameron wrote:
> On Sat, 25 Aug 2018 22:19:08 +0100
> Afonso Bordado <afonsobordado@az8.co> wrote:
> 
> > This patch adds device tree support for the fxas21002c driver,
> > including
> > bindings.
> > 
> > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
> 
> Now, the devicetree bindings should not reflect just what the driver
> uses right now, but rather describe the hardware.
> 
> There are interrupts on there for starters that definitely want to be
> described from the start.  Also there is a reset line that should
> probably
> be here from the start.
> 
> Potentially also the two power supplies though that's less critical
> (nice to have though)
> 
> It is also an i2c and spi part though that can probably be added
> later as
> we can argue we are only documenting the bindings for the device in
> i2c mode
> for now.
> 
> So what is here is fine, but I think we need to describe more.
> 
> It's all well understood details of how it is connected so no need to
> have tested it with a driver to be sure it will be right.
> 
> Jonathan

Ok, so i'm thinking about adding both interrupts, the reset line and
the regulators. If i say they are optional in the device tree document,
i shouldn't need to add any more code immediately and could just
implement support for it later right?


