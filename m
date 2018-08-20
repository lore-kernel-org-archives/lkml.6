Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B339C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31C9216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="cJH1l8NT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31C9216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeHTRNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:13:48 -0400
Received: from mail.blih.net ([212.83.177.182]:54469 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTRNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:13:47 -0400
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id 5eb1196e;
        Mon, 20 Aug 2018 15:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=KRZOT7XD9U2gHIS+xMWvXd4AuKE=; b=cJH1l8NTvhzvD45fSc56TYgb3B4Y
        GzAtC0YbBMl+0eBQbOQYvuZyoov7rQ4ZTWZJP7q32Qe6dmdkPNWnC7SRUUTHdhNm
        C4M+zPcYvtEVQtLc/IUQsqAc81wL/JAJEzTK0vPHm6m7GNQKIDOgQuzAS+z1SaFf
        hDVfV22ECucMbWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=aD9aTWz8A/mJPwEq1ZS9I14t7rJYwhRm7hfsDubcZKWFFvJAkGC8juKA
        B4dT5XwNepYTC3cfFk6JLJfxvLEbrb9HDGg0DbHAXm6sdAxS3fEB9nF/P7FU5MJj
        9JlWPW0oEBjlW56jPP5ip+P517i2+6TIbHuvqfOjRLEkL7kgpK4=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id 6e07d9ee
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Mon, 20 Aug 2018 15:57:58 +0200 (CEST)
Date:   Mon, 20 Aug 2018 15:57:57 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Emmanuel Vadot <manu@freebsd.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
Message-Id: <20180820155757.7f393d75fdbe55610efff0c1@bidouilliste.com>
In-Reply-To: <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
References: <20180804070355.14857-1-manu@freebsd.org>
        <20180820111755.rzg7l2lznmbpuf2e@flea>
        <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 07:41:22 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > This patch adds documentation for Device-Tree bindings for the Allwinner
> > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > >
> > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> >
> > I'm not going to merge a binding for a device that doesn't have any
> > driver implemented at the moment in Linux.
> 
> I'll take it then. Linux is not the only DT client.
> 
> Rob

 Thanks Rob, I'll send a V2 shortly with the modification you asked and
some minor others documentation corrections.

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
