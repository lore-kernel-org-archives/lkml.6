Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5BEC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4BC218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfAAQ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 11:56:54 -0500
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:49644 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727360AbfAAQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 11:56:53 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 24FAA182CF666;
        Tue,  1 Jan 2019 16:56:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin36_75f2ef0090321
X-Filterd-Recvd-Size: 3254
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue,  1 Jan 2019 16:56:50 +0000 (UTC)
Message-ID: <a935ceb348e5b4efb754484da745425afa1e7713.camel@perches.com>
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
From:   Joe Perches <joe@perches.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Date:   Tue, 01 Jan 2019 08:56:49 -0800
In-Reply-To: <20190101032622.GC2736@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
         <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
         <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
         <20190101032622.GC2736@Mani-XPS-13-9360>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-01 at 08:56 +0530, Manivannan Sadhasivam wrote:
> Hi Joe,

Hi Manivannan.

> On Mon, Dec 31, 2018 at 11:12:18AM -0800, Joe Perches wrote:
> > On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> > > Add the linux-actions mailing list for Actions Semi SoC architecture.
> > 
> > Unrelated to adding this L: entry
> > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> > >  M:	Andreas Färber <afaerber@suse.de>
> > >  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> > >  S:	Maintained
> > >  N:	owl
> > 
> > The N: entry matches too many non-owl entries like:
> > 
> > Documentation/parport-lowlevel.txt
> > drivers/misc/ibmasm/lowlevel.c
> > drivers/misc/ibmasm/lowlevel.h
> > fs/udf/lowlevel.c
> > net/ipv6/ip6_flowlabel.c
> > sound/soc/samsung/lowland.c
> > 
> > Maybe there should be two entries
> > 
> > N:	/owl
> > N:	-owl
> > 
> 
> Thanks for letting us know. Yes, we need to change it. How about below?
> 
> N: owl-
> N: -owl
> 
> Will do it as a follow-up patch if agreed!

from MAINTAINERS:

	   scripts/get_maintainer.pl has different behavior for files that
	   match F: pattern and matches of N: patterns.  By default,
	   get_maintainer will not look at git log history when an F: pattern
	   match occurs.  When an N: match occurs, git log history is used
	   to also notify the people that have git commit signatures.

F: entries are preferred to N: entries because the
get_maintainer.pl script does not assume that the
N: entries are exclusively maintained.  Maybe use a
more comprehensive F: list like:

F:	Documentation/devicetree/bindings/*/*owl-*
F:	arch/arm/boot/dts/owl-*
F:	drivers/*/owl-*
F:	drivers/*/*-owl*
F:	drivers/*/*/owl-*
F:	drivers/*/*/*-owl*
F:	include/dt-bindings/power/owl-*
F:	include/linux/soc/actions/owl-sps.h


