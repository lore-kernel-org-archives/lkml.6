Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B40ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C72075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13C72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbeGRNaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:30:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:58543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730371AbeGRNaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:30:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 05:52:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,370,1526367600"; 
   d="scan'208";a="246242823"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2018 05:52:20 -0700
Message-ID: <b70d78516e765b3a6587323cffb6066e9363cd48.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms@verge.net.au>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Date:   Wed, 18 Jul 2018 15:52:20 +0300
In-Reply-To: <CAMuHMdWJkwJ5+DDqbaWH-cMhRQynWCxb4MbFtpejqi1HhUBHTQ@mail.gmail.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
         <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
         <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
         <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
         <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
         <CAMuHMdWJkwJ5+DDqbaWH-cMhRQynWCxb4MbFtpejqi1HhUBHTQ@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 13:06 +0200, Geert Uytterhoeven wrote:
> On Wed, Jul 18, 2018 at 11:14 AM Simon Horman <horms@verge.net.au>
> wrote:

> >         if (IS_ERR(dev->buslck) && PTR_ERR(dev->busclk) != -ENOENT)
> >                 return PTR_ERR(dev->busclk);
> > 
> >         ...
> 
> As this is a commonly-used construct, perhaps it would be good to
> introduce
> clk_get_optional() (cfr. gpiod_get_optional()) and
> devm_clk_get_optional(),
> which would return NULL instead of -ENOENT?
> Then it becomes a simple check for IS_ERR() in the driver.

I'm puzzled why CCF still lack of such API.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
