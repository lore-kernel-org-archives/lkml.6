Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D85C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B4C20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549280926;
	bh=JFmbK5f1v43xy+KQO0/OkRVOJCt6hzsCZhwn67cefqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DkrAu8m0mzHlQtiy70y2CzHRQa9GFCCN4fuUz0JRpKBlUrKTyz0Ag3KXrD1IYElL4
	 PtfvO10VWERHyKUXjVDTf79I8SZ8HRbcmATDHdydrnpUuhtDgAoBcfDITl0hfrIg+/
	 Pd9vd6BYUjbWaESTBaA7AhPJjDAe4eKIN41uOOXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfBDLso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:48:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfBDLso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:48:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C797620811;
        Mon,  4 Feb 2019 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549280923;
        bh=JFmbK5f1v43xy+KQO0/OkRVOJCt6hzsCZhwn67cefqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntRfwf7/uod2pf97DbZv0RrRvWFVAZ2HlI+ujSYG/I9TTiFKEZinEHkW9tStTLkmD
         OYZlsDzevw7lbCF+hvdhhmtFm7KKrfMu3u23pmLTvDlW3VuiobHG0YF8v0wMUQZ7R+
         DjhyQ35iidsbGfNCwDhbsesMME4V573pIfaz0ypE=
Date:   Mon, 4 Feb 2019 12:48:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     devicetree@vger.kernel.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, hdegoede@redhat.com,
        heikki.krogerus@linux.intel.com, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, rogerq@ti.com, linux-kernel@vger.kernel.org,
        jbergsagel@ti.com, nsekhar@ti.com, nm@ti.com, sureshp@cadence.com,
        peter.chen@nxp.com, pjez@cadence.com, kurahul@cadence.com
Subject: Re: [PATCH v3 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Message-ID: <20190204114841.GD28608@kroah.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
 <1548935553-452-6-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548935553-452-6-git-send-email-pawell@cadence.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:52:32AM +0000, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver
> to linux kernel.
> 
> The Cadence USBSS DRD Driver is a highly
> configurable IP Core which can be
> instantiated as Dual-Role Device (DRD),
> Peripheral Only and Host Only (XHCI)
> configurations.
> 
> The current driver has been validated with
> FPGA burned. We have support for PCIe
> bus, which is used on FPGA prototyping.
> 
> The host side of USBSS-DRD controller is compliance
> with XHCI specification, so it works with
> standard XHCI linux driver.

Please line-wrap this properly at 72 columns, like your editor asks you
to when you run git :)

> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig                |    2 +
>  drivers/usb/Makefile               |    2 +
>  drivers/usb/cdns3/Kconfig          |   44 +
>  drivers/usb/cdns3/Makefile         |   14 +
>  drivers/usb/cdns3/cdns3-pci-wrap.c |  155 +++
>  drivers/usb/cdns3/core.c           |  403 ++++++
>  drivers/usb/cdns3/core.h           |  116 ++
>  drivers/usb/cdns3/debug.h          |  168 +++
>  drivers/usb/cdns3/debugfs.c        |  164 +++
>  drivers/usb/cdns3/drd.c            |  365 +++++
>  drivers/usb/cdns3/drd.h            |  162 +++
>  drivers/usb/cdns3/ep0.c            |  907 +++++++++++++
>  drivers/usb/cdns3/gadget-export.h  |   28 +
>  drivers/usb/cdns3/gadget.c         | 1985 ++++++++++++++++++++++++++++
>  drivers/usb/cdns3/gadget.h         | 1207 +++++++++++++++++
>  drivers/usb/cdns3/host-export.h    |   28 +
>  drivers/usb/cdns3/host.c           |   72 +
>  drivers/usb/cdns3/trace.c          |   23 +
>  drivers/usb/cdns3/trace.h          |  404 ++++++
>  19 files changed, 6249 insertions(+)
>  create mode 100644 drivers/usb/cdns3/Kconfig
>  create mode 100644 drivers/usb/cdns3/Makefile
>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>  create mode 100644 drivers/usb/cdns3/core.c
>  create mode 100644 drivers/usb/cdns3/core.h
>  create mode 100644 drivers/usb/cdns3/debug.h
>  create mode 100644 drivers/usb/cdns3/debugfs.c
>  create mode 100644 drivers/usb/cdns3/drd.c
>  create mode 100644 drivers/usb/cdns3/drd.h
>  create mode 100644 drivers/usb/cdns3/ep0.c
>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>  create mode 100644 drivers/usb/cdns3/gadget.c
>  create mode 100644 drivers/usb/cdns3/gadget.h
>  create mode 100644 drivers/usb/cdns3/host-export.h
>  create mode 100644 drivers/usb/cdns3/host.c
>  create mode 100644 drivers/usb/cdns3/trace.c
>  create mode 100644 drivers/usb/cdns3/trace.h

This is way too big to try to review all at once.  You need to break
this up into logical chunks, each one adding a single functionality to
make it possible to actually review it.

thanks,

greg k-h
