Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B74C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C277B26798
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C277B26798
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeF0JkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:40:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:27152 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752592AbeF0JkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:40:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 02:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="66719739"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2018 02:40:14 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id B3570205FC; Wed, 27 Jun 2018 12:40:13 +0300 (EEST)
Date:   Wed, 27 Jun 2018 12:40:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     alanx.chiang@intel.com, linux-i2c <linux-i2c@vger.kernel.org>,
        andy.yeh@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        andriy.shevchenko@intel.com,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        tfiga@chromium.org, jcliang@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: at24: Add address-width property
Message-ID: <20180627094013.e42crqqufo2jqra6@paasikivi.fi.intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
 <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
 <CAMRc=MeowpZ+OjjWs6-67BOnY=+Nbpn4Bi_Xw3n+NLsELZaptQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MeowpZ+OjjWs6-67BOnY=+Nbpn4Bi_Xw3n+NLsELZaptQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:19:38AM +0200, Bartosz Golaszewski wrote:
> 2018-06-27 7:46 GMT+02:00  <alanx.chiang@intel.com>:
> > From: Alan Chiang <alanx.chiang@intel.com>
> >
> > The AT24 series chips use 8-bit address by default. If some
> > chips would like to support more than 8 bits, the at24 driver
> > should be added the compatible field for specfic chips.
> >
> > Provide a flexible way to determine the addressing bits through
> > address-width in this patch.
> >
> > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> >
> > ---
> > since v1:
> > -- Remove the address-width field in the example.
> > since v2:
> > -- Remove redundant space.
> >
> > ---
> >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> > index 61d833a..aededdb 100644
> > --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> > +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> > @@ -72,6 +72,8 @@ Optional properties:
> >
> >    - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
> >
> > +  - address-width: number of address bits (one of 8, 16).
> > +
> >  Example:
> >
> >  eeprom@52 {
> > --
> > 2.7.4
> >
> 
> Rob,
> 
> we only have two possibilities here and the default is 8 bits.
> 
> What do you think about introducing a boolean property here called:
> 'address-width-16' instead of an integer?

I'd have thought the same, but it turns out address-width is already being
used by the at25 bindings:

Documentation/devicetree/bindings/eeprom/at25.txt

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
