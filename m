Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CFDACC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1162089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1162089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934882AbeFLXxx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:53:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:8078 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934607AbeFLXxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:53:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 16:53:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="236935921"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.61])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2018 16:53:47 -0700
Date:   Wed, 13 Jun 2018 07:42:39 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH v6 12/29] fpga: add FPGA DFL PCIe device driver
Message-ID: <20180612234239.GB8459@hao-dev>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-13-git-send-email-hao.wu@intel.com>
 <87a783f1-9db8-e56d-c4c4-1802c29c416a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a783f1-9db8-e56d-c4c4-1802c29c416a@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:27:27AM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 06/12/2018 03:10 AM, Wu Hao wrote:
> > From: Zhang Yi <yi.z.zhang@intel.com>
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 4052532..5faab48 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -146,4 +146,19 @@ config FPGA_DFL
> >  	  Gate Array (FPGA) solutions which implement Device Feature List.
> >  	  It provides enumeration APIs, and feature device infrastructure.
> >  
> > +config FPGA_DFL_PCI
> > +	tristate "FPGA DFL PCIe Device Driver"
> > +	depends on PCI && FPGA_DFL
> > +	help
> > +	  Select this option to enable PCIe driver for PCIe based
> 
> 	                                               PCIe-based
> 
> > +	  Field-Programmable Gate Array (FPGA) solutions which implemented
> 
> 	                                                 which implement

Hi Randy

Thanks for the comments on these patches, I will fix them all in the next
version.

Hao

> 
> > +	  the Device Feature List (DFL). This driver provides interfaces
> > +	  for userspace applications to configure, enumerate, open and access
> > +	  FPGA accelerators on the FPGA DFL devices, enables system level
> > +	  management functions such as FPGA partial reconfiguration, power
> > +	  management, and virtualization with DFL framework and DFL feature
> > +	  device drivers.
> > +
> > +	  To compile this as a module, choose M here.
> > +
> >  endif # FPGA
> 
> 
> -- 
> ~Randy
