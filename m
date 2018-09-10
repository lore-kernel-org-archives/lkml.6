Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A6C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127FD20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127FD20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeIJXQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:16:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJXQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:16:28 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5F731088;
        Mon, 10 Sep 2018 18:21:06 +0000 (UTC)
Date:   Mon, 10 Sep 2018 20:21:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Roger Quadros <rogerq@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: Re: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Message-ID: <20180910182104.GD6019@kroah.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <82e8093d-eb6b-ea04-7d36-54ee27df3e06@ti.com>
 <BYAPR07MB4709106F8160EBF0F3B5DBB4DD2C0@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB4709106F8160EBF0F3B5DBB4DD2C0@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 04:26:45AM +0000, Pawel Laszczak wrote:
> > > This patch set introduce new Cadence USBSSP DRD driver to linux
> > > kernel.
> > >
> > > The Cadence USBSSP DRD Driver s a highly configurable IP Core which
> > > can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> > > Host Only (XHCI) configurations.
> > >
> > > The current driver has been validated with FPGA burned. We have
> > > support for PCIe bus, which is used on FPGA prototyping.
> > >
> > > The host site of USBSSP controller is compliance with XHCI
> > > specification, so it works with standard XHCI linux driver.
> > >
> > > Also, device side of USBSSP controller was designed in such way to
> > > looks like XHCI. It means that most of logic of USBSSP controller is
> > > also compliance with XHCI specification.
> > >
> > > Consequently, the USBSSP driver for peripheral mode is very similar to
> > > XHCI driver.
> > >
> > > This version of driver supports only Device mode but DRD and Host mode
> > > will be added in the future.
> > >
> > 
> > Based on the posting date this series looks like v3.
> > 
> > You should add the version prefix to the patches next time.
> > e.g. [PATCH v4 ...]
> >
> I wanted to start versioning driver after this set patch will be approved. 

What does that mean?  No one "approves" a patch series and then you
start numbering it.

Have you read the kernel documentation for how to properly create and
submit a kernel patch series and write a good changelog?

thanks,

greg k-h
