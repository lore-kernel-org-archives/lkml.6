Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA54C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392AF21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="mZ/sFhap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392AF21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeHTRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:43:09 -0400
Received: from mail.blih.net ([212.83.177.182]:35100 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeHTRnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:43:09 -0400
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id adedab94;
        Mon, 20 Aug 2018 16:27:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=sHHJ0myfS51zQKvRTxizYVb8wOQ=; b=mZ/sFhapxRLYM2+xAWaQEPi6ZSFS
        agWiOX0HdbVe9CG6spSiepLWFokoTFRwYboGG7aEfixQsq56/DBXguhcdGkajqfY
        DOdkz7X3qlcWq3d+1EFI8FI8seLxXNbuEWOwy5sgaaI/2+jz3I43oWFwVfqq8ONL
        T9aE9PRPnRWT9H4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=LamlkiZgFmEmoMMlt7WYfIyTTyJ/Vd+ECVKroQqqyPyhcp6tjWwpyq0F
        zyGa8WWkTakW7X7mqweuzUcYsJDB6ktWrRxNKoM/bgon+477eNsZ17tLNSeTjQOJ
        lU3lG/pfJ0F9hEe086cP3tmfffORsf25hHI3XG7ulq4+dAoUYnU=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id 7c86e7cf
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Mon, 20 Aug 2018 16:27:15 +0200 (CEST)
Date:   Mon, 20 Aug 2018 16:27:15 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
Message-Id: <20180820162715.49e6d8a469ece983f3c1d288@bidouilliste.com>
In-Reply-To: <20180820140737.xmqhu5ndqzehvkql@flea>
References: <20180804070355.14857-1-manu@freebsd.org>
        <20180820111755.rzg7l2lznmbpuf2e@flea>
        <CAL_JsqLVQDRH1esAXghfQdxmp+iorWVCArM2qTwjbgmQzmhzQw@mail.gmail.com>
        <20180820140737.xmqhu5ndqzehvkql@flea>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 16:07:37 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Mon, Aug 20, 2018 at 07:41:22AM -0600, Rob Herring wrote:
> > On Mon, Aug 20, 2018 at 5:17 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Sat, Aug 04, 2018 at 09:03:49AM +0200, Emmanuel Vadot wrote:
> > > > This patch adds documentation for Device-Tree bindings for the Allwinner
> > > > Thermal Sensor Controller found on the H3, H5 and A64 SoCs
> > > >
> > > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > >
> > > I'm not going to merge a binding for a device that doesn't have any
> > > driver implemented at the moment in Linux.
> > 
> > I'll take it then. Linux is not the only DT client.
> 
> Then don't complain if we ever have to break the ABI. We never tested
> that hardware, never had any code running on it, and it *will* cause
> some issues. For example, the calibration data have never been used
> and how they should be represented have never been described, since no
> one ever actually tried to use it.
> 
> And sure, Linux is not the only DT client. Just like FreeBSD isn't.
> 
> Maxime

 Maxime,

 What kind of data would you need for me to make things better ?
 We have the driver in FreeBSD for almost two years now, whne I started
to see how to upstream it I noticed a lot of problems and spent 4 or 5
days to try on all the SoCs mentionned in the serie, the only SoC I
didn't include it the A83T as for some reason I couldn't make the
driver work.
 I just hope that you understand that we cannot wait for Linux to have
a driver to have some bindings.

 Cheers,

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
