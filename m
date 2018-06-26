Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB05C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C521C18
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C521C18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935472AbeFZMOf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:14:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:12300 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934583AbeFZMOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:14:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 05:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="66425992"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2018 05:14:27 -0700
Message-ID: <ff4c668d0807657940a4cddc6f7eb63d19be327c.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/2] Add a property in at24.c
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>, alanx.chiang@intel.com
Cc:     linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        rajmohan.mani@intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jun 2018 15:14:26 +0300
In-Reply-To: <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
         <CAMRc=Me-Tm8Q5_hGu2r1uqeYFAvCM9ssr7o=w1KZUyXcAn_uCw@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 09:41 +0200, Bartosz Golaszewski wrote:
> 2018-06-26 8:22 GMT+02:00  <alanx.chiang@intel.com>:
> > From: "alanx.chiang" <alanx.chiang@intel.com>
> > 
> > In at24.c, it uses 8-bit addressing by default. In this patch,
> > add a property address-width that provides a flexible method to
> > pass the information to the driver.
> > 
> > alanx.chiang (2):
> >   dt-bindings: at24: Add address-width property
> >   eeprom: at24: Add support for address-width property
> > 
> >  Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
> >  drivers/misc/eeprom/at24.c                        | 16
> > ++++++++++++++++
> >  2 files changed, 18 insertions(+)
> > 
> > --
> > 2.7.4
> > 
> 
> What is your use case exactly? Do you have an EEPROM model that's not
> yet supported explicitly in the driver? Why would you need this
> option?

The current at24 driver has no address width support, thus, reusing same
(allocated) IDs (non-DT case) is hard.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
