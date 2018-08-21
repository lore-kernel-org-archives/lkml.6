Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF9BC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90738217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQfZU5PP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90738217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeHUSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbeHUSr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:47:59 -0400
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FEE20C03;
        Tue, 21 Aug 2018 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534865243;
        bh=Pzc0wxJFDYGkSGdynuucXn2KLtQ8UjBa/MnBQhXiTt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQfZU5PPaxuWebwahBBA6svnZrLz2tlefGulq8pMfoeC3gQkbPEPe8Y/d1YBmRQlV
         WOAZdNsEmPkUQ2tCcRvnneYhzhyyIztJF3WTGNv/raIX5/tw8bdLBwCz3feahLsh1f
         JBNHG07neplL/+qRTH0hJ2sLxwUwSyBYV7VmfXC0=
Date:   Tue, 21 Aug 2018 23:26:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
Message-ID: <20180821152643.GC32159@dragon>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
 <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
 <20180808111429.GC25150@e107981-ln.cambridge.arm.com>
 <a5556be9a5f62ea0472a1a2336bce8d71df0dcaa.camel@nxp.com>
 <20180808141938.GA30428@e107981-ln.cambridge.arm.com>
 <efd9c1d560cae84e2a4ee7585a4c61d5d40ba755.camel@nxp.com>
 <20180808152741.GA31808@e107981-ln.cambridge.arm.com>
 <52ee6376fa15d3a9a62bcfa5d87173e454ccc024.camel@nxp.com>
 <20180810151341.GA6863@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810151341.GA6863@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:13:41PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Aug 10, 2018 at 11:11:55AM +0000, Leonard Crestez wrote:
> 
> [...]
> 
> > This needs further clarification: without the reset patch this will
> > hang on imx7 suspend/resume but this is the current behavior anyway.
> > 
> > Both patches are required for imx7 pci suspend and including them out
> > of order shouldn't break unrelated functionality.
> > 
> > So it should actually be fine to just include the pci changes now,
> > right?
> 
> It is a bit late for v4.19 but before considering that, this series
> is actually a set of fixes, correct ? If that's the case I think
> Shawn can send them upstream for a v4.19-rc*, I can ACK them if that
> sounds reasonable.
> 
> Patch (2) subject must make clear you are actually fixing a problem if
> we choose this course of action.

This is something never worked before, so it's a new feature to me.
That said, I'm not in the position to send the PCI patch for 4.19-rc as
a fix though IMX (arm-soc) tree.

I will send the DTS patch for 4.19-rc inclusion though, since that's
indeed a fix.

Shawn
