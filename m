Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCCAC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F09224124
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F09224124
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbeF0Lln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:41:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:29184 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752545AbeF0Lll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:41:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 04:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,278,1526367600"; 
   d="scan'208";a="53298124"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2018 04:41:36 -0700
Message-ID: <049fae0ebe5521d4bb92d7d0f66cd2a54a1a2d22.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: at24: Add address-width property
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     alanx.chiang@intel.com, linux-i2c <linux-i2c@vger.kernel.org>,
        andy.yeh@intel.com, Rajmohan Mani <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        tfiga@chromium.org, jcliang@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Date:   Wed, 27 Jun 2018 14:41:35 +0300
In-Reply-To: <20180627094013.e42crqqufo2jqra6@paasikivi.fi.intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
         <1530078385-1546-2-git-send-email-alanx.chiang@intel.com>
         <CAMRc=MeowpZ+OjjWs6-67BOnY=+Nbpn4Bi_Xw3n+NLsELZaptQ@mail.gmail.com>
         <20180627094013.e42crqqufo2jqra6@paasikivi.fi.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-06-27 at 12:40 +0300, Sakari Ailus wrote:
> On Wed, Jun 27, 2018 at 10:19:38AM +0200, Bartosz Golaszewski wrote:
> > 2018-06-27 7:46 GMT+02:00  <alanx.chiang@intel.com>:
> > > From: Alan Chiang <alanx.chiang@intel.com>
> > > 
> > > The AT24 series chips use 8-bit address by default. If some
> > > chips would like to support more than 8 bits, the at24 driver
> > > should be added the compatible field for specfic chips.
> > > 
> > > Provide a flexible way to determine the addressing bits through
> > > address-width in this patch.
> > > 
> > > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> > > 
> > > ---
> > > since v1:
> > > -- Remove the address-width field in the example.
> > > since v2:
> > > -- Remove redundant space.
> > > 
> > > ---
> > >  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt
> > > b/Documentation/devicetree/bindings/eeprom/at24.txt
> > > index 61d833a..aededdb 100644
> > > --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> > > +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> > > @@ -72,6 +72,8 @@ Optional properties:
> > > 
> > >    - wp-gpios: GPIO to which the write-protect pin of the chip is
> > > connected.
> > > 
> > > +  - address-width: number of address bits (one of 8, 16).
> > > +
> > >  Example:
> > > 
> > >  eeprom@52 {
> > > --
> > > 2.7.4
> > > 
> > 
> > Rob,
> > 
> > we only have two possibilities here and the default is 8 bits.
> > 
> > What do you think about introducing a boolean property here called:
> > 'address-width-16' instead of an integer?
> 
> I'd have thought the same, but it turns out address-width is already
> being
> used by the at25 bindings:
> 
> Documentation/devicetree/bindings/eeprom/at25.txt
> 

Agree with Sakari, there is no need to evolve a chaos in DT bindings. We
have too many semi-hemi-duplications in bindings. Especially in this
case we have already established property by a similar driver.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
